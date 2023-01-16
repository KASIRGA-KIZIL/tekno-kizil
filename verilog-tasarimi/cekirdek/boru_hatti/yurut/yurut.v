// yurut.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// denetim durum birimi ile iliskisinin kurulmasi gerek

module yurut(
    input clk_i,
    input rst_i,
    
    input buyruk_compressed_i,
    
    input [`MI_BIT-1:0] buyruk_mikroislem_i, // 0 olursa gecersiz
    
    input [4:0] rd_adres_i, // geri yaza kadar gitmesi lazim
    
    input [31:0] rs1_deger_i, // ayni zamanda uimm icin kullan
    input [31:0] rs2_deger_i, // ayni zamanda shamt icin kullan
    
    input [31:0] i_imm_i, // fencete ve csrlarda kullan
    input [31:0] s_imm_i,
    input [31:0] b_imm_i,
    input [31:0] u_imm_i,
    input [31:0] j_imm_i,
    
    
    output [4:0] rd_adres_o, // geri yaza kadar gitmesi lazim
    output [31:0] rd_deger_o, // islem birimlerinden gelen sonuclar
    output yaz_yazmac_o


);

    assign rd_adres_o = rd_adres_i;


endmodule
