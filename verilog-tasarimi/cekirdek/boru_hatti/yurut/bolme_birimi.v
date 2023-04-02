// bolme_birimi.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

`define L_DIVU 2'b00
`define L_REMU 2'b01
`define L_DIV  2'b10
`define L_REM  2'b11


module bolme_birimi(
    input  wire clk_i,
    input  wire rst_i,
    input  wire basla_i,
    input  wire [1:0] islem_i, //00 DIVU, 01 REMU, 10 DIV, 11 REM
    input  wire [31:0] bolunen_i,
    input  wire [31:0] bolen_i,
    output wire [31:0] sonuc_o,
    output wire bitti_o
);
    wire signedInput = 1'b0;
    wire [32:0] q;
    wire [32:0] r;
    wire divByZeroEx;
    wire bitti;

    wire isaret_farkli = (bolunen_i[31] ^ bolen_i[31]);
    wire [32:0] divu_sonuc = q;
    wire [32:0] remu_sonuc = r;
    wire [32:0] div_sonuc  = isaret_farkli ? ((~q) + 1) : q;
    wire [32:0] rem_sonuc  = bolunen_i[31] ? ((~r) + 1) : r;

    wire [32:0] sonuc = (islem_i == `L_DIV ) ? div_sonuc  :
                        (islem_i == `L_DIVU) ? divu_sonuc :
                        (islem_i == `L_REM ) ? rem_sonuc  :
                                               remu_sonuc ;

    wire [31:0] sonuc_ex = (islem_i == `L_DIV) || (islem_i == `L_DIVU) ? -1 : bolunen_i;

    assign sonuc_o  = divByZeroEx ? sonuc_ex : sonuc[31:0];

    assign bitti_o = (~basla_i&~bitti) | (basla_i&bitti);

    wire [31:0] pos_bolunen = ((~bolunen_i) + 1);
    wire [31:0] pos_bolen   = ((~bolen_i  ) + 1);
    wire [32:0] x = islem_i[1]&bolunen_i[31] ? {1'b0,pos_bolunen} : {1'b0,bolunen_i};
    wire [32:0] y = islem_i[1]&bolen_i  [31] ? {1'b0,pos_bolen  } : {1'b0,bolen_i  };


    Radix4SRTDivider #(
        .N (33)
    ) Radix4SRTDivider_dut (
        .rst_i (rst_i ),
        .clk_i (clk_i ),
        .start (basla_i ),
        .signedInput (signedInput ),
        .x (x ),
        .y (y ),
        .q (q ),
        .r (r ),
        .done (bitti ),
        .divByZeroEx  (divByZeroEx)
    );


endmodule
    //-----------------------------------------------------------------------------
// Copyright 2021 Andrea Miele
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//-----------------------------------------------------------------------------

// Radix4SRTDivider.sv
// Radix-4 generic integer SRT divider
// remainder is in rxqReg[N + 2 : N] and it is kept in [-2/3 y, 2/3 y]

module Radix4SRTDivider
#(
    parameter N = 32
)
(
    input logic rst_i,
    input logic clk_i,
    input logic start,
    input logic signedInput,
    input logic [N - 1 : 0] x,
    input logic [N - 1 : 0] y,
    output logic [N - 1 : 0] q,
    output logic [N - 1 : 0] r,
    output logic done,
    output logic divByZeroEx
);

typedef enum {RESET, START, RUN, DONE} State;
State state;
logic doneReg;
logic divByZeroExReg;
logic [N - 1 : 0] qnReg;
logic [N - 1 : 0] yReg;
logic [2 * N + 2 : 0] rxqReg;
logic [$size(N) - 1 : 0] counter;
logic ySign;
logic [$size(N) : 0] shiftY;
logic [$size(N) : 0] shiftYReg;
logic [N - 1 : 0] yAbs;
logic [N + 2 : 0] cReg;
logic [N + 2 : 0] ca, sa, cs, ss, ca2, sa2, cs2, ss2;
logic [N + 2 : 0] ca1, sa1, cs1, ss1; // to handle odd N
logic [5 : 0] r6;
logic [7 : 0] r8;
logic [2 * N + 2 : 0] rxVar;
logic [N + 2 : 0] sum;
logic q0, q1, qSign;

// outputs
assign q = rxqReg[N - 1 : 0];
assign r = rxqReg[2 * N - 1 : N];
assign done = doneReg;
assign divByZeroEx = divByZeroExReg;

assign sum = rxqReg[2 * N + 2 : N] + {cReg[N + 2 : 0]};
assign r8 = rxqReg[2 * N : 2 * N - 7] + cReg[N : N - 7]; // need to sum 8 bits of carry-save registers with carry ripple to select q
assign r6 = r8[7 : 2]; // last bit is sign
assign yAbs = (y[N - 1] & signedInput) ? -y : y;

zeroMSBCounter #(N) zmsb(.x(yAbs), .out(shiftY));
// For odd N, last iteration shift by 1 only
csAddSubGen #(N + 3) csadd1(.sub(1'b0), .cin({cReg[N + 1 : 0], 1'b0}), .x({rxqReg[2 * N + 1 : N - 1]}), .y({3'b000, yReg}),
.s(sa1), .c(ca1));
csAddSubGen #(N + 3) cssub1(.sub(1'b1), .cin({cReg[N + 1 : 0], 1'b0}), .x({rxqReg[2 * N + 1 : N - 1]}), .y({3'b000, yReg}),
.s(ss1), .c(cs1));

csAddSubGen #(N + 3) csadd(.sub(1'b0), .cin({cReg[N : 0], 2'b00}), .x(rxqReg[2 * N : N - 2]), .y({3'b000, yReg}),
.s(sa), .c(ca));
csAddSubGen #(N + 3) cssub(.sub(1'b1), .cin({cReg[N : 0], 2'b00}), .x(rxqReg[2 * N : N - 2]), .y({3'b000, yReg}),
.s(ss), .c(cs));
csAddSubGen #(N + 3) csadd2(.sub(1'b0), .cin({cReg[N : 0], 2'b00}), .x(rxqReg[2 * N : N - 2]), .y({2'b0, yReg, 1'b0}),
.s(sa2), .c(ca2));
csAddSubGen #(N + 3) cssub2(.sub(1'b1), .cin({cReg[N : 0], 2'b00}), .x(rxqReg[2 * N : N - 2]), .y({2'b0, yReg, 1'b0}),
.s(ss2), .c(cs2));

// simplified, non-negative, quotient selection LUT/PLA
// use 1's complement absolute value
qSelPLAPos qSelect(r6[5] ? ~r6[4 : 0]: r6[4 : 0], yReg[N - 1 : N - 4], {q1, q0});
assign qSign = r6[5] & (!({q1, q0} == 2'b00)); // Takes care of sign-magnitude 000, 100 zeros

// signed shift
always_comb
begin: signedShift
    rxVar = x <<< shiftY;
end


always_ff @(posedge clk_i)
begin: FSM
    integer i;
    if(rst_i)
    begin
        state <= RESET;
        doneReg <= 1'b0;
    end
    else
    begin
        case (state)
            RESET:
            begin
                counter <= '0;
                rxqReg <= '0;
                yReg <= '0;
                qnReg <= '0;
                cReg <= '0;
                doneReg <= 1'b0;
                divByZeroExReg <= 1'b0;
                if(start)
                    state <= START;
                else
                    state <= RESET;
            end
            START:
            begin
                shiftYReg <= shiftY;
                yReg      <= yAbs << shiftY;
                ySign <= y[N - 1];
                rxqReg  <=   rxVar;
                if (y == {N{1'b0}})
                begin
                    doneReg <= 1'b1;
                    divByZeroExReg <= 1'b1;
                    state <= DONE;
                end
                else
                    state <= RUN;
            end
            DONE:
            begin
                state   <= RESET;
                doneReg <= 1'b0;
            end
            RUN:
            begin
                if (counter == N / 2 + N % 2)
                begin
                    if(sum[N + 2])
                    begin
                        rxqReg[2 * N - 1 : N] <= N'((sum + yReg) >> shiftYReg);
                    end
                    else
                    begin
                        rxqReg[2 * N - 1 : N] <= N'(sum >> shiftYReg);
                    end
                    if(signedInput & ySign)
                        rxqReg[N - 1 : 0] <= -(rxqReg[N - 1 : 0] - sum[N]);
                    else
                        rxqReg[N - 1 : 0] <= rxqReg[N - 1 : 0] - sum[N];
                    doneReg <= 1'b1;
                    counter <= 0;
                    state <= DONE;
                end
                else
                if (counter == N / 2 && (N % 2)
                || (counter == 0 && (y == 1 && x[N - 1] && !(signedInput))))
                // handle odd N (last iteration: shift by just 1) or
                // first remainder > 2/3 y (first iteration: shift by just 1)
                begin
                    case ({qSign, q1, q0})
                        3'b000:
                        begin

                            rxqReg <= {rxqReg[2 * N + 1 : 0], 1'b0};
                            cReg <= {cReg[N + 1 : 0], 1'b0};
                            qnReg <= {qnReg[N - 2 : 0], 1'b1};
                        end
                        3'b001:
                        begin

                            rxqReg <= {ss1, rxqReg[N - 2 : 0], 1'b1};
                            cReg <=  cs1;
                            qnReg <= {rxqReg[N - 2 : 0], 1'b0};
                        end

                        3'b010:
                        begin

                            rxqReg <= {ss1, rxqReg[N - 2 : 0], 1'b1};
                            cReg <=  cs1;
                            qnReg <= {rxqReg[N - 2 : 0], 1'b0};
                        end

                        3'b101:
                        begin

                            rxqReg <= {sa1, qnReg[N - 2 : 0], 1'b1};
                            cReg <=  ca1;
                            qnReg <= {qnReg[N - 2 : 0], 1'b0};
                        end

                        3'b110:
                        begin

                            rxqReg <= {sa1, qnReg[N - 2 : 0], 1'b1};
                            cReg <=  ca1;
                            qnReg <= {qnReg[N - 2 : 0], 1'b0};
                        end
                    endcase

                    state <= RUN;
                    counter <= counter + 1;
                end
                else
                begin

                    case ({qSign, q1, q0})
                        3'b000:
                        begin

                            rxqReg <= {rxqReg[2 * N : 0], 2'b00};
                            cReg <= {cReg[N : 0], 2'b00};
                            qnReg <= {qnReg[N - 3 : 0], 2'b11};
                        end
                        3'b001:
                        begin

                            rxqReg <= {ss, rxqReg[N - 3 : 0], 2'b01};
                            cReg <=  cs;
                            qnReg <= {rxqReg[N - 3 : 0], 2'b00};
                        end

                        3'b010:
                        begin

                            rxqReg <= {ss2, rxqReg[N - 3 : 0], 2'b10};
                            cReg <=  cs2;
                            qnReg <= {rxqReg[N - 3 : 0], 2'b01};
                        end

                        3'b101:
                        begin

                            rxqReg <= {sa, qnReg[N - 3 : 0], 2'b11};
                            cReg <=  ca;
                            qnReg <= {qnReg[N - 3 : 0], 2'b10};
                        end

                        3'b110:
                        begin

                            rxqReg <= {sa2, qnReg[N - 3 : 0], 2'b10};
                            cReg <=  ca2;
                            qnReg <= {qnReg[N - 3 : 0], 2'b01};
                        end
                    endcase

                    state <= RUN;
                    counter <= counter + 1;
                end
            end
        endcase
    end
end // end FSM
endmodule

module csAddSubGen
#(parameter N = 32)

(
input logic sub,
input logic [N - 1 : 0] x,
input logic [N - 1 : 0] y,
input logic [N - 1 : 0] cin,
output logic [N - 1: 0] s,
output logic [N - 1 : 0] c
);

logic [N - 1 : 0] ys;

assign ys = y ^ {N{sub}};
assign c[0] = 1'b0;
assign s[0] = x[0] ^ ys[0] ^ sub;
assign c[1] = x[0] & ys[0] | x[0] & sub | ys[0] & sub;
assign s[N - 1 : 1] = x[N - 1 : 1] ^ ys[N - 1 : 1] ^ cin[N - 1 : 1];
assign c[N - 1 : 2] = x[N - 2 : 1] & ys[N - 2 : 1] | x[N - 2 : 1] & cin[N - 2 : 1] |
 ys[N - 2 : 1] & cin[N - 2 : 1];

// ignore last carry

endmodule


module zeroMSBCounter
#(parameter N = 32)
(
    input logic [N - 1 : 0] x,
    output logic [$size(N) : 0] out
);
logic [N - 1 : 0] xi;
logic [N - 1 : 0] caOut;
genvar i;
generate
for(i = 0; i < N; i++)
begin: invertbits
   assign xi[i] = x[N - 1 - i];
end
endgenerate

combArbiter #(N) ca(.x(xi), .out(caOut));
encoder #(N) enc(.x(caOut), .out(out));
endmodule

//-----------------------------------------------------------------------------
// Copyright 2021 Andrea Miele
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//-----------------------------------------------------------------------------

// qSelPLAPos.sv
// Non-negative only PLA for Radix-4 SRT quotient selection
// -2/3y <= r <= 2/3 y
// follows table in H&P 5th edition, appendix J, page 57

module qSelPLAPos
(
    input logic [4 : 0] r5,
    input logic [3 : 0] y4,
    output logic [1 : 0] q2 // magnitude of quotient digit
);

always_comb
begin

    case ({y4, r5})
        // 8 0: 0
        {4'h8, 5'h0}: q2 = 2'b00;
        // 8 1: 0
        {4'h8, 5'h1}: q2 = 2'b00;
        // 8 2: 1
        {4'h8, 5'h2}: q2 = 2'b01;
        // 8 3: 1
        {4'h8, 5'h3}: q2 = 2'b01;
        // 8 4: 1
        {4'h8, 5'h4}: q2 = 2'b01;
        // 8 5: 1
        {4'h8, 5'h5}: q2 = 2'b01;
        // 8 6: 2
        {4'h8, 5'h6}: q2 = 2'b10;
        // 8 7: 2
        {4'h8, 5'h7}: q2 = 2'b10;
        // 8 8: 2
        {4'h8, 5'h8}: q2 = 2'b10;
        // 8 9: 2
        {4'h8, 5'h9}: q2 = 2'b10;
        // 8 10: 2
        {4'h8, 5'ha}: q2 = 2'b10;
        // 8 11: 2
        {4'h8, 5'hb}: q2 = 2'b10;
        // 9 0: 0
        {4'h9, 5'h0}: q2 = 2'b00;
        // 9 1: 0
        {4'h9, 5'h1}: q2 = 2'b00;
        // 9 2: 0
        {4'h9, 5'h2}: q2 = 2'b00;
        // 9 3: 1
        {4'h9, 5'h3}: q2 = 2'b01;
        // 9 4: 1
        {4'h9, 5'h4}: q2 = 2'b01;
        // 9 5: 1
        {4'h9, 5'h5}: q2 = 2'b01;
        // 9 6: 1
        {4'h9, 5'h6}: q2 = 2'b01;
        // 9 7: 2
        {4'h9, 5'h7}: q2 = 2'b10;
        // 9 8: 2
        {4'h9, 5'h8}: q2 = 2'b10;
        // 9 9: 2
        {4'h9, 5'h9}: q2 = 2'b10;
        // 9 10: 2
        {4'h9, 5'ha}: q2 = 2'b10;
        // 9 11: 2
        {4'h9, 5'hb}: q2 = 2'b10;
        // 9 12: 2
        {4'h9, 5'hc}: q2 = 2'b10;
        // 9 13: 2
        {4'h9, 5'hd}: q2 = 2'b10;
        // 10 0: 0
        {4'ha, 5'h0}: q2 = 2'b00;
        // 10 1: 0
        {4'ha, 5'h1}: q2 = 2'b00;
        // 10 2: 0
        {4'ha, 5'h2}: q2 = 2'b00;
        // 10 3: 1
        {4'ha, 5'h3}: q2 = 2'b01;
        // 10 4: 1
        {4'ha, 5'h4}: q2 = 2'b01;
        // 10 5: 1
        {4'ha, 5'h5}: q2 = 2'b01;
        // 10 6: 1
        {4'ha, 5'h6}: q2 = 2'b01;
        // 10 7: 1
        {4'ha, 5'h7}: q2 = 2'b01;
        // 10 8: 2
        {4'ha, 5'h8}: q2 = 2'b10;
        // 10 9: 2
        {4'ha, 5'h9}: q2 = 2'b10;
        // 10 10: 2
        {4'ha, 5'ha}: q2 = 2'b10;
        // 10 11: 2
        {4'ha, 5'hb}: q2 = 2'b10;
        // 10 12: 2
        {4'ha, 5'hc}: q2 = 2'b10;
        // 10 13: 2
        {4'ha, 5'hd}: q2 = 2'b10;
        // 10 14: 2
        {4'ha, 5'he}: q2 = 2'b10;
        // 11 0: 0
        {4'hb, 5'h0}: q2 = 2'b00;
        // 11 1: 0
        {4'hb, 5'h1}: q2 = 2'b00;
        // 11 2: 0
        {4'hb, 5'h2}: q2 = 2'b00;
        // 11 3: 1
        {4'hb, 5'h3}: q2 = 2'b01;
        // 11 4: 1
        {4'hb, 5'h4}: q2 = 2'b01;
        // 11 5: 1
        {4'hb, 5'h5}: q2 = 2'b01;
        // 11 6: 1
        {4'hb, 5'h6}: q2 = 2'b01;
        // 11 7: 1
        {4'hb, 5'h7}: q2 = 2'b01;
        // 11 8: 1
        {4'hb, 5'h8}: q2 = 2'b01;
        // 11 9: 2
        {4'hb, 5'h9}: q2 = 2'b10;
        // 11 10: 2
        {4'hb, 5'ha}: q2 = 2'b10;
        // 11 11: 2
        {4'hb, 5'hb}: q2 = 2'b10;
        // 11 12: 2
        {4'hb, 5'hc}: q2 = 2'b10;
        // 11 13: 2
        {4'hb, 5'hd}: q2 = 2'b10;
        // 11 14: 2
        {4'hb, 5'he}: q2 = 2'b10;
        // 11 15: 2
        {4'hb, 5'hf}: q2 = 2'b10;
        // 12 0: 0
        {4'hc, 5'h0}: q2 = 2'b00;
        // 12 1: 0
        {4'hc, 5'h1}: q2 = 2'b00;
        // 12 2: 0
        {4'hc, 5'h2}: q2 = 2'b00;
        // 12 3: 0
        {4'hc, 5'h3}: q2 = 2'b00;
        // 12 4: 1
        {4'hc, 5'h4}: q2 = 2'b01;
        // 12 5: 1
        {4'hc, 5'h5}: q2 = 2'b01;
        // 12 6: 1
        {4'hc, 5'h6}: q2 = 2'b01;
        // 12 7: 1
        {4'hc, 5'h7}: q2 = 2'b01;
        // 12 8: 1
        {4'hc, 5'h8}: q2 = 2'b01;
        // 12 9: 1
        {4'hc, 5'h9}: q2 = 2'b01;
        // 12 10: 2
        {4'hc, 5'ha}: q2 = 2'b10;
        // 12 11: 2
        {4'hc, 5'hb}: q2 = 2'b10;
        // 12 12: 2
        {4'hc, 5'hc}: q2 = 2'b10;
        // 12 13: 2
        {4'hc, 5'hd}: q2 = 2'b10;
        // 12 14: 2
        {4'hc, 5'he}: q2 = 2'b10;
        // 12 15: 2
        {4'hc, 5'hf}: q2 = 2'b10;
        // 12 16: 2
        {4'hc, 5'h10}: q2 = 2'b10;
        // 12 17: 2
        {4'hc, 5'h11}: q2 = 2'b10;
        // 13 0: 0
        {4'hd, 5'h0}: q2 = 2'b00;
        // 13 1: 0
        {4'hd, 5'h1}: q2 = 2'b00;
        // 13 2: 0
        {4'hd, 5'h2}: q2 = 2'b00;
        // 13 3: 0
        {4'hd, 5'h3}: q2 = 2'b00;
        // 13 4: 1
        {4'hd, 5'h4}: q2 = 2'b01;
        // 13 5: 1
        {4'hd, 5'h5}: q2 = 2'b01;
        // 13 6: 1
        {4'hd, 5'h6}: q2 = 2'b01;
        // 13 7: 1
        {4'hd, 5'h7}: q2 = 2'b01;
        // 13 8: 1
        {4'hd, 5'h8}: q2 = 2'b01;
        // 13 9: 1
        {4'hd, 5'h9}: q2 = 2'b01;
        // 13 10: 2
        {4'hd, 5'ha}: q2 = 2'b10;
        // 13 11: 2
        {4'hd, 5'hb}: q2 = 2'b10;
        // 13 12: 2
        {4'hd, 5'hc}: q2 = 2'b10;
        // 13 13: 2
        {4'hd, 5'hd}: q2 = 2'b10;
        // 13 14: 2
        {4'hd, 5'he}: q2 = 2'b10;
        // 13 15: 2
        {4'hd, 5'hf}: q2 = 2'b10;
        // 13 16: 2
        {4'hd, 5'h10}: q2 = 2'b10;
        // 13 17: 2
        {4'hd, 5'h11}: q2 = 2'b10;
        // 13 18: 2
        {4'hd, 5'h12}: q2 = 2'b10;
        // 14 0: 0
        {4'he, 5'h0}: q2 = 2'b00;
        // 14 1: 0
        {4'he, 5'h1}: q2 = 2'b00;
        // 14 2: 0
        {4'he, 5'h2}: q2 = 2'b00;
        // 14 3: 0
        {4'he, 5'h3}: q2 = 2'b00;
        // 14 4: 1
        {4'he, 5'h4}: q2 = 2'b01;
        // 14 5: 1
        {4'he, 5'h5}: q2 = 2'b01;
        // 14 6: 1
        {4'he, 5'h6}: q2 = 2'b01;
        // 14 7: 1
        {4'he, 5'h7}: q2 = 2'b01;
        // 14 8: 1
        {4'he, 5'h8}: q2 = 2'b01;
        // 14 9: 1
        {4'he, 5'h9}: q2 = 2'b01;
        // 14 10: 1
        {4'he, 5'ha}: q2 = 2'b01;
        // 14 11: 2
        {4'he, 5'hb}: q2 = 2'b10;
        // 14 12: 2
        {4'he, 5'hc}: q2 = 2'b10;
        // 14 13: 2
        {4'he, 5'hd}: q2 = 2'b10;
        // 14 14: 2
        {4'he, 5'he}: q2 = 2'b10;
        // 14 15: 2
        {4'he, 5'hf}: q2 = 2'b10;
        // 14 16: 2
        {4'he, 5'h10}: q2 = 2'b10;
        // 14 17: 2
        {4'he, 5'h11}: q2 = 2'b10;
        // 14 18: 2
        {4'he, 5'h12}: q2 = 2'b10;
        // 14 19: 2
        {4'he, 5'h13}: q2 = 2'b10;
        // 15 0: 0
        {4'hf, 5'h0}: q2 = 2'b00;
        // 15 1: 0
        {4'hf, 5'h1}: q2 = 2'b00;
        // 15 2: 0
        {4'hf, 5'h2}: q2 = 2'b00;
        // 15 3: 0
        {4'hf, 5'h3}: q2 = 2'b00;
        // 15 4: 0
        {4'hf, 5'h4}: q2 = 2'b00;
        // 15 5: 1
        {4'hf, 5'h5}: q2 = 2'b01;
        // 15 6: 1
        {4'hf, 5'h6}: q2 = 2'b01;
        // 15 7: 1
        {4'hf, 5'h7}: q2 = 2'b01;
        // 15 8: 1
        {4'hf, 5'h8}: q2 = 2'b01;
        // 15 9: 1
        {4'hf, 5'h9}: q2 = 2'b01;
        // 15 10: 1
        {4'hf, 5'ha}: q2 = 2'b01;
        // 15 11: 1
        {4'hf, 5'hb}: q2 = 2'b01;
        // 15 12: 2
        {4'hf, 5'hc}: q2 = 2'b10;
        // 15 13: 2
        {4'hf, 5'hd}: q2 = 2'b10;
        // 15 14: 2
        {4'hf, 5'he}: q2 = 2'b10;
        // 15 15: 2
        {4'hf, 5'hf}: q2 = 2'b10;
        // 15 16: 2
        {4'hf, 5'h10}: q2 = 2'b10;
        // 15 17: 2
        {4'hf, 5'h11}: q2 = 2'b10;
        // 15 18: 2
        {4'hf, 5'h12}: q2 = 2'b10;
        // 15 19: 2
        {4'hf, 5'h13}: q2 = 2'b10;
        // 15 20: 2
        {4'hf, 5'h14}: q2 = 2'b10;
        // 15 21: 2
        {4'hf, 5'h15}: q2 = 2'b10;

		  default:       q2 = 2'b00;

    endcase
end
endmodule

module combArbiter
#(parameter N = 32)
(
    input logic [N - 1 : 0] x,
    output logic [N - 1 : 0] out
);
logic [N - 1 : 0] notFoundYet;

genvar i;
assign notFoundYet[0] = 1'b1;

generate
for(i = 1; i < N; i++)
begin: arbiterFor
    assign notFoundYet[i] = (~x[i - 1]) & notFoundYet[i - 1];
end
endgenerate
assign out = x & notFoundYet;
endmodule


module encoder
#(parameter N = 32)
(
    input logic [N - 1 : 0] x,
    output logic [$size(N) : 0] out
);

always_comb
begin
    out = {$clog2(N) + 1{1'b0}};
    for (int unsigned i = 0; i < N; i++)
    begin
        if (x[i])
            out |= $clog2(N)'(i);
    end
end
endmodule