// bolme_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module csr_birimi(
    input  wire clk_i,
    input  wire rst_i,
    input  wire basla_i,
    input  wire exception_i,
    input  wire [ 2:0] kontrol_i,
    input  wire [31:1] ps_i,
    input  wire [31:0] deger_i,
    input  wire [ 4:0] zimm_i,
    input  wire [11:0] adr_i,
    output reg  [31:0] sonuc_o
);

    reg [31:0] mstatus;
    reg [31:0] mcause;
    reg [31:0] mepc;
    reg [31:0] mtvec;
    wire [31:0] deger;
    always @(*) begin
        /*
        case(kontrol_i)
            `SISTEM_ECALL :
            `SISTEM_EBREAK:
            `SISTEM_CSRRC :
            `SISTEM_CSRRCI:
            `SISTEM_CSRRS :
            `SISTEM_CSRRSI:
            `SISTEM_CSRRW :
            `SISTEM_CSRRWI:
        endcase
        */
        case(adr_i)
            12'h300: sonuc_o <= mstatus;
            12'h305: sonuc_o <= mtvec;
            12'h341: sonuc_o <= mepc;
            12'h342: sonuc_o <= mcause;
            default: sonuc_o =  32'bx;
        endcase
    end

    always @(posedge clk_i) begin
        case(adr_i)
            12'h300: mstatus <= deger_i;
            12'h305: mtvec   <= deger_i;
            12'h341: mepc    <= deger_i;
            12'h342: mcause  <= deger_i;
        endcase
    end

/*
Exception olusunca
    Guncelle:
        mstatus
        mepc
        mcause
    mtvec'te gosterilen yere atla.

Exception Handler'dan donerken:
    Guncelle:
        mstatus
    mepc'de gosterilen yere atla.
*/
/*
CSR aciklamalari:
    mepc:     Exception olusturan buyrugun PC'si buraya saklanir.adr_i
    mscratch: 32bit genel kullanim icin yazmac. GEnelde GPR'larin saklandigi hafizayi gosterir.
    mtvec:    Exception Handler'in baslangic adresi.

    mcause[3:0]: Exception kaynagina gore cesitli degerler alir.
                 ecall instruction (11),
                 misaligned store (6)
                 misaligned load (4),
                 ebreak instruction (3),
                 illegal instruction (2),
                 misaligned jump (0)
*/
endmodule
