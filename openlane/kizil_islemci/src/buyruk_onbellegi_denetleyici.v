// buyruk_onbellegi.v
`timescale 1ns / 1ps

`define TAG 18:11
`define ADR 10:2
   
module buyruk_onbellegi_denetleyici(
   input  wire        clk_i,
   input  wire        rst_i,
   
   output reg         iomem_valid,
   input  wire        iomem_ready,
   output reg  [18:2] iomem_addr,
   
   output reg         l1b_bekle_o,
   output wire [31:0] l1b_deger_o,
   input  wire [18:1] l1b_adres_i,
   // RAM256_T0
   output wire       we0_o,
   output wire [7:0] adr0_o,
   input  wire [7:0] datao0_i,
   // RAM256_T1
   output wire       we1_o,
   output wire [7:0] adr1_o,
   input  wire [7:0] datao1_i,
   // RAM512_D0
   output wire        ram512d0_we0_o,
   output wire [ 8:0] ram512d0_adr0_o,
   input  wire [15:0] ram512d0_datao0_i,
   // RAM512_D1
   output wire        ram512d1_we0_o,
   output wire [ 8:0] ram512d1_adr0_o,
   input  wire [15:0] ram512d1_datao0_i
);
   wire [15:0] data0;
   wire [15:0] data1;
   
   // Hizasiz erisimlerde 16 bitlerin yerini degistir.
   assign l1b_deger_o = l1b_adres_i[1] ? {data0,data1} : {data1,data0};
   
   localparam  READMEM0   = 3'd0,
               READMEM1   = 3'd1,
               READCACHE  = 3'd2;
   
   reg [2:0] state;
   reg [2:0] next;
   
   reg  [ 8:0] d_addr0, d_addr0_next;
   reg  [ 8:0] d_addr1, d_addr1_next;
   wire [ 8:0] data_addr0 = l1b_adres_i[`ADR] + {{8{1'b0}},l1b_adres_i[1]}; // Eger hizasiz erisim ise 1 yukardaki satira eris.
   wire [ 8:0] data_addr1 = l1b_adres_i[`ADR];
   
   wire valid0;
   wire valid1;
   wire [7:0] tag0;
   wire [7:0] tag1;
   
   reg wen, wen_next;
   wire data0_ready = (l1b_adres_i[`TAG] === tag0) && valid0;
   wire data1_ready = (l1b_adres_i[`TAG] === tag1) && valid1;
   
   always @(posedge clk_i) begin
       if(rst_i) begin
           state <= READMEM0;
           wen <= 1'b0;
           d_addr1 <= 9'd0;
           d_addr0 <= 9'd0;
       end
       else begin
           state <= next;
           wen <= wen_next;
           d_addr1 <= d_addr1_next;
           d_addr0 <= d_addr0_next;
       end
   end
   
   always @(*) begin
       wen_next = 1'b0;
       d_addr1_next = 9'd0;
       d_addr0_next = 9'd0;
       case(state)
          READMEM0: begin
             if(iomem_ready)
                next = READCACHE;
             else
                next = READMEM0;
          end
          READMEM1: begin
             if(iomem_ready)
                next = READCACHE;
             else
                next = READMEM1;
          end
          READCACHE: begin
             if(~data0_ready)
                next = READMEM0;
             else if(~data1_ready)
                next = READMEM1;
             else
                next = READCACHE;
          end
          default: next = READMEM0;
       endcase
       case(state)
           READMEM0: begin
              iomem_addr  = {l1b_adres_i[`TAG],data_addr0};
              iomem_valid = 1'b1;
              d_addr0_next = iomem_addr[`ADR];
              d_addr1_next = iomem_addr[`ADR];
              l1b_bekle_o = 1'b1;
              wen_next = iomem_ready;
           end
           READMEM1: begin
              iomem_addr  = {l1b_adres_i[`TAG],data_addr1};
              iomem_valid = 1'b1;
              d_addr0_next = iomem_addr[`ADR];
              d_addr1_next = iomem_addr[`ADR];
              l1b_bekle_o = 1'b1;
              wen_next = iomem_ready;
           end
           READCACHE: begin
              iomem_addr  = l1b_adres_i[18:2];
              iomem_valid = 1'b0;
              d_addr0_next = data_addr0;
              d_addr1_next = data_addr1;
              l1b_bekle_o = ~(data0_ready && data1_ready);
              wen_next = 1'b0;
           end
           default: begin
           end
       endcase
   end
   
   assign ram512d0_we0_o    = wen_next;
   assign ram512d0_adr0_o   = d_addr0_next;
   assign data0 = ram512d0_datao0_i;
   
   assign ram512d1_we0_o    = wen_next;
   assign ram512d1_adr0_o   = d_addr1_next;
   assign data1 = ram512d1_datao0_i;
   
   
   tag_denetleyici tagden_dut (
      .clk_i  (clk_i ),
      .rst_i  (rst_i ),
      //
      .wen_i  (wen_next   ),
      .wadr_i (iomem_addr[`ADR] ),
      //
      .data0_o ({valid0,tag0}),
      .radr0_i (data_addr0 ),
      //
      .data1_o ({valid1,tag1}),
      .radr1_i (data_addr1 ),
      //
      .we0_o    (we0_o ),
      .adr0_o   (adr0_o ),
      .datao0_i (datao0_i ),
      //
      .we1_o    (we1_o ),
      .adr1_o   (adr1_o ),
      .datao1_i ( datao1_i)
   );

endmodule
