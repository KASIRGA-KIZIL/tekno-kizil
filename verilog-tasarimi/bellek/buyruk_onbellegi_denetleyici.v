// buyruk_onbellegi.v
`timescale 1ns / 1ps

`define L1B_TAG 18:10
`define L1B_ADR 9:2

`define YOL_TAG   40:32
`define YOL_DATA  31:0
`define YOL_VALID 41

module buyruk_onbellegi_denetleyici(
    input  wire        clk_i, //
    input  wire        rst_i, //

    output wire         iomem_valid, //
    input  wire         iomem_ready, //
    output wire  [18:2] iomem_addr,  //
    input  wire  [31:0] iomem_rdata, //

    output wire        l1b_bekle_o, //
    output wire [31:0] l1b_deger_o, //
    input  wire [18:1] l1b_adres_i, //

    // RAM256_yol0
    output wire        yol0_we_o,    //
    output wire [ 7:0] yol0_wadr_o,  //
    output wire [41:0] yol0_data_o,  //
    output wire [ 7:0] yol0_radr0_o, //
    input  wire [41:0] yol0_data0_i, //
    output wire [ 7:0] yol0_radr1_o, //
    input  wire [41:0] yol0_data1_i, //
    // RAM256_yol1
    output wire        yol1_we_o,    //
    output wire [ 7:0] yol1_wadr_o,  //
    output wire [41:0] yol1_data_o,  //
    output wire [ 7:0] yol1_radr0_o, //
    input  wire [41:0] yol1_data0_i, //
    output wire [ 7:0] yol1_radr1_o, //
    input  wire [41:0] yol1_data1_i  //
);
    reg [255:0] lru;
    reg  [8:0] counter;
    wire [7:0] lru_adr = iomem_addr[`L1B_ADR];
    wire hizasiz_okuma = l1b_adres_i[1];
    wire [18:2] sonraki_adres = l1b_adres_i[18:2]+1;

    assign yol0_radr0_o = l1b_adres_i  [`L1B_ADR];
    assign yol0_radr1_o = sonraki_adres[`L1B_ADR];

    assign yol1_radr0_o = l1b_adres_i  [`L1B_ADR];
    assign yol1_radr1_o = sonraki_adres[`L1B_ADR];

    wire hit_yol0_0 = (l1b_adres_i  [`L1B_TAG] == yol0_data0_i[`YOL_TAG]) & yol0_data0_i[`YOL_VALID];
    wire hit_yol0_1 = (sonraki_adres[`L1B_TAG] == yol0_data1_i[`YOL_TAG]) & yol0_data1_i[`YOL_VALID];
    wire hit_yol1_0 = (l1b_adres_i  [`L1B_TAG] == yol1_data0_i[`YOL_TAG]) & yol1_data0_i[`YOL_VALID];
    wire hit_yol1_1 = (sonraki_adres[`L1B_TAG] == yol1_data1_i[`YOL_TAG]) & yol1_data1_i[`YOL_VALID];

    assign l1b_bekle_o = (counter != 9'd256) ? 1'b1 :
                          hizasiz_okuma ? ~((hit_yol0_0&hit_yol0_1)|
                                            (hit_yol0_0&hit_yol1_1)|
                                            (hit_yol1_0&hit_yol0_1)|
                                            (hit_yol1_0&hit_yol1_1)):
                                           ~(hit_yol0_0|hit_yol1_0);


    wire [31:0] hizali_data = hit_yol0_0 ? yol0_data0_i[`YOL_DATA] : yol1_data0_i[`YOL_DATA];

    wire [15:0] data_alt = hit_yol0_0 ? yol0_data0_i[31:16] : yol1_data0_i[31:16];
    wire [15:0] data_ust = hit_yol0_1 ? yol0_data1_i[15: 0] : yol1_data1_i[15: 0];

    assign l1b_deger_o = hizasiz_okuma ? {data_ust,data_alt} : hizali_data;

    assign yol0_wadr_o = (counter != 9'd256) ? counter[7:0] : iomem_addr[`L1B_ADR];
    assign yol1_wadr_o = (counter != 9'd256) ? counter[7:0] : iomem_addr[`L1B_ADR];

    assign yol0_we_o = (counter != 9'd256) ? 1'b1 :  lru[lru_adr] & iomem_ready;
    assign yol1_we_o = (counter != 9'd256) ? 1'b1 : ~lru[lru_adr] & iomem_ready;

    assign yol0_data_o = (counter != 9'd256) ? {1'b0,iomem_addr[`L1B_TAG],iomem_rdata} : {1'b1,iomem_addr[`L1B_TAG],iomem_rdata};
    assign yol1_data_o = (counter != 9'd256) ? {1'b0,iomem_addr[`L1B_TAG],iomem_rdata} : {1'b1,iomem_addr[`L1B_TAG],iomem_rdata};

    assign iomem_valid = l1b_bekle_o;
    assign iomem_addr = hizasiz_okuma ? (~(hit_yol0_0|hit_yol1_0) ? l1b_adres_i[18:2] : sonraki_adres) : l1b_adres_i[18:2];

    always @(posedge clk_i) begin
        if(rst_i)begin
            counter <= 9'b0;
            lru     <= 256'b0;
        end else begin
            counter <= (counter != 9'd256) ? (counter + 9'b1) : counter;
            lru[lru_adr] <= yol0_we_o ? 1'b0 :
                            yol1_we_o ? 1'b1 :
                                        lru[lru_adr];
        end
    end

endmodule
