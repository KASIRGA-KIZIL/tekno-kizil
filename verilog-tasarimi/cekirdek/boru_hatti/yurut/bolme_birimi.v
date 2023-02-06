// bolme_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module bolme_birimi(
	input clk_i,
	input rst_i,
	input basla_i,
	input [1:0] islem_i, //00 DIVU, 01 REMU, 10 DIV, 11 REM
	input [31:0] bolunen_i,
	input [31:0] bolen_i,
	output reg [31:0] sonuc_o,
	output wire bitti_o
);

    // TODO 33 cevrimde sonuc
    // bitti 1 cevrim gec 34 cevrim oluyor, duzeltelim
	// eger baslamadiysa hep bitti
	reg bitti_sonraki_r = 1;

	//reg sonuc_sonraki_r = 0;

	reg [31:0] bolen_r = 0;
	reg [31:0] bolen_sonraki_r = 0;

	reg [31:0] bolunen_r = 0;
	reg [31:0] bolunen_sonraki_r = 0;

	reg [31:0] fark_r = 0;
	reg [31:0] fark_sonraki_r = 0;

	reg [33:0] cevrim_r = 34'd1;
	reg [33:0] cevrim_sonraki_r = 34'd1;

	reg[31:0] gecici_fark_r = 0;

	reg isaret_bolunen_r = 0;
	reg isaret_bolen_r = 0;

	always @(*)begin
		bolen_sonraki_r = bolen_r;
        bolunen_sonraki_r = bolunen_r;
        fark_sonraki_r = fark_r;
        cevrim_sonraki_r = cevrim_r;

		bitti_sonraki_r = 1;

		if(basla_i) begin
			bitti_sonraki_r = 0;

            case({cevrim_r[33], cevrim_r[0]})
                2'b01: begin // ilk cevrim
                    isaret_bolen_r = bolen_i[31];
				    isaret_bolunen_r = bolunen_i[31];

				    if(islem_i[1] & bolen_i[31]) begin
				       bolen_sonraki_r = ~bolen_i + 1;
				    end
				    else begin
				       bolen_sonraki_r= bolen_i;
				    end

			        if(islem_i[1] & bolunen_i[31])begin
				       bolunen_sonraki_r = ~bolunen_i + 1;
				    end
				    else begin
				       bolunen_sonraki_r = bolunen_i;
				    end
				    cevrim_sonraki_r = cevrim_r<<1;
                end

                2'b00: begin // boluyor
                    fark_sonraki_r = {fark_r[30:0], bolunen_r[31]} - bolen_r;
				    gecici_fark_r = fark_sonraki_r;
				    bolunen_sonraki_r = bolunen_r<<1;

				    if(fark_sonraki_r[31])begin
				    	bolunen_sonraki_r[0] = 0;
				    	fark_sonraki_r = gecici_fark_r + bolen_r;
				    end
				    else begin
				    	bolunen_sonraki_r[0] = 1;

				    end

				    cevrim_sonraki_r = cevrim_r<<1;
                end

                2'b10: begin // son cevrim
                    casez({islem_i, (isaret_bolen_r ^ isaret_bolunen_r)})
				    	{`BOLME_DIVU, 1'b?}: sonuc_o = bolunen_r;
				    	{`BOLME_REMU, 1'b?}: sonuc_o = fark_r;

				    	{`BOLME_DIV, 1'b0}: sonuc_o = bolunen_r;
				    	{`BOLME_DIV, 1'b1}: sonuc_o = (~bolunen_r) + 1;
				    	{`BOLME_REM, 1'b0}: sonuc_o = fark_r;
				    	{`BOLME_REM, 1'b1}: sonuc_o = fark_r - bolen_r;
				    	default: sonuc_o = 32'hxxxx_xxxx;
				    endcase

				    cevrim_sonraki_r = 34'd1;
				    fark_sonraki_r = 0;
				    bolen_sonraki_r = 0;
				    bolunen_sonraki_r = 0;

				    bitti_sonraki_r = 1;
                end

                default: begin
                    bolen_sonraki_r = 32'dx;
                    bolunen_sonraki_r = 32'dx;
                    fark_sonraki_r = 32'dx;
                    cevrim_sonraki_r = 1;

		            bitti_sonraki_r = 1;
                end
            endcase
		end
		else begin
		    bolen_sonraki_r = 32'dx;
            bolunen_sonraki_r = 32'dx;
            fark_sonraki_r = 32'dx;
            cevrim_sonraki_r = 1;

		    bitti_sonraki_r = 1;
		end
		if(bolen_i == 32'b0) begin
			bitti_sonraki_r = 1;
			sonuc_o = -1;
		end

	end
	reg bitti;
	reg once;
	assign bitti_o = bitti && (((basla_i) ? 1'b0 : 1'b1) || once);
	always @(posedge clk_i)begin
		if(rst_i | !basla_i) begin
			bolen_r <= 0;
			bolunen_r <= 0;
			fark_r <= 0;
			cevrim_r <= 1;

            //sonuc_o <= 0;
			bitti <= 1;
			once  <= 0;
		end
		else begin
			once  <= 1;
			bolen_r <= bolen_sonraki_r;
			bolunen_r <= bolunen_sonraki_r;
			fark_r <= fark_sonraki_r;
			cevrim_r <= cevrim_sonraki_r;

            //sonuc_o <= sonuc_sonraki_r;
			bitti <= bitti_sonraki_r;
		end
	end

endmodule
