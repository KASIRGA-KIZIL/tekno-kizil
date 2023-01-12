`timescale 1ns/1ps

module conv(
    input [31:0] src_reg1_val,
    input [31:0] src_reg2_val,
    input [0:0] load_w,
    input [0:0] load_x,
    input [0:0] clr_w,
    input [0:0] clr_x,
    input [0:0] rs2_enable,
    input [0:0] run,
    output reg[31:0] dst_reg_val,
    output reg[0:0] w_full,
    output reg[0:0] x_full,
    output reg[0:0] w_empty,
    output reg[0:0] x_empty,
    output reg[0:0] exception
);
    reg [31:0] weight [15:0];
    reg [4:0] weight_ptr;
    reg [31:0] data [15:0];
    reg [4:0] data_ptr;

    assign w_full = weight_ptr == 5'd16;
    assign x_full = data_ptr == 5'd16;
    assign w_empty = !(|weight_ptr);
    assign x_empty = !(|data_ptr);


    //burdaki ifler case'e dönüştürülebilir.
    always@*begin
        if(load_w)begin
            weight[weight_ptr] = src_reg1_val;
            weight_ptr = weight_ptr + 1;
            if(rs2_enable)begin
                weight[weight_ptr] = src_reg2_val;
                weight_ptr = weight_ptr + 1;
            end
        end
        if(clr_w)begin
            for(int i = 0; i < 16; i++)begin
                weight[i] = 0;
                weight_ptr = 0;
            end
        end
        if(load_x)begin
            data[data_ptr] = src_reg1_val;
            data_ptr = data_ptr + 1;
            if(rs2_enable)begin
                data[data_ptr] = src_reg2_val;
                data_ptr = data_ptr + 1;
            end
        end
        if(clr_x)begin
            for(int i = 0; i < 16; i++)begin
                data[i] = 0;
                data_ptr = 0;
            end
        end
        if(run)begin
            dst_reg_val = 0;
            for(int i=0;i<16;i++)begin
                dst_reg_val = dst_reg_val + weight[i] * data[i];
            end
            if(weight_ptr != data_ptr)begin
                exception = 1;
            end
        end
    end
endmodule