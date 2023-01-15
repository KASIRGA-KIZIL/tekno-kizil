// coz.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// burada sadece buyruklari cozersem yurutte bunlarin gruplanmasi yerine her bir buyruk ayri casede yurutulecek
// ama belki caseler gruplanabilir

// buyruklarin gecersizligi de burada verilmeli caddi4spn gibi

// bitleri ayarla
module coz(
    input clk_i,
    input rst_i,

    input [31:0] buyruk_i, // buyrugun alt 16 biti compressed olacak
    //input program_sayaci_i,

    output [6:0] buyruk_mikroislem_o, // 0 olursa gecersiz
    
    // icini buradan alamayiz sanirim
    //output kaynak_yazmaci1_degeri_o, // ici
    //output kaynak_yazmaci2_degeri_o // ici
    
    // bunlar icin getirde compressed oldugunu anlayip baslarina iki 0 atmak lazim
    // getirden bu asamaya giris olarak compressed mi gelmesi lazim
    // ya da sonu 11 degilse compressed oldugunu varsayarak cikis verelim burada

    output [4:0] rd_o,
    output [4:0] rs1_o, // ayni zamanda uimm icin kullan
    output [4:0] rs2_o, // ayni zamanda shamt icin kullan

    output [31:0] i_imm_o, // fencete ve csrlarda kullan
    output [31:0] s_imm_o,
    output [31:0] b_imm_o,
    output [31:0] u_imm_o,
    output [31:0] j_imm_o,

    // compressed cikislari eksik simdilik
    output [9:0] nzuimm_o // sext olacak mi?

    // amb buyrugu
    // x buyrugu
    // ...

);

    wire [31:0] buyruk_w;
    assign buyruk_w = buyruk_i;

    //assign opcode_w = buyruk_w[6:0];
    //assign func3_w = buyruk_w[14:12];
    //assign func7_w = buyruk_w[31:25];

    reg [4:0] rd_r = 0;
    reg [4:0] buyruk_rd_r = 0;
    
    reg [4:0] rs1_r = 0;
    reg [4:0] buyruk_rs1_r = 0;

    reg [4:0] rs2_r = 0;
    reg [4:0] buyruk_rs2_r = 0;

    assign rd_o = buyruk_rd_r;
    assign rs1_o = buyruk_rs1_r;
    assign rs2_o = buyruk_rs2_r;


    //assign rd_o = (buyruk_w[1:0] == 2'b11) ? buyruk_w[11:7] : /*compressed*/ {2'b00, buyruk_w[4:2]};

    // bunlar yazmac obeginden okunacak
    //assign rs1_o = buyruk_w[19:15];
    //assign rs2_o = buyruk_w[24:20];



    // anlik degerleri tek bir degiskene atamak yerine hepsi bir sonraki asamaya giris olarak gecsin
    /*
    assign i_imm_o = {{20{buyruk_w[31]}}, buyruk_w[20+:12]};
    assign u_imm_o = {{12{buyruk_w[31]}}, buyruk_w[12+:20]}; //{{12{buyruk_w[31]}}, buyruk_w[31:12]};
    assign j_imm_o = {{11{buyruk_w[19]}}, buyruk_w[19], buyruk_w[12+:8], buyruk_w[20], buyruk_w[21+:10], 1'b0};
    assign s_imm_o = {{20{buyruk_w[31]}}, buyruk_w[25+:7], buyruk_w[7+:5]};
    assign b_imm_o = {{19{buyruk_w[31]}}, buyruk_w[31], buyruk_w[7], buyruk_w[25+:6], buyruk_w[8+:4], 1'b0};
    */

    assign i_imm_o = {{20{buyruk_w[31]}}, buyruk_w[31:20]};
    assign s_imm_o = {{20{buyruk_w[31]}}, buyruk_w[31:25], buyruk_w[11:7]};
    assign b_imm_o = {{19{buyruk_w[31]}}, buyruk_w[31], buyruk_w[7], buyruk_w[30:25], buyruk_w[11:8], 1'b0};
    assign u_imm_o = {buyruk_w[31:12], {12{1'b0}}};
    assign j_imm_o = {{11{buyruk_w[31]}}, buyruk_w[31], buyruk_w[19:12], buyruk_w[20], buyruk_w[30:21], 1'b0};
    
    assign nzuimm_o = {buyruk_w[10:7], buyruk_w[12:11], buyruk_w[5], buyruk_w[6], 2'b00};


    reg [6:0] mikroislem_r = 0;

    reg [6:0] buyruk_mikroislem_r = 0;
    assign buyruk_mikroislem_o = buyruk_mikroislem_r;

/*
    yazmac_obegi yo(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .ky1_adres_i(yo_ky1_adres_w),
        .ky2_adres_i(yo_ky2_adres_w),
        .hy_adres_i(yo_yaz_hedef_w),
        .hy_deger_i(yo_yaz_veri_w),
        .yaz_i(yo_yaz_w),
        .ky1_deger_o(yo_ky1_veri_w),
        .ky2_deger_o(yo_ky2_veri_w)
    );
*/

    always @* begin
        rd_r = (buyruk_w[1:0] == 2'b11) ? buyruk_w[11:7] : /*compressed*/ {2'b00, buyruk_w[4:2]};
        rs1_r = buyruk_w[19:15];
        rs2_r = buyruk_w[24:20];

        // bitleri en tamam olandan olmayana kadar gitmek gerek.
        casez(buyruk_w)
            32'b0000000000000000_0000000000000000: begin
                mikroislem_r = `GECERSIZ;
            end
            `EBREAK: begin
                mikroislem_r = `EBREAK_MI;
            end
            `ECALL: begin
                mikroislem_r = `ECALL_MI;
            end
            `CONV_CLR_W: begin
                mikroislem_r = `CONV_CLR_W_MI;
            end
            `CONV_CLR_X: begin
                mikroislem_r = `CONV_CLR_X_MI;
            end
            32'b0000000000000000_00000000000???00: begin
                // C_ADDI4SPN'nin gecersiz olma durumu
                mikroislem_r = `GECERSIZ;
            end
            `CONV_RUN: begin
                mikroislem_r = `CONV_RUN_MI;
            end
            `RVRS: begin
                mikroislem_r = `RVRS_MI;
            end
            `CNTZ: begin
                mikroislem_r = `CNTZ_MI;
            end
            `CNTP: begin
                mikroislem_r = `CNTP_MI;
            end
            `CONV_LD_W: begin
                mikroislem_r = `CONV_LD_W_MI;
            end
            `CONV_LD_X: begin
                mikroislem_r = `CONV_LD_X_MI;
            end
            `ADD: begin
                mikroislem_r = `ADD_MI;
            end
            `AND: begin
                mikroislem_r = `AND_MI;
            end
            `DIV: begin
                mikroislem_r = `DIV_MI;
            end
            `DIVU: begin
                mikroislem_r = `DIVU_MI;
            end
            `MUL: begin
                mikroislem_r = `MUL_MI;
            end
            `MULH: begin
                mikroislem_r = `MULH_MI;
            end
            `MULHSU: begin
                mikroislem_r = `MULHSU_MI;
            end
            `MULHU: begin
                mikroislem_r = `MULHU_MI;
            end
            `OR: begin
                mikroislem_r = `OR_MI;
            end
            `REM: begin
                mikroislem_r = `REM_MI;
            end
            `REMU: begin
                mikroislem_r = `REMU_MI;
            end
            `SLL: begin
                mikroislem_r = `SLL_MI;
            end
            `SLT: begin
                mikroislem_r = `SLT_MI;
            end
            `SLTU: begin
                mikroislem_r = `SLTU_MI;
            end
            `SRA: begin
                mikroislem_r = `SRA_MI;
            end
            `SRL: begin
                mikroislem_r = `SRL_MI;
            end
            `SUB: begin
                mikroislem_r = `SUB_MI;
            end
            `XOR: begin
                mikroislem_r = `XOR_MI;
            end
            `HMDST: begin
                mikroislem_r = `HMDST_MI;
            end
            `PKG: begin
                mikroislem_r = `PKG_MI;
            end
            `SLADD: begin
                mikroislem_r = `SLADD_MI;
            end
            `C_EBREAK: begin
                mikroislem_r = `C_EBREAK_MI;
            end
            `SLLI: begin
                mikroislem_r = `SLLI_MI;
            end
            `SRAI: begin
                mikroislem_r = `SRAI_MI;
            end
            `SRLI: begin
                mikroislem_r = `SRLI_MI;
            end
            `C_JALR: begin
                mikroislem_r = `C_JALR_MI;
            end
            `C_JR: begin
                mikroislem_r = `C_JR_MI;
            end
            `ADDI: begin
                mikroislem_r = `ADDI_MI;
            end
            `ANDI: begin
                mikroislem_r = `ANDI_MI;
            end
            `BEQ: begin
                mikroislem_r = `BEQ_MI;
            end
            `BGE: begin
                mikroislem_r = `BGE_MI;
            end
            `BGEU: begin
                mikroislem_r = `BGEU_MI;
            end
            `BLT: begin
                mikroislem_r = `BLT_MI;
            end
            `BLTU: begin
                mikroislem_r = `BLTU_MI;
            end
            `BNE: begin
                mikroislem_r = `BNE_MI;
            end
            `C_ADDI16SP: begin
                mikroislem_r = `C_ADDI16SP_MI;
            end
            `C_AND: begin
                mikroislem_r = `C_AND_MI;
            end
            `C_NOP: begin
                mikroislem_r = `C_NOP_MI;
            end
            `C_OR: begin
                mikroislem_r = `C_OR_MI;
            end
            `C_SUB: begin
                mikroislem_r = `C_SUB_MI;
            end
            `C_XOR: begin
                mikroislem_r = `C_XOR_MI;
            end
            `FENCE: begin
                mikroislem_r = `FENCE_MI;
            end
            `FENCE_I: begin
                mikroislem_r = `FENCE_I_MI;
            end
            `JALR: begin
                mikroislem_r = `JALR_MI;
            end
            `LB: begin
                mikroislem_r = `LB_MI;
            end
            `LBU: begin
                mikroislem_r = `LBU_MI;
            end
            `LH: begin
                mikroislem_r = `LH_MI;
            end
            `LHU: begin
                mikroislem_r = `LHU_MI;
            end
            `LW: begin
                mikroislem_r = `LW_MI;
            end
            `ORI: begin
                mikroislem_r = `ORI_MI;
            end
            `SB: begin
                mikroislem_r = `SB_MI;
            end
            `SH: begin
                mikroislem_r = `SH_MI;
            end
            `SLTI: begin
                mikroislem_r = `SLTI_MI;
            end
            `SLTIU: begin
                mikroislem_r = `SLTIU_MI;
            end
            `SW: begin
                mikroislem_r = `SW_MI;
            end
            `XORI: begin
                mikroislem_r = `XORI_MI;
            end
            `AUIPC: begin
                mikroislem_r = `AUIPC_MI;
            end
            `C_ANDI: begin
                mikroislem_r = `C_ANDI_MI;
            end
            `C_SRAI: begin
                mikroislem_r = `C_SRAI_MI;
            end
            `C_SRLI: begin
                mikroislem_r = `C_SRLI_MI;
            end
            `JAL: begin
                mikroislem_r = `JAL_MI;
            end
            `LUI: begin
                mikroislem_r = `LUI_MI;
            end
            `C_ADD: begin
                mikroislem_r = `C_ADD_MI;
            end
            `C_MV: begin
                mikroislem_r = `C_MV_MI;
            end
            `C_ADDI: begin
                mikroislem_r = `C_ADDI_MI;
            end
            `C_ADDI4SPN: begin
                mikroislem_r = `C_ADDI4SPN_MI;
            end
            `C_BEQZ: begin
                mikroislem_r = `C_BEQZ_MI;
            end
            `C_BNEZ: begin
                mikroislem_r = `C_BNEZ_MI;
            end
            `C_J: begin
                mikroislem_r = `C_J_MI;
            end
            `C_JAL: begin
                mikroislem_r = `C_JAL_MI;
            end
            `C_LI: begin
                mikroislem_r = `C_LI_MI;
            end
            `C_LUI: begin
                mikroislem_r = `C_LUI_MI;
            end
            `C_LW: begin
                mikroislem_r = `C_LW_MI;
            end
            `C_LWSP: begin
                mikroislem_r = `C_LWSP_MI;
            end
            `C_SLLI: begin
                mikroislem_r = `C_SLLI_MI;
            end
            `C_SW: begin
                mikroislem_r = `C_SW_MI;
            end
            `C_SWSP: begin
                mikroislem_r = `C_SWSP_MI;
            end
            default: begin
                mikroislem_r = `GECERSIZ;
                $display("default");
            end
        endcase
    end

    always @(posedge clk_i) begin
        if (rst_i) begin
            buyruk_mikroislem_r <= 0;

            buyruk_rd_r <= 0;
            buyruk_rs1_r <= 0;
            buyruk_rs2_r <= 0;
        end
        else begin
            buyruk_mikroislem_r <= mikroislem_r;

            buyruk_rd_r <= rd_r;
            buyruk_rs1_r <= rs1_r;
            buyruk_rs2_r <= rs2_r;
        end
    end

endmodule
