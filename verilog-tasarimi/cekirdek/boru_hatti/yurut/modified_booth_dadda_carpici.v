// modified_booth_dadda_carpici.v
// modified booth carpici eklendi, dadda tree eklenecek
// en son toplam "+" lar ile yapıldı. Dadda tree eklenince buna gerek kalmayacak
`timescale 1ns / 1ps

`include "tanimlamalar.vh"

module modified_booth_dadda_carpici(
input  [31:0] carpilan_i,
input  [31:0] carpan_i,
output reg [63:0] sonuc_o

);

reg [63:0]seviye1_araCarpim_r[15:0];
reg [32:0] carpan_r;
reg [2:0] araCarpici_r;
integer i;
initial begin
    for(i=0;i<16;i=i+1)begin
        seviye1_araCarpim_r[i]=64'd0;
    end
end
always @(*)begin
carpan_r=carpan_i<<1;
for(i=2;i<33;i=i+2) begin
    araCarpici_r=carpan_r[i-:3];
    case(araCarpici_r)
        3'b000:begin
            seviye1_araCarpim_r[(i/2)-1]=64'd0;
        end
        
        3'b001:begin
            seviye1_araCarpim_r[(i/2)-1][(29+i)-:32]=carpilan_i;
        end
        
        3'b010:begin
            seviye1_araCarpim_r[(i/2)-1][(29+i)-:32]=carpilan_i;
        end
        
        3'b011:begin
            seviye1_araCarpim_r[(i/2)-1][(29+i)-:32]=carpilan_i<<1;
        end
        
        3'b100:begin
            seviye1_araCarpim_r[(i/2)-1][(29+i)-:32]=~(carpilan_i<<1)+1;
        end
        
        3'b101:begin
            seviye1_araCarpim_r[(i/2)-1][(29+i)-:32]=~carpilan_i+1;
        end
        
        3'b110:begin
        seviye1_araCarpim_r[(i/2)-1][(29+i)-:32]=~carpilan_i+1;
        end
        
        3'b111:begin
        seviye1_araCarpim_r[(i/2)-1]=64'd0;
        end
        
    endcase
    if(seviye1_araCarpim_r[(i/2)-1][(29+i)]==1)begin
        seviye1_araCarpim_r[(i/2)-1][(30+i)+:(32)]=32'b11111111_11111111_11111111_11111111;
    end
end
    sonuc_o= seviye1_araCarpim_r[0]+ seviye1_araCarpim_r[1]+ seviye1_araCarpim_r[2]+
    seviye1_araCarpim_r[3]+ seviye1_araCarpim_r[4]+ seviye1_araCarpim_r[5]+
    seviye1_araCarpim_r[6]+ seviye1_araCarpim_r[7]+ seviye1_araCarpim_r[8]+
    seviye1_araCarpim_r[9]+ seviye1_araCarpim_r[10]+ seviye1_araCarpim_r[11]+
    seviye1_araCarpim_r[12]+ seviye1_araCarpim_r[13]+ seviye1_araCarpim_r[14]+
    seviye1_araCarpim_r[15];
end
endmodule
