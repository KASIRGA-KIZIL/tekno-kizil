// zero_counter.v


`timescale 1ns / 1ps
module zero_counter(
  input wire [31:0] deger_i,
  output wire [5:0] sifir_sayisi
);

reg [31:0] ters_deger;

integer i;
always @(*) begin
    for(i = 0; i< 32; i=i+1)
        ters_deger[i] = deger_i[31-i];
end

wire [3:0] alt_sifir_sayisi;
wire [3:0] ust_sifir_sayisi;
wire alt_hepsi_sifir;
wire ust_hepsi_sifir;

zero_counter_16 zc16_ust_dut (
  .A (ters_deger[31:16]),
  .Z (ust_sifir_sayisi),
  .V (ust_hepsi_sifir)
);

zero_counter_16 zc16_alt_dut (
  .A (ters_deger[15:0]),
  .Z (alt_sifir_sayisi),
  .V (alt_hepsi_sifir)
);

assign sifir_sayisi = ust_hepsi_sifir &  alt_hepsi_sifir ? 6'd32                          :
                      ust_hepsi_sifir & ~alt_hepsi_sifir ? 5'd16 + {1'b0,alt_sifir_sayisi}:
                                                          ({2'b0,ust_sifir_sayisi})       ;

endmodule

module zero_counter_16(
    input  wire [15:0] A,
    output reg [ 3:0] Z,
    output reg V
);

    integer i;
    reg [7:0] C0;
    reg [3:0] C1;
    reg [3:0] D0;
    reg t0;
    reg t1;
    reg t2;
    reg t3;
    reg e0;
    reg e1;
    always @(*) begin
        for(i=0;i<8;i=i+1)begin
            C0[i] = (A[(i*2)+1]|A[(i*2)]);
        end
        for(i=0;i<4;i=i+1)begin
            C1[i] = (C0[(i*2)+1]|C0[(i*2)]);
        end
        for(i=0;i<4;i=i+1)begin
            D0[i] = ((A[(i*4)+1]&~C0[(2*i)+1])|A[(i*4)+3]);
        end

        t0 = ((C0[1]&~C1[1])|C0[3]);
        t1 = ((D0[0]&~C1[1])|D0[1]);

        t2 = ((C0[5]&~C1[3])|C0[7]);
        t3 = ((D0[2]&~C1[3])|D0[3]);

        e0 = C1[1]|C1[0];
        e1 = C1[3]|C1[2];

        V = ~(e0|e1);

        Z[3] = ~e1;
        Z[2] = ~((C1[1]&~e1)|C1[3]);
        Z[1] = ~((t0   &~e1)|t2   );
        Z[0] = ~((t1   &~e1)|t3   );

    end


endmodule

