`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module tb_geri_yaz();

    
    // YURUT'ten gelenler
    reg [ 4:0] yrt_rd_adres_i;
    reg [31:0] yrt_rd_deger_i;
    reg [ 2:0] yrt_mikroislem_i;
    reg [31:0] yrt_carpma_deger_i;
    reg [31:1] yrt_ps_artmis_i;
    
    // COZ'e gidenler
    wire [ 4:0] cyo_yaz_adres_o;
    wire [31:0] cyo_yaz_deger_o;
    wire        cyo_yaz_yazmac_o;

    
    geri_yaz gytb(
        
        // YURUT'ten gelenler
        .yrt_rd_adres_i     (yrt_rd_adres_i),
        .yrt_rd_deger_i     (yrt_rd_deger_i),
        .yrt_mikroislem_i   (yrt_mikroislem_i),
        .yrt_carpma_deger_i (yrt_carpma_deger_i),
        .yrt_ps_artmis_i    (yrt_ps_artmis_i),
        
          // COZ'e gidenler
        .cyo_yaz_adres_o    (cyo_yaz_adres_o),
        .cyo_yaz_deger_o    (cyo_yaz_deger_o),
        .cyo_yaz_yazmac_o   (cyo_yaz_yazmac_o)
    );
    
    
    initial begin
        
        yrt_rd_adres_i=5'b00110;
        yrt_rd_deger_i=32'h0000_ffff;
        yrt_carpma_deger_i=32'hffff_0000;
        yrt_ps_artmis_i=32'hffff_ffff;
        yrt_mikroislem_i=3'b000;
        #10;
        $display("cyo_yaz_adres_o: %h",  cyo_yaz_adres_o);
        $display("cyo_yaz_deger_o: %h",  cyo_yaz_deger_o);
        $display("cyo_yaz_yazmac_o: %h", cyo_yaz_yazmac_o);
        
        yrt_mikroislem_i=3'b001;
        #10;
        $display("cyo_yaz_adres_o: %h",  cyo_yaz_adres_o);
        $display("cyo_yaz_deger_o: %h",  cyo_yaz_deger_o);
        $display("cyo_yaz_yazmac_o: %h", cyo_yaz_yazmac_o);      
    
        yrt_mikroislem_i=3'b010;
        #10;
        $display("cyo_yaz_adres_o: %h",  cyo_yaz_adres_o);
        $display("cyo_yaz_deger_o: %h",  cyo_yaz_deger_o);
        $display("cyo_yaz_yazmac_o: %h", cyo_yaz_yazmac_o);            
             
        yrt_mikroislem_i=3'b011;
        #10;
        $display("cyo_yaz_adres_o: %h",  cyo_yaz_adres_o);
        $display("cyo_yaz_deger_o: %h",  cyo_yaz_deger_o);
        $display("cyo_yaz_yazmac_o: %h", cyo_yaz_yazmac_o); 
        
        //cyo_yaz_yazmac_o=1;
        $display("cyo_yaz_adres_o: %h",  cyo_yaz_adres_o);
        $display("cyo_yaz_deger_o: %h",  cyo_yaz_deger_o);
        $display("cyo_yaz_yazmac_o: %h", cyo_yaz_yazmac_o);
        
        yrt_mikroislem_i=3'b101;
        #10;
        $display("cyo_yaz_adres_o: %h",  cyo_yaz_adres_o);
        $display("cyo_yaz_deger_o: %h",  cyo_yaz_deger_o);
        $display("cyo_yaz_yazmac_o: %h", cyo_yaz_yazmac_o);      
        
        yrt_mikroislem_i=3'b110;
        #10;
        $display("cyo_yaz_adres_o: %h",  cyo_yaz_adres_o);
        $display("cyo_yaz_deger_o: %h",  cyo_yaz_deger_o);
        $display("cyo_yaz_yazmac_o: %h", cyo_yaz_yazmac_o);            
             
        yrt_mikroislem_i=3'b111;
        #10;
        $display("cyo_yaz_adres_o: %h",  cyo_yaz_adres_o);
        $display("cyo_yaz_deger_o: %h",  cyo_yaz_deger_o);
        $display("cyo_yaz_yazmac_o: %h", cyo_yaz_yazmac_o); 
       
    end
endmodule
