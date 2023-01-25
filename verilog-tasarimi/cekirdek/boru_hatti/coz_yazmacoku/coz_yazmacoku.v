// coz_yazmacoku.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"


module coz_yazmacoku(
    input clk_i,
    input rst_i,

    // GETIR'den gelen sinyaller
    input [31:0] gtr_buyruk_i,
    input [31:0] gtr_ps_i,
    input [31:0] gtr_ps_artmis_i,  // Rd=PC+4/2 islemi icin gerekli

    // YURUT'e giden sinyaller
    output reg [`MI_BIT-1:0] yrt_mikroislem_o,         // mikroislem buyruklara ait tum bilgiyi bitleriyle veriyor
    output reg [       31:0] yrt_deger1_o,             // Yurut birim girdileri. Yonlendirme ve Immediate secilmis son degerler.
    output reg [       31:0] yrt_deger2_o,
    output reg [        2:0] yrt_lt_ltu_eq_o,          // Dallanma ve atlama icin gerekli. Degerler arasindaki iliski. lt_ltu_eq_i: {lessthan,lt_unsigned, equal}
    output reg [        1:0] yrt_buyruk_tipi_o,        // J veya B tipi veya digertip, branch/jump buyruklari icin
    output reg               yrt_yapay_zeka_en_o,      // Yapay zeka biriminin rs2 icin yazma(enable) sinyali
    //
    output reg [       31:0] yrt_ps_artmis_o,      // GERIYAZ'a kadar giden sinyaller
    output reg [        4:0] yrt_rd_adres_o,       // GERIYAZ'a kadar giden sinyaller
    //
    input wire [       31:0] yrt_yonlendir_deger_i, // Yonlendirme (Forwarding) sinyalleri

    // GERIYAZ'dan gelen sinyaller
    input wire [ 4:0] gy_yaz_adres_i,     // Rd'nin adresi
    input wire [31:0] gy_yaz_deger_i,     // Rd'nin degeri
    input wire        gy_yaz_yazmac_i,           // Rd'ye sonuc yazilacak mi

    // Denetim Durum Birimi sinyalleri
    input  wire       ddb_durdur_i,             // COZ'u durdur
    input  wire       ddb_bosalt_i,             // COZ'u bosalt
    input  wire [1:0] ddb_yonlendir_kontrol1_i, // YURUT ve GERIYAZ'dan gelen degerleri yonlendir
    input  wire [1:0] ddb_yonlendir_kontrol2_i,
    output wire [4:0] ddb_rs1_adres_o,          // Suanki buyrugun rs adresleri. Yonlendirme icin.
    output wire [4:0] ddb_rs2_adres_o,
    output reg        ddb_gecersiz_buyruk_o     // Cozulen buyruk gecersiz.
);

    // 30:29, 27, 25, 21:20, 14:12, 6:2
    wire [`BUYRUK_COZ_BIT-1:0] buyruk_coz_w = {gtr_buyruk_i[30:29], gtr_buyruk_i[27], gtr_buyruk_i[25], gtr_buyruk_i[21:20], gtr_buyruk_i[14:12], gtr_buyruk_i[6:2]};

    reg [`MI_BIT-1:0] mikroislem_sonraki_r = 0;

    reg [31:0] imm_r = 0;

    wire [31:0] rs1_deger_w; // okunan 1. yazmac
    wire [31:0] rs2_deger_w; // okunan 2. yazmac

    wire [31:0] deger1_tmp_w = (ddb_yonlendir_kontrol1_i == `YON_GERIYAZ   ) ? gy_yaz_deger_i :
                               (ddb_yonlendir_kontrol1_i == `YON_YURUT     ) ? yrt_yonlendir_deger_i    :
                               (ddb_yonlendir_kontrol1_i == `YON_HICBISEY  ) ? rs1_deger_w    :
                                                                               rs1_deger_w;

    wire [31:0] deger1_w = (mikroislem_sonraki_r[`OPERAND] == `OPERAND_PC) ? gtr_ps_i : deger1_tmp_w;

    wire [31:0] deger2_tmp_w = (mikroislem_sonraki_r[`OPERAND] == `OPERAND_IMM) ? imm_r : rs2_deger_w;

    wire [31:0] deger2_w = (ddb_yonlendir_kontrol2_i  == `YON_GERIYAZ  ) ? gy_yaz_deger_i :
                           (ddb_yonlendir_kontrol2_i  == `YON_YURUT    ) ? yrt_yonlendir_deger_i    :
                           (ddb_yonlendir_kontrol2_i  == `YON_HICBISEY ) ? deger2_tmp_w    :
                                                                           deger2_tmp_w;

    wire lt_w  = ($signed(deger1_tmp_w) < $signed(deger2_w));
    wire ltu_w = (deger1_tmp_w  < deger2_w);
    wire eq_w  = (deger1_tmp_w == deger2_w);

    always @* begin
        ddb_gecersiz_buyruk_o = 1'b0;

        // Cozulmesi gereken bitler 14 bit 30:29, 27, 25, 21:20, 14:12, 6:2
        // bitleri en tamam olandan olmayana kadar gitmek gerek.
        casez(buyruk_coz_w)
            `EBREAK_COZ:     begin mikroislem_sonraki_r = `EBREAK_MI;    end
            `ECALL_COZ:      begin mikroislem_sonraki_r = `ECALL_MI;     end
            `CONV_CLR_W_COZ: begin mikroislem_sonraki_r = `CONV_CLR_W_MI;end
            `CONV_CLR_X_COZ: begin mikroislem_sonraki_r = `CONV_CLR_X_MI;end
            `CONV_RUN_COZ:   begin mikroislem_sonraki_r = `CONV_RUN_MI;  end
            `RVRS_COZ:       begin mikroislem_sonraki_r = `RVRS_MI;      end
            `CNTZ_COZ:       begin mikroislem_sonraki_r = `CNTZ_MI;      end
            `CNTP_COZ:       begin mikroislem_sonraki_r = `CNTP_MI;      end
            `CONV_LD_W_COZ:  begin mikroislem_sonraki_r = `CONV_LD_W_MI; end
            `CONV_LD_X_COZ:  begin mikroislem_sonraki_r = `CONV_LD_X_MI; end
            `ADD_COZ:        begin mikroislem_sonraki_r = `ADD_MI;       end
            `AND_COZ:        begin mikroislem_sonraki_r = `AND_MI;       end
            `DIV_COZ:        begin mikroislem_sonraki_r = `DIV_MI;       end
            `DIVU_COZ:       begin mikroislem_sonraki_r = `DIVU_MI;      end
            `MUL_COZ:        begin mikroislem_sonraki_r = `MUL_MI;       end
            `MULH_COZ:       begin mikroislem_sonraki_r = `MULH_MI;      end
            `MULHSU_COZ:     begin mikroislem_sonraki_r = `MULHSU_MI;    end
            `MULHU_COZ:      begin mikroislem_sonraki_r = `MULHU_MI;     end
            `OR_COZ:         begin mikroislem_sonraki_r = `OR_MI;        end
            `REM_COZ:        begin mikroislem_sonraki_r = `REM_MI;       end
            `REMU_COZ:       begin mikroislem_sonraki_r = `REMU_MI;      end
            `SLL_COZ:        begin mikroislem_sonraki_r = `SLL_MI;       end
            `SLT_COZ:        begin mikroislem_sonraki_r = `SLT_MI;       end
            `SLTU_COZ:       begin mikroislem_sonraki_r = `SLTU_MI;      end
            `SRA_COZ:        begin mikroislem_sonraki_r = `SRA_MI;       end
            `SRL_COZ:        begin mikroislem_sonraki_r = `SRL_MI;       end
            `SUB_COZ:        begin mikroislem_sonraki_r = `SUB_MI;       end
            `XOR_COZ:        begin mikroislem_sonraki_r = `XOR_MI;       end
            `HMDST_COZ:      begin mikroislem_sonraki_r = `HMDST_MI;     end
            `PKG_COZ:        begin mikroislem_sonraki_r = `PKG_MI;       end
            `SLADD_COZ:      begin mikroislem_sonraki_r = `SLADD_MI;     end
            `SLLI_COZ:       begin mikroislem_sonraki_r = `SLLI_MI;      end
            `SRAI_COZ:       begin mikroislem_sonraki_r = `SRAI_MI;      end
            `SRLI_COZ:       begin mikroislem_sonraki_r = `SRLI_MI;      end
            `ADDI_COZ:       begin mikroislem_sonraki_r = `ADDI_MI;      end
            `ANDI_COZ:       begin mikroislem_sonraki_r = `ANDI_MI;      end
            `BEQ_COZ:        begin mikroislem_sonraki_r = `BEQ_MI;       end
            `BGE_COZ:        begin mikroislem_sonraki_r = `BGE_MI;       end
            `BGEU_COZ:       begin mikroislem_sonraki_r = `BGEU_MI;      end
            `BLT_COZ:        begin mikroislem_sonraki_r = `BLT_MI;       end
            `BLTU_COZ:       begin mikroislem_sonraki_r = `BLTU_MI;      end
            `BNE_COZ:        begin mikroislem_sonraki_r = `BNE_MI;       end
            `FENCE_COZ:      begin mikroislem_sonraki_r = `FENCE_MI;     end
            `FENCE_I_COZ:    begin mikroislem_sonraki_r = `FENCE_I_MI;   end
            `JALR_COZ:       begin mikroislem_sonraki_r = `JALR_MI;      end
            `LB_COZ:         begin mikroislem_sonraki_r = `LB_MI;        end
            `LBU_COZ:        begin mikroislem_sonraki_r = `LBU_MI;       end
            `LH_COZ:         begin mikroislem_sonraki_r = `LH_MI;        end
            `LHU_COZ:        begin mikroislem_sonraki_r = `LHU_MI;       end
            `LW_COZ:         begin mikroislem_sonraki_r = `LW_MI;        end
            `ORI_COZ:        begin mikroislem_sonraki_r = `ORI_MI;       end
            `SB_COZ:         begin mikroislem_sonraki_r = `SB_MI;        end
            `SH_COZ:         begin mikroislem_sonraki_r = `SH_MI;        end
            `SLTI_COZ:       begin mikroislem_sonraki_r = `SLTI_MI;      end
            `SLTIU_COZ:      begin mikroislem_sonraki_r = `SLTIU_MI;     end
            `SW_COZ:         begin mikroislem_sonraki_r = `SW_MI;        end
            `XORI_COZ:       begin mikroislem_sonraki_r = `XORI_MI;      end
            `AUIPC_COZ:      begin mikroislem_sonraki_r = `AUIPC_MI;     end
            `JAL_COZ:        begin mikroislem_sonraki_r = `JAL_MI;       end
            `LUI_COZ:        begin mikroislem_sonraki_r = `LUI_MI;       end
            default:         begin
                mikroislem_sonraki_r  = 28'hxxxx_xxx;
                ddb_gecersiz_buyruk_o = 1'b1; // buraya gelirsek exception olmustur. Handle edilmesi gerek. Normalde jump yapilir exception handler'a.
                $display("default");
            end
        endcase
    end

    assign ddb_rs1_adres_o = gtr_buyruk_i[19:15];
    assign ddb_rs2_adres_o = gtr_buyruk_i[24:20];

    // anlik secmek icin buyruk tipini belirle
    reg [2:0] buyruk_tipi_r;
    always @(*) begin
        case(gtr_buyruk_i[6:2])
            5'b00000: begin buyruk_tipi_r = `S_Tipi; end// lw
            5'b01000: begin buyruk_tipi_r = `S_Tipi; end// sw
            5'b01100: begin buyruk_tipi_r =  3'bxxx; end// R tipi. Yazmac buyrugunda anlik yok.
            5'b11000: begin buyruk_tipi_r = `B_Tipi; end// B-tipi
            5'b00100: begin buyruk_tipi_r = `I_Tipi; end// I-tipi ALU
            5'b11011: begin buyruk_tipi_r = `J_Tipi; end// jal
            5'b00101: begin buyruk_tipi_r = `U_Tipi; end// auipc // add upper immediate to pc
            5'b01101: begin buyruk_tipi_r = `U_Tipi; end// lui
            5'b11001: begin buyruk_tipi_r = `I_Tipi; end// jalr I tipinde
            5'b00000: begin buyruk_tipi_r = `I_Tipi; end// reset icin
            default:  begin buyruk_tipi_r =  3'bxxx; end
        endcase

        // buyruk tipine gore anlik sec
        case(buyruk_tipi_r)
            `I_Tipi: begin imm_r = {{20{gtr_buyruk_i[31]}}, gtr_buyruk_i[31:20]};                                       end
            `S_Tipi: begin imm_r = {{20{gtr_buyruk_i[31]}}, gtr_buyruk_i[31:25], gtr_buyruk_i[11:7]};                       end
            `B_Tipi: begin imm_r = {{20{gtr_buyruk_i[31]}}, gtr_buyruk_i[7], gtr_buyruk_i[30:25], gtr_buyruk_i[11:8], 1'b0};    end
            `J_Tipi: begin imm_r = {{12{gtr_buyruk_i[31]}}, gtr_buyruk_i[19:12], gtr_buyruk_i[20], gtr_buyruk_i[30:21], 1'b0};  end
            `U_Tipi: begin imm_r = {gtr_buyruk_i[31:12], 12'b0};                                                    end
            default: begin imm_r = 32'hxxxxxxxx;                                                                end
        endcase
    end


    always @(posedge clk_i) begin
        if (rst_i || ddb_bosalt_i) begin
            yrt_mikroislem_o <= 0;
            yrt_deger1_o <= 0;
            yrt_deger2_o <= 0;
            yrt_rd_adres_o <= 0;
            yrt_yapay_zeka_en_o <= 0;
        end
        else begin
            if(!ddb_durdur_i) begin
                yrt_mikroislem_o <= mikroislem_sonraki_r;
                yrt_deger1_o <= deger1_w;
                yrt_deger2_o <= deger2_w;
                yrt_rd_adres_o <= gtr_buyruk_i[11:7];
                yrt_yapay_zeka_en_o <= gtr_buyruk_i[31];
                yrt_lt_ltu_eq_o <= {lt_w,ltu_w,eq_w};
                yrt_ps_artmis_o <= gtr_ps_artmis_i;
                yrt_buyruk_tipi_o <= buyruk_tipi_r[1:0];
            end
        end
    end

    yazmac_obegi yo(
        .clk_i        (clk_i),
        .rst_i        (rst_i),
        .oku1_adr_i   (gtr_buyruk_i[19:15]),
        .oku2_adr_i   (gtr_buyruk_i[24:20]),
        .oku1_deger_o (rs1_deger_w),
        .oku2_deger_o (rs2_deger_w),
        .yaz_adr_i    (gy_yaz_adres_i),
        .yaz_deger_i  (gy_yaz_deger_i),
        .yaz_i        (gy_yaz_yazmac_i)
    );
endmodule
