/*
    Copyright ©2020-2022 The American University in Cairo

    This file is part of the DFFRAM Memory Compiler.
    See https://github.com/Cloud-V/DFFRAM for further info.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

`include "tanimlamalar.vh"

`ifdef OPENLANE
// Add 1x2 binary decoder
`default_nettype none

module DEC2x4 (
    input           EN,
    input   [1:0]   A,
    output  [3:0]   SEL
);
    sky130_fd_sc_hd__nor3b_2    AND0 ( .Y(SEL[0]), .A(A[0]),   .B(A[1]), .C_N(EN) );
    sky130_fd_sc_hd__and3b_2    AND1 ( .X(SEL[1]), .A_N(A[1]), .B(A[0]), .C(EN) );
    sky130_fd_sc_hd__and3b_2    AND2 ( .X(SEL[2]), .A_N(A[0]), .B(A[1]), .C(EN) ); // 4.600000
    sky130_fd_sc_hd__and3_2     AND3 ( .X(SEL[3]), .A(A[1]),   .B(A[0]), .C(EN) ); // 4.14

endmodule

module DEC3x8 (
    input           EN,
    input [2:0]     A,
    output [7:0]    SEL
);

    wire [2:0]  A_buf;
    wire        EN_buf;

    sky130_fd_sc_hd__clkbuf_2 ABUF[2:0] (.X(A_buf), .A(A));
    sky130_fd_sc_hd__clkbuf_2 ENBUF (.X(EN_buf), .A(EN));

    (* keep = "true" *)
    sky130_fd_sc_hd__nor4b_2   AND0 ( .Y(SEL[0])  , .A(A_buf[0]), .B(A_buf[1])  , .C(A_buf[2]), .D_N(EN_buf) ); // 000

    sky130_fd_sc_hd__and4bb_2   AND1 ( .X(SEL[1])  , .A_N(A_buf[2]), .B_N(A_buf[1]), .C(A_buf[0])  , .D(EN_buf) ); // 001
    sky130_fd_sc_hd__and4bb_2   AND2 ( .X(SEL[2])  , .A_N(A_buf[2]), .B_N(A_buf[0]), .C(A_buf[1])  , .D(EN_buf) ); // 010
    sky130_fd_sc_hd__and4b_2    AND3 ( .X(SEL[3])  , .A_N(A_buf[2]), .B(A_buf[1]), .C(A_buf[0])  , .D(EN_buf) );   // 011
    sky130_fd_sc_hd__and4bb_2   AND4 ( .X(SEL[4])  , .A_N(A_buf[0]), .B_N(A_buf[1]), .C(A_buf[2])  , .D(EN_buf) ); // 100
    sky130_fd_sc_hd__and4b_2    AND5 ( .X(SEL[5])  , .A_N(A_buf[1]), .B(A_buf[0]), .C(A_buf[2])  , .D(EN_buf) );   // 101
    sky130_fd_sc_hd__and4b_2    AND6 ( .X(SEL[6])  , .A_N(A_buf[0]), .B(A_buf[1]), .C(A_buf[2])  , .D(EN_buf) );   // 110
    sky130_fd_sc_hd__and4_2     AND7 ( .X(SEL[7])  , .A(A_buf[0]), .B(A_buf[1]), .C(A_buf[2])  , .D(EN_buf) ); // 111
endmodule

module DEC5x32 (
    input   [4:0]   A,
    output  [31:0]  SEL
);
	wire [3:0]  EN;
	DEC3x8 D0 ( .A(A[2:0]), .SEL(SEL[7:0]),   .EN(EN[0]) );
	DEC3x8 D1 ( .A(A[2:0]), .SEL(SEL[15:8]),  .EN(EN[1]) );
	DEC3x8 D2 ( .A(A[2:0]), .SEL(SEL[23:16]), .EN(EN[2]) );
	DEC3x8 D3 ( .A(A[2:0]), .SEL(SEL[31:24]), .EN(EN[3]) );

    wire hi;
    sky130_fd_sc_hd__conb_1 TIE  (.LO(), .HI(hi));

	DEC2x4 D ( .A(A[4:3]), .SEL(EN), .EN(hi) );
endmodule


module MUX2x1 #(parameter   WIDTH=32)
(
    input   wire [WIDTH-1:0]    A0, A1,
    input   wire                S,
    output  wire [WIDTH-1:0]    X
);
    localparam SIZE = WIDTH/8;
    wire [SIZE-1:0] SEL;
    sky130_fd_sc_hd__clkbuf_2 SEL0BUF[SIZE-1:0] (.X(SEL), .A(S));
    generate
        genvar i;
        for(i=0; i<SIZE; i=i+1) begin : M
`ifndef NO_DIODES
            (* keep = "true" *)
            sky130_fd_sc_hd__diode_2 DIODE_A0MUX [(i+1)*8-1:i*8] (.DIODE(A0[(i+1)*8-1:i*8]));
            (* keep = "true" *)
            sky130_fd_sc_hd__diode_2 DIODE_A1MUX [(i+1)*8-1:i*8] (.DIODE(A1[(i+1)*8-1:i*8]));
`endif
            sky130_fd_sc_hd__mux2_1 MUX[7:0] (.A0(A0[(i+1)*8-1:i*8]), .A1(A1[(i+1)*8-1:i*8]), .S(SEL[i]), .X(X[(i+1)*8-1:i*8]) );
        end
    endgenerate
endmodule


module  CLKBUF_2  (input A, output X);

sky130_fd_sc_hd__clkbuf_2  __cell__ (.A(A), .X(X));

endmodule


module CLKBUF_16 (input A, output X);

sky130_fd_sc_hd__clkbuf_16 __cell__ (.A(A), .X(X));

endmodule

module DIODE (input DIODE);

sky130_fd_sc_hd__diode_2 __cell__ (.DIODE(DIODE));

endmodule

module CLKBUF_4 (input A, output X);

sky130_fd_sc_hd__clkbuf_4 __cell__ (.A(A), .X(X));

endmodule

module CONB (output HI, output LO);

sky130_fd_sc_hd__conb_1 __cell__ (.HI(), .LO(LO));

endmodule

module EBUFN_2 (input A, input TE_B, output Z);

sky130_fd_sc_hd__ebufn_2 __cell__ ( .A(A), .TE_B(TE_B), .Z(Z));

endmodule

module RFWORD #(parameter WSIZE=8)
(
    input   wire             CLK,
    input   wire             WE,
    input   wire             SELW,
    output  wire [WSIZE-1:0] D1,
    input   wire [WSIZE-1:0] DW
);

    wire             we_wire;
    wire [(WSIZE/8)-1:0]          GCLK;


    sky130_fd_sc_hd__and2_1 CGAND ( .A(SELW), .B(WE), .X(we_wire) );
    sky130_fd_sc_hd__dlclkp_1 CG[(WSIZE/8)-1:0] ( .CLK(CLK), .GCLK(GCLK), .GATE(we_wire) );

    generate
        genvar i;
        for(i=0; i<WSIZE; i=i+1) begin : BIT
            sky130_fd_sc_hd__dfxtp_4 FF ( .D(DW[i]), .Q(D1[i]), .CLK(GCLK[i/8]) );
        end
    endgenerate

endmodule
`endif