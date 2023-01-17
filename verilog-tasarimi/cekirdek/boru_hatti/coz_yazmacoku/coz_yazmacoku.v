// coz_yazmacoku.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// burada sadece buyruklari cozersem yurutte bunlarin gruplanmasi yerine her bir buyruk ayri casede yurutulecek
// ama belki caseler gruplanabilir

// buyruklarin gecersizligine dikkat edilmeli

// denetim durum birimi ile iliskisinin kurulmasi gerek

// bitleri ayarla
module coz_yazmacoku(
    input clk_i,
    input rst_i,

    // compressed buyruklar getirde normal buyruklara donusturulecek
    input [31:0] buyruk_i,
    input [31:0] buyruk_gecerli_i,
    input buyruk_compressed_i,

    output buyruk_compressed_o,

    // geri yazdan gelenler
    input [4:0] yaz_adres_i,
    input [31:0] yaz_deger_i,
    input yaz_yazmac_i,

    //input program_sayaci_i,

    // mikroislem buyruklara ait tum bilgiyi bitleriyle veriyor
    output [`MI_BIT-1:0] buyruk_mikroislem_o, // 0 olursa gecersiz

    // geriye sadece yazmac adresleri ve anlik degerler cikis olarak verilmeli

    output [4:0] rd_adres_o, // geri yaza kadar gitmesi lazim

    output [31:0] rs1_deger_o, // ayni zamanda uimm icin kullan
    output [31:0] rs2_deger_o, // ayni zamanda shamt icin kullan

    output [31:0] imm_o,

    output yz_en_o

);
    assign buyruk_compressed_o = buyruk_compressed_i;

    // 30:29, 27, 25, 21:20, 14:12, 6:2
    wire [`BUYRUK_COZ_BIT-1:0] buyruk_coz_w = {buyruk_i[30:29], buyruk_i[27], buyruk_i[25], buyruk_i[21:20], buyruk_i[14:12], buyruk_i[6:2]};

    assign rd_adres_o = buyruk_i[11:7];
    wire [4:0] rs1_adres_w = buyruk_i[19:15];
    wire [4:0] rs2_adres_w = buyruk_i[24:20];

    // anliklarda burada extend etmek yerine yurutte yapmak hizlandirabilir, buradan az bit cikar
    // anlik degerleri tek bir degiskene atamak yerine hepsi bir sonraki asamaya giris olarak gecsin

    // yapay zeka buyruklari con.ld.w ve conv.ld.x icin enable biti yurute ve yurutten yapay zeka birimine gidecek
    assign yz_en_o = buyruk_i[31];


    reg [`MI_BIT-1:0] mikroislem_r = 0;
    reg [`MI_BIT-1:0] buyruk_mikroislem_r = 0;
    assign buyruk_mikroislem_o = buyruk_mikroislem_r;

    always @* begin
        // Cozulmesi gereken bitler 14 bit 30:29, 27, 25, 21:20, 14:12, 6:2
        // bitleri en tamam olandan olmayana kadar gitmek gerek.
        casez(buyruk_coz_w)
            `EBREAK_COZ: begin
                mikroislem_r = `EBREAK_MI;
            end
            `ECALL_COZ: begin
                mikroislem_r = `ECALL_MI;
            end
            `CONV_CLR_W_COZ: begin
                mikroislem_r = `CONV_CLR_W_MI;
            end
            `CONV_CLR_X_COZ: begin
                mikroislem_r = `CONV_CLR_X_MI;
            end
            `CONV_RUN_COZ: begin
                mikroislem_r = `CONV_RUN_MI;
            end
            `RVRS_COZ: begin
                mikroislem_r = `RVRS_MI;
            end
            `CNTZ_COZ: begin
                mikroislem_r = `CNTZ_MI;
            end
            `CNTP_COZ: begin
                mikroislem_r = `CNTP_MI;
            end
            `CONV_LD_W_COZ: begin
                mikroislem_r = `CONV_LD_W_MI;
            end
            `CONV_LD_X_COZ: begin
                mikroislem_r = `CONV_LD_X_MI;
            end
            `ADD_COZ: begin
                mikroislem_r = `ADD_MI;
            end
            `AND_COZ: begin
                mikroislem_r = `AND_MI;
            end
            `DIV_COZ: begin
                mikroislem_r = `DIV_MI;
            end
            `DIVU_COZ: begin
                mikroislem_r = `DIVU_MI;
            end
            `MUL_COZ: begin
                mikroislem_r = `MUL_MI;
            end
            `MULH_COZ: begin
                mikroislem_r = `MULH_MI;
            end
            `MULHSU_COZ: begin
                mikroislem_r = `MULHSU_MI;
            end
            `MULHU_COZ: begin
                mikroislem_r = `MULHU_MI;
            end
            `OR_COZ: begin
                mikroislem_r = `OR_MI;
            end
            `REM_COZ: begin
                mikroislem_r = `REM_MI;
            end
            `REMU_COZ: begin
                mikroislem_r = `REMU_MI;
            end
            `SLL_COZ: begin
                mikroislem_r = `SLL_MI;
            end
            `SLT_COZ: begin
                mikroislem_r = `SLT_MI;
            end
            `SLTU_COZ: begin
                mikroislem_r = `SLTU_MI;
            end
            `SRA_COZ: begin
                mikroislem_r = `SRA_MI;
            end
            `SRL_COZ: begin
                mikroislem_r = `SRL_MI;
            end
            `SUB_COZ: begin
                mikroislem_r = `SUB_MI;
            end
            `XOR_COZ: begin
                mikroislem_r = `XOR_MI;
            end
            `HMDST_COZ: begin
                mikroislem_r = `HMDST_MI;
            end
            `PKG_COZ: begin
                mikroislem_r = `PKG_MI;
            end
            `SLADD_COZ: begin
                mikroislem_r = `SLADD_MI;
            end
            `SLLI_COZ: begin
                mikroislem_r = `SLLI_MI;
            end
            `SRAI_COZ: begin
                mikroislem_r = `SRAI_MI;
            end
            `SRLI_COZ: begin
                mikroislem_r = `SRLI_MI;
            end
            `ADDI_COZ: begin
                mikroislem_r = `ADDI_MI;
            end
            `ANDI_COZ: begin
                mikroislem_r = `ANDI_MI;
            end
            `BEQ_COZ: begin
                mikroislem_r = `BEQ_MI;
            end
            `BGE_COZ: begin
                mikroislem_r = `BGE_MI;
            end
            `BGEU_COZ: begin
                mikroislem_r = `BGEU_MI;
            end
            `BLT_COZ: begin
                mikroislem_r = `BLT_MI;
            end
            `BLTU_COZ: begin
                mikroislem_r = `BLTU_MI;
            end
            `BNE_COZ: begin
                mikroislem_r = `BNE_MI;
            end
            `FENCE_COZ: begin
                mikroislem_r = `FENCE_MI;
            end
            `FENCE_I_COZ: begin
                mikroislem_r = `FENCE_I_MI;
            end
            `JALR_COZ: begin
                mikroislem_r = `JALR_MI;
            end
            `LB_COZ: begin
                mikroislem_r = `LB_MI;
            end
            `LBU_COZ: begin
                mikroislem_r = `LBU_MI;
            end
            `LH_COZ: begin
                mikroislem_r = `LH_MI;
            end
            `LHU_COZ: begin
                mikroislem_r = `LHU_MI;
            end
            `LW_COZ: begin
                mikroislem_r = `LW_MI;
            end
            `ORI_COZ: begin
                mikroislem_r = `ORI_MI;
            end
            `SB_COZ: begin
                mikroislem_r = `SB_MI;
            end
            `SH_COZ: begin
                mikroislem_r = `SH_MI;
            end
            `SLTI_COZ: begin
                mikroislem_r = `SLTI_MI;
            end
            `SLTIU_COZ: begin
                mikroislem_r = `SLTIU_MI;
            end
            `SW_COZ: begin
                mikroislem_r = `SW_MI;
            end
            `XORI_COZ: begin
                mikroislem_r = `XORI_MI;
            end
            `AUIPC_COZ: begin
                mikroislem_r = `AUIPC_MI;
            end
            `JAL_COZ: begin
                mikroislem_r = `JAL_MI;
            end
            `LUI_COZ: begin
                mikroislem_r = `LUI_MI;
            end
            default: begin
                mikroislem_r = `GECERSIZ;
                $display("default");
            end
        endcase

        if(~buyruk_gecerli_i)
                mikroislem_r = `GECERSIZ;
    end

    // anlik secmek icin buyruk tipini belirle
    reg [2:0] buyruk_tipi;
    always @(*) begin
        case(buyruk_i[6:2])
            7'b00000: buyruk_tipi = `S_Tipi; // lw
            7'b01000: buyruk_tipi = `S_Tipi; // sw
            7'b01100: buyruk_tipi =  3'bxxx; // R tipi. Yazmac buyrugunda anlik yok.
            7'b11000: buyruk_tipi = `B_Tipi; // B-tipi
            7'b00100: buyruk_tipi = `I_Tipi; // I-tipi ALU
            7'b11011: buyruk_tipi = `J_Tipi; // jal
            7'b00101: buyruk_tipi = `U_Tipi; // auipc // add upper immediate to pc
            7'b01101: buyruk_tipi = `U_Tipi; // lui
            7'b11001: buyruk_tipi = `I_Tipi; // jalr I tipinde
            7'b00000: buyruk_tipi = `I_Tipi; // reset icin
            default:  buyruk_tipi =  3'bxxx;
        endcase
    end

    // buyruk tipine gore anlik sec
    always @(posedge clk_i) begin
        case(buyruk_tipi)
            `I_Tipi: imm_o = {{20{buyruk_i[31]}}, buyruk_i[31:20]};
            `S_Tipi: imm_o = {{20{buyruk_i[31]}}, buyruk_i[31:25], buyruk_i[11:7]};
            `B_Tipi: imm_o = {{20{buyruk_i[31]}}, buyruk_i[7], buyruk_i[30:25], buyruk_i[11:8], 1'b0};
            `J_Tipi: imm_o = {{12{buyruk_i[31]}}, buyruk_i[19:12], buyruk_i[20], buyruk_i[30:21], 1'b0};
            `U_Tipi: imm_o = {buyruk_i[31:12], 12'b0};
            default: imm_o = 32'bx;
        endcase
    end

    always @(posedge clk_i) begin
        if (rst_i) begin
            buyruk_mikroislem_r <= 0;
        end
        else begin
            buyruk_mikroislem_r <= mikroislem_r;
        end
    end

    yazmac_obegi yo(
        .clk_i        (clk_i),
        .rst_i        (rst_i),
        .oku1_adr_i   (rs1_adres_w),
        .oku2_adr_i   (rs2_adres_w),
        .oku1_deger_o (rs1_deger_o),
        .oku2_deger_o (rs2_deger_o),
        .yaz_adr_i    (yaz_adres_i),
        .yaz_deger_i  (yaz_deger_i),
        .yaz_i        (yaz_yazmac_i)
    );
endmodule
