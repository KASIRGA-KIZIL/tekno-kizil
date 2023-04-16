// geri_yaz.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module geri_yaz(
   // YURUT'ten gelenler
   input [ 4:0] yrt_rd_adres_i,   // Geri yazilacak yazmac adresi
   input [31:0] yrt_rd_deger_i,   // Geri yazilacak RD sinyali
   input [ 2:0] yrt_mikroislem_i, // Gerekli kontrol sinyali
   input [18:1] yrt_ps_artmis_i,  // PS+4 veya PS+2
   input [31:0] yrt_carp_deger_i, // Carpmanin kendi cikis register'i var. Ondan ayri gelir.
   
   // COZ'e gidenler
   output [ 4:0] cyo_yaz_adres_o,
   output [31:0] cyo_yaz_deger_o,
   output        cyo_yaz_yazmac_o
);
   // Geri yazilacak deger mikro islem tarafindan secilir.
   assign cyo_yaz_deger_o = (yrt_mikroislem_i[`GERIYAZ] == `GERIYAZ_KAYNAK_YURUT ) ? yrt_rd_deger_i                   :
                            (yrt_mikroislem_i[`GERIYAZ] == `GERIYAZ_KAYNAK_PC    ) ? {8'h40,5'b0,yrt_ps_artmis_i,1'b0}:
                            (yrt_mikroislem_i[`GERIYAZ] == `GERIYAZ_KAYNAK_CARP  ) ? yrt_carp_deger_i                 :
                                                                                    32'hxxxx_xxxx;
   
   assign cyo_yaz_adres_o  = yrt_rd_adres_i;
   assign cyo_yaz_yazmac_o = yrt_mikroislem_i[`YAZMAC];
   
endmodule
