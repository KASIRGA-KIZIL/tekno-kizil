// tb_modified_booth_dadda_carpici.v
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

// carpici 33x33-> 66 bitlik, mulhsu icin 1 bit genis.

module wallace(deger1_i,deger2_i,sonuc_o);
input [32:0] deger1_i,deger2_i;
  
output [65:0] sonuc_o;

wire [31:0] ip0,ip1,ip2,ip3,ip4,ip5,ip6,ip7 , ip8,ip9,ip10,ip11,ip12,ip13,ip14,ip15, ip16,ip17,ip18,ip19,ip20,ip21,ip22,ip23, ip24,ip25,ip26,ip27,ip28,ip29,ip30,ip31 ,ip32;
wire [32:0] si,iip;
wire [31:0] s1,s2,s3,s4,s5,s6, s7,s8,s9,s10,s11,s12,s13,s14,s15, s16,s17,s18,s19,s20,s21,s22,s23, s24,s25,s26,s27,s28,s29,s30 ,s31;
wire [32:0] c1,c2,c3,c4,c5,c6,c7, c8,c9,c10,c11,c12,c13,c14,c15, c16,c17,c18,c19,c20,c21,c22,c23, c24,c25,c26,c27,c28,c29,c30,c31 ,c32;
  
// first AND array
and_array I0(deger2_i[0], deger1_i, {ip0[30:0],sonuc_o[0]}, si[0]);
not I1(ip0[31],si[0]);

// second AND array and NOT GATES
and_array I2(deger2_i[1], deger1_i, ip1, si[1]);

//third
and_array I3(deger2_i[2], deger1_i, ip2, si[2]);

//fourth
and_array I4(deger2_i[3], deger1_i, ip3, si[3]);

//fifth
and_array I5(deger2_i[4], deger1_i, ip4, si[4]);

//sixth
and_array I6(deger2_i[5], deger1_i, ip5, si[5]);

//seventh
and_array I7(deger2_i[6], deger1_i, ip6, si[6]);

and_array a7 (deger2_i[7 ], deger1_i, ip7 , si[7 ]);
and_array a8 (deger2_i[8 ], deger1_i, ip8 , si[8 ]);
and_array a9 (deger2_i[9 ], deger1_i, ip9 , si[9 ]);
and_array a10(deger2_i[10], deger1_i, ip10, si[10]);
and_array a11(deger2_i[11], deger1_i, ip11, si[11]);
and_array a12(deger2_i[12], deger1_i, ip12, si[12]);
and_array a13(deger2_i[13], deger1_i, ip13, si[13]);
and_array a14(deger2_i[14], deger1_i, ip14, si[14]);
and_array a15(deger2_i[15], deger1_i, ip15, si[15]);
and_array a16(deger2_i[16], deger1_i, ip16, si[16]);
and_array a17(deger2_i[17], deger1_i, ip17, si[17]);
and_array a18(deger2_i[18], deger1_i, ip18, si[18]);
and_array a19(deger2_i[19], deger1_i, ip19, si[19]);
and_array a20(deger2_i[20], deger1_i, ip20, si[20]);
and_array a21(deger2_i[21], deger1_i, ip21, si[21]);
and_array a22(deger2_i[22], deger1_i, ip22, si[22]);
and_array a23(deger2_i[23], deger1_i, ip23, si[23]);
and_array a24(deger2_i[24], deger1_i, ip24, si[24]);
and_array a25(deger2_i[25], deger1_i, ip25, si[25]);
and_array a26(deger2_i[26], deger1_i, ip26, si[26]);
and_array a27(deger2_i[27], deger1_i, ip27, si[27]);
and_array a28(deger2_i[28], deger1_i, ip28, si[28]);
and_array a29(deger2_i[29], deger1_i, ip29, si[29]);
and_array a30(deger2_i[30], deger1_i, ip30, si[30]);
and_array a31(deger2_i[31], deger1_i, ip31, si[31]);
//eight
wire niip32;
and_array I8(deger2_i[32], deger1_i, iip[31:0], niip32);
not I9(iip[32], niip32);

xor I10(ip32[0],deger2_i[32],iip[0]);
xor I11(ip32[1],deger2_i[32],iip[1]);
xor I12(ip32[2],deger2_i[32],iip[2]);
xor I13(ip32[3],deger2_i[32],iip[3]);
xor I14(ip32[4],deger2_i[32],iip[4]);
xor I15(ip32[5],deger2_i[32],iip[5]);
xor I16(ip32[6],deger2_i[32],iip[6]);

xor (ip32[7 ],deger2_i[32],iip[7 ]);
xor (ip32[8 ],deger2_i[32],iip[8 ]);
xor (ip32[9 ],deger2_i[32],iip[9 ]);
xor (ip32[10],deger2_i[32],iip[10]);
xor (ip32[11],deger2_i[32],iip[11]);
xor (ip32[12],deger2_i[32],iip[12]);
xor (ip32[13],deger2_i[32],iip[13]);
xor (ip32[14],deger2_i[32],iip[14]);
xor (ip32[15],deger2_i[32],iip[15]);
xor (ip32[16],deger2_i[32],iip[16]);
xor (ip32[17],deger2_i[32],iip[17]);
xor (ip32[18],deger2_i[32],iip[18]);
xor (ip32[19],deger2_i[32],iip[19]);
xor (ip32[20],deger2_i[32],iip[20]);
xor (ip32[21],deger2_i[32],iip[21]);
xor (ip32[22],deger2_i[32],iip[22]);
xor (ip32[23],deger2_i[32],iip[23]);
xor (ip32[24],deger2_i[32],iip[24]);
xor (ip32[25],deger2_i[32],iip[25]);
xor (ip32[26],deger2_i[32],iip[26]);
xor (ip32[27],deger2_i[32],iip[27]);
xor (ip32[28],deger2_i[32],iip[28]);
xor (ip32[29],deger2_i[32],iip[29]);
xor (ip32[30],deger2_i[32],iip[30]);
xor (ip32[31],deger2_i[32],iip[31]);

xnor I17(si[32],deger2_i[32],iip[32]);

  
//first adder array
adder_array I18(si[0], ip0, {si[1],ip1}, ip2, s1, c1, sonuc_o[1]);

//second adder array
adder_array I19(si[2], s1, c1, ip3, s2, c2, sonuc_o[2]);

//third adder
adder_array I20(si[3], s2, c2, ip4, s3, c3, sonuc_o[3]);

//fourth adder
adder_array I21(si[4], s3, c3, ip5, s4, c4, sonuc_o[4]);

//fifth adder
adder_array I22(si[5], s4, c4, ip6, s5, c5, sonuc_o[5]);

//sixth adder
adder_array I23(si[6], s5, c5, ip7, s6, c6, sonuc_o[6]);


adder_array aa7 (si[7 ], s6 , c6 , ip8 , s7 , c7 , sonuc_o[7 ]);
adder_array aa8 (si[8 ], s7 , c7 , ip9 , s8 , c8 , sonuc_o[8 ]);
adder_array aa9 (si[9 ], s8 , c8 , ip10, s9 , c9 , sonuc_o[9]);
adder_array aa10(si[10], s9 , c9 , ip11, s10, c10, sonuc_o[10]);
adder_array aa11(si[11], s10, c10, ip12, s11, c11, sonuc_o[11]);
adder_array aa12(si[12], s11, c11, ip13, s12, c12, sonuc_o[12]);
adder_array aa13(si[13], s12, c12, ip14, s13, c13, sonuc_o[13]);
adder_array aa14(si[14], s13, c13, ip15, s14, c14, sonuc_o[14]);
adder_array aa15(si[15], s14, c14, ip16, s15, c15, sonuc_o[15]);
adder_array aa16(si[16], s15, c15, ip17, s16, c16, sonuc_o[16]);
adder_array aa17(si[17], s16, c16, ip18, s17, c17, sonuc_o[17]);
adder_array aa18(si[18], s17, c17, ip19, s18, c18, sonuc_o[18]);
adder_array aa19(si[19], s18, c18, ip20, s19, c19, sonuc_o[19]);
adder_array aa20(si[20], s19, c19, ip21, s20, c20, sonuc_o[20]);
adder_array aa21(si[21], s20, c20, ip22, s21, c21, sonuc_o[21]);
adder_array aa22(si[22], s21, c21, ip23, s22, c22, sonuc_o[22]);
adder_array aa23(si[23], s22, c22, ip24, s23, c23, sonuc_o[23]);
adder_array aa24(si[24], s23, c23, ip25, s24, c24, sonuc_o[24]);
adder_array aa25(si[25], s24, c24, ip26, s25, c25, sonuc_o[25]);
adder_array aa26(si[26], s25, c25, ip27, s26, c26, sonuc_o[26]);
adder_array aa27(si[27], s26, c26, ip28, s27, c27, sonuc_o[27]);
adder_array aa28(si[28], s27, c27, ip29, s28, c28, sonuc_o[28]);
adder_array aa29(si[29], s28, c28, ip30, s29, c29, sonuc_o[29]);
adder_array aa30(si[30], s29, c29, ip31, s30, c30, sonuc_o[30]);
adder_array aa31(si[31], s30, c30, ip32, s31, c31, sonuc_o[31]);  
//seventh adder
FA I24(s31[0],c31[0],deger2_i[32], c32[0],sonuc_o[32]);
FA I25(s31[1],c31[1],c32[0],c32[1],sonuc_o[33]);
FA I26(s31[2],c31[2],c32[1],c32[2],sonuc_o[34]);
FA I27(s31[3],c31[3],c32[2],c32[3],sonuc_o[35]);
FA I28(s31[4],c31[4],c32[3],c32[4],sonuc_o[36]);
FA I29(s31[5],c31[5],c32[4],c32[5],sonuc_o[37]);
FA I30(s31[6],c31[6],c32[5],c32[6],sonuc_o[38]);

FA fa7 (s31[7 ],c31[7 ],c32[6 ],c32[7 ],sonuc_o[39]);
FA fa8 (s31[8 ],c31[8 ],c32[7 ],c32[8 ],sonuc_o[40]);
FA fa9 (s31[9 ],c31[9 ],c32[8 ],c32[9 ],sonuc_o[41]);
FA fa10(s31[10],c31[10],c32[9 ],c32[10],sonuc_o[42]);
FA fa11(s31[11],c31[11],c32[10],c32[11],sonuc_o[43]);
FA fa12(s31[12],c31[12],c32[11],c32[12],sonuc_o[44]);
FA fa13(s31[13],c31[13],c32[12],c32[13],sonuc_o[45]);
FA fa14(s31[14],c31[14],c32[13],c32[14],sonuc_o[46]);
FA fa15(s31[15],c31[15],c32[14],c32[15],sonuc_o[47]);
FA fa16(s31[16],c31[16],c32[15],c32[16],sonuc_o[48]);
FA fa17(s31[17],c31[17],c32[16],c32[17],sonuc_o[49]);
FA fa18(s31[18],c31[18],c32[17],c32[18],sonuc_o[50]);
FA fa19(s31[19],c31[19],c32[18],c32[19],sonuc_o[51]);
FA fa20(s31[20],c31[20],c32[19],c32[20],sonuc_o[52]);
FA fa21(s31[21],c31[21],c32[20],c32[21],sonuc_o[53]);
FA fa22(s31[22],c31[22],c32[21],c32[22],sonuc_o[54]);
FA fa23(s31[23],c31[23],c32[22],c32[23],sonuc_o[55]);
FA fa24(s31[24],c31[24],c32[23],c32[24],sonuc_o[56]);
FA fa25(s31[25],c31[25],c32[24],c32[25],sonuc_o[57]);
FA fa26(s31[26],c31[26],c32[25],c32[26],sonuc_o[58]);
FA fa27(s31[27],c31[27],c32[26],c32[27],sonuc_o[59]);
FA fa28(s31[28],c31[28],c32[27],c32[28],sonuc_o[60]);
FA fa29(s31[29],c31[29],c32[28],c32[29],sonuc_o[61]);
FA fa30(s31[30],c31[30],c32[29],c32[30],sonuc_o[62]);
FA fa31(s31[31],c31[31],c32[30],c32[31],sonuc_o[63]);

FA I31(si[32],c31[32],c32[31],c32[32],sonuc_o[64]);

xor I32(sonuc_o[65],1'b1,c32[32]);

endmodule




module HA(a,b,c,s);
input a,b;
  
output c,s;

and I0(c,a,b);
xor I1(s,a,b);
endmodule

module FA(a,b,c,cy,sm);
input a,b,c;
  
output cy,sm;
  
wire x,y,z;
  
HA I0(a,b,x,z);
HA I1(z,c,y,sm);
or I2(cy,x,y);
endmodule

module and_array(y, x, ip, si);
input y;
input [32:0] x;
  
output [31:0] ip;
output si;
  
and I0(ip[0],y,x[0]);
and I1(ip[1],y,x[1]);
and I2(ip[2],y,x[2]);
and I3(ip[3],y,x[3]);
and I4(ip[4],y,x[4]);
and I5(ip[5],y,x[5]);
and I6(ip[6],y,x[6]);

and (ip[7 ],y,x[7 ]);
and (ip[8 ],y,x[8 ]);
and (ip[9 ],y,x[9 ]);
and (ip[10],y,x[10]);
and (ip[11],y,x[11]);
and (ip[12],y,x[12]);
and (ip[13],y,x[13]);
and (ip[14],y,x[14]);
and (ip[15],y,x[15]);
and (ip[16],y,x[16]);
and (ip[17],y,x[17]);
and (ip[18],y,x[18]);
and (ip[19],y,x[19]);
and (ip[20],y,x[20]);
and (ip[21],y,x[21]);
and (ip[22],y,x[22]);
and (ip[23],y,x[23]);
and (ip[24],y,x[24]);
and (ip[25],y,x[25]);
and (ip[26],y,x[26]);
and (ip[27],y,x[27]);
and (ip[28],y,x[28]);
and (ip[29],y,x[29]);
and (ip[30],y,x[30]);
and (ip[31],y,x[31]);

nand I7(si,  y,x[32]);
endmodule

module adder_array(si, s1, c1, ip, s2, c2, p);
input si;
input [31:0] s1;
input [32:0] c1;
input [31:0] ip;

output [31:0] s2;
output [32:0] c2;
output p;

HA I0(s1[0],c1[0],      c2[0],p);
FA I1(s1[1],c1[1],ip[0],c2[1],s2[0]);
FA I2(s1[2],c1[2],ip[1],c2[2],s2[1]);
FA I3(s1[3],c1[3],ip[2],c2[3],s2[2]);
FA I4(s1[4],c1[4],ip[3],c2[4],s2[3]);
FA I5(s1[5],c1[5],ip[4],c2[5],s2[4]);
FA I6(s1[6],c1[6],ip[5],c2[6],s2[5]);

FA f7 (s1[7 ],c1[7 ],ip[6 ],c2[7 ],s2[6 ]);
FA f8 (s1[8 ],c1[8 ],ip[7 ],c2[8 ],s2[7 ]);
FA f9 (s1[9 ],c1[9 ],ip[8 ],c2[9 ],s2[8 ]);
FA f10(s1[10],c1[10],ip[9 ],c2[10],s2[9 ]);
FA f11(s1[11],c1[11],ip[10],c2[11],s2[10]);
FA f12(s1[12],c1[12],ip[11],c2[12],s2[11]);
FA f13(s1[13],c1[13],ip[12],c2[13],s2[12]);
FA f14(s1[14],c1[14],ip[13],c2[14],s2[13]);
FA f15(s1[15],c1[15],ip[14],c2[15],s2[14]);
FA f16(s1[16],c1[16],ip[15],c2[16],s2[15]);
FA f17(s1[17],c1[17],ip[16],c2[17],s2[16]);
FA f18(s1[18],c1[18],ip[17],c2[18],s2[17]);
FA f19(s1[19],c1[19],ip[18],c2[19],s2[18]);
FA f20(s1[20],c1[20],ip[19],c2[20],s2[19]);
FA f21(s1[21],c1[21],ip[20],c2[21],s2[20]);
FA f22(s1[22],c1[22],ip[21],c2[22],s2[21]);
FA f23(s1[23],c1[23],ip[22],c2[23],s2[22]);
FA f24(s1[24],c1[24],ip[23],c2[24],s2[23]);
FA f25(s1[25],c1[25],ip[24],c2[25],s2[24]);
FA f26(s1[26],c1[26],ip[25],c2[26],s2[25]);
FA f27(s1[27],c1[27],ip[26],c2[27],s2[26]);
FA f28(s1[28],c1[28],ip[27],c2[28],s2[27]);
FA f29(s1[29],c1[29],ip[28],c2[29],s2[28]);
FA f30(s1[30],c1[30],ip[29],c2[30],s2[29]);
FA f31(s1[31],c1[31],ip[30],c2[31],s2[30]);
FA I7(si,   c1[32],ip[31],c2[32],s2[31]);

endmodule





module carpma_birimi (
    input  wire        clk_i,
    input  wire [ 1:0] kontrol,
    input  wire [31:0] deger1_i,
    input  wire [31:0] deger2_i,
    output reg         bitti,
    output reg  [31:0] sonuc_o
);
    wire [65:0] sonuc;
    reg isaretli;

    reg [32:0] deger1;
    reg [32:0] deger2;
    always @(*) begin
        bitti <= 1'b1; // suanlik carpma kombinasyonel.

        case(kontrol)
        `CARPMA_MUL: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {deger2_i[31],deger2_i};
            isaretli = 1'b1;
            sonuc_o  = sonuc[31:0];
            sonuc_o  = sonuc[63:32];
        end
        `CARPMA_MULH: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {deger2_i[31],deger2_i};
            isaretli = 1'b1;
            sonuc_o  = sonuc[63:32];
        end
        `CARPMA_MULHU: begin
            deger1   = {1'b0,deger1_i};
            deger2   = {1'b0,deger2_i};
            isaretli = 1'b0;
            sonuc_o  = sonuc[63:32];
        end
        `CARPMA_MULHSU: begin
            deger1   = {deger1_i[31],deger1_i};
            deger2   = {1'b0,deger2_i};
            isaretli = 1'b1;
            sonuc_o  = sonuc[63:32];
        end
        endcase
    end

    wallace wall (
        .carpilan_i(deger1),
        .carpan_i(deger2),
        .sonuc_o(sonuc)
    );

endmodule

