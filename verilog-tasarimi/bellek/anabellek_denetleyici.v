// anabellek_denetleyici.v
`timescale 1ns / 1ps


module anabellek_denetleyici(
    input clk_i,
    input rst_i,
    // DDB <-> Anabellek Denetleyici
    output ddb_durdur,
    // Anabellek <-> Anabellek Denetleyici
    output iomem_valid,
    input iomem_ready,
    output [ 3:0] iomem_wstrb,
    output [31:0] iomem_addr,
    output [31:0] iomem_wdata,
    input [31:0] iomem_rdata,
    // Getir Onbellek Denetleyici <-> Anabellek Denetleyici
    input go_csb,
    input go_web,
    input [31:0] go_addr,
    input [31:0] go_din,
    output [31:0] go_dot,
    output go_oku_valid,
    output go_stall,
    // Yurut Onbellek Denetleyici <-> Anabellek Denetleyici
    input yo_csb,
    input yo_web,
    input [31:0] yo_addr,
    input [31:0] yo_din,
    output [31:0] yo_dot,
    output yo_oku_valid,
    output yo_stall
    );

    ////////////////////////////////////////////////////
    //                  Tanimlamalar
    ////////////////////////////////////////////////////

    // durumlar
    localparam CIFT_ISTEK = 2'b11,
               GETIR = 2'b10,
               YURUT = 2'b01,
               ISTEK_YOK = 2'b00;

    localparam BOSTA = 2'b01,
               BEKLE = 2'b10;
    reg [1:0] durum_r, durum_next_r;

    // iki istek ayni anda geldiğinde biri registerlarda tutulmali
    reg cift_istek_r, cift_istek_next_r; 

    reg istek_yo_r, istek_yo_next_r; 
    reg istek_yaz_r, istek_yaz_next_r;
    
    // Bunlara gerek olmayabilir, 
    // zaten cekirdek durdugunda veri ayni kaliyor
    reg [31:0] ikinci_addr_r, ikinci_addr_next_r;
    reg [31:0] ikinci_wdata_r, ikinci_wdata_next_r;
    reg ikinci_istek_yaz_r, ikinci_istek_yaz_next_r; 

    // Cikis registerlari
    reg ana_valid_r, ana_valid_next_r;
    reg [3:0] ana_wstrb_r, ana_wstrb_next_r;
    reg [31:0] ana_addr_r, ana_addr_next_r;
    reg [31:0] ana_wdata_r, ana_wdata_next_r;

    // Cikis l1 denetleyici registerlari
    reg [31:0] yo_dot_r, yo_dot_next_r;
    reg yo_oku_valid_r, yo_oku_valid_next_r;
    reg [31:0] go_dot_r, go_dot_next_r; 
    reg go_oku_valid_r, go_oku_valid_next_r;

    ////////////////////////////////////////////////////
    //                  Atamalar
    ////////////////////////////////////////////////////
    assign ddb_durdur = ~durum_r[0];
    assign yo_stall = ddb_durdur;
    assign go_stall = ddb_durdur;

    always@* begin
        durum_next_r = durum_r;
        cift_istek_next_r = cift_istek_r;
        
        ikinci_addr_next_r = ikinci_addr_r;
        ikinci_wdata_next_r = ikinci_wdata_r;
        ikinci_istek_yaz_next_r = ikinci_istek_yaz_r;

        ana_valid_next_r = 1'b0;
        ana_wstrb_next_r = 4'b1111;
        ana_addr_next_r = ana_addr_r;
        ana_wdata_next_r = ana_wdata_r;

        yo_dot_next_r = 32'd0;
        yo_oku_valid_next_r = 1'b0;

        go_dot_next_r = 32'd0;
        go_oku_valid_next_r = 1'b0;

        istek_yo_next_r = istek_yo_r;
        istek_yaz_next_r = istek_yaz_r;

        case(durum_r)
            BOSTA: begin
                case({go_csb, yo_csb}) 
                    CIFT_ISTEK: begin
                        durum_next_r = BEKLE;

                        cift_istek_next_r = 1'b1;
                        ikinci_addr_next_r = go_addr;
                        ikinci_wdata_next_r = go_din;
                        ikinci_istek_yaz_next_r = go_web;
                        
                        ana_addr_next_r = yo_addr;
                        ana_wdata_next_r = yo_din;
                        ana_valid_next_r = 1'b1;
                    end

                    GETIR: begin
                        durum_next_r = BEKLE;

                        istek_yaz_next_r = go_web;
                    end

                    YURUT: begin
                        durum_next_r = BEKLE;

                        istek_yo_next_r = 1'b1;
                        istek_yaz_next_r = yo_web;
                    end
                endcase
            end

            BEKLE: begin
                if(iomem_ready) begin
                    if(cift_istek_r) begin
                        cift_istek_next_r = 1'b0;

                        ana_addr_next_r = ikinci_addr_r;
                        ana_wdata_next_r = ikinci_wdata_r;
                        istek_yaz_next_r = ikinci_istek_yaz_r;
                        ana_valid_next_r = 1'b1;
                        
                        if(~istek_yaz_r) begin
                            yo_dot_next_r = iomem_rdata;
                            yo_oku_valid_next_r = 1'b1;
                        end
                    end

                    if(!cift_istek_r) begin
                        durum_next_r = BOSTA;
                        
                        if(~istek_yaz_r) begin
                            yo_dot_next_r = iomem_rdata;
                            yo_oku_valid_next_r = istek_yo_r;

                            go_dot_next_r = iomem_rdata;
                            go_oku_valid_next_r = ~istek_yo_r;
                        end
                    end
                end
            end
        endcase
    end

    always@(posedge clk_i) begin
        if(reset) begin
            durum_r <= BOSTA;
            cift_istek_r <= 'd0;
            ikinci_addr_r <= 'd0;
            ikinci_wdata_r <= 'd0;
            ikinci_istek_yaz_r <= 'd0;
            ana_valid_r <= 'd0;
            ana_wstrb_r <= 'd0;
            ana_addr_r <= 'd0;
            ana_wdata_r <= 'd0;
            yo_dot_r <= 'd0;
            yo_oku_valid_r <= 'd0;
            go_dot_r <= 'd0;
            go_oku_valid_r <= 'd0;
            istek_yo_r <= 'd0;
            istek_yaz_r <= 'd0;
        end
        else begin
            durum_r <= durum_next_r;
            cift_istek_r <= cift_istek_next_r;
            ikinci_addr_r <= ikinci_addr_next_r;
            ikinci_wdata_r <= ikinci_wdata_next_r;
            ikinci_istek_yaz_r <= ikinci_istek_yaz_next_r;
            ana_valid_r <= ana_valid_next_r;
            ana_wstrb_r <= ana_wstrb_next_r;
            ana_addr_r <= ana_addr_next_r;
            ana_wdata_r <= ana_wdata_next_r;
            yo_dot_r <= yo_dot_next_r;
            yo_oku_valid_r <= yo_oku_valid_next_r;
            go_dot_r <= go_dot_next_r;
            go_oku_valid_r <= go_oku_valid_next_r;
            istek_yo_r <= istek_yo_next_r;
            istek_yaz_r <= istek_yaz_next_r;
        end
    end

endmodule