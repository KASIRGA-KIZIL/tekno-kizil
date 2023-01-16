// getir.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module getir(
    input clk_i,
    input rst_i,

    input [31:0] l1b_buyruk_i,
    input l1b_buyruk_gecerli_i,

    //input [31:0] l1b_program_sayaci_i,
    //input l1b_program_sayaci_gecerli_i,

    input getir_duraklat_i,

    output [31:0] getir_buyruk_o, // TODO cikisi 2 bit az verebiliriz, hepsinin sonu 11 olacak zaten, 29:0 
    output getir_buyruk_gecerli_o

    // cekirdekte ps ureteci olsa ve buradan ps ve anliklarin cikisi versek orada +2 ya da +4 ile toplasa daha hizli olabilir psin alt modullere gitmesindense 
);

    reg [31:0] buyruk_r = 0;
    reg [31:0] getir_buyruk_r = 0;
    assign buyruk_o = getir_buyruk_r;

    reg buyruk_gecerli_r = 0;
    reg getir_buyruk_gecerli_r = 0;
    assign getir_buyruk_gecerli_o = getir_buyruk_gecerli_r;

    always @* begin
        if(l1b_buyruk_gecerli_i) begin
            case (l1b_buyruk_i[1:0])
                // 32 bit buyruk
                2'b11: begin
                    buyruk_r = l1b_buyruk_i;
                    buyruk_gecerli_r = 1'b1; // burada gecerliymis kabul et cozde gecersizleri belirlersin
                end

                // compressed 16 bit quadrant 0
                2'b00: begin

                end

                // compressed 16 bit quadrant 1
                2'b01: begin

                end

                // compressed 16 bit quadrant 2
                2'b10: begin

                end
            endcase
        end
    end

    always @(posedge clk_i) begin
        if (rst_i) begin
            getir_buyruk_r <= 0;
            getir_buyruk_gecerli_r <= 0;
        end
        else begin
            if (getir_duraklat_i) begin
                getir_buyruk_r <= getir_buyruk_r;
                getir_buyruk_gecerli_r <= getir_buyruk_gecerli_r;
            end
            else begin
                getir_buyruk_r <= buyruk_r;
                getir_buyruk_gecerli_r <= buyruk_gecerli_r;
            end
        end
    end
endmodule
