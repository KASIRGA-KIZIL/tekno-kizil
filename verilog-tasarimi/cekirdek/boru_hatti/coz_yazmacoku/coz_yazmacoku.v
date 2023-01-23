// coz_yazmacoku.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"


module coz_yazmacoku(
    input clk_i,
    input rst_i,

    // GETIR'den gelen sinyaller
    input [31:0] buyruk_i,
    input buyruk_gecerli_i,
    input [31:0] program_sayaci_i,

    // YURUT'e giden sinyaller
    output reg [`MI_BIT-1:0] mikroislem_o,  // mikroislem buyruklara ait tum bilgiyi bitleriyle veriyor
    output reg [31:0] deger1_o,             // Yurut birim girdileri. Yonlendirme ve Immediate secilmis son degerler.
    output reg [31:0] deger2_o,
    output reg [ 2:0] lt_ltu_eq_o,          // Dallanma ve atlama icin gerekli. Degerler arasindaki iliski. lt_ltu_eq_i: {lessthan,lt_unsigned, equal}
    output reg [ 1:0] buyruk_tipi_o,        // J veya B tipi veya digertip, branch/jump buyruklari icin
    output reg        yapay_zeka_en_o,       // Yapay zeka biriminin rs2 icin yazma(enable) sinyali

    // GERIYAZ'a kadar giden sinyaller
    input      [31:0] program_sayaci_artmis_i,  // Rd=PC+4/2 islemi icin gerekli
    output reg [31:0] program_sayaci_artmis_o,  // Rd=PC+4/2 islemi icin gerekli
    output reg [ 4:0] rd_adres_o,               // Rd'nin adresi

    // GERIYAZ'dan gelen sinyaller
    input [4:0]  yaz_adres_i,     // Rd'nin adresi
    input [31:0] yaz_deger_i,     // Rd'nin degeri
    input yaz_yazmac_i,           // Rd'ye sonuc yazilacak mi

    // Yonlendirme (Forwarding) sinyalleri
    input [31:0] yonlendir_yurut_deger_i,

    // Denetim Durum Birimi sinyalleri
    input        durdur_i,           // COZ'u durdur
    input        bosalt_i,           // COZ'u bosalt
    input  [1:0] yonlendir_kontrol1_i, // YURUT ve GERIYAZ'dan gelen degerleri yonlendir
    input  [1:0] yonlendir_kontrol2_i,
    output [4:0] rs1_adres_o,        // Suanki buyrugun rs adresleri. Yonlendirme icin.
    output [4:0] rs2_adres_o,
    output       gecersiz_buyruk_o   // Cozulen buyruk gecersiz.
);

    reg [31:0] buyruk_r = 0;
    reg buyruk_compressed_r = 0;
    reg buyruk_gecerli_r = 0;
    
    // 30:29, 27, 25, 21:20, 14:12, 6:2
    wire [`BUYRUK_COZ_BIT-1:0] buyruk_coz_w = {buyruk_r[30:29], buyruk_r[27], buyruk_r[25], buyruk_r[21:20], buyruk_r[14:12], buyruk_r[6:2]};

    wire [4:0] rs1_adres_w = buyruk_r[19:15];
    wire [4:0] rs2_adres_w = buyruk_r[24:20];

    reg [`MI_BIT-1:0] mikroislem_sonraki_r = 0;

    reg [31:0] deger1_sonraki_r = 0;

    reg [31:0] deger2_sonraki_r = 0;

    reg [31:0] imm_r = 0;

    reg [31:0] program_sayaci_sonraki_r = 0;

    reg yz_en_sonraki_r = 0;

    reg gecersiz_buyruk_r = 0;

    wire [31:0] rs1_deger_w; // okunan 1. yazmac
    wire [31:0] rs2_deger_w; // okunan 2. yazmac

    wire [31:0] deger1_tmp_w = (yonlendir_kontrol1_i == `YON_GERIYAZ   ) ? yaz_deger_i :
                               (yonlendir_kontrol1_i == `YON_YURUT     ) ? yonlendir_yurut_deger_i    :
                               (yonlendir_kontrol1_i == `YON_HICBISEY  ) ? rs1_deger_w    :
                                                                                    rs1_deger_w;

    wire [31:0] deger1_w = (mikroislem_sonraki_r[`OPERAND] == `OPERAND_PC) ? program_sayaci_i : deger1_tmp_w;

    wire [31:0] deger2_tmp_w = (mikroislem_sonraki_r[`OPERAND] == `OPERAND_IMM) ? imm_r : rs2_deger_w;

    wire [31:0] deger2_w = (yonlendir_kontrol2_i  == `YON_GERIYAZ  ) ? yaz_deger_i :
                           (yonlendir_kontrol2_i  == `YON_YURUT    ) ? yonlendir_yurut_deger_i    :
                           (yonlendir_kontrol2_i  == `YON_HICBISEY ) ? deger2_tmp_w    :
                                                                                deger2_tmp_w;

    wire lt_w  = ($signed(deger1_tmp_w) < $signed(deger2_w));
    wire ltu_w = (deger1_tmp_w  < deger2_w);
    wire eq_w  = (deger1_tmp_w == deger2_w);

    // 16 bit compressedleri 32 bit buyruklara genislet
    always @* begin
        buyruk_r = 1'b0;
        buyruk_gecerli_r = 1'b0;
        buyruk_compressed_r = 1'b0;
        
        if(buyruk_gecerli_i) begin
            buyruk_gecerli_r = 1'b1;
            
            case (buyruk_i[1:0])
                // 32 bit buyruk
                2'b11: begin
                    buyruk_r = buyruk_i;
                    buyruk_gecerli_r = 1'b1; // burada gecerliymis kabul et cozde gecersizleri belirlersin
                    buyruk_compressed_r = 1'b0;
                end

                // if-elseleri kaldirarak kendi icinde bitleri orlayabilirim
                // compressedler icin de tanimlamalar.vhta tablo kurulup burada genisletilebilir, dest0var, dest0yok gibi

                // Compressedleri getirde 32 bit buyruk esleniklerine genisletiyoruz
                
                // compressed 16 bit quadrant 0
                2'b00: begin
                    buyruk_compressed_r = 1'b1;
                    
                    case (buyruk_i[15:14])
                        2'b00: begin
                          //if(buyruk_i[12:5] == 8'h00)
                          //    buyruk_gecerli_r = 1'b0;
                          //else
                            buyruk_gecerli_r = |buyruk_i[12:5];
                              // c.addi4spn -> addi rd', x2, nzuimm
                              buyruk_r = {2'b0, buyruk_i[10:7], buyruk_i[12:11], buyruk_i[5], buyruk_i[6], 2'b00, 5'h02, 3'b000, 2'b01, buyruk_i[4:2], 7'h13};
                        end

                        2'b01: begin
                          // c.lw -> lw rd', uimm(rs1')
                          buyruk_r = {5'b0, buyruk_i[5], buyruk_i[12:10], buyruk_i[6], 2'b00, 2'b01, buyruk_i[9:7], 3'b010, 2'b01, buyruk_i[4:2], 7'h03};
                        end
                           
                        2'b10: begin
                          buyruk_gecerli_r = 1'b0;
                        end

                        2'b11: begin
                          // c.sw -> sw rs2', uimm(rs1')
                          buyruk_r = {5'b0, buyruk_i[5], buyruk_i[12], 2'b01, buyruk_i[4:2], 2'b01, buyruk_i[9:7], 3'b010, buyruk_i[11:10], buyruk_i[6], 2'b00, 7'h23};
                        end
                    endcase
                end

                // compressed 16 bit quadrant 1
                2'b01: begin
                    buyruk_compressed_r = 1'b1;
                    
                    case (buyruk_i[15:13])
                        3'b000: begin
                          // c.addi -> addi rd, rd, nzimm
                          // c.nop -> addi, 0, 0, 0
                          // normalde c.addi icin nzimm non-zero kontrolu yapilmasi lazim ama c.nop ile beraber bu kontrole gerek yok burada
                          buyruk_r = {{6 {buyruk_i[12]}}, buyruk_i[12], buyruk_i[6:2], buyruk_i[11:7], 3'b0, buyruk_i[11:7], 7'h13};
                        end

                        3'b001, 
                        3'b101: begin
                          // 001: c.jal -> jal x1, imm
                          // 101: c.j   -> jal x0, imm
                          buyruk_r = {buyruk_i[12], buyruk_i[8], buyruk_i[10:9], buyruk_i[6], buyruk_i[7], buyruk_i[2], buyruk_i[11], buyruk_i[5:3], {9 {buyruk_i[12]}}, 4'b0, ~buyruk_i[15], 7'h6f};
                        end

                        3'b010: begin
                          //if(buyruk_i[11:7] == 5'h00)
                          //    buyruk_gecerli_r = 1'b0;
                          //else
                            buyruk_gecerli_r = |buyruk_i[11:7];
                              // c.li -> addi rd, x0, imm
                              buyruk_r = {{6 {buyruk_i[12]}}, buyruk_i[12], buyruk_i[6:2], 5'b0, 3'b0, buyruk_i[11:7], 7'h13};
                        end

                        3'b011: begin
                            //if (buyruk_i[11:7] == 5'h02) begin
                            //  //if({buyruk_i[12], buyruk_i[6:2]} == 6'h00)
                            //  //  buyruk_gecerli_r = 1'b0;
                            //  //else
                            //    buyruk_gecerli_r = |{buyruk_i[12], buyruk_i[6:2]};
                            //    // c.addi16sp -> addi x2, x2, nzimm
                            //    buyruk_r = {{3 {buyruk_i[12]}}, buyruk_i[4:3], buyruk_i[5], buyruk_i[2], buyruk_i[6], 4'b0, 5'h02, 3'b000, 5'h02, 7'h13};
                            //end
                            //else if (buyruk_i[11:7] == 5'h00) begin
                            //  buyruk_gecerli_r = 1'b0;
                            //end
                            
                            case(buyruk_i[11:7])
                                5'h00: begin
                                    buyruk_gecerli_r = 1'b0;
                                end
                                5'h02: begin
                                    buyruk_gecerli_r = |{buyruk_i[12], buyruk_i[6:2]};
                                    buyruk_r = {{3 {buyruk_i[12]}}, buyruk_i[4:3], buyruk_i[5], buyruk_i[2], buyruk_i[6], 4'b0, 5'h02, 3'b000, 5'h02, 7'h13};
                                end
                                default: begin
                                    buyruk_gecerli_r = |{buyruk_i[12], buyruk_i[6:2]};
                                    // c.lui -> lui rd, nzimm
                                    buyruk_r = {{15 {buyruk_i[12]}}, buyruk_i[6:2], buyruk_i[11:7], 7'h37};
                                end
                            endcase


                            //else begin
                            //  if({buyruk_i[12], buyruk_i[6:2]} == 6'h00)
                            //    buyruk_gecerli_r = 1'b0;
                            //  else
                            //    // c.lui -> lui rd, nzimm
                            //    buyruk_r = {{15 {buyruk_i[12]}}, buyruk_i[6:2], buyruk_i[11:7], 7'h37};
                            //end

                        end

                        3'b100: begin
                          case (buyruk_i[11:10])
                            2'b00,
                            2'b01: begin
                              //if(buyruk_i[12] == 1'b1) // must be zero
                              //  buyruk_gecerli_r = 1'b0;
                              //else
                                // burada 12.yi kontrol etmeme gerek yok
                                //if({buyruk_i[12], buyruk_i[6:2]} == 6'h00) // shift amount must be non-zero
                                //  buyruk_gecerli_r = 1'b0;
                                //else
                                // burayi tekrar kontrol et TODO
                                buyruk_gecerli_r = ~buyruk_i[12] & |buyruk_i[6:2];
                                  // 00: c.srli -> srli rd, rd, shamt
                                  // 01: c.srai -> srai rd, rd, shamt
                                  buyruk_r = {1'b0, buyruk_i[10], 5'b0, buyruk_i[6:2], 2'b01, buyruk_i[9:7], 3'b101, 2'b01, buyruk_i[9:7], 7'h13};
                            end

                            2'b10: begin
                              // c.andi -> andi rd, rd, imm
                              buyruk_r = {{6 {buyruk_i[12]}}, buyruk_i[12], buyruk_i[6:2], 2'b01, buyruk_i[9:7], 3'b111, 2'b01, buyruk_i[9:7], 7'h13};
                            end

                            2'b11: begin
                              case (buyruk_i[6:5])
                                2'b00: begin
                                  // c.sub -> sub rd', rd', rs2'
                                  buyruk_r = {2'b01, 5'b0, 2'b01, buyruk_i[4:2], 2'b01, buyruk_i[9:7], 3'b000, 2'b01, buyruk_i[9:7], 7'h33};
                                end

                                2'b01: begin
                                  // c.xor -> xor rd', rd', rs2'
                                  buyruk_r = {7'b0, 2'b01, buyruk_i[4:2], 2'b01, buyruk_i[9:7], 3'b100, 2'b01, buyruk_i[9:7], 7'h33};
                                end

                                2'b10: begin
                                  // c.or  -> or  rd', rd', rs2'
                                  buyruk_r = {7'b0, 2'b01, buyruk_i[4:2], 2'b01, buyruk_i[9:7], 3'b110, 2'b01, buyruk_i[9:7], 7'h33};
                                end

                                2'b11: begin
                                  // c.and -> and rd', rd', rs2'
                                  buyruk_r = {7'b0, 2'b01, buyruk_i[4:2], 2'b01, buyruk_i[9:7], 3'b111, 2'b01, buyruk_i[9:7], 7'h33};
                                end
                              endcase
                            end
                          endcase
                        end

                        3'b110, 
                        3'b111: begin
                          // 110: c.beqz -> beq rs1', x0, imm
                          // 111: c.bnez -> bne rs1', x0, imm
                          buyruk_r = {{4 {buyruk_i[12]}}, buyruk_i[6:5], buyruk_i[2], 5'b0, 2'b01, buyruk_i[9:7], 2'b00, buyruk_i[13], buyruk_i[11:10], buyruk_i[4:3], buyruk_i[12], 7'h63};
                        end
                    endcase
                end

                // compressed 16 bit quadrant 2
                2'b10: begin
                    buyruk_compressed_r = 1'b1;
                    
                    case (buyruk_i[15:14])
                        2'b00: begin
                          //if(buyruk_i[12] == 1'b1) // must be zero
                          //  buyruk_gecerli_r = 1'b0;
                          //else
                          //  // burada 12.yi kontrol etmeme gerek yok
                          //  if({buyruk_i[12], buyruk_i[6:2]} == 6'h00) // shift amount must be non-zero
                          //    buyruk_gecerli_r = 1'b0;
                          //  else
                            // burayi tekrar kontrol et TODO
                            buyruk_gecerli_r = ~buyruk_i[12] & |buyruk_i[6:2];
                              // c.slli -> slli rd, rd, shamt
                              buyruk_r = {7'b0, buyruk_i[6:2], buyruk_i[11:7], 3'b001, buyruk_i[11:7], 7'h13};
                        end

                        2'b01: begin
                          //if(buyruk_i[11:7] == 5'h00)
                          //  buyruk_gecerli_r = 1'b0;
                          //else
                            buyruk_gecerli_r = |buyruk_i[11:7];
                            // c.lwsp -> lw rd, uimm(x2)
                            buyruk_r = {4'b0, buyruk_i[3:2], buyruk_i[12], buyruk_i[6:4], 2'b00, 5'h02, 3'b010, buyruk_i[11:7], 7'h03};
                        end

                        2'b10: begin
                            case(buyruk_i[12])
                                1'b0: begin
                                    //if (buyruk_i[11:7] == 5'h00) begin
                                //  buyruk_gecerli_r = 1'b0;
                                //end
                                //else begin
                                buyruk_gecerli_r = |buyruk_i[11:7];

                                case(buyruk_i[6:2])
                                    5'h00:
                                        // c.jr -> jalr x0, rd/rs1, 0
                                        buyruk_r = {12'b0, buyruk_i[11:7], 3'b0, 5'b0, 7'h67};
                                    default:
                                        // c.mv -> add rd/rs1, x0, rs2
                                        buyruk_r = {7'b0, buyruk_i[6:2], 5'b0, 3'b0, buyruk_i[11:7], 7'h33};
                                endcase
                                end
                                  //if (buyruk_i[6:2] == 5'h00) begin
                                  //  // c.jr -> jalr x0, rd/rs1, 0
                                  //  buyruk_r = {12'b0, buyruk_i[11:7], 3'b0, 5'b0, 7'h67};
                                  //end 
                                  //else begin
                                  //  // c.mv -> add rd/rs1, x0, rs2
                                  //  buyruk_r = {7'b0, buyruk_i[6:2], 5'b0, 3'b0, buyruk_i[11:7], 7'h33};
                                  //end
                                //end

                                //1'b1:
                                default: begin
                                    case(buyruk_i[6:2])
                                        5'h00:
                                            case(buyruk_i[11:7])
                                                5'h00:
                                                    // c.ebreak -> ebreak
                                                    buyruk_r = {32'h00_10_00_73};

                                                default:
                                                    // c.jalr -> jalr x1, rs1, 0
                                                    buyruk_r = {12'b0, buyruk_i[11:7], 3'b000, 5'b00001, 7'h67};
                                            endcase
                                        
                                        default: begin
                                            buyruk_gecerli_r = |buyruk_i[11:7];
                                            // c.add -> add rd, rd, rs2
                                            buyruk_r = {7'b0, buyruk_i[6:2], buyruk_i[11:7], 3'b0, buyruk_i[11:7], 7'h33};
                                        end
                                    endcase
                                    end
                                    //if (buyruk_i[6:2] == 5'h00) begin
                                    //    case(buyruk_i[11:7])
                                    //        5'h00:
                                    //            // c.ebreak -> ebreak
                                    //            buyruk_r = {32'h00_10_00_73};
//      
                                    //        default:
                                    //            // c.jalr -> jalr x1, rs1, 0
                                    //            buyruk_r = {12'b0, buyruk_i[11:7], 3'b000, 5'b00001, 7'h67};
                                    //    endcase
                                    //  //if (buyruk_i[11:7] == 5'h00) begin
                                    //  //  // c.ebreak -> ebreak
                                    //  //  buyruk_r = {32'h00_10_00_73};
                                    //  //end 
                                    //  //else begin
                                    //  //  // c.jalr -> jalr x1, rs1, 0
                                    //  //  buyruk_r = {12'b0, buyruk_i[11:7], 3'b000, 5'b00001, 7'h67};
                                    //  //end
                                    //end 
                                    //else begin
                                    //  //if (buyruk_i[11:7] == 5'h00)
                                    //  //  buyruk_gecerli_r = 1'b0;
                                    //  //else
                                    //    buyruk_gecerli_r = |buyruk_i[11:7];
                                    //    // c.add -> add rd, rd, rs2
                                    //    buyruk_r = {7'b0, buyruk_i[6:2], buyruk_i[11:7], 3'b0, buyruk_i[11:7], 7'h33};
                                    //end

                            endcase

                          //if (buyruk_i[12] == 1'b0) begin
                          //  1'b0:
                          //          //if (buyruk_i[11:7] == 5'h00) begin
                          //      //  buyruk_gecerli_r = 1'b0;
                          //      //end
                          //      //else begin
                          //      buyruk_gecerli_r = |buyruk_i[11:7];
//
                          //      case(buyruk_i[6:2])
                          //          5'h00:
                          //              // c.jr -> jalr x0, rd/rs1, 0
                          //              buyruk_r = {12'b0, buyruk_i[11:7], 3'b0, 5'b0, 7'h67};
                          //          default:
                          //              // c.mv -> add rd/rs1, x0, rs2
                          //              buyruk_r = {7'b0, buyruk_i[6:2], 5'b0, 3'b0, buyruk_i[11:7], 7'h33};
                          //      endcase
//
                          //        //if (buyruk_i[6:2] == 5'h00) begin
                          //        //  // c.jr -> jalr x0, rd/rs1, 0
                          //        //  buyruk_r = {12'b0, buyruk_i[11:7], 3'b0, 5'b0, 7'h67};
                          //        //end 
                          //        //else begin
                          //        //  // c.mv -> add rd/rs1, x0, rs2
                          //        //  buyruk_r = {7'b0, buyruk_i[6:2], 5'b0, 3'b0, buyruk_i[11:7], 7'h33};
                          //        //end
                          //      //end
                          //end
                          //else begin
                          //  case(buyruk_i[6:2])
                          //              5'h00:
                          //                  case(buyruk_i[11:7])
                          //                      5'h00:
                          //                          // c.ebreak -> ebreak
                          //                          buyruk_r = {32'h00_10_00_73};
//
                          //                      default:
                          //                          // c.jalr -> jalr x1, rs1, 0
                          //                          buyruk_r = {12'b0, buyruk_i[11:7], 3'b000, 5'b00001, 7'h67};
                          //                  endcase
                          //              
                          //              default: begin
                          //                  buyruk_gecerli_r = |buyruk_i[11:7];
                          //                  // c.add -> add rd, rd, rs2
                          //                  buyruk_r = {7'b0, buyruk_i[6:2], buyruk_i[11:7], 3'b0, buyruk_i[11:7], 7'h33};
                          //              end
                          //          endcase
                          //      
                          //          //if (buyruk_i[6:2] == 5'h00) begin
                          //          //    case(buyruk_i[11:7])
                          //          //        5'h00:
                          //          //            // c.ebreak -> ebreak
                          //          //            buyruk_r = {32'h00_10_00_73};
//      //
                          //          //        default:
                          //          //            // c.jalr -> jalr x1, rs1, 0
                          //          //            buyruk_r = {12'b0, buyruk_i[11:7], 3'b000, 5'b00001, 7'h67};
                          //          //    endcase
                          //          //  //if (buyruk_i[11:7] == 5'h00) begin
                          //          //  //  // c.ebreak -> ebreak
                          //          //  //  buyruk_r = {32'h00_10_00_73};
                          //          //  //end 
                          //          //  //else begin
                          //          //  //  // c.jalr -> jalr x1, rs1, 0
                          //          //  //  buyruk_r = {12'b0, buyruk_i[11:7], 3'b000, 5'b00001, 7'h67};
                          //          //  //end
                          //          //end 
                          //          //else begin
                          //          //  //if (buyruk_i[11:7] == 5'h00)
                          //          //  //  buyruk_gecerli_r = 1'b0;
                          //          //  //else
                          //          //    buyruk_gecerli_r = |buyruk_i[11:7];
                          //          //    // c.add -> add rd, rd, rs2
                          //          //    buyruk_r = {7'b0, buyruk_i[6:2], buyruk_i[11:7], 3'b0, buyruk_i[11:7], 7'h33};
                          //          //end
                          //end
                        end

                        2'b11: begin
                          // c.swsp -> sw rs2, uimm(x2)
                          buyruk_r = {4'b0, buyruk_i[8:7], buyruk_i[12], buyruk_i[6:2], 5'h02, 3'b010, buyruk_i[11:9], 2'b00, 7'h23};
                        end
                    endcase
                end
            endcase
        end
    end
    
    always @* begin
        //gecersiz_buyruk_r = 1'b0;
        gecersiz_buyruk_r = ~buyruk_gecerli_r;
        
        // Cozulmesi gereken bitler 14 bit 30:29, 27, 25, 21:20, 14:12, 6:2
        // bitleri en tamam olandan olmayana kadar gitmek gerek.
        casez(buyruk_coz_w)
            `EBREAK_COZ: begin
                mikroislem_sonraki_r = `EBREAK_MI;
            end
            `ECALL_COZ: begin
                mikroislem_sonraki_r = `ECALL_MI;
            end
            `CONV_CLR_W_COZ: begin
                mikroislem_sonraki_r = `CONV_CLR_W_MI;
            end
            `CONV_CLR_X_COZ: begin
                mikroislem_sonraki_r = `CONV_CLR_X_MI;
            end
            `CONV_RUN_COZ: begin
                mikroislem_sonraki_r = `CONV_RUN_MI;
            end
            `RVRS_COZ: begin
                mikroislem_sonraki_r = `RVRS_MI;
            end
            `CNTZ_COZ: begin
                mikroislem_sonraki_r = `CNTZ_MI;
            end
            `CNTP_COZ: begin
                mikroislem_sonraki_r = `CNTP_MI;
            end
            `CONV_LD_W_COZ: begin
                mikroislem_sonraki_r = `CONV_LD_W_MI;
            end
            `CONV_LD_X_COZ: begin
                mikroislem_sonraki_r = `CONV_LD_X_MI;
            end
            `ADD_COZ: begin
                mikroislem_sonraki_r = `ADD_MI;
            end
            `AND_COZ: begin
                mikroislem_sonraki_r = `AND_MI;
            end
            `DIV_COZ: begin
                mikroislem_sonraki_r = `DIV_MI;
            end
            `DIVU_COZ: begin
                mikroislem_sonraki_r = `DIVU_MI;
            end
            `MUL_COZ: begin
                mikroislem_sonraki_r = `MUL_MI;
            end
            `MULH_COZ: begin
                mikroislem_sonraki_r = `MULH_MI;
            end
            `MULHSU_COZ: begin
                mikroislem_sonraki_r = `MULHSU_MI;
            end
            `MULHU_COZ: begin
                mikroislem_sonraki_r = `MULHU_MI;
            end
            `OR_COZ: begin
                mikroislem_sonraki_r = `OR_MI;
            end
            `REM_COZ: begin
                mikroislem_sonraki_r = `REM_MI;
            end
            `REMU_COZ: begin
                mikroislem_sonraki_r = `REMU_MI;
            end
            `SLL_COZ: begin
                mikroislem_sonraki_r = `SLL_MI;
            end
            `SLT_COZ: begin
                mikroislem_sonraki_r = `SLT_MI;
            end
            `SLTU_COZ: begin
                mikroislem_sonraki_r = `SLTU_MI;
            end
            `SRA_COZ: begin
                mikroislem_sonraki_r = `SRA_MI;
            end
            `SRL_COZ: begin
                mikroislem_sonraki_r = `SRL_MI;
            end
            `SUB_COZ: begin
                mikroislem_sonraki_r = `SUB_MI;
            end
            `XOR_COZ: begin
                mikroislem_sonraki_r = `XOR_MI;
            end
            `HMDST_COZ: begin
                mikroislem_sonraki_r = `HMDST_MI;
            end
            `PKG_COZ: begin
                mikroislem_sonraki_r = `PKG_MI;
            end
            `SLADD_COZ: begin
                mikroislem_sonraki_r = `SLADD_MI;
            end
            `SLLI_COZ: begin
                mikroislem_sonraki_r = `SLLI_MI;
            end
            `SRAI_COZ: begin
                mikroislem_sonraki_r = `SRAI_MI;
            end
            `SRLI_COZ: begin
                mikroislem_sonraki_r = `SRLI_MI;
            end
            `ADDI_COZ: begin
                mikroislem_sonraki_r = `ADDI_MI;
            end
            `ANDI_COZ: begin
                mikroislem_sonraki_r = `ANDI_MI;
            end
            `BEQ_COZ: begin
                mikroislem_sonraki_r = `BEQ_MI;
            end
            `BGE_COZ: begin
                mikroislem_sonraki_r = `BGE_MI;
            end
            `BGEU_COZ: begin
                mikroislem_sonraki_r = `BGEU_MI;
            end
            `BLT_COZ: begin
                mikroislem_sonraki_r = `BLT_MI;
            end
            `BLTU_COZ: begin
                mikroislem_sonraki_r = `BLTU_MI;
            end
            `BNE_COZ: begin
                mikroislem_sonraki_r = `BNE_MI;
            end
            `FENCE_COZ: begin
                mikroislem_sonraki_r = `FENCE_MI;
            end
            `FENCE_I_COZ: begin
                mikroislem_sonraki_r = `FENCE_I_MI;
            end
            `JALR_COZ: begin
                mikroislem_sonraki_r = `JALR_MI;
            end
            `LB_COZ: begin
                mikroislem_sonraki_r = `LB_MI;
            end
            `LBU_COZ: begin
                mikroislem_sonraki_r = `LBU_MI;
            end
            `LH_COZ: begin
                mikroislem_sonraki_r = `LH_MI;
            end
            `LHU_COZ: begin
                mikroislem_sonraki_r = `LHU_MI;
            end
            `LW_COZ: begin
                mikroislem_sonraki_r = `LW_MI;
            end
            `ORI_COZ: begin
                mikroislem_sonraki_r = `ORI_MI;
            end
            `SB_COZ: begin
                mikroislem_sonraki_r = `SB_MI;
            end
            `SH_COZ: begin
                mikroislem_sonraki_r = `SH_MI;
            end
            `SLTI_COZ: begin
                mikroislem_sonraki_r = `SLTI_MI;
            end
            `SLTIU_COZ: begin
                mikroislem_sonraki_r = `SLTIU_MI;
            end
            `SW_COZ: begin
                mikroislem_sonraki_r = `SW_MI;
            end
            `XORI_COZ: begin
                mikroislem_sonraki_r = `XORI_MI;
            end
            `AUIPC_COZ: begin
                mikroislem_sonraki_r = `AUIPC_MI;
            end
            `JAL_COZ: begin
                mikroislem_sonraki_r = `JAL_MI;
            end
            `LUI_COZ: begin
                mikroislem_sonraki_r = `LUI_MI;
            end
            default: begin
                mikroislem_sonraki_r = 28'hxxxx_xxx;
                gecersiz_buyruk_r    = 1'b1; // buraya gelirsek exception olmustur. Handle edilmesi gerek. Normalde jump yapilir exception handler'a.
                $display("default");
            end
        endcase
        /* GETIR'den gelen buyruk gecerli sinyali DDB'ye gidecek. DDB cozu durduracak. Bu exception degil bubble durumu.
        if(~buyruk_gecerli_i)
            mikroislem_sonraki_r = `GECERSIZ;
        */
    end

    assign gecersiz_buyruk_o = gecersiz_buyruk_r;
    assign rs1_adres_o = buyruk_i[19:15];
    assign rs2_adres_o = buyruk_i[24:20];

    // anlik secmek icin buyruk tipini belirle
    reg [2:0] buyruk_tipi_r;
    always @(*) begin
        case(buyruk_i[6:2])
            5'b00000: buyruk_tipi_r = `S_Tipi; // lw
            5'b01000: buyruk_tipi_r = `S_Tipi; // sw
            5'b01100: buyruk_tipi_r =  3'bxxx; // R tipi. Yazmac buyrugunda anlik yok.
            5'b11000: buyruk_tipi_r = `B_Tipi; // B-tipi
            5'b00100: buyruk_tipi_r = `I_Tipi; // I-tipi ALU
            5'b11011: buyruk_tipi_r = `J_Tipi; // jal
            5'b00101: buyruk_tipi_r = `U_Tipi; // auipc // add upper immediate to pc
            5'b01101: buyruk_tipi_r = `U_Tipi; // lui
            5'b11001: buyruk_tipi_r = `I_Tipi; // jalr I tipinde
            5'b00000: buyruk_tipi_r = `I_Tipi; // reset icin
            default:  buyruk_tipi_r =  3'bxxx;
        endcase

        // buyruk tipine gore anlik sec
        case(buyruk_tipi_r)
            `I_Tipi: imm_r = {{20{buyruk_i[31]}}, buyruk_i[31:20]};
            `S_Tipi: imm_r = {{20{buyruk_i[31]}}, buyruk_i[31:25], buyruk_i[11:7]};
            `B_Tipi: imm_r = {{20{buyruk_i[31]}}, buyruk_i[7], buyruk_i[30:25], buyruk_i[11:8], 1'b0};
            `J_Tipi: imm_r = {{12{buyruk_i[31]}}, buyruk_i[19:12], buyruk_i[20], buyruk_i[30:21], 1'b0};
            `U_Tipi: imm_r = {buyruk_i[31:12], 12'b0};
            default: imm_r = 32'hxxxxxxxx;
        endcase

        // TODO
        // burasi daha optimize edilebilir, eger SRAI geldiyse ust 30.bitinde kalan 1i temizle
        // ayrica digerlerinde de sign extend yapmamis oluyoruz
        // imm_r = {{27{1'b0}}, buyruk_i[24:20]};
        // burasi 0li?
        // eger yurutte son 5 bite bakiliyorsa burada bu kontrole gerek yok
        //if(mikroislem_sonraki_r == `SLLI_MI)
        //    imm_r[31:5] = {27{1'b0}};
        //if(mikroislem_sonraki_r == `SRLI_MI)
        //    imm_r[31:5] = {27{1'b0}};
        //if(mikroislem_sonraki_r == `SRAI_MI)
        //    imm_r[31:5] = {27{1'b0}};
    end


    always @(posedge clk_i) begin
        if (rst_i || bosalt_i) begin
            mikroislem_o <= 0;
            deger1_o <= 0;
            deger2_o <= 0;
            rd_adres_o <= 0;
            yapay_zeka_en_o <= 0;
        end
        else begin
            if(!durdur_i) begin
                mikroislem_o <= mikroislem_sonraki_r;
                deger1_o <= deger1_w;
                deger2_o <= deger2_w;
                rd_adres_o <= buyruk_i[11:7];
                yapay_zeka_en_o <= buyruk_i[31];
                lt_ltu_eq_o <= {lt_w,ltu_w,eq_w};
                program_sayaci_artmis_o <= program_sayaci_artmis_i;
                buyruk_tipi_o <= buyruk_tipi_r[1:0];
            end
        end
    end

    yazmac_obegi yo(
        .clk_i        (clk_i),
        .rst_i        (rst_i),
        .oku1_adr_i   (rs1_adres_w),
        .oku2_adr_i   (rs2_adres_w),
        .oku1_deger_o (rs1_deger_w),
        .oku2_deger_o (rs2_deger_w),
        .yaz_adr_i    (yaz_adres_i),
        .yaz_deger_i  (yaz_deger_i),
        .yaz_i        (yaz_yazmac_i)
    );
endmodule
