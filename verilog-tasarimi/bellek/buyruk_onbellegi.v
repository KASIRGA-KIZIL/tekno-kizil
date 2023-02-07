`timescale 1ns / 1ps

module buyruk_onbellegi(
  input clk_i,
  input rst_i,
  // DDB <-> Onbellek Denetleyici
  output ddb_durdur,
  // Getir2 <-> buyruk onbellegi
  output gtr2_gecerli_o,
  output [31:0] gtr2_deger_o,
  input [31:0] gtr1_adres_i,
  input gtr1_gecerli,
  // Anabellek Denetleyici <-> buyruk onbellegi
  output [31:0] ab_addr,
  output ab_csb,
  input [31:0] ab_dot,
  input ab_oku_valid
);

  ////////////////////////////////////////////////////
  //                  Tanimlamalar
  ////////////////////////////////////////////////////

  wire valid;
  wire dummy; 
  wire [20:0] tag;
  wire [31:0] cache_data;

  localparam DEVAM = 2'b01,
             BEKLE = 2'b10;
  reg [1:0] durum_r, durum_next_r;

  wire tag_esittir;

  assign tag_esittir = (gtr1_adres_i[31:11]==tag);

  // ddb durdur veya g_bekle bi tanesi yeterli
  assign ddb_durdur = (gtr1_gecerli && (!valid || !tag_esittir)) || (durum_r != DEVAM);

  assign gtr2_gecerli_o = (gtr1_gecerli && valid && tag_esittir) || (ab_oku_valid && (durum_r != DEVAM));

  assign gtr2_deger_o = ab_oku_valid ? ab_dot : (valid ? cache_data : 'd0);

  assign ab_addr = gtr1_adres_i;

  assign ab_csb = (durum_r != DEVAM);

  // Not: Normalde writeback yapilacak fakat buyruk verisi kirtletilemeyecegi icin burda onemli degil
  // data config: 
  // { 1 bit Valid, 1 bit Dummy, 21 bits Tag, 32 bits Data} 
  sram_54b_512_1w_1r_sky130 buyruk_onbellegi(
    // write port
    .clk0       (clk_i),
    .csb0       (!ab_oku_valid),
    .spare_wen0 (ab_oku_valid),
    // zaten islemci durmus olucagi icin kontrole gerek yok
    .addr0      (gtr1_adres_i[10:0]),
    .din0       ({1'b1, 1'bx, gtr1_adres_i[31:11], ab_dot}),
    // read port
    .clk1  (clk_i),
    .csb1  (!gtr1_gecerli),
    .addr1 (gtr1_adres_i[10:0]),
    .dout1 ({valid, dummy, tag, cache_data})
  );

  always@* begin
    durum_next_r = durum_r;
    case(durum_r) 
      DEVAM: begin
        // Veri onbellekte bulunamadi
        if((gtr1_gecerli && (!valid || !tag_esittir))) begin
          durum_next_r = BEKLE;
        end
      end
      BEKLE: begin
        // ab valid ise hem onbellege yaz hem de veriyi getire ver
        if(ab_oku_valid) begin
          durum_next_r = DEVAM;
        end
      end
    endcase
  end

  always@(posedge clk_i) begin
    if(rst_i) begin
      durum_r <= 2'b01;
    end
    else begin
      durum_r <= durum_next_r;
    end
  end
  
endmodule
