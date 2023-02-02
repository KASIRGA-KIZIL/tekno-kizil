`timescale 1ns / 1ps

module bolme_birimi(
input clk_i,
input [1:0] islem_i,//00 DIVU , 01 REMU , 10 DIV, 11 REM
input [31:0] bolunen_i,
input [31:0] bolen_i, 
output reg [31:0] sonuc_o
);

reg [31:0] bolen_r,bolen_sonraki_r, bolunen_r,bolunen_sonraki_r;
reg [31:0] fark_r=32'd0,fark_sonraki_r=32'd0;
reg[33:0] cevrim_r=34'd1,cevrim_sonraki_r=34'd1;
reg boluyor_r=0,boluyor_sonraki_r=0;
reg[31:0] gecici_fark_r;
reg isaret_bolunen_r,isaret_bolen_r;

always @(*)begin
bolen_sonraki_r=bolen_r; 
bolunen_sonraki_r=bolunen_r;
fark_sonraki_r=fark_r;
cevrim_sonraki_r=cevrim_r;
boluyor_sonraki_r=boluyor_r;

    if(cevrim_r[0]) begin
    isaret_bolen_r=bolen_i[31];
	isaret_bolunen_r=bolunen_i[31];
	if(islem_i[1]&bolen_i[31])begin
	   bolen_sonraki_r= ~bolen_i+1;
	end
	else begin
	   bolen_sonraki_r= bolen_i;
	end
    
    if(islem_i[1]&bolunen_i[31])begin
	   bolunen_sonraki_r= ~bolunen_i+1;
	end
	else begin
	   bolunen_sonraki_r = bolunen_i;
	end
	boluyor_sonraki_r=1;
	cevrim_sonraki_r=cevrim_r<<1;
	
	end
	
	if(boluyor_r)begin
	
		fark_sonraki_r = {fark_r[30:0], bolunen_r[31]} - bolen_r;
		gecici_fark_r=fark_sonraki_r;
		bolunen_sonraki_r = bolunen_r<<1;
		
		if(fark_sonraki_r[31])begin
			bolunen_sonraki_r[0] = 0;
			fark_sonraki_r = gecici_fark_r + bolen_r;
		end
		else begin
			bolunen_sonraki_r[0] = 1;
			
		end
		
		cevrim_sonraki_r=cevrim_r<<1;
		boluyor_sonraki_r=~cevrim_r[32];
	end
	
	if(cevrim_r[33])begin
	case({islem_i,(isaret_bolen_r^isaret_bolunen_r)})
	   3'b000: sonuc_o = bolunen_r;
	   3'b001: sonuc_o = bolunen_r;
	   3'b010: sonuc_o = fark_r;
	   3'b011: sonuc_o = fark_r;
	   
	   3'b100: sonuc_o = bolunen_r;
	   3'b101: sonuc_o = (~bolunen_r)+1;
	   3'b110: sonuc_o = fark_r;
	   3'b111: sonuc_o = fark_r-bolen_r;
	endcase
	cevrim_sonraki_r=34'd1;
	boluyor_sonraki_r=0;
	fark_sonraki_r=0;
	bolen_sonraki_r=0;
	bolunen_sonraki_r=0;
	end
end

always @(posedge clk_i)begin
bolen_r<=bolen_sonraki_r; 
bolunen_r<=bolunen_sonraki_r;
fark_r<=fark_sonraki_r;
cevrim_r<=cevrim_sonraki_r;
boluyor_r<=boluyor_sonraki_r;
end

endmodule




