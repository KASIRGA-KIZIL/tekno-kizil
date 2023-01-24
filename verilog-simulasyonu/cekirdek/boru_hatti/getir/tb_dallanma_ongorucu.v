// tb_dallanma_ongorucu.v
`timescale 1ns / 1ps


module tb_dallanma_ongorucu;

  // Parameters

  // Ports
  reg  rst_i = 0;
  reg  clk_i = 0;
  reg [31:1] ps_i;
  reg  buyruk_ctipi_i = 0;
  reg  tahmin_et_i = 0;
  wire [31:1] ongorulen_ps_o;
  wire  ongorulen_ps_gecerli_o;
  reg [31:1] atlanan_ps_i;
  reg  atlanan_ps_gecerli_i = 0;
  wire [ 1:0] hata_duzelt_o;
  wire [31:1] yrt_ps_o;
  wire  yrt_buyruk_ctipi_o;

  dallanma_ongorucu dot (
    .rst_i (rst_i ),
    .clk_i (clk_i ),
    //
    .ps_i (ps_i ),
    .buyruk_ctipi_i (buyruk_ctipi_i ),
    .tahmin_et_i (tahmin_et_i ),
    .ongorulen_ps_o (ongorulen_ps_o ),
    .ongorulen_ps_gecerli_o (ongorulen_ps_gecerli_o ),
    // Kalibrasyon sinyalleri
    .atlanan_ps_i (atlanan_ps_i ),
    .atlanan_ps_gecerli_i (atlanan_ps_gecerli_i ),
    // hata duzeltme
    .hata_duzelt_o (hata_duzelt_o ),
    .yrt_ps_o (yrt_ps_o ),
    .yrt_buyruk_ctipi_o  ( yrt_buyruk_ctipi_o)
  );

  initial begin
    begin
      $finish;
    end
  end

  always
    #5  clk_i = ! clk_i ;

endmodule
