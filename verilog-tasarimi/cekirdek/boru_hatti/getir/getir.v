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
    output getir_buyruk_gecerli_o,
    output getir_buyruk_compressed_o

    // cekirdekte ps ureteci olsa ve buradan ps ve anliklarin cikisi versek orada +2 ya da +4 ile toplasa daha hizli olabilir psin alt modullere gitmesindense 
);

    reg [31:0] buyruk_r = 0;
    reg [31:0] getir_buyruk_r = 0;
    assign buyruk_o = getir_buyruk_r;

    reg buyruk_gecerli_r = 0;
    reg getir_buyruk_gecerli_r = 0;
    assign getir_buyruk_gecerli_o = getir_buyruk_gecerli_r;
    
    reg buyruk_compressed_r = 0;
    reg getir_buyruk_compressed_r = 0;
    assign getir_buyruk_compressed_o = getir_buyruk_compressed_r;

    always @* begin
        buyruk_r = 1'b0;
        buyruk_gecerli_r = 1'b0;
        buyruk_compressed_r = 1'b0;
        
        if(l1b_buyruk_gecerli_i) begin
            buyruk_gecerli_r = 1'b1;
            
            case (l1b_buyruk_i[1:0])
                // 32 bit buyruk
                2'b11: begin
                    buyruk_r = l1b_buyruk_i;
                    buyruk_gecerli_r = 1'b1; // burada gecerliymis kabul et cozde gecersizleri belirlersin
                    buyruk_compressed_r = 1'b0;
                end

                // if-elseleri kaldirarak kendi icinde bitleri orlayabilirim
                // compressedler icin de tanimlamalar.vhta tablo kurulup burada genisletilebilir, dest0var, dest0yok gibi

                // Compressedleri getirde 32 bit buyruk esleniklerine genisletiyoruz
                
                // compressed 16 bit quadrant 0
                2'b00: begin
                    buyruk_compressed_r = 1'b1;
                    
                    case (l1b_buyruk_i[15:14])
                        2'b00: begin
                          if(l1b_buyruk_i[12:5] == 8'h00)
                              buyruk_gecerli_r = 1'b0;
                          else
                              // c.addi4spn -> addi rd', x2, nzuimm
                              buyruk_r = {2'b0, l1b_buyruk_i[10:7], l1b_buyruk_i[12:11], l1b_buyruk_i[5], l1b_buyruk_i[6], 2'b00, 5'h02, 3'b000, 2'b01, l1b_buyruk_i[4:2], 7'h13};
                        end

                        2'b01: begin
                          // c.lw -> lw rd', uimm(rs1')
                          buyruk_r = {5'b0, l1b_buyruk_i[5], l1b_buyruk_i[12:10], l1b_buyruk_i[6], 2'b00, 2'b01, l1b_buyruk_i[9:7], 3'b010, 2'b01, l1b_buyruk_i[4:2], 7'h03};
                        end
                           
                        2'b10: begin
                          buyruk_gecerli_r = 1'b0;
                        end

                        2'b11: begin
                          // c.sw -> sw rs2', uimm(rs1')
                          buyruk_r = {5'b0, l1b_buyruk_i[5], l1b_buyruk_i[12], 2'b01, l1b_buyruk_i[4:2], 2'b01, l1b_buyruk_i[9:7], 3'b010, l1b_buyruk_i[11:10], l1b_buyruk_i[6], 2'b00, 7'h23};
                        end
                    endcase
                end

                // compressed 16 bit quadrant 1
                2'b01: begin
                    buyruk_compressed_r = 1'b1;
                    
                    case (l1b_buyruk_i[15:13])
                        3'b000: begin
                          // c.addi -> addi rd, rd, nzimm
                          // c.nop -> addi, 0, 0, 0
                          // normalde c.addi icin nzimm non-zero kontrolu yapilmasi lazim ama c.nop ile beraber bu kontrole gerek yok burada
                          buyruk_r = {{6 {l1b_buyruk_i[12]}}, l1b_buyruk_i[12], l1b_buyruk_i[6:2], l1b_buyruk_i[11:7], 3'b0, l1b_buyruk_i[11:7], 7'h13};
                        end

                        3'b001, 
                        3'b101: begin
                          // 001: c.jal -> jal x1, imm
                          // 101: c.j   -> jal x0, imm
                          buyruk_r = {l1b_buyruk_i[12], l1b_buyruk_i[8], l1b_buyruk_i[10:9], l1b_buyruk_i[6], l1b_buyruk_i[7], l1b_buyruk_i[2], l1b_buyruk_i[11], l1b_buyruk_i[5:3], {9 {l1b_buyruk_i[12]}}, 4'b0, ~l1b_buyruk_i[15], 7'h6f};
                        end

                        3'b010: begin
                          if(l1b_buyruk_i[11:7] == 5'h00)
                              buyruk_gecerli_r = 1'b0;
                          else
                              // c.li -> addi rd, x0, imm
                              buyruk_r = {{6 {l1b_buyruk_i[12]}}, l1b_buyruk_i[12], l1b_buyruk_i[6:2], 5'b0, 3'b0, l1b_buyruk_i[11:7], 7'h13};
                        end

                        3'b011: begin
                            if (l1b_buyruk_i[11:7] == 5'h02) begin
                              if({l1b_buyruk_i[12], l1b_buyruk_i[6:2]} == 6'h00)
                                buyruk_gecerli_r = 1'b0;
                              else
                                // c.addi16sp -> addi x2, x2, nzimm
                                buyruk_r = {{3 {l1b_buyruk_i[12]}}, l1b_buyruk_i[4:3], l1b_buyruk_i[5], l1b_buyruk_i[2], l1b_buyruk_i[6], 4'b0, 5'h02, 3'b000, 5'h02, 7'h13};
                            end
                            else if (l1b_buyruk_i[11:7] == 5'h00) begin
                              buyruk_gecerli_r = 1'b0;
                            end
                            else begin
                              if({l1b_buyruk_i[12], l1b_buyruk_i[6:2]} == 6'h00)
                                buyruk_gecerli_r = 1'b0;
                              else
                                // c.lui -> lui rd, nzimm
                                buyruk_r = {{15 {l1b_buyruk_i[12]}}, l1b_buyruk_i[6:2], l1b_buyruk_i[11:7], 7'h37};
                            end

                        end

                        3'b100: begin
                          case (l1b_buyruk_i[11:10])
                            2'b00,
                            2'b01: begin
                              if(l1b_buyruk_i[12] == 1'b1) // must be zero
                                buyruk_gecerli_r = 1'b0;
                              else
                                // burada 12.yi kontrol etmeme gerek yok
                                if({l1b_buyruk_i[12], l1b_buyruk_i[6:2]} == 6'h00) // shift amount must be non-zero
                                  buyruk_gecerli_r = 1'b0;
                                else
                                  // 00: c.srli -> srli rd, rd, shamt
                                  // 01: c.srai -> srai rd, rd, shamt
                                  buyruk_r = {1'b0, l1b_buyruk_i[10], 5'b0, l1b_buyruk_i[6:2], 2'b01, l1b_buyruk_i[9:7], 3'b101, 2'b01, l1b_buyruk_i[9:7], 7'h13};
                            end

                            2'b10: begin
                              // c.andi -> andi rd, rd, imm
                              buyruk_r = {{6 {l1b_buyruk_i[12]}}, l1b_buyruk_i[12], l1b_buyruk_i[6:2], 2'b01, l1b_buyruk_i[9:7], 3'b111, 2'b01, l1b_buyruk_i[9:7], 7'h13};
                            end

                            2'b11: begin
                              case (l1b_buyruk_i[6:5])
                                2'b00: begin
                                  // c.sub -> sub rd', rd', rs2'
                                  buyruk_r = {2'b01, 5'b0, 2'b01, l1b_buyruk_i[4:2], 2'b01, l1b_buyruk_i[9:7], 3'b000, 2'b01, l1b_buyruk_i[9:7], 7'h33};
                                end

                                2'b01: begin
                                  // c.xor -> xor rd', rd', rs2'
                                  buyruk_r = {7'b0, 2'b01, l1b_buyruk_i[4:2], 2'b01, l1b_buyruk_i[9:7], 3'b100, 2'b01, l1b_buyruk_i[9:7], 7'h33};
                                end

                                2'b10: begin
                                  // c.or  -> or  rd', rd', rs2'
                                  buyruk_r = {7'b0, 2'b01, l1b_buyruk_i[4:2], 2'b01, l1b_buyruk_i[9:7], 3'b110,
                                            2'b01, l1b_buyruk_i[9:7], 7'h33};
                                end

                                2'b11: begin
                                  // c.and -> and rd', rd', rs2'
                                  buyruk_r = {7'b0, 2'b01, l1b_buyruk_i[4:2], 2'b01, l1b_buyruk_i[9:7], 3'b111, 2'b01, l1b_buyruk_i[9:7], 7'h33};
                                end
                              endcase
                            end
                          endcase
                        end

                        3'b110, 
                        3'b111: begin
                          // 110: c.beqz -> beq rs1', x0, imm
                          // 111: c.bnez -> bne rs1', x0, imm
                          buyruk_r = {{4 {l1b_buyruk_i[12]}}, l1b_buyruk_i[6:5], l1b_buyruk_i[2], 5'b0, 2'b01, l1b_buyruk_i[9:7], 2'b00, l1b_buyruk_i[13], l1b_buyruk_i[11:10], l1b_buyruk_i[4:3], l1b_buyruk_i[12], 7'h63};
                        end
                    endcase
                end

                // compressed 16 bit quadrant 2
                2'b10: begin
                    buyruk_compressed_r = 1'b1;
                    
                    case (l1b_buyruk_i[15:14])
                        2'b00: begin
                          if(l1b_buyruk_i[12] == 1'b1) // must be zero
                            buyruk_gecerli_r = 1'b0;
                          else
                            // burada 12.yi kontrol etmeme gerek yok
                            if({l1b_buyruk_i[12], l1b_buyruk_i[6:2]} == 6'h00) // shift amount must be non-zero
                              buyruk_gecerli_r = 1'b0;
                            else
                              // c.slli -> slli rd, rd, shamt
                              buyruk_r = {7'b0, l1b_buyruk_i[6:2], l1b_buyruk_i[11:7], 3'b001, l1b_buyruk_i[11:7], 7'h13};
                        end

                        2'b01: begin
                          if(l1b_buyruk_i[11:7] == 5'h00)
                            buyruk_gecerli_r = 1'b0;
                          else
                            // c.lwsp -> lw rd, uimm(x2)
                            buyruk_r = {4'b0, l1b_buyruk_i[3:2], l1b_buyruk_i[12], l1b_buyruk_i[6:4], 2'b00, 5'h02, 3'b010, l1b_buyruk_i[11:7], 7'h03};
                        end

                        2'b10: begin
                          if (l1b_buyruk_i[12] == 1'b0) begin
                            if (l1b_buyruk_i[11:7] == 5'h00) begin
                              buyruk_gecerli_r = 1'b0;
                            end
                            else begin
                              if (l1b_buyruk_i[6:2] == 5'h00) begin
                                // c.jr -> jalr x0, rd/rs1, 0
                                buyruk_r = {12'b0, l1b_buyruk_i[11:7], 3'b0, 5'b0, 7'h67};
                              end 
                              else begin
                                // c.mv -> add rd/rs1, x0, rs2
                                buyruk_r = {7'b0, l1b_buyruk_i[6:2], 5'b0, 3'b0, l1b_buyruk_i[11:7], 7'h33};
                              end
                            end
                          end
                          else begin
                            if (l1b_buyruk_i[6:2] == 5'h00) begin
                              if (l1b_buyruk_i[11:7] == 5'h00) begin
                                // c.ebreak -> ebreak
                                buyruk_r = {32'h00_10_00_73};
                              end 
                              else begin
                                // c.jalr -> jalr x1, rs1, 0
                                buyruk_r = {12'b0, l1b_buyruk_i[11:7], 3'b000, 5'b00001, 7'h67};
                              end
                            end 
                            else begin
                              if (l1b_buyruk_i[11:7] == 5'h00)
                                buyruk_gecerli_r = 1'b0;
                              else
                                // c.add -> add rd, rd, rs2
                                buyruk_r = {7'b0, l1b_buyruk_i[6:2], l1b_buyruk_i[11:7], 3'b0, l1b_buyruk_i[11:7], 7'h33};
                            end
                          end
                        end

                        2'b11: begin
                          // c.swsp -> sw rs2, uimm(x2)
                          buyruk_r = {4'b0, l1b_buyruk_i[8:7], l1b_buyruk_i[12], l1b_buyruk_i[6:2], 5'h02, 3'b010, l1b_buyruk_i[11:9], 2'b00, 7'h23};
                        end
                    endcase
                end
            endcase
        end
    end

    always @(posedge clk_i) begin
        if (rst_i) begin
            getir_buyruk_r <= 0;
            getir_buyruk_gecerli_r <= 0;
            getir_buyruk_compressed_r <= 0;
        end
        else begin
            if (getir_duraklat_i) begin
                getir_buyruk_r <= getir_buyruk_r;
                getir_buyruk_gecerli_r <= getir_buyruk_gecerli_r;
                getir_buyruk_compressed_r <= getir_buyruk_compressed_r;
            end
            else begin
                getir_buyruk_r <= buyruk_r;
                getir_buyruk_gecerli_r <= buyruk_gecerli_r;
                getir_buyruk_compressed_r <= buyruk_compressed_r;
            end
        end
    end
endmodule
