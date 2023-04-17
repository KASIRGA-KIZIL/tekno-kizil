// Icarus verilog kapi seviyesi simulasyonda ayri dosyalar bulunma sorununa yol actigi icin
// butun Kapi seviyesi RAM modelleri ve bu dosyaya konulmustur.

`ifdef OPENLANE

`ifdef COCOTB_SIM
    `include "sky130_fd_sc_hd.v"
`endif

module MUX8_8x1_8 (
    input  wire [7:0] A0 ,
    input  wire [7:0] A1 ,
    input  wire [7:0] A2 ,
    input  wire [7:0] A3 ,
    input  wire [7:0] A4 ,
    input  wire [7:0] A5 ,
    input  wire [7:0] A6 ,
    input  wire [7:0] A7 ,
    input  wire [2:0] S,
    output wire [7:0] X
);
    wire [7:0] words [7:0];
    genvar i;
    generate
        for (i=0;i<8;i=i+1)begin
            assign words[i] = {A7 [i],A6 [i],A5 [i],A4 [i],A3 [i],A2 [i],A1 [i],A0 [i]};
        end
    endgenerate
    MUX8x1 m0(.A(words[0]), .S(S), .X(X[0]) );
    MUX8x1 m1(.A(words[1]), .S(S), .X(X[1]) );
    MUX8x1 m2(.A(words[2]), .S(S), .X(X[2]) );
    MUX8x1 m3(.A(words[3]), .S(S), .X(X[3]) );
    MUX8x1 m4(.A(words[4]), .S(S), .X(X[4]) );
    MUX8x1 m5(.A(words[5]), .S(S), .X(X[5]) );
    MUX8x1 m6(.A(words[6]), .S(S), .X(X[6]) );
    MUX8x1 m7(.A(words[7]), .S(S), .X(X[7]) );
endmodule



module MUX32_8x1_8 (
    input  wire [7:0] A0 ,
    input  wire [7:0] A1 ,
    input  wire [7:0] A2 ,
    input  wire [7:0] A3 ,
    input  wire [7:0] A4 ,
    input  wire [7:0] A5 ,
    input  wire [7:0] A6 ,
    input  wire [7:0] A7 ,
    input  wire [7:0] A8 ,
    input  wire [7:0] A9 ,
    input  wire [7:0] A10,
    input  wire [7:0] A11,
    input  wire [7:0] A12,
    input  wire [7:0] A13,
    input  wire [7:0] A14,
    input  wire [7:0] A15,
    input  wire [7:0] A16,
    input  wire [7:0] A17,
    input  wire [7:0] A18,
    input  wire [7:0] A19,
    input  wire [7:0] A20,
    input  wire [7:0] A21,
    input  wire [7:0] A22,
    input  wire [7:0] A23,
    input  wire [7:0] A24,
    input  wire [7:0] A25,
    input  wire [7:0] A26,
    input  wire [7:0] A27,
    input  wire [7:0] A28,
    input  wire [7:0] A29,
    input  wire [7:0] A30,
    input  wire [7:0] A31,
    input  wire [4:0] S,
    output wire [7:0] X
);
    wire [31:0] words [7:0];
    genvar i;
    generate
        for (i=0;i<8;i=i+1)begin
            assign words[i] = {A31[i],A30[i],A29[i],A28[i],A27[i],A26[i],A25[i],A24[i],A23[i],A22[i],A21[i],A20[i],A19[i],A18[i],A17[i],A16[i],A15[i],A14[i],A13[i],A12[i],A11[i],A10[i],A9 [i],A8 [i],A7 [i],A6 [i],A5 [i],A4 [i],A3 [i],A2 [i],A1 [i],A0 [i]};
        end
    endgenerate
    MUX32x1 m0(.A(words[0]), .S(S), .X(X[0]) );
    MUX32x1 m1(.A(words[1]), .S(S), .X(X[1]) );
    MUX32x1 m2(.A(words[2]), .S(S), .X(X[2]) );
    MUX32x1 m3(.A(words[3]), .S(S), .X(X[3]) );
    MUX32x1 m4(.A(words[4]), .S(S), .X(X[4]) );
    MUX32x1 m5(.A(words[5]), .S(S), .X(X[5]) );
    MUX32x1 m6(.A(words[6]), .S(S), .X(X[6]) );
    MUX32x1 m7(.A(words[7]), .S(S), .X(X[7]) );
endmodule

module MUX32x1 (
    input  wire [31:0] A,
    input  wire [ 4:0] S,
    output wire X
);
    wire tmp0, tmp1;
    MUX16x1 m0 (
        .A(A[15:0]),
        .S(S[ 3:0]),
        .X(tmp0)
    );
    MUX16x1 m1 (
        .A(A[31:16]),
        .S(S[ 3:0]),
        .X(tmp1)
    );
    sky130_fd_sc_hd__mux2_1 m2(
        .X (X),
        .A0(tmp0),
        .A1(tmp1),
        .S (S[4])
    );
endmodule


module MUX16x1 (
    input  wire [15:0] A,
    input  wire [3:0] S,
    output wire X
);
    wire tmp0, tmp1;
    MUX8x1 m0 (
        .A(A[7:0]),
        .S(S[2:0]),
        .X(tmp0)
    );
    MUX8x1 m1 (
        .A(A[15:8]),
        .S(S[2:0]),
        .X(tmp1)
    );
    sky130_fd_sc_hd__mux2_1 m2(
        .X (X),
        .A0(tmp0),
        .A1(tmp1),
        .S (S[3])
    );
endmodule


module MUX8x1 (
    input  wire [7:0] A,
    input  wire [2:0] S,
    output wire X
);
    wire tmp0, tmp1;
    sky130_fd_sc_hd__mux4_1 m0 (
        .A0(A[0]),
        .A1(A[1]),
        .A2(A[2]),
        .A3(A[3]),
        .S0(S[0]),
        .S1(S[1]),
        .X(tmp0)
    );
    sky130_fd_sc_hd__mux4_1 m1(
        .A0(A[4]),
        .A1(A[5]),
        .A2(A[6]),
        .A3(A[7]),
        .S0(S[0]),
        .S1(S[1]),
        .X(tmp1)
    );
    sky130_fd_sc_hd__mux2_1 m2(
        .X (X),
        .A0(tmp0),
        .A1(tmp1),
        .S (S[2])
    );
endmodule

module RAM32x8_ASYNC_sky130
(
    input   wire    [4:0] A0, AW,
    input   wire    [7:0] Di0,
    output  wire    [7:0] Do0,
    input   wire          CLK,
    input   wire          WE0
);
    wire [31:0] selw;
    wire [ 7:0] do_tmp [31:0];

    DEC5x32 DEC2 ( .A(AW), .SEL(selw) );

    generate
        genvar e;
        for(e=0; e<32; e=e+1) begin : REGF
            RFWORD #(.WSIZE(8)) RFW ( .CLK(CLK), .WE(WE0), .SELW(selw[e]), .D1(do_tmp[e]), .DW(Di0) );
        end
    endgenerate
    MUX32_8x1_8 m0(
        .A0 (do_tmp[0 ]),
        .A1 (do_tmp[1 ]),
        .A2 (do_tmp[2 ]),
        .A3 (do_tmp[3 ]),
        .A4 (do_tmp[4 ]),
        .A5 (do_tmp[5 ]),
        .A6 (do_tmp[6 ]),
        .A7 (do_tmp[7 ]),
        .A8 (do_tmp[8 ]),
        .A9 (do_tmp[9 ]),
        .A10(do_tmp[10]),
        .A11(do_tmp[11]),
        .A12(do_tmp[12]),
        .A13(do_tmp[13]),
        .A14(do_tmp[14]),
        .A15(do_tmp[15]),
        .A16(do_tmp[16]),
        .A17(do_tmp[17]),
        .A18(do_tmp[18]),
        .A19(do_tmp[19]),
        .A20(do_tmp[20]),
        .A21(do_tmp[21]),
        .A22(do_tmp[22]),
        .A23(do_tmp[23]),
        .A24(do_tmp[24]),
        .A25(do_tmp[25]),
        .A26(do_tmp[26]),
        .A27(do_tmp[27]),
        .A28(do_tmp[28]),
        .A29(do_tmp[29]),
        .A30(do_tmp[30]),
        .A31(do_tmp[31]),
        .S(A0),
        .X(Do0)
    );

endmodule


module RAM256x8_ASYNC_sky130
(
    input   wire    [7:0] A0,
    input   wire    [7:0] Di0,
    output  wire    [7:0] Do0,
    input   wire          CLK,
    input   wire          WE0
);
    wire [7:0] do_tmp [7:0];
    wire [7:0] W_BANK_SEL;
    wire [7:0] R_BANK_SEL;
    wire [7:0] Q_WIRE [7:0];
    wire hi;
    sky130_fd_sc_hd__conb_1 TIE  (.LO(), .HI(hi));
    DEC3x8  DECW ( .A(A0[7:5]), .SEL(W_BANK_SEL),   .EN(hi) );
    DEC3x8  DECR ( .A(A0[7:5]), .SEL(R_BANK_SEL),   .EN(hi) );

    generate
        genvar e;
        for(e=0; e<8; e=e+1) begin : REGF
            RAM32x8_ASYNC_sky130 RAM32x8_ASYNC_dut (
                .A0 (A0[4:0]),
                .AW (A0[4:0]),
                .Di0 (Di0 ),
                .Do0 (Q_WIRE[e] ),
                .CLK (CLK ),
                .WE0 (W_BANK_SEL[e] & WE0)
            );
        end
    endgenerate

    MUX8_8x1_8 m0(
        .A0 (Q_WIRE[0]),
        .A1 (Q_WIRE[1]),
        .A2 (Q_WIRE[2]),
        .A3 (Q_WIRE[3]),
        .A4 (Q_WIRE[4]),
        .A5 (Q_WIRE[5]),
        .A6 (Q_WIRE[6]),
        .A7 (Q_WIRE[7]),
        .S(A0[7:5]),
        .X(Do0)
    );

endmodule

module RAM256x16_ASYNC_sky130
(
    input   wire    [7:0]  A0,
    input   wire    [15:0] Di0,
    output  wire    [15:0] Do0,
    input   wire           CLK,
    input   wire    [1:0]  WE0
);
    RAM256x8_ASYNC_sky130 BANK0 (
        .A0 (A0),
        .Di0 (Di0[7:0] ),
        .Do0 (Do0[7:0] ),
        .CLK (CLK ),
        .WE0 (WE0[0])
    );
    RAM256x8_ASYNC_sky130 BANK1 (
        .A0 (A0),
        .Di0 (Di0[15:8] ),
        .Do0 (Do0[15:8] ),
        .CLK (CLK ),
        .WE0 (WE0[1])
    );
endmodule

module RAM512x16_ASYNC_sky130
(
    input   wire    [ 8:0]  A0,
    input   wire    [15:0] Di0,
    output  wire    [15:0] Do0,
    input   wire           CLK,
    input   wire    [1:0]  WE0
);
    wire    [15:0] lo_bank;
    wire    [15:0] hi_bank;
    RAM256x8_ASYNC_sky130 BANK00 (
        .A0 (A0[7:0]),
        .Di0 (Di0[7:0] ),
        .Do0 (lo_bank[7:0] ),
        .CLK (CLK ),
        .WE0 (WE0[0]&~A0[8])
    );
    RAM256x8_ASYNC_sky130 BANK01 (
        .A0 (A0[7:0]),
        .Di0 (Di0[15:8] ),
        .Do0 (lo_bank[15:8] ),
        .CLK (CLK ),
        .WE0 (WE0[1]&~A0[8])
    );
    RAM256x8_ASYNC_sky130 BANK10 (
        .A0 (A0[7:0]),
        .Di0 (Di0[7:0] ),
        .Do0 (hi_bank[7:0] ),
        .CLK (CLK ),
        .WE0 (WE0[0])
    );
    RAM256x8_ASYNC_sky130 BANK11 (
        .A0 (A0[7:0]),
        .Di0 (Di0[15:8] ),
        .Do0 (hi_bank[15:8] ),
        .CLK (CLK ),
        .WE0 (WE0[1])
    );
    MUX2x1 #(.WIDTH(16)) m0(
        .A0 (lo_bank),
        .A1 (hi_bank),
        .S(A0[8]),
        .X(Do0)
    );
endmodule

`endif