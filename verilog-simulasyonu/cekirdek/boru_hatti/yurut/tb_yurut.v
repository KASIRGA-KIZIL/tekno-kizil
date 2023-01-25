// tb_yurut.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"
module tb_yurut;

// Parameters

// Ports
reg  clk_i = 0;
reg  rst_i = 0;
reg [`MI_BIT-1:0] cyo_mikroislem_i;
reg [        4:0] cyo_rd_adres_i;
reg [       31:0] cyo_ps_artmis_i;
reg [       31:0] cyo_deger1_i;
reg [       31:0] cyo_deger2_i;
reg  cyo_yapay_zeka_en_i = 0;
reg [ 2:0] cyo_lt_ltu_eq_i;
reg [ 1:0] cyo_buyruk_tipi_i;
wire [31:0] gtr_atlanan_ps_o;
wire  gtr_atlanan_ps_gecerli_o;
wire [ 4:0] gy_rd_adres_o;
wire [31:0] gy_ps_artmis_o;
wire [31:0] gy_rd_deger_o;
wire [31:0] gy_bib_deger_o;
wire [ 2:0] gy_mikroislem_o;
wire [31:0] cyo_yonlendir_deger_o;

yurut
yurut_dut (
  .clk_i (clk_i ),
  .rst_i (rst_i ),
  .cyo_mikroislem_i (cyo_mikroislem_i ),
  .cyo_rd_adres_i (cyo_rd_adres_i ),
  .cyo_ps_artmis_i (cyo_ps_artmis_i ),
  .cyo_deger1_i (cyo_deger1_i ),
  .cyo_deger2_i (cyo_deger2_i ),
  .cyo_yapay_zeka_en_i (cyo_yapay_zeka_en_i ),
  .cyo_lt_ltu_eq_i (cyo_lt_ltu_eq_i ),
  .cyo_buyruk_tipi_i (cyo_buyruk_tipi_i ),
  .gtr_atlanan_ps_o (gtr_atlanan_ps_o ),
  .gtr_atlanan_ps_gecerli_o (gtr_atlanan_ps_gecerli_o ),
  .gy_rd_adres_o (gy_rd_adres_o ),
  .gy_ps_artmis_o (gy_ps_artmis_o ),
  .gy_rd_deger_o (gy_rd_deger_o ),
  .gy_bib_deger_o (gy_bib_deger_o ),
  .gy_mikroislem_o (gy_mikroislem_o ),
  .cyo_yonlendir_deger_o  ( cyo_yonlendir_deger_o)
);

initial begin
  begin
    $finish;
  end
end

always
  #5  clk_i = ! clk_i ;

endmodule
