// buyruk_onbellegi.v
`timescale 1ns / 1ps

`define TAG 18:11
`define ADR 10:2

module buyruk_onbellegi(
    input  wire        clk_i,
    input  wire        rst_i,

    output reg         iomem_valid,
    input  wire        iomem_ready,
    output reg  [31:0] iomem_addr,
    input  wire [31:0] iomem_rdata,

    output reg         l1b_bekle_o,
    output wire [31:0] l1b_deger_o,
    input  wire [31:0] l1b_adres_i

);

    localparam  RESET      = 3'd0,
                RESETONE   = 3'd1,
                RESETTWO   = 3'd2,
                MISS       = 3'd3,
                HIT        = 3'd4;

    reg [2:0] state;
    reg [2:0] next;

    reg [8:0] counter;
    reg [2:0] shift;

    always @(posedge clk_i) begin
        if(rst_i) state <= RESET;
        else      state <= next;
    end

    always @(*) begin
        case(state)
            RESET: if(counter == 511) next = RESETONE;
                   else               next = RESET;
            RESETONE:                 next = RESETTWO;
            RESETTWO:                 next = MISS;
            MISS:  if(shift==3'b000)  next = HIT;
                   else               next = MISS;
            HIT:   if(l1b_bekle_o)    next = MISS;
                   else               next = HIT;
            default:                  next = RESET;
        endcase
    end


    always @(posedge clk_i) begin
        if(rst_i) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
            shift <= {shift[1:0],l1b_bekle_o};
            case(next)
                RESET: begin
                end
                MISS: begin
                end
                HIT: begin
                end
            endcase
        end
    end
    reg csb0;
    reg spare_wen0;
    reg [8:0] addr0;
    reg [41:0] din0;


    wire valid;
    wire [7:0] tag;
    wire dummy;

    always @(*) begin
        case(state)
            RESET: begin
                csb0        = 1'b0;
                spare_wen0  = 1'b1;
                addr0       = counter;
                din0        = {1'b0,1'bx,l1b_adres_i[`TAG],iomem_rdata};
                l1b_bekle_o = 1'b1;
            end
            RESETONE: begin
                csb0        = 1'b0;
                spare_wen0  = 1'b1;
                addr0       = counter;
                din0        = {1'b0,1'bx,l1b_adres_i[`TAG],iomem_rdata};
                l1b_bekle_o = 1'b1;
            end
            RESETTWO: begin
                csb0        = 1'b0;
                spare_wen0  = 1'b1;
                addr0       = counter;
                din0        = {1'b0,1'bx,l1b_adres_i[`TAG],iomem_rdata};
                l1b_bekle_o = 1'b1;
            end
            MISS: begin
                csb0        = ~iomem_ready;
                spare_wen0  = iomem_ready;
                addr0       = l1b_adres_i[`ADR];
                din0        = {1'b1,1'bx,l1b_adres_i[`TAG],iomem_rdata};
                l1b_bekle_o = ~((l1b_adres_i[`TAG] == tag) && valid && (shift != 6));
            end
            HIT: begin
                csb0       = ~iomem_ready;
                spare_wen0 = iomem_ready;
                addr0      = l1b_adres_i[`ADR];
                din0       = {1'b1,1'bx,l1b_adres_i[`TAG],iomem_rdata};
                l1b_bekle_o = ~((l1b_adres_i[`TAG] == tag) && valid && (shift != 6));
            end
            default: begin
                csb0       = 1'bx;
                spare_wen0 = 1'bx;
                addr0      = 32'bx;
                din0       = 32'bx;
            end
        endcase
    end

    sram_41_512_sky130 sram_41_512_sky130_dut (
        .clk0       (clk_i),
        .csb0       (csb0),
        .spare_wen0 (spare_wen0),
        .addr0      (addr0),
        .din0       (din0),
        //
        .clk1  (clk_i                  ),
        .csb1  (1'b0                   ),
        .addr1 (l1b_adres_i[`ADR]            ),
        .dout1 ({valid,dummy,tag,l1b_deger_o})
    );


    assign iomem_addr  = l1b_adres_i;
    assign iomem_valid = 1'b1;

endmodule
