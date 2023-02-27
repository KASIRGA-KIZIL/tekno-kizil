// buyruk_onbellegi.v
`timescale 1ns / 1ps

`define TAG 18:11
`define ADR 10:2

module buyruk_onbellegi(
    input  wire        clk_i,
    input  wire        rst_i,

    output reg         iomem_valid,
    input  wire        iomem_ready,
    output reg  [18:2] iomem_addr,
    input  wire [31:0] iomem_rdata,

    output reg         l1b_bekle_o,
    output wire [31:0] l1b_deger_o,
    input  wire [18:1] l1b_adres_i
);

    wire [15:0] data0;
    wire [15:0] data1;

    assign l1b_deger_o = l1b_adres_i[1] ? {data0,data1} : {data1,data0};


    localparam  RESET      = 3'd0,
                RESETONE   = 3'd1,
                RESETTWO   = 3'd2,
                READ       = 3'd3;

    reg [2:0] state;
    reg [2:0] next;

    reg [8:0] counter;

    always @(posedge clk_i) begin
        if(rst_i) state <= RESET;
        else      state <= next;
    end

    always @(*) begin
        case(state)
            RESET: if(counter == 511) next = RESETONE;
                   else               next = RESET;
            RESETONE:                 next = RESETTWO;
            RESETTWO:                 next = READ;
            READ:                     next = READ;
            default:                  next = RESET;
        endcase
    end


    always @(posedge clk_i) begin
        if(rst_i) begin
            counter <= 9'b0;
        end else begin
            counter <= counter + 9'b1;
        end
    end

    reg csb0;
    wire [8:0] addr0 = l1b_adres_i[`ADR] + {{8{1'b0}},l1b_adres_i[1]};
    wire [8:0] addr1 = l1b_adres_i[`ADR];
    reg [40:0] din0;


    wire valid0;
    wire valid1;
    wire [7:0] tag0;
    wire [7:0] tag1;

    wire no_next = ~((l1b_adres_i[`TAG] == tag0) && valid0);

    always @(*) begin
        case(state)
            RESET: begin
                csb0        = 1'b0;
                din0        = {1'b0,l1b_adres_i[`TAG],iomem_rdata};
                l1b_bekle_o = 1'b1;
                iomem_valid = 1'b0;
                iomem_addr  = {8'b0,counter};
            end
            RESETONE: begin
                csb0        = 1'b0;
                din0        = {1'b0,l1b_adres_i[`TAG],iomem_rdata};
                l1b_bekle_o = 1'b1;
                iomem_valid = 1'b0;
                iomem_addr  = {8'b0,counter};
            end
            RESETTWO: begin
                csb0        = 1'b0;
                din0        = {1'b0,l1b_adres_i[`TAG],iomem_rdata};
                l1b_bekle_o = 1'b1;
                iomem_valid = 1'b0;
                iomem_addr  = {8'b0,counter};
            end
            READ: begin
                csb0        = ~iomem_ready;
                din0        = {1'b1,l1b_adres_i[`TAG],iomem_rdata};
                l1b_bekle_o = ~((l1b_adres_i[`TAG] == tag0) && (l1b_adres_i[`TAG] == tag1) && valid0 && valid1);
                iomem_valid = l1b_bekle_o;
                iomem_addr  = no_next ? {l1b_adres_i[`TAG],addr0} : l1b_adres_i[18:2];
            end
            default: begin
                csb0        = 1'b0;
                din0        = {1'b0,l1b_adres_i[`TAG],iomem_rdata};
                l1b_bekle_o = 1'b1;
                iomem_valid = 1'b0;
                iomem_addr  = {8'b0,counter};
            end
        endcase
    end


    buyruk_ffram #(
        .DATA_WIDTH(16),
        .COLS_N(512)
    ) bffram_d0 (
        .clk_i (clk_i ),

        .wen_i  (~csb0),
        .data_i (din0[15:0]),
        .wadr_i (iomem_addr[`ADR]),

        .data_o (data0),
        .radr_i (addr0)
    );

    buyruk_ffram #(
        .DATA_WIDTH(16),
        .COLS_N(512)
    ) bffram_d1 (
        .clk_i (clk_i ),

        .wen_i  (~csb0),
        .data_i (din0[31:16]),
        .wadr_i (iomem_addr[`ADR]),

        .data_o (data1),
        .radr_i (addr1)
    );

    buyruk_tagvram #(
        .DATA_WIDTH(9),
        .COLS_N(512)
    ) bffram_c2 (
        .clk_i (clk_i ),

        .wen_i  (~csb0),
        .data_i (din0[40:32]),
        .wadr_i (iomem_addr[`ADR]),

        .data0_o ({valid0,tag0}),
        .radr0_i (addr0),

        .data1_o ({valid1,tag1}),
        .radr1_i (addr1)
    );

endmodule
