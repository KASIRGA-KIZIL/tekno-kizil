module bolme_birimi (
	clk_i,
	rst_i,
	basla_i,
	islem_i,
	bolunen_i,
	bolen_i,
	sonuc_o,
	bitti_o
);
	input wire clk_i;
	input wire rst_i;
	input wire basla_i;
	input wire [1:0] islem_i;
	input wire [31:0] bolunen_i;
	input wire [31:0] bolen_i;
	output wire [31:0] sonuc_o;
	output wire bitti_o;
	wire signedInput = 1'b0;
	wire [32:0] q;
	wire [32:0] r;
	wire divByZeroEx;
	wire bitti;
	wire isaret_farkli = bolunen_i[31] ^ bolen_i[31];
	wire [32:0] divu_sonuc = q;
	wire [32:0] remu_sonuc = r;
	wire [32:0] div_sonuc = (isaret_farkli ? ~q + 1 : q);
	wire [32:0] rem_sonuc = (bolunen_i[31] ? ~r + 1 : r);
	wire [32:0] sonuc = (islem_i == 2'b10 ? div_sonuc : (islem_i == 2'b00 ? divu_sonuc : (islem_i == 2'b11 ? rem_sonuc : remu_sonuc)));
	wire [31:0] sonuc_ex = ((islem_i == 2'b10) || (islem_i == 2'b00) ? -1 : bolunen_i);
	assign sonuc_o = (divByZeroEx ? sonuc_ex : sonuc[31:0]);
	assign bitti_o = (~basla_i & ~bitti) | (basla_i & bitti);
	wire [31:0] pos_bolunen = ~bolunen_i + 1;
	wire [31:0] pos_bolen = ~bolen_i + 1;
	wire [32:0] x = (islem_i[1] & bolunen_i[31] ? {1'b0, pos_bolunen} : {1'b0, bolunen_i});
	wire [32:0] y = (islem_i[1] & bolen_i[31] ? {1'b0, pos_bolen} : {1'b0, bolen_i});
	Radix4SRTDivider #(.N(33)) Radix4SRTDivider_dut(
		.rst_i(rst_i),
		.clk_i(clk_i),
		.start(basla_i),
		.signedInput(signedInput),
		.x(x),
		.y(y),
		.q(q),
		.r(r),
		.done(bitti),
		.divByZeroEx(divByZeroEx)
	);
endmodule
module Radix4SRTDivider (
	rst_i,
	clk_i,
	start,
	signedInput,
	x,
	y,
	q,
	r,
	done,
	divByZeroEx
);
	parameter N = 32;
	input wire rst_i;
	input wire clk_i;
	input wire start;
	input wire signedInput;
	input wire [N - 1:0] x;
	input wire [N - 1:0] y;
	output wire [N - 1:0] q;
	output wire [N - 1:0] r;
	output wire done;
	output wire divByZeroEx;
	reg [31:0] state;
	reg doneReg;
	reg divByZeroExReg;
	reg [N - 1:0] qnReg;
	reg [N - 1:0] yReg;
	reg [(2 * N) + 2:0] rxqReg;
	reg [31:0] counter;
	reg ySign;
	wire [32:0] shiftY;
	reg [32:0] shiftYReg;
	wire [N - 1:0] yAbs;
	reg [N + 2:0] cReg;
	wire [N + 2:0] ca;
	wire [N + 2:0] sa;
	wire [N + 2:0] cs;
	wire [N + 2:0] ss;
	wire [N + 2:0] ca2;
	wire [N + 2:0] sa2;
	wire [N + 2:0] cs2;
	wire [N + 2:0] ss2;
	wire [N + 2:0] ca1;
	wire [N + 2:0] sa1;
	wire [N + 2:0] cs1;
	wire [N + 2:0] ss1;
	wire [5:0] r6;
	wire [7:0] r8;
	reg [(2 * N) + 2:0] rxVar;
	wire [N + 2:0] sum;
	wire q0;
	wire q1;
	wire qSign;
	assign q = rxqReg[N - 1:0];
	assign r = rxqReg[(2 * N) - 1:N];
	assign done = doneReg;
	assign divByZeroEx = divByZeroExReg;
	assign sum = rxqReg[(2 * N) + 2:N] + {cReg[N + 2:0]};
	assign r8 = rxqReg[2 * N:(2 * N) - 7] + cReg[N:N - 7];
	assign r6 = r8[7:2];
	assign yAbs = (y[N - 1] & signedInput ? -y : y);
	zeroMSBCounter #(.N(N)) zmsb(
		.x(yAbs),
		.out(shiftY)
	);
	csAddSubGen #(.N(N + 3)) csadd1(
		.sub(1'b0),
		.cin({cReg[N + 1:0], 1'b0}),
		.x({rxqReg[(2 * N) + 1:N - 1]}),
		.y({3'b000, yReg}),
		.s(sa1),
		.c(ca1)
	);
	csAddSubGen #(.N(N + 3)) cssub1(
		.sub(1'b1),
		.cin({cReg[N + 1:0], 1'b0}),
		.x({rxqReg[(2 * N) + 1:N - 1]}),
		.y({3'b000, yReg}),
		.s(ss1),
		.c(cs1)
	);
	csAddSubGen #(.N(N + 3)) csadd(
		.sub(1'b0),
		.cin({cReg[N:0], 2'b00}),
		.x(rxqReg[2 * N:N - 2]),
		.y({3'b000, yReg}),
		.s(sa),
		.c(ca)
	);
	csAddSubGen #(.N(N + 3)) cssub(
		.sub(1'b1),
		.cin({cReg[N:0], 2'b00}),
		.x(rxqReg[2 * N:N - 2]),
		.y({3'b000, yReg}),
		.s(ss),
		.c(cs)
	);
	csAddSubGen #(.N(N + 3)) csadd2(
		.sub(1'b0),
		.cin({cReg[N:0], 2'b00}),
		.x(rxqReg[2 * N:N - 2]),
		.y({2'b00, yReg, 1'b0}),
		.s(sa2),
		.c(ca2)
	);
	csAddSubGen #(.N(N + 3)) cssub2(
		.sub(1'b1),
		.cin({cReg[N:0], 2'b00}),
		.x(rxqReg[2 * N:N - 2]),
		.y({2'b00, yReg, 1'b0}),
		.s(ss2),
		.c(cs2)
	);
	qSelPLAPos qSelect(
		.r5((r6[5] ? ~r6[4:0] : r6[4:0])),
		.y4(yReg[N - 1:N - 4]),
		.q2({q1, q0})
	);
	assign qSign = r6[5] & ({q1, q0} != 2'b00);
	always @(*) begin : signedShift
		rxVar = x <<< shiftY;
	end
	function automatic [N - 1:0] sv2v_cast_AC047;
		input reg [N - 1:0] inp;
		sv2v_cast_AC047 = inp;
	endfunction
	always @(posedge clk_i) begin : FSM
		integer i;
		if (rst_i) begin
			state <= 32'd0;
			doneReg <= 1'b0;
		end
		else
			case (state)
				32'd0: begin
					counter <= 1'sb0;
					rxqReg <= 1'sb0;
					yReg <= 1'sb0;
					qnReg <= 1'sb0;
					cReg <= 1'sb0;
					doneReg <= 1'b0;
					divByZeroExReg <= 1'b0;
					if (start)
						state <= 32'd1;
					else
						state <= 32'd0;
				end
				32'd1: begin
					shiftYReg <= shiftY;
					yReg <= yAbs << shiftY;
					ySign <= y[N - 1];
					rxqReg <= rxVar;
					if (y == {N {1'b0}}) begin
						doneReg <= 1'b1;
						divByZeroExReg <= 1'b1;
						state <= 32'd3;
					end
					else
						state <= 32'd2;
				end
				32'd3: begin
					state <= 32'd0;
					doneReg <= 1'b0;
				end
				32'd2:
					if (counter == ((N / 2) + (N % 2))) begin
						if (sum[N + 2])
							rxqReg[(2 * N) - 1:N] <= sv2v_cast_AC047((sum + yReg) >> shiftYReg);
						else
							rxqReg[(2 * N) - 1:N] <= sv2v_cast_AC047(sum >> shiftYReg);
						if (signedInput & ySign)
							rxqReg[N - 1:0] <= sum[N] - rxqReg[N - 1:0];
						else
							rxqReg[N - 1:0] <= rxqReg[N - 1:0] - sum[N];
						doneReg <= 1'b1;
						counter <= 0;
						state <= 32'd3;
					end
					else if (((counter == (N / 2)) && (N % 2)) || ((counter == 0) && (((y == 1) && x[N - 1]) && !signedInput))) begin
						case ({qSign, q1, q0})
							3'b000: begin
								rxqReg <= {rxqReg[(2 * N) + 1:0], 1'b0};
								cReg <= {cReg[N + 1:0], 1'b0};
								qnReg <= {qnReg[N - 2:0], 1'b1};
							end
							3'b001: begin
								rxqReg <= {ss1, rxqReg[N - 2:0], 1'b1};
								cReg <= cs1;
								qnReg <= {rxqReg[N - 2:0], 1'b0};
							end
							3'b010: begin
								rxqReg <= {ss1, rxqReg[N - 2:0], 1'b1};
								cReg <= cs1;
								qnReg <= {rxqReg[N - 2:0], 1'b0};
							end
							3'b101: begin
								rxqReg <= {sa1, qnReg[N - 2:0], 1'b1};
								cReg <= ca1;
								qnReg <= {qnReg[N - 2:0], 1'b0};
							end
							3'b110: begin
								rxqReg <= {sa1, qnReg[N - 2:0], 1'b1};
								cReg <= ca1;
								qnReg <= {qnReg[N - 2:0], 1'b0};
							end
						endcase
						state <= 32'd2;
						counter <= counter + 1;
					end
					else begin
						case ({qSign, q1, q0})
							3'b000: begin
								rxqReg <= {rxqReg[2 * N:0], 2'b00};
								cReg <= {cReg[N:0], 2'b00};
								qnReg <= {qnReg[N - 3:0], 2'b11};
							end
							3'b001: begin
								rxqReg <= {ss, rxqReg[N - 3:0], 2'b01};
								cReg <= cs;
								qnReg <= {rxqReg[N - 3:0], 2'b00};
							end
							3'b010: begin
								rxqReg <= {ss2, rxqReg[N - 3:0], 2'b10};
								cReg <= cs2;
								qnReg <= {rxqReg[N - 3:0], 2'b01};
							end
							3'b101: begin
								rxqReg <= {sa, qnReg[N - 3:0], 2'b11};
								cReg <= ca;
								qnReg <= {qnReg[N - 3:0], 2'b10};
							end
							3'b110: begin
								rxqReg <= {sa2, qnReg[N - 3:0], 2'b10};
								cReg <= ca2;
								qnReg <= {qnReg[N - 3:0], 2'b01};
							end
						endcase
						state <= 32'd2;
						counter <= counter + 1;
					end
			endcase
	end
endmodule
module csAddSubGen (
	sub,
	x,
	y,
	cin,
	s,
	c
);
	parameter N = 32;
	input wire sub;
	input wire [N - 1:0] x;
	input wire [N - 1:0] y;
	input wire [N - 1:0] cin;
	output wire [N - 1:0] s;
	output wire [N - 1:0] c;
	wire [N - 1:0] ys;
	assign ys = y ^ {N {sub}};
	assign c[0] = 1'b0;
	assign s[0] = (x[0] ^ ys[0]) ^ sub;
	assign c[1] = ((x[0] & ys[0]) | (x[0] & sub)) | (ys[0] & sub);
	assign s[N - 1:1] = (x[N - 1:1] ^ ys[N - 1:1]) ^ cin[N - 1:1];
	assign c[N - 1:2] = ((x[N - 2:1] & ys[N - 2:1]) | (x[N - 2:1] & cin[N - 2:1])) | (ys[N - 2:1] & cin[N - 2:1]);
endmodule
module zeroMSBCounter (
	x,
	out
);
	parameter N = 32;
	input wire [N - 1:0] x;
	output wire [32:0] out;
	wire [N - 1:0] xi;
	wire [N - 1:0] caOut;
	genvar i;
	generate
		for (i = 0; i < N; i = i + 1) begin : invertbits
			assign xi[i] = x[(N - 1) - i];
		end
	endgenerate
	combArbiter #(.N(N)) ca(
		.x(xi),
		.out(caOut)
	);
	encoder #(.N(N)) enc(
		.x(caOut),
		.out(out)
	);
endmodule
module qSelPLAPos (
	r5,
	y4,
	q2
);
	input wire [4:0] r5;
	input wire [3:0] y4;
	output reg [1:0] q2;
	always @(*)
		case ({y4, r5})
			9'h100: q2 = 2'b00;
			9'h101: q2 = 2'b00;
			9'h102: q2 = 2'b01;
			9'h103: q2 = 2'b01;
			9'h104: q2 = 2'b01;
			9'h105: q2 = 2'b01;
			9'h106: q2 = 2'b10;
			9'h107: q2 = 2'b10;
			9'h108: q2 = 2'b10;
			9'h109: q2 = 2'b10;
			9'h10a: q2 = 2'b10;
			9'h10b: q2 = 2'b10;
			9'h120: q2 = 2'b00;
			9'h121: q2 = 2'b00;
			9'h122: q2 = 2'b00;
			9'h123: q2 = 2'b01;
			9'h124: q2 = 2'b01;
			9'h125: q2 = 2'b01;
			9'h126: q2 = 2'b01;
			9'h127: q2 = 2'b10;
			9'h128: q2 = 2'b10;
			9'h129: q2 = 2'b10;
			9'h12a: q2 = 2'b10;
			9'h12b: q2 = 2'b10;
			9'h12c: q2 = 2'b10;
			9'h12d: q2 = 2'b10;
			9'h140: q2 = 2'b00;
			9'h141: q2 = 2'b00;
			9'h142: q2 = 2'b00;
			9'h143: q2 = 2'b01;
			9'h144: q2 = 2'b01;
			9'h145: q2 = 2'b01;
			9'h146: q2 = 2'b01;
			9'h147: q2 = 2'b01;
			9'h148: q2 = 2'b10;
			9'h149: q2 = 2'b10;
			9'h14a: q2 = 2'b10;
			9'h14b: q2 = 2'b10;
			9'h14c: q2 = 2'b10;
			9'h14d: q2 = 2'b10;
			9'h14e: q2 = 2'b10;
			9'h160: q2 = 2'b00;
			9'h161: q2 = 2'b00;
			9'h162: q2 = 2'b00;
			9'h163: q2 = 2'b01;
			9'h164: q2 = 2'b01;
			9'h165: q2 = 2'b01;
			9'h166: q2 = 2'b01;
			9'h167: q2 = 2'b01;
			9'h168: q2 = 2'b01;
			9'h169: q2 = 2'b10;
			9'h16a: q2 = 2'b10;
			9'h16b: q2 = 2'b10;
			9'h16c: q2 = 2'b10;
			9'h16d: q2 = 2'b10;
			9'h16e: q2 = 2'b10;
			9'h16f: q2 = 2'b10;
			9'h180: q2 = 2'b00;
			9'h181: q2 = 2'b00;
			9'h182: q2 = 2'b00;
			9'h183: q2 = 2'b00;
			9'h184: q2 = 2'b01;
			9'h185: q2 = 2'b01;
			9'h186: q2 = 2'b01;
			9'h187: q2 = 2'b01;
			9'h188: q2 = 2'b01;
			9'h189: q2 = 2'b01;
			9'h18a: q2 = 2'b10;
			9'h18b: q2 = 2'b10;
			9'h18c: q2 = 2'b10;
			9'h18d: q2 = 2'b10;
			9'h18e: q2 = 2'b10;
			9'h18f: q2 = 2'b10;
			9'h190: q2 = 2'b10;
			9'h191: q2 = 2'b10;
			9'h1a0: q2 = 2'b00;
			9'h1a1: q2 = 2'b00;
			9'h1a2: q2 = 2'b00;
			9'h1a3: q2 = 2'b00;
			9'h1a4: q2 = 2'b01;
			9'h1a5: q2 = 2'b01;
			9'h1a6: q2 = 2'b01;
			9'h1a7: q2 = 2'b01;
			9'h1a8: q2 = 2'b01;
			9'h1a9: q2 = 2'b01;
			9'h1aa: q2 = 2'b10;
			9'h1ab: q2 = 2'b10;
			9'h1ac: q2 = 2'b10;
			9'h1ad: q2 = 2'b10;
			9'h1ae: q2 = 2'b10;
			9'h1af: q2 = 2'b10;
			9'h1b0: q2 = 2'b10;
			9'h1b1: q2 = 2'b10;
			9'h1b2: q2 = 2'b10;
			9'h1c0: q2 = 2'b00;
			9'h1c1: q2 = 2'b00;
			9'h1c2: q2 = 2'b00;
			9'h1c3: q2 = 2'b00;
			9'h1c4: q2 = 2'b01;
			9'h1c5: q2 = 2'b01;
			9'h1c6: q2 = 2'b01;
			9'h1c7: q2 = 2'b01;
			9'h1c8: q2 = 2'b01;
			9'h1c9: q2 = 2'b01;
			9'h1ca: q2 = 2'b01;
			9'h1cb: q2 = 2'b10;
			9'h1cc: q2 = 2'b10;
			9'h1cd: q2 = 2'b10;
			9'h1ce: q2 = 2'b10;
			9'h1cf: q2 = 2'b10;
			9'h1d0: q2 = 2'b10;
			9'h1d1: q2 = 2'b10;
			9'h1d2: q2 = 2'b10;
			9'h1d3: q2 = 2'b10;
			9'h1e0: q2 = 2'b00;
			9'h1e1: q2 = 2'b00;
			9'h1e2: q2 = 2'b00;
			9'h1e3: q2 = 2'b00;
			9'h1e4: q2 = 2'b00;
			9'h1e5: q2 = 2'b01;
			9'h1e6: q2 = 2'b01;
			9'h1e7: q2 = 2'b01;
			9'h1e8: q2 = 2'b01;
			9'h1e9: q2 = 2'b01;
			9'h1ea: q2 = 2'b01;
			9'h1eb: q2 = 2'b01;
			9'h1ec: q2 = 2'b10;
			9'h1ed: q2 = 2'b10;
			9'h1ee: q2 = 2'b10;
			9'h1ef: q2 = 2'b10;
			9'h1f0: q2 = 2'b10;
			9'h1f1: q2 = 2'b10;
			9'h1f2: q2 = 2'b10;
			9'h1f3: q2 = 2'b10;
			9'h1f4: q2 = 2'b10;
			9'h1f5: q2 = 2'b10;
			default: q2 = 2'b00;
		endcase
endmodule
module combArbiter (
	x,
	out
);
	parameter N = 32;
	input wire [N - 1:0] x;
	output wire [N - 1:0] out;
	wire [N - 1:0] notFoundYet;
	genvar i;
	assign notFoundYet[0] = 1'b1;
	generate
		for (i = 1; i < N; i = i + 1) begin : arbiterFor
			assign notFoundYet[i] = ~x[i - 1] & notFoundYet[i - 1];
		end
	endgenerate
	assign out = x & notFoundYet;
endmodule
module encoder (
	x,
	out
);
	parameter N = 32;
	input wire [N - 1:0] x;
	output reg [32:0] out;
	function automatic [$clog2(N) - 1:0] sv2v_cast_18FA7;
		input reg [$clog2(N) - 1:0] inp;
		sv2v_cast_18FA7 = inp;
	endfunction
	always @(*) begin
		out = {$clog2(N) + 1 {1'b0}};
		begin : sv2v_autoblock_1
			reg [31:0] i;
			for (i = 0; i < N; i = i + 1)
				if (x[i])
					out = out | sv2v_cast_18FA7(i);
		end
	end
endmodule
