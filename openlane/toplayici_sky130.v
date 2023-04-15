
`include "tanimlamalar.vh"

`ifdef OPENLANE

module toplayici_sky130(
	input  [32:0] a_in,
	input  [32:0] b_in,
	output [32:0] sum
);
	wire n8_tree_32, n9_tree_32, n10_tree_32, n11_tree_32, n12_tree_32, n13_tree_32, n16_tree_32, n17_tree_32, n18_tree_31, n18_tree_32, n19_tree_31, n19_tree_32, n20_tree_32, n21_tree_32, n24_tree_32, n25_tree_32, n26_tree_32, n27_tree_32, n28_tree_32, n29_tree_32, n32_tree_32, n33_tree_32, n34_tree_31, n34_tree_32, n35_tree_31, n35_tree_32, n36_tree_32, n37_tree_32, n38_tree_30, n39_tree_30, n40_tree_32, n41_tree_32, n42_tree_32, n43_tree_32, n44_tree_32, n45_tree_32, n48_tree_32, n49_tree_32, n50_tree_31, n50_tree_32, n51_tree_31, n51_tree_32, n52_tree_32, n53_tree_32, n56_tree_32, n57_tree_32, n58_tree_32, n59_tree_32, n60_tree_32, n61_tree_32, n64_tree_32, n65_tree_32, n66_tree_31, n66_tree_32, n67_tree_31, n67_tree_32, n68_tree_32, n69_tree_32, n70_tree_30, n71_tree_30, n72_tree_32, n73_tree_32, n74_tree_32, n75_tree_32, n76_tree_32, n77_tree_32, n80_tree_32, n81_tree_32, n82_tree_29, n82_tree_31, n82_tree_32, n83_tree_29, n83_tree_31, n83_tree_32, n84_tree_32, n85_tree_32, n88_tree_32, n89_tree_32, n90_tree_32, n91_tree_32, n92_tree_32, n93_tree_32, n96_tree_32, n97_tree_32, n98_tree_31, n98_tree_32, n99_tree_31, n99_tree_32, n100_tree_32, n101_tree_32, n102_tree_30, n103_tree_30, n104_tree_32, n105_tree_32, n106_tree_32, n107_tree_32, n108_tree_32, n109_tree_32, n112_tree_32, n113_tree_32, n114_tree_31, n114_tree_32, n115_tree_31, n115_tree_32, n116_tree_32, n117_tree_32, n120_tree_32, n121_tree_32, n122_tree_32, n123_tree_32, n124_tree_32, n125_tree_32, n126_tree_32, n127_tree_32;

	adder_tree_32 U0(
		.a_in(a_in[32:0]),
		.b_in(b_in[32:0]),
		.sum(sum[32]),
		.n127_tree_32(n127_tree_32),
		.n126_tree_32(n126_tree_32),
		.n125_tree_32(n125_tree_32),
		.n124_tree_32(n124_tree_32),
		.n121_tree_32(n121_tree_32),
		.n120_tree_32(n120_tree_32),
		.n117_tree_32(n117_tree_32),
		.n116_tree_32(n116_tree_32),
		.n113_tree_32(n113_tree_32),
		.n112_tree_32(n112_tree_32),
		.n109_tree_32(n109_tree_32),
		.n108_tree_32(n108_tree_32),
		.n105_tree_32(n105_tree_32),
		.n104_tree_32(n104_tree_32),
		.n101_tree_32(n101_tree_32),
		.n100_tree_32(n100_tree_32),
		.n97_tree_32(n97_tree_32),
		.n96_tree_32(n96_tree_32),
		.n93_tree_32(n93_tree_32),
		.n92_tree_32(n92_tree_32),
		.n89_tree_32(n89_tree_32),
		.n88_tree_32(n88_tree_32),
		.n85_tree_32(n85_tree_32),
		.n84_tree_32(n84_tree_32),
		.n81_tree_32(n81_tree_32),
		.n80_tree_32(n80_tree_32),
		.n77_tree_32(n77_tree_32),
		.n76_tree_32(n76_tree_32),
		.n73_tree_32(n73_tree_32),
		.n72_tree_32(n72_tree_32),
		.n69_tree_32(n69_tree_32),
		.n68_tree_32(n68_tree_32),
		.n65_tree_32(n65_tree_32),
		.n64_tree_32(n64_tree_32),
		.n61_tree_32(n61_tree_32),
		.n60_tree_32(n60_tree_32),
		.n57_tree_32(n57_tree_32),
		.n56_tree_32(n56_tree_32),
		.n53_tree_32(n53_tree_32),
		.n52_tree_32(n52_tree_32),
		.n49_tree_32(n49_tree_32),
		.n48_tree_32(n48_tree_32),
		.n45_tree_32(n45_tree_32),
		.n44_tree_32(n44_tree_32),
		.n41_tree_32(n41_tree_32),
		.n40_tree_32(n40_tree_32),
		.n37_tree_32(n37_tree_32),
		.n36_tree_32(n36_tree_32),
		.n33_tree_32(n33_tree_32),
		.n32_tree_32(n32_tree_32),
		.n29_tree_32(n29_tree_32),
		.n28_tree_32(n28_tree_32),
		.n25_tree_32(n25_tree_32),
		.n24_tree_32(n24_tree_32),
		.n21_tree_32(n21_tree_32),
		.n20_tree_32(n20_tree_32),
		.n17_tree_32(n17_tree_32),
		.n16_tree_32(n16_tree_32),
		.n13_tree_32(n13_tree_32),
		.n12_tree_32(n12_tree_32),
		.n9_tree_32(n9_tree_32),
		.n8_tree_32(n8_tree_32),
		.n10_tree_32(n10_tree_32),
		.n11_tree_32(n11_tree_32),
		.n18_tree_32(n18_tree_32),
		.n19_tree_32(n19_tree_32),
		.n26_tree_32(n26_tree_32),
		.n27_tree_32(n27_tree_32),
		.n34_tree_32(n34_tree_32),
		.n35_tree_32(n35_tree_32),
		.n42_tree_32(n42_tree_32),
		.n43_tree_32(n43_tree_32),
		.n50_tree_32(n50_tree_32),
		.n51_tree_32(n51_tree_32),
		.n58_tree_32(n58_tree_32),
		.n59_tree_32(n59_tree_32),
		.n66_tree_32(n66_tree_32),
		.n67_tree_32(n67_tree_32),
		.n74_tree_32(n74_tree_32),
		.n75_tree_32(n75_tree_32),
		.n82_tree_32(n82_tree_32),
		.n83_tree_32(n83_tree_32),
		.n90_tree_32(n90_tree_32),
		.n91_tree_32(n91_tree_32),
		.n98_tree_32(n98_tree_32),
		.n99_tree_32(n99_tree_32),
		.n106_tree_32(n106_tree_32),
		.n107_tree_32(n107_tree_32),
		.n114_tree_32(n114_tree_32),
		.n115_tree_32(n115_tree_32),
		.n122_tree_32(n122_tree_32),
		.n123_tree_32(n123_tree_32)
	);
	adder_tree_31 U1(
		.a_in(a_in[31:0]),
		.b_in(b_in[31:0]),
		.n9_tree_32(n9_tree_32),
		.n8_tree_32(n8_tree_32),
		.n10_tree_32(n10_tree_32),
		.n11_tree_32(n11_tree_32),
		.n18_tree_32(n18_tree_32),
		.n19_tree_32(n19_tree_32),
		.n26_tree_32(n26_tree_32),
		.n27_tree_32(n27_tree_32),
		.n34_tree_32(n34_tree_32),
		.n35_tree_32(n35_tree_32),
		.n42_tree_32(n42_tree_32),
		.n43_tree_32(n43_tree_32),
		.n50_tree_32(n50_tree_32),
		.n51_tree_32(n51_tree_32),
		.n58_tree_32(n58_tree_32),
		.n59_tree_32(n59_tree_32),
		.n66_tree_32(n66_tree_32),
		.n67_tree_32(n67_tree_32),
		.n74_tree_32(n74_tree_32),
		.n75_tree_32(n75_tree_32),
		.n82_tree_32(n82_tree_32),
		.n83_tree_32(n83_tree_32),
		.n90_tree_32(n90_tree_32),
		.n91_tree_32(n91_tree_32),
		.n98_tree_32(n98_tree_32),
		.n99_tree_32(n99_tree_32),
		.n106_tree_32(n106_tree_32),
		.n107_tree_32(n107_tree_32),
		.n114_tree_32(n114_tree_32),
		.n115_tree_32(n115_tree_32),
		.n122_tree_32(n122_tree_32),
		.n123_tree_32(n123_tree_32),
		.sum(sum[31]),
		.n18_tree_31(n18_tree_31),
		.n19_tree_31(n19_tree_31),
		.n34_tree_31(n34_tree_31),
		.n35_tree_31(n35_tree_31),
		.n50_tree_31(n50_tree_31),
		.n51_tree_31(n51_tree_31),
		.n66_tree_31(n66_tree_31),
		.n67_tree_31(n67_tree_31),
		.n82_tree_31(n82_tree_31),
		.n83_tree_31(n83_tree_31),
		.n98_tree_31(n98_tree_31),
		.n99_tree_31(n99_tree_31),
		.n114_tree_31(n114_tree_31),
		.n115_tree_31(n115_tree_31)
	);
	adder_tree_30 U2(
		.a_in(a_in[30:0]),
		.b_in(b_in[30:0]),
		.n10_tree_32(n10_tree_32),
		.n11_tree_32(n11_tree_32),
		.n18_tree_31(n18_tree_31),
		.n19_tree_31(n19_tree_31),
		.n34_tree_31(n34_tree_31),
		.n35_tree_31(n35_tree_31),
		.n50_tree_31(n50_tree_31),
		.n51_tree_31(n51_tree_31),
		.n66_tree_31(n66_tree_31),
		.n67_tree_31(n67_tree_31),
		.n82_tree_31(n82_tree_31),
		.n83_tree_31(n83_tree_31),
		.n98_tree_31(n98_tree_31),
		.n99_tree_31(n99_tree_31),
		.n114_tree_31(n114_tree_31),
		.n115_tree_31(n115_tree_31),
		.sum(sum[30]),
		.n38_tree_30(n38_tree_30),
		.n39_tree_30(n39_tree_30),
		.n70_tree_30(n70_tree_30),
		.n71_tree_30(n71_tree_30),
		.n102_tree_30(n102_tree_30),
		.n103_tree_30(n103_tree_30)
	);
	adder_tree_29 U3(
		.a_in(a_in[29:0]),
		.b_in(b_in[29:0]),
		.n17_tree_32(n17_tree_32),
		.n16_tree_32(n16_tree_32),
		.n18_tree_31(n18_tree_31),
		.n19_tree_31(n19_tree_31),
		.n38_tree_30(n38_tree_30),
		.n39_tree_30(n39_tree_30),
		.n70_tree_30(n70_tree_30),
		.n71_tree_30(n71_tree_30),
		.n102_tree_30(n102_tree_30),
		.n103_tree_30(n103_tree_30),
		.sum(sum[29]),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29)
	);
	adder_tree_28 U4(
		.a_in(a_in[28:0]),
		.b_in(b_in[28:0]),
		.n18_tree_31(n18_tree_31),
		.n19_tree_31(n19_tree_31),
		.n38_tree_30(n38_tree_30),
		.n39_tree_30(n39_tree_30),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[28])
	);
	adder_tree_27 U5(
		.a_in(a_in[27:0]),
		.b_in(b_in[27:0]),
		.n25_tree_32(n25_tree_32),
		.n24_tree_32(n24_tree_32),
		.n26_tree_32(n26_tree_32),
		.n27_tree_32(n27_tree_32),
		.n38_tree_30(n38_tree_30),
		.n39_tree_30(n39_tree_30),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[27])
	);
	adder_tree_26 U6(
		.a_in(a_in[26:0]),
		.b_in(b_in[26:0]),
		.n26_tree_32(n26_tree_32),
		.n27_tree_32(n27_tree_32),
		.n38_tree_30(n38_tree_30),
		.n39_tree_30(n39_tree_30),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[26])
	);
	adder_tree_25 U7(
		.a_in(a_in[25:0]),
		.b_in(b_in[25:0]),
		.n33_tree_32(n33_tree_32),
		.n32_tree_32(n32_tree_32),
		.n38_tree_30(n38_tree_30),
		.n39_tree_30(n39_tree_30),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[25])
	);
	adder_tree_24 U8(
		.a_in(a_in[24:0]),
		.b_in(b_in[24:0]),
		.n38_tree_30(n38_tree_30),
		.n39_tree_30(n39_tree_30),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[24])
	);
	adder_tree_23 U9(
		.a_in(a_in[23:0]),
		.b_in(b_in[23:0]),
		.n41_tree_32(n41_tree_32),
		.n40_tree_32(n40_tree_32),
		.n42_tree_32(n42_tree_32),
		.n43_tree_32(n43_tree_32),
		.n50_tree_31(n50_tree_31),
		.n51_tree_31(n51_tree_31),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[23])
	);
	adder_tree_22 U10(
		.a_in(a_in[22:0]),
		.b_in(b_in[22:0]),
		.n42_tree_32(n42_tree_32),
		.n43_tree_32(n43_tree_32),
		.n50_tree_31(n50_tree_31),
		.n51_tree_31(n51_tree_31),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[22])
	);
	adder_tree_21 U11(
		.a_in(a_in[21:0]),
		.b_in(b_in[21:0]),
		.n49_tree_32(n49_tree_32),
		.n48_tree_32(n48_tree_32),
		.n50_tree_31(n50_tree_31),
		.n51_tree_31(n51_tree_31),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[21])
	);
	adder_tree_20 U12(
		.a_in(a_in[20:0]),
		.b_in(b_in[20:0]),
		.n50_tree_31(n50_tree_31),
		.n51_tree_31(n51_tree_31),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[20])
	);
	adder_tree_19 U13(
		.a_in(a_in[19:0]),
		.b_in(b_in[19:0]),
		.n57_tree_32(n57_tree_32),
		.n56_tree_32(n56_tree_32),
		.n58_tree_32(n58_tree_32),
		.n59_tree_32(n59_tree_32),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[19])
	);
	adder_tree_18 U14(
		.a_in(a_in[18:0]),
		.b_in(b_in[18:0]),
		.n58_tree_32(n58_tree_32),
		.n59_tree_32(n59_tree_32),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[18])
	);
	adder_tree_17 U15(
		.a_in(a_in[17:0]),
		.b_in(b_in[17:0]),
		.n65_tree_32(n65_tree_32),
		.n64_tree_32(n64_tree_32),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[17])
	);
	adder_tree_16 U16(
		.a_in(a_in[16:0]),
		.b_in(b_in[16:0]),
		.n82_tree_29(n82_tree_29),
		.n83_tree_29(n83_tree_29),
		.sum(sum[16])
	);
	adder_tree_15 U17(
		.a_in(a_in[15:0]),
		.b_in(b_in[15:0]),
		.n73_tree_32(n73_tree_32),
		.n72_tree_32(n72_tree_32),
		.n74_tree_32(n74_tree_32),
		.n75_tree_32(n75_tree_32),
		.n82_tree_31(n82_tree_31),
		.n83_tree_31(n83_tree_31),
		.n102_tree_30(n102_tree_30),
		.n103_tree_30(n103_tree_30),
		.sum(sum[15])
	);
	adder_tree_14 U18(
		.a_in(a_in[14:0]),
		.b_in(b_in[14:0]),
		.n74_tree_32(n74_tree_32),
		.n75_tree_32(n75_tree_32),
		.n82_tree_31(n82_tree_31),
		.n83_tree_31(n83_tree_31),
		.n102_tree_30(n102_tree_30),
		.n103_tree_30(n103_tree_30),
		.sum(sum[14])
	);
	adder_tree_13 U19(
		.a_in(a_in[13:0]),
		.b_in(b_in[13:0]),
		.n81_tree_32(n81_tree_32),
		.n80_tree_32(n80_tree_32),
		.n82_tree_31(n82_tree_31),
		.n83_tree_31(n83_tree_31),
		.n102_tree_30(n102_tree_30),
		.n103_tree_30(n103_tree_30),
		.sum(sum[13])
	);
	adder_tree_12 U20(
		.a_in(a_in[12:0]),
		.b_in(b_in[12:0]),
		.n82_tree_31(n82_tree_31),
		.n83_tree_31(n83_tree_31),
		.n102_tree_30(n102_tree_30),
		.n103_tree_30(n103_tree_30),
		.sum(sum[12])
	);
	adder_tree_11 U21(
		.a_in(a_in[11:0]),
		.b_in(b_in[11:0]),
		.n89_tree_32(n89_tree_32),
		.n88_tree_32(n88_tree_32),
		.n90_tree_32(n90_tree_32),
		.n91_tree_32(n91_tree_32),
		.n102_tree_30(n102_tree_30),
		.n103_tree_30(n103_tree_30),
		.sum(sum[11])
	);
	adder_tree_10 U22(
		.a_in(a_in[10:0]),
		.b_in(b_in[10:0]),
		.n90_tree_32(n90_tree_32),
		.n91_tree_32(n91_tree_32),
		.n102_tree_30(n102_tree_30),
		.n103_tree_30(n103_tree_30),
		.sum(sum[10])
	);
	adder_tree_9 U23(
		.a_in(a_in[9:0]),
		.b_in(b_in[9:0]),
		.n97_tree_32(n97_tree_32),
		.n96_tree_32(n96_tree_32),
		.n102_tree_30(n102_tree_30),
		.n103_tree_30(n103_tree_30),
		.sum(sum[9])
	);
	adder_tree_8 U24(
		.a_in(a_in[8:0]),
		.b_in(b_in[8:0]),
		.n102_tree_30(n102_tree_30),
		.n103_tree_30(n103_tree_30),
		.sum(sum[8])
	);
	adder_tree_7 U25(
		.a_in(a_in[7:0]),
		.b_in(b_in[7:0]),
		.n105_tree_32(n105_tree_32),
		.n104_tree_32(n104_tree_32),
		.n106_tree_32(n106_tree_32),
		.n107_tree_32(n107_tree_32),
		.n114_tree_31(n114_tree_31),
		.n115_tree_31(n115_tree_31),
		.sum(sum[7])
	);
	adder_tree_6 U26(
		.a_in(a_in[6:0]),
		.b_in(b_in[6:0]),
		.n106_tree_32(n106_tree_32),
		.n107_tree_32(n107_tree_32),
		.n114_tree_31(n114_tree_31),
		.n115_tree_31(n115_tree_31),
		.sum(sum[6])
	);
	adder_tree_5 U27(
		.a_in(a_in[5:0]),
		.b_in(b_in[5:0]),
		.n113_tree_32(n113_tree_32),
		.n112_tree_32(n112_tree_32),
		.n114_tree_31(n114_tree_31),
		.n115_tree_31(n115_tree_31),
		.sum(sum[5])
	);
	adder_tree_4 U28(
		.a_in(a_in[4:0]),
		.b_in(b_in[4:0]),
		.n114_tree_31(n114_tree_31),
		.n115_tree_31(n115_tree_31),
		.sum(sum[4])
	);
	adder_tree_3 U29(
		.a_in(a_in[3:0]),
		.b_in(b_in[3:0]),
		.n121_tree_32(n121_tree_32),
		.n120_tree_32(n120_tree_32),
		.n122_tree_32(n122_tree_32),
		.n123_tree_32(n123_tree_32),
		.sum(sum[3])
	);
	adder_tree_2 U30(
		.a_in(a_in[2:0]),
		.b_in(b_in[2:0]),
		.n122_tree_32(n122_tree_32),
		.n123_tree_32(n123_tree_32),
		.sum(sum[2])
	);
	adder_tree_1 U31(
		.a_in(a_in[1:0]),
		.b_in(b_in[1:0]),
		.n127_tree_32(n127_tree_32),
		.n126_tree_32(n126_tree_32),
		.sum(sum[1])
	);
	adder_tree_0 U32(
		.a_in(a_in[0]),
		.b_in(b_in[0]),
		.sum(sum[0])
	);
endmodule // adder
module adder_tree_0(
	input   a_in,
	input   b_in,
	output  sum
);
// adder_forest tree_0
	wire n1_tree_0;
	assign sum = n1_tree_0;
    sky130_fd_sc_hd__xor2_1 U193(.X(n1_tree_0), .A(a_in), .B(b_in));
endmodule // adder_tree_0
module adder_tree_1(
	input  [1:0] a_in,
	input  [1:0] b_in,
	input   n127_tree_32,
	input   n126_tree_32,
	output  sum
);
// adder_forest tree_1
	wire n1_tree_1, n2_tree_1;
    sky130_fd_sc_hd__mux2_1 U202(.X(sum), .S(n126_tree_32), .A0(n1_tree_1), .A1(n2_tree_1));
    sky130_fd_sc_hd__xor2_1 U210(.X(n1_tree_1), .A(a_in[1]), .B(b_in[1]));
    sky130_fd_sc_hd__xnor2_1 U211(.Y(n2_tree_1), .A(a_in[1]), .B(b_in[1]));
endmodule // adder_tree_1
module adder_tree_2(
	input  [2:0] a_in,
	input  [2:0] b_in,
	input   n122_tree_32,
	input   n123_tree_32,
	output  sum
);
// adder_forest tree_2
	wire n1_tree_2, n2_tree_2;
    sky130_fd_sc_hd__mux2_1 U224(.X(sum), .S(n122_tree_32), .A0(n1_tree_2), .A1(n2_tree_2));
    sky130_fd_sc_hd__xor2_1 U245(.X(n1_tree_2), .A(a_in[2]), .B(b_in[2]));
    sky130_fd_sc_hd__xnor2_1 U246(.Y(n2_tree_2), .A(a_in[2]), .B(b_in[2]));
endmodule // adder_tree_2
module adder_tree_3(
	input  [3:0] a_in,
	input  [3:0] b_in,
	input   n121_tree_32,
	input   n120_tree_32,
	input   n122_tree_32,
	input   n123_tree_32,
	output  sum
);
// adder_forest tree_3
	wire n0, n1_tree_3, n2_tree_3, n3_tree_3;
    sky130_fd_sc_hd__mux2_1 U262(.X(sum), .S(n3_tree_3), .A0(n1_tree_3), .A1(n2_tree_3));
    sky130_fd_sc_hd__xor2_1 U276(.X(n1_tree_3), .A(a_in[3]), .B(b_in[3]));
    sky130_fd_sc_hd__xnor2_1 U277(.Y(n2_tree_3), .A(a_in[3]), .B(b_in[3]));
    sky130_fd_sc_hd__and2_1 U285(.X(n0), .A(n121_tree_32), .B(n123_tree_32));
    sky130_fd_sc_hd__a21o_1 U286(.X(n3_tree_3), .A1(n122_tree_32), .A2(n121_tree_32), .B1(n120_tree_32));
endmodule // adder_tree_3
module adder_tree_4(
	input  [4:0] a_in,
	input  [4:0] b_in,
	input   n114_tree_31,
	input   n115_tree_31,
	output  sum
);
// adder_forest tree_4
	wire n1_tree_4, n2_tree_4;
    sky130_fd_sc_hd__mux2_1 U301(.X(sum), .S(n114_tree_31), .A0(n1_tree_4), .A1(n2_tree_4));
    sky130_fd_sc_hd__xor2_1 U322(.X(n1_tree_4), .A(a_in[4]), .B(b_in[4]));
    sky130_fd_sc_hd__xnor2_1 U323(.Y(n2_tree_4), .A(a_in[4]), .B(b_in[4]));
endmodule // adder_tree_4
module adder_tree_5(
	input  [5:0] a_in,
	input  [5:0] b_in,
	input   n113_tree_32,
	input   n112_tree_32,
	input   n114_tree_31,
	input   n115_tree_31,
	output  sum
);
// adder_forest tree_5
	wire n0, n1_tree_5, n2_tree_5, n3_tree_5;
    sky130_fd_sc_hd__mux2_1 U1(.X(sum), .S(n3_tree_5), .A0(n1_tree_5), .A1(n2_tree_5));
    sky130_fd_sc_hd__xor2_1 U34(.X(n1_tree_5), .A(a_in[5]), .B(b_in[5]));
    sky130_fd_sc_hd__xnor2_1 U35(.Y(n2_tree_5), .A(a_in[5]), .B(b_in[5]));
    sky130_fd_sc_hd__and2_1 U40(.X(n0), .A(n113_tree_32), .B(n115_tree_31));
    sky130_fd_sc_hd__a21o_1 U41(.X(n3_tree_5), .A1(n114_tree_31), .A2(n113_tree_32), .B1(n112_tree_32));
endmodule // adder_tree_5
module adder_tree_6(
	input  [6:0] a_in,
	input  [6:0] b_in,
	input   n106_tree_32,
	input   n107_tree_32,
	input   n114_tree_31,
	input   n115_tree_31,
	output  sum
);
// adder_forest tree_6
	wire n1_tree_6, n2_tree_6, n6_tree_6, n7_tree_6;
    sky130_fd_sc_hd__mux2_1 U73(.X(sum), .S(n6_tree_6), .A0(n1_tree_6), .A1(n2_tree_6));
    sky130_fd_sc_hd__xor2_1 U118(.X(n1_tree_6), .A(a_in[6]), .B(b_in[6]));
    sky130_fd_sc_hd__xnor2_1 U119(.Y(n2_tree_6), .A(a_in[6]), .B(b_in[6]));
    sky130_fd_sc_hd__and2_1 U128(.X(n7_tree_6), .A(n107_tree_32), .B(n115_tree_31));
    sky130_fd_sc_hd__a21o_1 U129(.X(n6_tree_6), .A1(n114_tree_31), .A2(n107_tree_32), .B1(n106_tree_32));
endmodule // adder_tree_6
module adder_tree_7(
	input  [7:0] a_in,
	input  [7:0] b_in,
	input   n105_tree_32,
	input   n104_tree_32,
	input   n106_tree_32,
	input   n107_tree_32,
	input   n114_tree_31,
	input   n115_tree_31,
	output  sum
);
// adder_forest tree_7
	wire n1_tree_7, n2_tree_7, n3_tree_7, n10_tree_7, n11_tree_7, n28_tree_7;
    sky130_fd_sc_hd__mux2_1 U166(.X(sum), .S(n10_tree_7), .A0(n1_tree_7), .A1(n2_tree_7));
    sky130_fd_sc_hd__xor2_1 U220(.X(n1_tree_7), .A(a_in[7]), .B(b_in[7]));
    sky130_fd_sc_hd__xnor2_1 U221(.Y(n2_tree_7), .A(a_in[7]), .B(b_in[7]));
    sky130_fd_sc_hd__and2_1 U225(.X(n28_tree_7), .A(n105_tree_32), .B(n107_tree_32));
    sky130_fd_sc_hd__a21o_1 U226(.X(n3_tree_7), .A1(n106_tree_32), .A2(n105_tree_32), .B1(n104_tree_32));
    sky130_fd_sc_hd__and2_1 U241(.X(n11_tree_7), .A(n28_tree_7), .B(n115_tree_31));
    sky130_fd_sc_hd__a21o_1 U242(.X(n10_tree_7), .A1(n114_tree_31), .A2(n28_tree_7), .B1(n3_tree_7));
endmodule // adder_tree_7
module adder_tree_8(
	input  [8:0] a_in,
	input  [8:0] b_in,
	input   n102_tree_30,
	input   n103_tree_30,
	output  sum
);
// adder_forest tree_8
	wire n1_tree_8, n2_tree_8;
    sky130_fd_sc_hd__mux2_1 U267(.X(sum), .S(n102_tree_30), .A0(n1_tree_8), .A1(n2_tree_8));
    sky130_fd_sc_hd__xor2_1 U314(.X(n1_tree_8), .A(a_in[8]), .B(b_in[8]));
    sky130_fd_sc_hd__xnor2_1 U315(.Y(n2_tree_8), .A(a_in[8]), .B(b_in[8]));
endmodule // adder_tree_8
module adder_tree_9(
	input  [9:0] a_in,
	input  [9:0] b_in,
	input   n97_tree_32,
	input   n96_tree_32,
	input   n102_tree_30,
	input   n103_tree_30,
	output  sum
);
// adder_forest tree_9
	wire n0, n1_tree_9, n2_tree_9, n3_tree_9;
    sky130_fd_sc_hd__mux2_1 U14(.X(sum), .S(n3_tree_9), .A0(n1_tree_9), .A1(n2_tree_9));
    sky130_fd_sc_hd__xor2_1 U81(.X(n1_tree_9), .A(a_in[9]), .B(b_in[9]));
    sky130_fd_sc_hd__xnor2_1 U82(.Y(n2_tree_9), .A(a_in[9]), .B(b_in[9]));
    sky130_fd_sc_hd__and2_1 U85(.X(n0), .A(n97_tree_32), .B(n103_tree_30));
    sky130_fd_sc_hd__a21o_1 U86(.X(n3_tree_9), .A1(n102_tree_30), .A2(n97_tree_32), .B1(n96_tree_32));
endmodule // adder_tree_9
module adder_tree_10(
	input  [10:0] a_in,
	input  [10:0] b_in,
	input   n90_tree_32,
	input   n91_tree_32,
	input   n102_tree_30,
	input   n103_tree_30,
	output  sum
);
// adder_forest tree_10
	wire n1_tree_10, n2_tree_10, n6_tree_10, n7_tree_10;
    sky130_fd_sc_hd__mux2_1 U136(.X(sum), .S(n6_tree_10), .A0(n1_tree_10), .A1(n2_tree_10));
    sky130_fd_sc_hd__xor2_1 U214(.X(n1_tree_10), .A(a_in[10]), .B(b_in[10]));
    sky130_fd_sc_hd__xnor2_1 U215(.Y(n2_tree_10), .A(a_in[10]), .B(b_in[10]));
    sky130_fd_sc_hd__and2_1 U231(.X(n7_tree_10), .A(n91_tree_32), .B(n103_tree_30));
    sky130_fd_sc_hd__a21o_1 U232(.X(n6_tree_10), .A1(n102_tree_30), .A2(n91_tree_32), .B1(n90_tree_32));
endmodule // adder_tree_10
module adder_tree_11(
	input  [11:0] a_in,
	input  [11:0] b_in,
	input   n89_tree_32,
	input   n88_tree_32,
	input   n90_tree_32,
	input   n91_tree_32,
	input   n102_tree_30,
	input   n103_tree_30,
	output  sum
);
// adder_forest tree_11
	wire n1_tree_11, n2_tree_11, n3_tree_11, n10_tree_11, n11_tree_11, n44_tree_11;
    sky130_fd_sc_hd__mux2_1 U284(.X(sum), .S(n10_tree_11), .A0(n1_tree_11), .A1(n2_tree_11));
    sky130_fd_sc_hd__xor2_1 U344(.X(n1_tree_11), .A(a_in[11]), .B(b_in[11]));
    sky130_fd_sc_hd__xnor2_1 U345(.Y(n2_tree_11), .A(a_in[11]), .B(b_in[11]));
    sky130_fd_sc_hd__and2_1 U352(.X(n44_tree_11), .A(n89_tree_32), .B(n91_tree_32));
    sky130_fd_sc_hd__a21o_1 U353(.X(n3_tree_11), .A1(n90_tree_32), .A2(n89_tree_32), .B1(n88_tree_32));
    sky130_fd_sc_hd__and2_1 U8(.X(n11_tree_11), .A(n44_tree_11), .B(n103_tree_30));
    sky130_fd_sc_hd__a21o_1 U9(.X(n10_tree_11), .A1(n102_tree_30), .A2(n44_tree_11), .B1(n3_tree_11));
endmodule // adder_tree_11
module adder_tree_12(
	input  [12:0] a_in,
	input  [12:0] b_in,
	input   n82_tree_31,
	input   n83_tree_31,
	input   n102_tree_30,
	input   n103_tree_30,
	output  sum
);
// adder_forest tree_12
	wire n1_tree_12, n2_tree_12, n14_tree_12, n15_tree_12;
    sky130_fd_sc_hd__mux2_1 U66(.X(sum), .S(n14_tree_12), .A0(n1_tree_12), .A1(n2_tree_12));
    sky130_fd_sc_hd__xor2_1 U145(.X(n1_tree_12), .A(a_in[12]), .B(b_in[12]));
    sky130_fd_sc_hd__xnor2_1 U146(.Y(n2_tree_12), .A(a_in[12]), .B(b_in[12]));
    sky130_fd_sc_hd__and2_1 U176(.X(n15_tree_12), .A(n83_tree_31), .B(n103_tree_30));
    sky130_fd_sc_hd__a21o_1 U177(.X(n14_tree_12), .A1(n102_tree_30), .A2(n83_tree_31), .B1(n82_tree_31));
endmodule // adder_tree_12
module adder_tree_13(
	input  [13:0] a_in,
	input  [13:0] b_in,
	input   n81_tree_32,
	input   n80_tree_32,
	input   n82_tree_31,
	input   n83_tree_31,
	input   n102_tree_30,
	input   n103_tree_30,
	output  sum
);
// adder_forest tree_13
	wire n1_tree_13, n2_tree_13, n3_tree_13, n18_tree_13, n19_tree_13, n52_tree_13;
    sky130_fd_sc_hd__mux2_1 U240(.X(sum), .S(n18_tree_13), .A0(n1_tree_13), .A1(n2_tree_13));
    sky130_fd_sc_hd__xor2_1 U312(.X(n1_tree_13), .A(a_in[13]), .B(b_in[13]));
    sky130_fd_sc_hd__xnor2_1 U313(.Y(n2_tree_13), .A(a_in[13]), .B(b_in[13]));
    sky130_fd_sc_hd__and2_1 U318(.X(n52_tree_13), .A(n81_tree_32), .B(n83_tree_31));
    sky130_fd_sc_hd__a21o_1 U319(.X(n3_tree_13), .A1(n82_tree_31), .A2(n81_tree_32), .B1(n80_tree_32));
    sky130_fd_sc_hd__and2_1 U340(.X(n19_tree_13), .A(n52_tree_13), .B(n103_tree_30));
    sky130_fd_sc_hd__a21o_1 U341(.X(n18_tree_13), .A1(n102_tree_30), .A2(n52_tree_13), .B1(n3_tree_13));
endmodule // adder_tree_13
module adder_tree_14(
	input  [14:0] a_in,
	input  [14:0] b_in,
	input   n74_tree_32,
	input   n75_tree_32,
	input   n82_tree_31,
	input   n83_tree_31,
	input   n102_tree_30,
	input   n103_tree_30,
	output  sum
);
// adder_forest tree_14
	wire n1_tree_14, n2_tree_14, n6_tree_14, n7_tree_14, n22_tree_14, n23_tree_14;
    sky130_fd_sc_hd__mux2_1 U45(.X(sum), .S(n22_tree_14), .A0(n1_tree_14), .A1(n2_tree_14));
    sky130_fd_sc_hd__xor2_1 U141(.X(n1_tree_14), .A(a_in[14]), .B(b_in[14]));
    sky130_fd_sc_hd__xnor2_1 U142(.Y(n2_tree_14), .A(a_in[14]), .B(b_in[14]));
    sky130_fd_sc_hd__and2_1 U157(.X(n7_tree_14), .A(n75_tree_32), .B(n83_tree_31));
    sky130_fd_sc_hd__a21o_1 U158(.X(n6_tree_14), .A1(n82_tree_31), .A2(n75_tree_32), .B1(n74_tree_32));
    sky130_fd_sc_hd__and2_1 U182(.X(n23_tree_14), .A(n7_tree_14), .B(n103_tree_30));
    sky130_fd_sc_hd__a21o_1 U183(.X(n22_tree_14), .A1(n102_tree_30), .A2(n7_tree_14), .B1(n6_tree_14));
endmodule // adder_tree_14
module adder_tree_15(
	input  [15:0] a_in,
	input  [15:0] b_in,
	input   n73_tree_32,
	input   n72_tree_32,
	input   n74_tree_32,
	input   n75_tree_32,
	input   n82_tree_31,
	input   n83_tree_31,
	input   n102_tree_30,
	input   n103_tree_30,
	output  sum
);
// adder_forest tree_15
	wire n1_tree_15, n2_tree_15, n3_tree_15, n10_tree_15, n11_tree_15, n26_tree_15, n27_tree_15, n60_tree_15;
    sky130_fd_sc_hd__mux2_1 U249(.X(sum), .S(n26_tree_15), .A0(n1_tree_15), .A1(n2_tree_15));
    sky130_fd_sc_hd__xor2_1 U328(.X(n1_tree_15), .A(a_in[15]), .B(b_in[15]));
    sky130_fd_sc_hd__xnor2_1 U329(.Y(n2_tree_15), .A(a_in[15]), .B(b_in[15]));
    sky130_fd_sc_hd__and2_1 U338(.X(n60_tree_15), .A(n73_tree_32), .B(n75_tree_32));
    sky130_fd_sc_hd__a21o_1 U339(.X(n3_tree_15), .A1(n74_tree_32), .A2(n73_tree_32), .B1(n72_tree_32));
    sky130_fd_sc_hd__and2_1 U348(.X(n11_tree_15), .A(n60_tree_15), .B(n83_tree_31));
    sky130_fd_sc_hd__a21o_1 U349(.X(n10_tree_15), .A1(n82_tree_31), .A2(n60_tree_15), .B1(n3_tree_15));
    sky130_fd_sc_hd__and2_1 U19(.X(n27_tree_15), .A(n11_tree_15), .B(n103_tree_30));
    sky130_fd_sc_hd__a21o_1 U20(.X(n26_tree_15), .A1(n102_tree_30), .A2(n11_tree_15), .B1(n10_tree_15));
endmodule // adder_tree_15
module adder_tree_16(
	input  [16:0] a_in,
	input  [16:0] b_in,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_16
	wire n1_tree_16, n2_tree_16;
    sky130_fd_sc_hd__mux2_1 U78(.X(sum), .S(n82_tree_29), .A0(n1_tree_16), .A1(n2_tree_16));
    sky130_fd_sc_hd__xor2_1 U190(.X(n1_tree_16), .A(a_in[16]), .B(b_in[16]));
    sky130_fd_sc_hd__xnor2_1 U191(.Y(n2_tree_16), .A(a_in[16]), .B(b_in[16]));
endmodule // adder_tree_16
module adder_tree_17(
	input  [17:0] a_in,
	input  [17:0] b_in,
	input   n65_tree_32,
	input   n64_tree_32,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_17
	wire n0, n1_tree_17, n2_tree_17, n3_tree_17;
    sky130_fd_sc_hd__mux2_1 U296(.X(sum), .S(n3_tree_17), .A0(n1_tree_17), .A1(n2_tree_17));
    sky130_fd_sc_hd__xor2_1 U43(.X(n1_tree_17), .A(a_in[17]), .B(b_in[17]));
    sky130_fd_sc_hd__xnor2_1 U44(.Y(n2_tree_17), .A(a_in[17]), .B(b_in[17]));
    sky130_fd_sc_hd__and2_1 U50(.X(n0), .A(n65_tree_32), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U51(.X(n3_tree_17), .A1(n82_tree_29), .A2(n65_tree_32), .B1(n64_tree_32));
endmodule // adder_tree_17
module adder_tree_18(
	input  [18:0] a_in,
	input  [18:0] b_in,
	input   n58_tree_32,
	input   n59_tree_32,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_18
	wire n1_tree_18, n2_tree_18, n6_tree_18, n7_tree_18;
    sky130_fd_sc_hd__mux2_1 U161(.X(sum), .S(n6_tree_18), .A0(n1_tree_18), .A1(n2_tree_18));
    sky130_fd_sc_hd__xor2_1 U282(.X(n1_tree_18), .A(a_in[18]), .B(b_in[18]));
    sky130_fd_sc_hd__xnor2_1 U283(.Y(n2_tree_18), .A(a_in[18]), .B(b_in[18]));
    sky130_fd_sc_hd__and2_1 U294(.X(n7_tree_18), .A(n59_tree_32), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U295(.X(n6_tree_18), .A1(n82_tree_29), .A2(n59_tree_32), .B1(n58_tree_32));
endmodule // adder_tree_18
module adder_tree_19(
	input  [19:0] a_in,
	input  [19:0] b_in,
	input   n57_tree_32,
	input   n56_tree_32,
	input   n58_tree_32,
	input   n59_tree_32,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_19
	wire n1_tree_19, n2_tree_19, n3_tree_19, n10_tree_19, n11_tree_19, n76_tree_19;
    sky130_fd_sc_hd__mux2_1 U33(.X(sum), .S(n10_tree_19), .A0(n1_tree_19), .A1(n2_tree_19));
    sky130_fd_sc_hd__xor2_1 U164(.X(n1_tree_19), .A(a_in[19]), .B(b_in[19]));
    sky130_fd_sc_hd__xnor2_1 U165(.Y(n2_tree_19), .A(a_in[19]), .B(b_in[19]));
    sky130_fd_sc_hd__and2_1 U169(.X(n76_tree_19), .A(n57_tree_32), .B(n59_tree_32));
    sky130_fd_sc_hd__a21o_1 U170(.X(n3_tree_19), .A1(n58_tree_32), .A2(n57_tree_32), .B1(n56_tree_32));
    sky130_fd_sc_hd__and2_1 U184(.X(n11_tree_19), .A(n76_tree_19), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U185(.X(n10_tree_19), .A1(n82_tree_29), .A2(n76_tree_19), .B1(n3_tree_19));
endmodule // adder_tree_19
module adder_tree_20(
	input  [20:0] a_in,
	input  [20:0] b_in,
	input   n50_tree_31,
	input   n51_tree_31,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_20
	wire n1_tree_20, n2_tree_20, n14_tree_20, n15_tree_20;
    sky130_fd_sc_hd__mux2_1 U289(.X(sum), .S(n14_tree_20), .A0(n1_tree_20), .A1(n2_tree_20));
    sky130_fd_sc_hd__xor2_1 U60(.X(n1_tree_20), .A(a_in[20]), .B(b_in[20]));
    sky130_fd_sc_hd__xnor2_1 U61(.Y(n2_tree_20), .A(a_in[20]), .B(b_in[20]));
    sky130_fd_sc_hd__and2_1 U91(.X(n15_tree_20), .A(n51_tree_31), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U92(.X(n14_tree_20), .A1(n82_tree_29), .A2(n51_tree_31), .B1(n50_tree_31));
endmodule // adder_tree_20
module adder_tree_21(
	input  [21:0] a_in,
	input  [21:0] b_in,
	input   n49_tree_32,
	input   n48_tree_32,
	input   n50_tree_31,
	input   n51_tree_31,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_21
	wire n1_tree_21, n2_tree_21, n3_tree_21, n18_tree_21, n19_tree_21, n84_tree_21;
    sky130_fd_sc_hd__mux2_1 U203(.X(sum), .S(n18_tree_21), .A0(n1_tree_21), .A1(n2_tree_21));
    sky130_fd_sc_hd__xor2_1 U324(.X(n1_tree_21), .A(a_in[21]), .B(b_in[21]));
    sky130_fd_sc_hd__xnor2_1 U325(.Y(n2_tree_21), .A(a_in[21]), .B(b_in[21]));
    sky130_fd_sc_hd__and2_1 U334(.X(n84_tree_21), .A(n49_tree_32), .B(n51_tree_31));
    sky130_fd_sc_hd__a21o_1 U335(.X(n3_tree_21), .A1(n50_tree_31), .A2(n49_tree_32), .B1(n48_tree_32));
    sky130_fd_sc_hd__and2_1 U6(.X(n19_tree_21), .A(n84_tree_21), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U7(.X(n18_tree_21), .A1(n82_tree_29), .A2(n84_tree_21), .B1(n3_tree_21));
endmodule // adder_tree_21
module adder_tree_22(
	input  [22:0] a_in,
	input  [22:0] b_in,
	input   n42_tree_32,
	input   n43_tree_32,
	input   n50_tree_31,
	input   n51_tree_31,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_22
	wire n1_tree_22, n2_tree_22, n6_tree_22, n7_tree_22, n22_tree_22, n23_tree_22;
    sky130_fd_sc_hd__mux2_1 U112(.X(sum), .S(n22_tree_22), .A0(n1_tree_22), .A1(n2_tree_22));
    sky130_fd_sc_hd__xor2_1 U263(.X(n1_tree_22), .A(a_in[22]), .B(b_in[22]));
    sky130_fd_sc_hd__xnor2_1 U264(.Y(n2_tree_22), .A(a_in[22]), .B(b_in[22]));
    sky130_fd_sc_hd__and2_1 U274(.X(n7_tree_22), .A(n43_tree_32), .B(n51_tree_31));
    sky130_fd_sc_hd__a21o_1 U275(.X(n6_tree_22), .A1(n50_tree_31), .A2(n43_tree_32), .B1(n42_tree_32));
    sky130_fd_sc_hd__and2_1 U299(.X(n23_tree_22), .A(n7_tree_22), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U300(.X(n22_tree_22), .A1(n82_tree_29), .A2(n7_tree_22), .B1(n6_tree_22));
endmodule // adder_tree_22
module adder_tree_23(
	input  [23:0] a_in,
	input  [23:0] b_in,
	input   n41_tree_32,
	input   n40_tree_32,
	input   n42_tree_32,
	input   n43_tree_32,
	input   n50_tree_31,
	input   n51_tree_31,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_23
	wire n1_tree_23, n2_tree_23, n3_tree_23, n10_tree_23, n11_tree_23, n26_tree_23, n27_tree_23, n92_tree_23;
    sky130_fd_sc_hd__mux2_1 U42(.X(sum), .S(n26_tree_23), .A0(n1_tree_23), .A1(n2_tree_23));
    sky130_fd_sc_hd__xor2_1 U200(.X(n1_tree_23), .A(a_in[23]), .B(b_in[23]));
    sky130_fd_sc_hd__xnor2_1 U201(.Y(n2_tree_23), .A(a_in[23]), .B(b_in[23]));
    sky130_fd_sc_hd__and2_1 U208(.X(n92_tree_23), .A(n41_tree_32), .B(n43_tree_32));
    sky130_fd_sc_hd__a21o_1 U209(.X(n3_tree_23), .A1(n42_tree_32), .A2(n41_tree_32), .B1(n40_tree_32));
    sky130_fd_sc_hd__and2_1 U229(.X(n11_tree_23), .A(n92_tree_23), .B(n51_tree_31));
    sky130_fd_sc_hd__a21o_1 U230(.X(n10_tree_23), .A1(n50_tree_31), .A2(n92_tree_23), .B1(n3_tree_23));
    sky130_fd_sc_hd__and2_1 U256(.X(n27_tree_23), .A(n11_tree_23), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U257(.X(n26_tree_23), .A1(n82_tree_29), .A2(n11_tree_23), .B1(n10_tree_23));
endmodule // adder_tree_23
module adder_tree_24(
	input  [24:0] a_in,
	input  [24:0] b_in,
	input   n38_tree_30,
	input   n39_tree_30,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_24
	wire n1_tree_24, n2_tree_24, n30_tree_24, n31_tree_24;
    sky130_fd_sc_hd__mux2_1 U235(.X(sum), .S(n30_tree_24), .A0(n1_tree_24), .A1(n2_tree_24));
    sky130_fd_sc_hd__xor2_1 U137(.X(n1_tree_24), .A(a_in[24]), .B(b_in[24]));
    sky130_fd_sc_hd__xnor2_1 U138(.Y(n2_tree_24), .A(a_in[24]), .B(b_in[24]));
    sky130_fd_sc_hd__and2_1 U206(.X(n31_tree_24), .A(n39_tree_30), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U207(.X(n30_tree_24), .A1(n82_tree_29), .A2(n39_tree_30), .B1(n38_tree_30));
endmodule // adder_tree_24
module adder_tree_25(
	input  [25:0] a_in,
	input  [25:0] b_in,
	input   n33_tree_32,
	input   n32_tree_32,
	input   n38_tree_30,
	input   n39_tree_30,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_25
	wire n1_tree_25, n2_tree_25, n3_tree_25, n34_tree_25, n35_tree_25, n100_tree_25;
    sky130_fd_sc_hd__mux2_1 U175(.X(sum), .S(n34_tree_25), .A0(n1_tree_25), .A1(n2_tree_25));
    sky130_fd_sc_hd__xor2_1 U107(.X(n1_tree_25), .A(a_in[25]), .B(b_in[25]));
    sky130_fd_sc_hd__xnor2_1 U108(.Y(n2_tree_25), .A(a_in[25]), .B(b_in[25]));
    sky130_fd_sc_hd__and2_1 U116(.X(n100_tree_25), .A(n33_tree_32), .B(n39_tree_30));
    sky130_fd_sc_hd__a21o_1 U117(.X(n3_tree_25), .A1(n38_tree_30), .A2(n33_tree_32), .B1(n32_tree_32));
    sky130_fd_sc_hd__and2_1 U178(.X(n35_tree_25), .A(n100_tree_25), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U179(.X(n34_tree_25), .A1(n82_tree_29), .A2(n100_tree_25), .B1(n3_tree_25));
endmodule // adder_tree_25
module adder_tree_26(
	input  [26:0] a_in,
	input  [26:0] b_in,
	input   n26_tree_32,
	input   n27_tree_32,
	input   n38_tree_30,
	input   n39_tree_30,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_26
	wire n1_tree_26, n2_tree_26, n6_tree_26, n7_tree_26, n38_tree_26, n39_tree_26;
    sky130_fd_sc_hd__mux2_1 U133(.X(sum), .S(n38_tree_26), .A0(n1_tree_26), .A1(n2_tree_26));
    sky130_fd_sc_hd__xor2_1 U76(.X(n1_tree_26), .A(a_in[26]), .B(b_in[26]));
    sky130_fd_sc_hd__xnor2_1 U77(.Y(n2_tree_26), .A(a_in[26]), .B(b_in[26]));
    sky130_fd_sc_hd__and2_1 U98(.X(n7_tree_26), .A(n27_tree_32), .B(n39_tree_30));
    sky130_fd_sc_hd__a21o_1 U99(.X(n6_tree_26), .A1(n38_tree_30), .A2(n27_tree_32), .B1(n26_tree_32));
    sky130_fd_sc_hd__and2_1 U155(.X(n39_tree_26), .A(n7_tree_26), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U156(.X(n38_tree_26), .A1(n82_tree_29), .A2(n7_tree_26), .B1(n6_tree_26));
endmodule // adder_tree_26
module adder_tree_27(
	input  [27:0] a_in,
	input  [27:0] b_in,
	input   n25_tree_32,
	input   n24_tree_32,
	input   n26_tree_32,
	input   n27_tree_32,
	input   n38_tree_30,
	input   n39_tree_30,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_27
	wire n1_tree_27, n2_tree_27, n3_tree_27, n10_tree_27, n11_tree_27, n42_tree_27, n43_tree_27, n108_tree_27;
    sky130_fd_sc_hd__mux2_1 U111(.X(sum), .S(n42_tree_27), .A0(n1_tree_27), .A1(n2_tree_27));
    sky130_fd_sc_hd__xor2_1 U64(.X(n1_tree_27), .A(a_in[27]), .B(b_in[27]));
    sky130_fd_sc_hd__xnor2_1 U65(.Y(n2_tree_27), .A(a_in[27]), .B(b_in[27]));
    sky130_fd_sc_hd__and2_1 U74(.X(n108_tree_27), .A(n25_tree_32), .B(n27_tree_32));
    sky130_fd_sc_hd__a21o_1 U75(.X(n3_tree_27), .A1(n26_tree_32), .A2(n25_tree_32), .B1(n24_tree_32));
    sky130_fd_sc_hd__and2_1 U93(.X(n11_tree_27), .A(n108_tree_27), .B(n39_tree_30));
    sky130_fd_sc_hd__a21o_1 U94(.X(n10_tree_27), .A1(n38_tree_30), .A2(n108_tree_27), .B1(n3_tree_27));
    sky130_fd_sc_hd__and2_1 U149(.X(n43_tree_27), .A(n11_tree_27), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U150(.X(n42_tree_27), .A1(n82_tree_29), .A2(n11_tree_27), .B1(n10_tree_27));
endmodule // adder_tree_27
module adder_tree_28(
	input  [28:0] a_in,
	input  [28:0] b_in,
	input   n18_tree_31,
	input   n19_tree_31,
	input   n38_tree_30,
	input   n39_tree_30,
	input   n82_tree_29,
	input   n83_tree_29,
	output  sum
);
// adder_forest tree_28
	wire n1_tree_28, n2_tree_28, n14_tree_28, n15_tree_28, n46_tree_28, n47_tree_28;
    sky130_fd_sc_hd__mux2_1 U100(.X(sum), .S(n46_tree_28), .A0(n1_tree_28), .A1(n2_tree_28));
    sky130_fd_sc_hd__xor2_1 U62(.X(n1_tree_28), .A(a_in[28]), .B(b_in[28]));
    sky130_fd_sc_hd__xnor2_1 U63(.Y(n2_tree_28), .A(a_in[28]), .B(b_in[28]));
    sky130_fd_sc_hd__and2_1 U103(.X(n15_tree_28), .A(n19_tree_31), .B(n39_tree_30));
    sky130_fd_sc_hd__a21o_1 U104(.X(n14_tree_28), .A1(n38_tree_30), .A2(n19_tree_31), .B1(n18_tree_31));
    sky130_fd_sc_hd__and2_1 U162(.X(n47_tree_28), .A(n15_tree_28), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U163(.X(n46_tree_28), .A1(n82_tree_29), .A2(n15_tree_28), .B1(n14_tree_28));
endmodule // adder_tree_28
module adder_tree_29(
	input  [29:0] a_in,
	input  [29:0] b_in,
	input   n17_tree_32,
	input   n16_tree_32,
	input   n18_tree_31,
	input   n19_tree_31,
	input   n38_tree_30,
	input   n39_tree_30,
	input   n70_tree_30,
	input   n71_tree_30,
	input   n102_tree_30,
	input   n103_tree_30,
	output  sum,
	output  n82_tree_29,
	output  n83_tree_29
);
// adder_forest tree_29
	wire n1_tree_29, n2_tree_29, n3_tree_29, n18_tree_29, n19_tree_29, n50_tree_29, n51_tree_29, n116_tree_29;
    sky130_fd_sc_hd__mux2_1 U97(.X(sum), .S(n50_tree_29), .A0(n1_tree_29), .A1(n2_tree_29));
    sky130_fd_sc_hd__xor2_1 U79(.X(n1_tree_29), .A(a_in[29]), .B(b_in[29]));
    sky130_fd_sc_hd__xnor2_1 U80(.Y(n2_tree_29), .A(a_in[29]), .B(b_in[29]));
    sky130_fd_sc_hd__and2_1 U89(.X(n116_tree_29), .A(n17_tree_32), .B(n19_tree_31));
    sky130_fd_sc_hd__a21o_1 U90(.X(n3_tree_29), .A1(n18_tree_31), .A2(n17_tree_32), .B1(n16_tree_32));
    sky130_fd_sc_hd__and2_1 U124(.X(n19_tree_29), .A(n116_tree_29), .B(n39_tree_30));
    sky130_fd_sc_hd__a21o_1 U125(.X(n18_tree_29), .A1(n38_tree_30), .A2(n116_tree_29), .B1(n3_tree_29));
    sky130_fd_sc_hd__and2_1 U186(.X(n51_tree_29), .A(n19_tree_29), .B(n83_tree_29));
    sky130_fd_sc_hd__a21o_1 U187(.X(n50_tree_29), .A1(n82_tree_29), .A2(n19_tree_29), .B1(n18_tree_29));
    sky130_fd_sc_hd__and2_1 U243(.X(n83_tree_29), .A(n71_tree_30), .B(n103_tree_30));
    sky130_fd_sc_hd__a21o_1 U244(.X(n82_tree_29), .A1(n102_tree_30), .A2(n71_tree_30), .B1(n70_tree_30));
endmodule // adder_tree_29
module adder_tree_30(
	input  [30:0] a_in,
	input  [30:0] b_in,
	input   n10_tree_32,
	input   n11_tree_32,
	input   n18_tree_31,
	input   n19_tree_31,
	input   n34_tree_31,
	input   n35_tree_31,
	input   n50_tree_31,
	input   n51_tree_31,
	input   n66_tree_31,
	input   n67_tree_31,
	input   n82_tree_31,
	input   n83_tree_31,
	input   n98_tree_31,
	input   n99_tree_31,
	input   n114_tree_31,
	input   n115_tree_31,
	output  sum,
	output  n38_tree_30,
	output  n39_tree_30,
	output  n70_tree_30,
	output  n71_tree_30,
	output  n102_tree_30,
	output  n103_tree_30
);
// adder_forest tree_30
	wire n1_tree_30, n2_tree_30, n6_tree_30, n7_tree_30, n22_tree_30, n23_tree_30, n54_tree_30, n55_tree_30, n86_tree_30, n87_tree_30;
    sky130_fd_sc_hd__mux2_1 U113(.X(sum), .S(n54_tree_30), .A0(n1_tree_30), .A1(n2_tree_30));
    sky130_fd_sc_hd__xor2_1 U105(.X(n1_tree_30), .A(a_in[30]), .B(b_in[30]));
    sky130_fd_sc_hd__xnor2_1 U106(.Y(n2_tree_30), .A(a_in[30]), .B(b_in[30]));
    sky130_fd_sc_hd__and2_1 U122(.X(n7_tree_30), .A(n11_tree_32), .B(n19_tree_31));
    sky130_fd_sc_hd__a21o_1 U123(.X(n6_tree_30), .A1(n18_tree_31), .A2(n11_tree_32), .B1(n10_tree_32));
    sky130_fd_sc_hd__and2_1 U153(.X(n23_tree_30), .A(n7_tree_30), .B(n39_tree_30));
    sky130_fd_sc_hd__a21o_1 U154(.X(n22_tree_30), .A1(n38_tree_30), .A2(n7_tree_30), .B1(n6_tree_30));
    sky130_fd_sc_hd__and2_1 U198(.X(n39_tree_30), .A(n35_tree_31), .B(n51_tree_31));
    sky130_fd_sc_hd__a21o_1 U199(.X(n38_tree_30), .A1(n50_tree_31), .A2(n35_tree_31), .B1(n34_tree_31));
    sky130_fd_sc_hd__and2_1 U222(.X(n55_tree_30), .A(n23_tree_30), .B(n87_tree_30));
    sky130_fd_sc_hd__a21o_1 U223(.X(n54_tree_30), .A1(n86_tree_30), .A2(n23_tree_30), .B1(n22_tree_30));
    sky130_fd_sc_hd__and2_1 U252(.X(n71_tree_30), .A(n67_tree_31), .B(n83_tree_31));
    sky130_fd_sc_hd__a21o_1 U253(.X(n70_tree_30), .A1(n82_tree_31), .A2(n67_tree_31), .B1(n66_tree_31));
    sky130_fd_sc_hd__and2_1 U270(.X(n87_tree_30), .A(n71_tree_30), .B(n103_tree_30));
    sky130_fd_sc_hd__a21o_1 U271(.X(n86_tree_30), .A1(n102_tree_30), .A2(n71_tree_30), .B1(n70_tree_30));
    sky130_fd_sc_hd__and2_1 U292(.X(n103_tree_30), .A(n99_tree_31), .B(n115_tree_31));
    sky130_fd_sc_hd__a21o_1 U293(.X(n102_tree_30), .A1(n114_tree_31), .A2(n99_tree_31), .B1(n98_tree_31));
endmodule // adder_tree_30
module adder_tree_31(
	input  [31:0] a_in,
	input  [31:0] b_in,
	input   n9_tree_32,
	input   n8_tree_32,
	input   n10_tree_32,
	input   n11_tree_32,
	input   n18_tree_32,
	input   n19_tree_32,
	input   n26_tree_32,
	input   n27_tree_32,
	input   n34_tree_32,
	input   n35_tree_32,
	input   n42_tree_32,
	input   n43_tree_32,
	input   n50_tree_32,
	input   n51_tree_32,
	input   n58_tree_32,
	input   n59_tree_32,
	input   n66_tree_32,
	input   n67_tree_32,
	input   n74_tree_32,
	input   n75_tree_32,
	input   n82_tree_32,
	input   n83_tree_32,
	input   n90_tree_32,
	input   n91_tree_32,
	input   n98_tree_32,
	input   n99_tree_32,
	input   n106_tree_32,
	input   n107_tree_32,
	input   n114_tree_32,
	input   n115_tree_32,
	input   n122_tree_32,
	input   n123_tree_32,
	output  sum,
	output  n18_tree_31,
	output  n19_tree_31,
	output  n34_tree_31,
	output  n35_tree_31,
	output  n50_tree_31,
	output  n51_tree_31,
	output  n66_tree_31,
	output  n67_tree_31,
	output  n82_tree_31,
	output  n83_tree_31,
	output  n98_tree_31,
	output  n99_tree_31,
	output  n114_tree_31,
	output  n115_tree_31
);
// adder_forest tree_31
	wire n1_tree_31, n2_tree_31, n3_tree_31, n10_tree_31, n11_tree_31, n26_tree_31, n27_tree_31, n42_tree_31, n43_tree_31, n58_tree_31, n59_tree_31, n74_tree_31, n75_tree_31, n90_tree_31, n91_tree_31, n106_tree_31, n107_tree_31, n124_tree_31;
    sky130_fd_sc_hd__mux2_1 U132(.X(sum), .S(n58_tree_31), .A0(n1_tree_31), .A1(n2_tree_31));
    sky130_fd_sc_hd__xor2_1 U139(.X(n1_tree_31), .A(a_in[31]), .B(b_in[31]));
    sky130_fd_sc_hd__xnor2_1 U140(.Y(n2_tree_31), .A(a_in[31]), .B(b_in[31]));
    sky130_fd_sc_hd__and2_1 U151(.X(n124_tree_31), .A(n9_tree_32), .B(n11_tree_32));
    sky130_fd_sc_hd__a21o_1 U152(.X(n3_tree_31), .A1(n10_tree_32), .A2(n9_tree_32), .B1(n8_tree_32));
    sky130_fd_sc_hd__and2_1 U173(.X(n11_tree_31), .A(n124_tree_31), .B(n19_tree_31));
    sky130_fd_sc_hd__a21o_1 U174(.X(n10_tree_31), .A1(n18_tree_31), .A2(n124_tree_31), .B1(n3_tree_31));
    sky130_fd_sc_hd__and2_1 U194(.X(n19_tree_31), .A(n19_tree_32), .B(n27_tree_32));
    sky130_fd_sc_hd__a21o_1 U195(.X(n18_tree_31), .A1(n26_tree_32), .A2(n19_tree_32), .B1(n18_tree_32));
    sky130_fd_sc_hd__and2_1 U212(.X(n27_tree_31), .A(n11_tree_31), .B(n43_tree_31));
    sky130_fd_sc_hd__a21o_1 U213(.X(n26_tree_31), .A1(n42_tree_31), .A2(n11_tree_31), .B1(n10_tree_31));
    sky130_fd_sc_hd__and2_1 U233(.X(n35_tree_31), .A(n35_tree_32), .B(n43_tree_32));
    sky130_fd_sc_hd__a21o_1 U234(.X(n34_tree_31), .A1(n42_tree_32), .A2(n35_tree_32), .B1(n34_tree_32));
    sky130_fd_sc_hd__and2_1 U250(.X(n43_tree_31), .A(n35_tree_31), .B(n51_tree_31));
    sky130_fd_sc_hd__a21o_1 U251(.X(n42_tree_31), .A1(n50_tree_31), .A2(n35_tree_31), .B1(n34_tree_31));
    sky130_fd_sc_hd__and2_1 U258(.X(n51_tree_31), .A(n51_tree_32), .B(n59_tree_32));
    sky130_fd_sc_hd__a21o_1 U259(.X(n50_tree_31), .A1(n58_tree_32), .A2(n51_tree_32), .B1(n50_tree_32));
    sky130_fd_sc_hd__and2_1 U268(.X(n59_tree_31), .A(n27_tree_31), .B(n91_tree_31));
    sky130_fd_sc_hd__a21o_1 U269(.X(n58_tree_31), .A1(n90_tree_31), .A2(n27_tree_31), .B1(n26_tree_31));
    sky130_fd_sc_hd__and2_1 U278(.X(n67_tree_31), .A(n67_tree_32), .B(n75_tree_32));
    sky130_fd_sc_hd__a21o_1 U279(.X(n66_tree_31), .A1(n74_tree_32), .A2(n67_tree_32), .B1(n66_tree_32));
    sky130_fd_sc_hd__and2_1 U290(.X(n75_tree_31), .A(n67_tree_31), .B(n83_tree_31));
    sky130_fd_sc_hd__a21o_1 U291(.X(n74_tree_31), .A1(n82_tree_31), .A2(n67_tree_31), .B1(n66_tree_31));
    sky130_fd_sc_hd__and2_1 U302(.X(n83_tree_31), .A(n83_tree_32), .B(n91_tree_32));
    sky130_fd_sc_hd__a21o_1 U303(.X(n82_tree_31), .A1(n90_tree_32), .A2(n83_tree_32), .B1(n82_tree_32));
    sky130_fd_sc_hd__and2_1 U308(.X(n91_tree_31), .A(n75_tree_31), .B(n107_tree_31));
    sky130_fd_sc_hd__a21o_1 U309(.X(n90_tree_31), .A1(n106_tree_31), .A2(n75_tree_31), .B1(n74_tree_31));
    sky130_fd_sc_hd__and2_1 U320(.X(n99_tree_31), .A(n99_tree_32), .B(n107_tree_32));
    sky130_fd_sc_hd__a21o_1 U321(.X(n98_tree_31), .A1(n106_tree_32), .A2(n99_tree_32), .B1(n98_tree_32));
    sky130_fd_sc_hd__and2_1 U332(.X(n107_tree_31), .A(n99_tree_31), .B(n115_tree_31));
    sky130_fd_sc_hd__a21o_1 U333(.X(n106_tree_31), .A1(n114_tree_31), .A2(n99_tree_31), .B1(n98_tree_31));
    sky130_fd_sc_hd__and2_1 U346(.X(n115_tree_31), .A(n115_tree_32), .B(n123_tree_32));
    sky130_fd_sc_hd__a21o_1 U347(.X(n114_tree_31), .A1(n122_tree_32), .A2(n115_tree_32), .B1(n114_tree_32));
endmodule // adder_tree_31
module adder_tree_32(
	input  [32:0] a_in,
	input  [32:0] b_in,
	output  sum,
	output  n127_tree_32,
	output  n126_tree_32,
	output  n125_tree_32,
	output  n124_tree_32,
	output  n121_tree_32,
	output  n120_tree_32,
	output  n117_tree_32,
	output  n116_tree_32,
	output  n113_tree_32,
	output  n112_tree_32,
	output  n109_tree_32,
	output  n108_tree_32,
	output  n105_tree_32,
	output  n104_tree_32,
	output  n101_tree_32,
	output  n100_tree_32,
	output  n97_tree_32,
	output  n96_tree_32,
	output  n93_tree_32,
	output  n92_tree_32,
	output  n89_tree_32,
	output  n88_tree_32,
	output  n85_tree_32,
	output  n84_tree_32,
	output  n81_tree_32,
	output  n80_tree_32,
	output  n77_tree_32,
	output  n76_tree_32,
	output  n73_tree_32,
	output  n72_tree_32,
	output  n69_tree_32,
	output  n68_tree_32,
	output  n65_tree_32,
	output  n64_tree_32,
	output  n61_tree_32,
	output  n60_tree_32,
	output  n57_tree_32,
	output  n56_tree_32,
	output  n53_tree_32,
	output  n52_tree_32,
	output  n49_tree_32,
	output  n48_tree_32,
	output  n45_tree_32,
	output  n44_tree_32,
	output  n41_tree_32,
	output  n40_tree_32,
	output  n37_tree_32,
	output  n36_tree_32,
	output  n33_tree_32,
	output  n32_tree_32,
	output  n29_tree_32,
	output  n28_tree_32,
	output  n25_tree_32,
	output  n24_tree_32,
	output  n21_tree_32,
	output  n20_tree_32,
	output  n17_tree_32,
	output  n16_tree_32,
	output  n13_tree_32,
	output  n12_tree_32,
	output  n9_tree_32,
	output  n8_tree_32,
	output  n10_tree_32,
	output  n11_tree_32,
	output  n18_tree_32,
	output  n19_tree_32,
	output  n26_tree_32,
	output  n27_tree_32,
	output  n34_tree_32,
	output  n35_tree_32,
	output  n42_tree_32,
	output  n43_tree_32,
	output  n50_tree_32,
	output  n51_tree_32,
	output  n58_tree_32,
	output  n59_tree_32,
	output  n66_tree_32,
	output  n67_tree_32,
	output  n74_tree_32,
	output  n75_tree_32,
	output  n82_tree_32,
	output  n83_tree_32,
	output  n90_tree_32,
	output  n91_tree_32,
	output  n98_tree_32,
	output  n99_tree_32,
	output  n106_tree_32,
	output  n107_tree_32,
	output  n114_tree_32,
	output  n115_tree_32,
	output  n122_tree_32,
	output  n123_tree_32
);
// adder_forest tree_32
	wire n1_tree_32, n2_tree_32, n3_tree_32, n4_tree_32, n5_tree_32, n6_tree_32, n7_tree_32, n14_tree_32, n15_tree_32, n22_tree_32, n23_tree_32, n30_tree_32, n31_tree_32, n38_tree_32, n39_tree_32, n46_tree_32, n47_tree_32, n54_tree_32, n55_tree_32, n62_tree_32, n63_tree_32, n70_tree_32, n71_tree_32, n78_tree_32, n79_tree_32, n86_tree_32, n87_tree_32, n94_tree_32, n95_tree_32, n102_tree_32, n103_tree_32, n110_tree_32, n111_tree_32, n118_tree_32, n119_tree_32, n128_tree_32;
    sky130_fd_sc_hd__mux2_1 U192(.X(sum), .S(n62_tree_32), .A0(n1_tree_32), .A1(n2_tree_32));
    sky130_fd_sc_hd__xor2_1 U216(.X(n127_tree_32), .A(a_in[0]), .B(b_in[0]));
    sky130_fd_sc_hd__and2_1 U217(.X(n126_tree_32), .A(a_in[0]), .B(b_in[0]));
    sky130_fd_sc_hd__xor2_1 U236(.X(n125_tree_32), .A(a_in[1]), .B(b_in[1]));
    sky130_fd_sc_hd__and2_1 U237(.X(n124_tree_32), .A(a_in[1]), .B(b_in[1]));
    sky130_fd_sc_hd__xor2_1 U4(.X(n121_tree_32), .A(a_in[2]), .B(b_in[2]));
    sky130_fd_sc_hd__and2_1 U5(.X(n120_tree_32), .A(a_in[2]), .B(b_in[2]));
    sky130_fd_sc_hd__xor2_1 U12(.X(n117_tree_32), .A(a_in[3]), .B(b_in[3]));
    sky130_fd_sc_hd__and2_1 U13(.X(n116_tree_32), .A(a_in[3]), .B(b_in[3]));
    sky130_fd_sc_hd__xor2_1 U17(.X(n113_tree_32), .A(a_in[4]), .B(b_in[4]));
    sky130_fd_sc_hd__and2_1 U18(.X(n112_tree_32), .A(a_in[4]), .B(b_in[4]));
    sky130_fd_sc_hd__xor2_1 U23(.X(n109_tree_32), .A(a_in[5]), .B(b_in[5]));
    sky130_fd_sc_hd__and2_1 U24(.X(n108_tree_32), .A(a_in[5]), .B(b_in[5]));
    sky130_fd_sc_hd__xor2_1 U27(.X(n105_tree_32), .A(a_in[6]), .B(b_in[6]));
    sky130_fd_sc_hd__and2_1 U28(.X(n104_tree_32), .A(a_in[6]), .B(b_in[6]));
    sky130_fd_sc_hd__xor2_1 U31(.X(n101_tree_32), .A(a_in[7]), .B(b_in[7]));
    sky130_fd_sc_hd__and2_1 U32(.X(n100_tree_32), .A(a_in[7]), .B(b_in[7]));
    sky130_fd_sc_hd__xor2_1 U38(.X(n97_tree_32), .A(a_in[8]), .B(b_in[8]));
    sky130_fd_sc_hd__and2_1 U39(.X(n96_tree_32), .A(a_in[8]), .B(b_in[8]));
    sky130_fd_sc_hd__xor2_1 U48(.X(n93_tree_32), .A(a_in[9]), .B(b_in[9]));
    sky130_fd_sc_hd__and2_1 U49(.X(n92_tree_32), .A(a_in[9]), .B(b_in[9]));
    sky130_fd_sc_hd__xor2_1 U54(.X(n89_tree_32), .A(a_in[10]), .B(b_in[10]));
    sky130_fd_sc_hd__and2_1 U55(.X(n88_tree_32), .A(a_in[10]), .B(b_in[10]));
    sky130_fd_sc_hd__xor2_1 U58(.X(n85_tree_32), .A(a_in[11]), .B(b_in[11]));
    sky130_fd_sc_hd__and2_1 U59(.X(n84_tree_32), .A(a_in[11]), .B(b_in[11]));
    sky130_fd_sc_hd__xor2_1 U69(.X(n81_tree_32), .A(a_in[12]), .B(b_in[12]));
    sky130_fd_sc_hd__and2_1 U70(.X(n80_tree_32), .A(a_in[12]), .B(b_in[12]));
    sky130_fd_sc_hd__xor2_1 U71(.X(n77_tree_32), .A(a_in[13]), .B(b_in[13]));
    sky130_fd_sc_hd__and2_1 U72(.X(n76_tree_32), .A(a_in[13]), .B(b_in[13]));
    sky130_fd_sc_hd__xor2_1 U83(.X(n73_tree_32), .A(a_in[14]), .B(b_in[14]));
    sky130_fd_sc_hd__and2_1 U84(.X(n72_tree_32), .A(a_in[14]), .B(b_in[14]));
    sky130_fd_sc_hd__xor2_1 U87(.X(n69_tree_32), .A(a_in[15]), .B(b_in[15]));
    sky130_fd_sc_hd__and2_1 U88(.X(n68_tree_32), .A(a_in[15]), .B(b_in[15]));
    sky130_fd_sc_hd__xor2_1 U95(.X(n65_tree_32), .A(a_in[16]), .B(b_in[16]));
    sky130_fd_sc_hd__and2_1 U96(.X(n64_tree_32), .A(a_in[16]), .B(b_in[16]));
    sky130_fd_sc_hd__xor2_1 U101(.X(n61_tree_32), .A(a_in[17]), .B(b_in[17]));
    sky130_fd_sc_hd__and2_1 U102(.X(n60_tree_32), .A(a_in[17]), .B(b_in[17]));
    sky130_fd_sc_hd__xor2_1 U109(.X(n57_tree_32), .A(a_in[18]), .B(b_in[18]));
    sky130_fd_sc_hd__and2_1 U110(.X(n56_tree_32), .A(a_in[18]), .B(b_in[18]));
    sky130_fd_sc_hd__xor2_1 U114(.X(n53_tree_32), .A(a_in[19]), .B(b_in[19]));
    sky130_fd_sc_hd__and2_1 U115(.X(n52_tree_32), .A(a_in[19]), .B(b_in[19]));
    sky130_fd_sc_hd__xor2_1 U120(.X(n49_tree_32), .A(a_in[20]), .B(b_in[20]));
    sky130_fd_sc_hd__and2_1 U121(.X(n48_tree_32), .A(a_in[20]), .B(b_in[20]));
    sky130_fd_sc_hd__xor2_1 U126(.X(n45_tree_32), .A(a_in[21]), .B(b_in[21]));
    sky130_fd_sc_hd__and2_1 U127(.X(n44_tree_32), .A(a_in[21]), .B(b_in[21]));
    sky130_fd_sc_hd__xor2_1 U130(.X(n41_tree_32), .A(a_in[22]), .B(b_in[22]));
    sky130_fd_sc_hd__and2_1 U131(.X(n40_tree_32), .A(a_in[22]), .B(b_in[22]));
    sky130_fd_sc_hd__xor2_1 U134(.X(n37_tree_32), .A(a_in[23]), .B(b_in[23]));
    sky130_fd_sc_hd__and2_1 U135(.X(n36_tree_32), .A(a_in[23]), .B(b_in[23]));
    sky130_fd_sc_hd__xor2_1 U143(.X(n33_tree_32), .A(a_in[24]), .B(b_in[24]));
    sky130_fd_sc_hd__and2_1 U144(.X(n32_tree_32), .A(a_in[24]), .B(b_in[24]));
    sky130_fd_sc_hd__xor2_1 U147(.X(n29_tree_32), .A(a_in[25]), .B(b_in[25]));
    sky130_fd_sc_hd__and2_1 U148(.X(n28_tree_32), .A(a_in[25]), .B(b_in[25]));
    sky130_fd_sc_hd__xor2_1 U159(.X(n25_tree_32), .A(a_in[26]), .B(b_in[26]));
    sky130_fd_sc_hd__and2_1 U160(.X(n24_tree_32), .A(a_in[26]), .B(b_in[26]));
    sky130_fd_sc_hd__xor2_1 U167(.X(n21_tree_32), .A(a_in[27]), .B(b_in[27]));
    sky130_fd_sc_hd__and2_1 U168(.X(n20_tree_32), .A(a_in[27]), .B(b_in[27]));
    sky130_fd_sc_hd__xor2_1 U171(.X(n17_tree_32), .A(a_in[28]), .B(b_in[28]));
    sky130_fd_sc_hd__and2_1 U172(.X(n16_tree_32), .A(a_in[28]), .B(b_in[28]));
    sky130_fd_sc_hd__xor2_1 U180(.X(n13_tree_32), .A(a_in[29]), .B(b_in[29]));
    sky130_fd_sc_hd__and2_1 U181(.X(n12_tree_32), .A(a_in[29]), .B(b_in[29]));
    sky130_fd_sc_hd__xor2_1 U188(.X(n9_tree_32), .A(a_in[30]), .B(b_in[30]));
    sky130_fd_sc_hd__and2_1 U189(.X(n8_tree_32), .A(a_in[30]), .B(b_in[30]));
    sky130_fd_sc_hd__xor2_1 U196(.X(n5_tree_32), .A(a_in[31]), .B(b_in[31]));
    sky130_fd_sc_hd__and2_1 U197(.X(n4_tree_32), .A(a_in[31]), .B(b_in[31]));
    sky130_fd_sc_hd__xor2_1 U204(.X(n1_tree_32), .A(a_in[32]), .B(b_in[32]));
    sky130_fd_sc_hd__xnor2_1 U205(.Y(n2_tree_32), .A(a_in[32]), .B(b_in[32]));
    sky130_fd_sc_hd__and2_1 U218(.X(n128_tree_32), .A(n5_tree_32), .B(n9_tree_32));
    sky130_fd_sc_hd__a21o_1 U219(.X(n3_tree_32), .A1(n8_tree_32), .A2(n5_tree_32), .B1(n4_tree_32));
    sky130_fd_sc_hd__and2_1 U227(.X(n7_tree_32), .A(n128_tree_32), .B(n11_tree_32));
    sky130_fd_sc_hd__a21o_1 U228(.X(n6_tree_32), .A1(n10_tree_32), .A2(n128_tree_32), .B1(n3_tree_32));
    sky130_fd_sc_hd__and2_1 U238(.X(n11_tree_32), .A(n13_tree_32), .B(n17_tree_32));
    sky130_fd_sc_hd__a21o_1 U239(.X(n10_tree_32), .A1(n16_tree_32), .A2(n13_tree_32), .B1(n12_tree_32));
    sky130_fd_sc_hd__and2_1 U247(.X(n15_tree_32), .A(n7_tree_32), .B(n23_tree_32));
    sky130_fd_sc_hd__a21o_1 U248(.X(n14_tree_32), .A1(n22_tree_32), .A2(n7_tree_32), .B1(n6_tree_32));
    sky130_fd_sc_hd__and2_1 U254(.X(n19_tree_32), .A(n21_tree_32), .B(n25_tree_32));
    sky130_fd_sc_hd__a21o_1 U255(.X(n18_tree_32), .A1(n24_tree_32), .A2(n21_tree_32), .B1(n20_tree_32));
    sky130_fd_sc_hd__and2_1 U260(.X(n23_tree_32), .A(n19_tree_32), .B(n27_tree_32));
    sky130_fd_sc_hd__a21o_1 U261(.X(n22_tree_32), .A1(n26_tree_32), .A2(n19_tree_32), .B1(n18_tree_32));
    sky130_fd_sc_hd__and2_1 U265(.X(n27_tree_32), .A(n29_tree_32), .B(n33_tree_32));
    sky130_fd_sc_hd__a21o_1 U266(.X(n26_tree_32), .A1(n32_tree_32), .A2(n29_tree_32), .B1(n28_tree_32));
    sky130_fd_sc_hd__and2_1 U272(.X(n31_tree_32), .A(n15_tree_32), .B(n47_tree_32));
    sky130_fd_sc_hd__a21o_1 U273(.X(n30_tree_32), .A1(n46_tree_32), .A2(n15_tree_32), .B1(n14_tree_32));
    sky130_fd_sc_hd__and2_1 U280(.X(n35_tree_32), .A(n37_tree_32), .B(n41_tree_32));
    sky130_fd_sc_hd__a21o_1 U281(.X(n34_tree_32), .A1(n40_tree_32), .A2(n37_tree_32), .B1(n36_tree_32));
    sky130_fd_sc_hd__and2_1 U287(.X(n39_tree_32), .A(n35_tree_32), .B(n43_tree_32));
    sky130_fd_sc_hd__a21o_1 U288(.X(n38_tree_32), .A1(n42_tree_32), .A2(n35_tree_32), .B1(n34_tree_32));
    sky130_fd_sc_hd__and2_1 U297(.X(n43_tree_32), .A(n45_tree_32), .B(n49_tree_32));
    sky130_fd_sc_hd__a21o_1 U298(.X(n42_tree_32), .A1(n48_tree_32), .A2(n45_tree_32), .B1(n44_tree_32));
    sky130_fd_sc_hd__and2_1 U304(.X(n47_tree_32), .A(n39_tree_32), .B(n55_tree_32));
    sky130_fd_sc_hd__a21o_1 U305(.X(n46_tree_32), .A1(n54_tree_32), .A2(n39_tree_32), .B1(n38_tree_32));
    sky130_fd_sc_hd__and2_1 U306(.X(n51_tree_32), .A(n53_tree_32), .B(n57_tree_32));
    sky130_fd_sc_hd__a21o_1 U307(.X(n50_tree_32), .A1(n56_tree_32), .A2(n53_tree_32), .B1(n52_tree_32));
    sky130_fd_sc_hd__and2_1 U310(.X(n55_tree_32), .A(n51_tree_32), .B(n59_tree_32));
    sky130_fd_sc_hd__a21o_1 U311(.X(n54_tree_32), .A1(n58_tree_32), .A2(n51_tree_32), .B1(n50_tree_32));
    sky130_fd_sc_hd__and2_1 U316(.X(n59_tree_32), .A(n61_tree_32), .B(n65_tree_32));
    sky130_fd_sc_hd__a21o_1 U317(.X(n58_tree_32), .A1(n64_tree_32), .A2(n61_tree_32), .B1(n60_tree_32));
    sky130_fd_sc_hd__and2_1 U326(.X(n63_tree_32), .A(n31_tree_32), .B(n95_tree_32));
    sky130_fd_sc_hd__a21o_1 U327(.X(n62_tree_32), .A1(n94_tree_32), .A2(n31_tree_32), .B1(n30_tree_32));
    sky130_fd_sc_hd__and2_1 U330(.X(n67_tree_32), .A(n69_tree_32), .B(n73_tree_32));
    sky130_fd_sc_hd__a21o_1 U331(.X(n66_tree_32), .A1(n72_tree_32), .A2(n69_tree_32), .B1(n68_tree_32));
    sky130_fd_sc_hd__and2_1 U336(.X(n71_tree_32), .A(n67_tree_32), .B(n75_tree_32));
    sky130_fd_sc_hd__a21o_1 U337(.X(n70_tree_32), .A1(n74_tree_32), .A2(n67_tree_32), .B1(n66_tree_32));
    sky130_fd_sc_hd__and2_1 U342(.X(n75_tree_32), .A(n77_tree_32), .B(n81_tree_32));
    sky130_fd_sc_hd__a21o_1 U343(.X(n74_tree_32), .A1(n80_tree_32), .A2(n77_tree_32), .B1(n76_tree_32));
    sky130_fd_sc_hd__and2_1 U350(.X(n79_tree_32), .A(n71_tree_32), .B(n87_tree_32));
    sky130_fd_sc_hd__a21o_1 U351(.X(n78_tree_32), .A1(n86_tree_32), .A2(n71_tree_32), .B1(n70_tree_32));
    sky130_fd_sc_hd__and2_1 U2(.X(n83_tree_32), .A(n85_tree_32), .B(n89_tree_32));
    sky130_fd_sc_hd__a21o_1 U3(.X(n82_tree_32), .A1(n88_tree_32), .A2(n85_tree_32), .B1(n84_tree_32));
    sky130_fd_sc_hd__and2_1 U10(.X(n87_tree_32), .A(n83_tree_32), .B(n91_tree_32));
    sky130_fd_sc_hd__a21o_1 U11(.X(n86_tree_32), .A1(n90_tree_32), .A2(n83_tree_32), .B1(n82_tree_32));
    sky130_fd_sc_hd__and2_1 U15(.X(n91_tree_32), .A(n93_tree_32), .B(n97_tree_32));
    sky130_fd_sc_hd__a21o_1 U16(.X(n90_tree_32), .A1(n96_tree_32), .A2(n93_tree_32), .B1(n92_tree_32));
    sky130_fd_sc_hd__and2_1 U21(.X(n95_tree_32), .A(n79_tree_32), .B(n111_tree_32));
    sky130_fd_sc_hd__a21o_1 U22(.X(n94_tree_32), .A1(n110_tree_32), .A2(n79_tree_32), .B1(n78_tree_32));
    sky130_fd_sc_hd__and2_1 U25(.X(n99_tree_32), .A(n101_tree_32), .B(n105_tree_32));
    sky130_fd_sc_hd__a21o_1 U26(.X(n98_tree_32), .A1(n104_tree_32), .A2(n101_tree_32), .B1(n100_tree_32));
    sky130_fd_sc_hd__and2_1 U29(.X(n103_tree_32), .A(n99_tree_32), .B(n107_tree_32));
    sky130_fd_sc_hd__a21o_1 U30(.X(n102_tree_32), .A1(n106_tree_32), .A2(n99_tree_32), .B1(n98_tree_32));
    sky130_fd_sc_hd__and2_1 U36(.X(n107_tree_32), .A(n109_tree_32), .B(n113_tree_32));
    sky130_fd_sc_hd__a21o_1 U37(.X(n106_tree_32), .A1(n112_tree_32), .A2(n109_tree_32), .B1(n108_tree_32));
    sky130_fd_sc_hd__and2_1 U46(.X(n111_tree_32), .A(n103_tree_32), .B(n119_tree_32));
    sky130_fd_sc_hd__a21o_1 U47(.X(n110_tree_32), .A1(n118_tree_32), .A2(n103_tree_32), .B1(n102_tree_32));
    sky130_fd_sc_hd__and2_1 U52(.X(n115_tree_32), .A(n117_tree_32), .B(n121_tree_32));
    sky130_fd_sc_hd__a21o_1 U53(.X(n114_tree_32), .A1(n120_tree_32), .A2(n117_tree_32), .B1(n116_tree_32));
    sky130_fd_sc_hd__and2_1 U56(.X(n119_tree_32), .A(n115_tree_32), .B(n123_tree_32));
    sky130_fd_sc_hd__a21o_1 U57(.X(n118_tree_32), .A1(n122_tree_32), .A2(n115_tree_32), .B1(n114_tree_32));
    sky130_fd_sc_hd__and2_1 U67(.X(n123_tree_32), .A(n125_tree_32), .B(n127_tree_32));
    sky130_fd_sc_hd__a21o_1 U68(.X(n122_tree_32), .A1(n126_tree_32), .A2(n125_tree_32), .B1(n124_tree_32));
endmodule // adder_tree_32
`endif