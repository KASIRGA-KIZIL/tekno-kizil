`timescale 1ns / 1ps

`define FIFO_DEPTH 32

// cevrim bir gec geliyor
module spi_denetleyici (
    input clk_i,
    input rst_i,

    input  [31:0] wb_adres_i,
    output [31:0] wb_oku_veri_o,
    output        wb_oku_hazir_o, // =valid.
    input  [31:0] wb_yaz_veri_i,
    input         wb_yaz_etkin_i,
    input         wb_gecerli_i,
    output        wb_mesgul_o,

    // spi i/o
    input  spi_miso_i,
    output spi_mosi_o,
    output spi_cs_o,
    output spi_sck_o
    );

    wire rst_g = ~rst_i;

    reg [31:0] miso_buffer [7:0];
    reg [31:0] miso_buffer_next [7:0];
    reg [3:0] miso_tail, miso_tail_next;

    reg [31:0] mosi_buffer [7:0];
    reg [31:0] mosi_buffer_next [7:0];
    reg [3:0] mosi_tail, mosi_tail_next;

    reg [31:0] spi_ctrl, spi_ctrl_next;


    reg [`FIFO_DEPTH-1:0]  spi_rdata, spi_rdata_next; // fifo in

    reg [`FIFO_DEPTH:0]  spi_wdata, spi_wdata_next; // fifo out


    reg [13:0] spi_cmd, spi_cmd_next;

    // Kontrol Sinyalleri
    wire spi_en;
    assign spi_en = spi_ctrl[0];

    wire spi_rst;
    assign spi_rst = spi_ctrl[1];

    wire cpha;
    assign cpha = spi_ctrl[2];

    wire cpol;
    assign cpol = spi_ctrl[3];

    wire [15:0] sck_div;
    assign sck_div = spi_ctrl[31:16];

    wire [8:0] lenght;
    assign lenght = spi_cmd[8:0] << 3;

    wire cs_active;
    assign cs_active = spi_cmd[9];


    wire miso_en;
    assign miso_en = spi_cmd[12];

    wire mosi_en;
    assign mosi_en = spi_cmd[13];

    wire mosi_full;
    assign mosi_full = (mosi_tail == 4'd8); // spi_status[0];

    wire miso_full;
    assign miso_full = (miso_tail == 4'd8); // spi_status[1];

    wire mosi_empty;
    assign mosi_empty = (mosi_tail == 4'd0); // spi_status[2];

    wire miso_empty;
    assign miso_empty = (miso_tail == 4'd0); // spi_status[3]; //(wb_adres_i[4:0] == STATUS) ? 1'b0 :



    localparam [5:0]
       CTRL = 5'h00,
       STATUS = 5'h04,
       RDATA = 5'h08,
       WDATA = 5'h0c,
       CMD = 5'h10;


    localparam [2:0]
       IDLE = 3'b001,
       WRITE = 3'b010,
       READ = 3'b100;

    reg r_cs, r_cs_next;
    reg r_sck, r_sck_next;
    reg r_spi_sr, r_spi_sr_next;

    reg [2:0] state, state_next;
    reg [15:0] clock_ctr, clock_ctr_next;
    reg [8:0] bit_ctr, bit_ctr_next;
    reg [8:0] flow_ctr, flow_ctr_next;
    reg valid, valid_next;
    reg busy, busy_next;

    assign spi_cs_o = r_cs;
    assign spi_sck_o = r_spi_sr;
    assign spi_mosi_o = spi_wdata[32];
    assign wb_oku_veri_o = spi_rdata;
    assign wb_mesgul_o = busy;
    assign wb_oku_hazir_o = valid;


    integer loop_counter;
    always@* begin
        for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
            miso_buffer_next[loop_counter] = miso_buffer[loop_counter];
        end
        miso_tail_next = miso_tail;
        for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
            mosi_buffer_next[loop_counter] = mosi_buffer[loop_counter];
        end
        mosi_tail_next = mosi_tail;
        spi_ctrl_next = spi_ctrl;
        spi_rdata_next = spi_rdata;
        spi_wdata_next = spi_wdata;
        spi_cmd_next = spi_cmd;

        r_cs_next = r_cs;
        r_sck_next = r_sck;
        r_spi_sr_next = r_sck;
        state_next = state;
        clock_ctr_next = clock_ctr;
        bit_ctr_next = bit_ctr;
        flow_ctr_next = flow_ctr;
        valid_next = valid;
        busy_next = busy;


        if(clock_ctr > 0) begin
            clock_ctr_next  = clock_ctr - 16'd1;
        end
        else if((clock_ctr == 16'd0)) begin
            valid_next = 1'b0;
            case(state)

            IDLE: // IDLE: Kontrol yazmaclarina deger atama kismi burasi, her cycle yazmac degerlerine gore seri iletim gerceklesicek
            begin
                if(spi_en && mosi_en && (!miso_en)) begin // si -> yaz
                    clock_ctr_next = sck_div;
                    bit_ctr_next = (lenght > 9'd32) ? 9'd32 : lenght;
                    flow_ctr_next = (lenght > 9'd32) ? (lenght - 9'd32) : 9'd0;
                    state_next = WRITE;

                    spi_wdata_next = {1'b0, mosi_buffer[0]};
                    r_sck_next = cpol;
                    r_cs_next = 1'b0;
                end
                else if(spi_en && miso_en && (!mosi_en)) begin // so -> oku
                    clock_ctr_next = sck_div;
                    bit_ctr_next = (lenght > 9'd32) ? 9'd32 : lenght;
                    flow_ctr_next = (lenght - 9'd32) ? (lenght - 9'd32) : 9'd0;
                    state_next = READ;


                    r_sck_next = cpol;
                    r_cs_next = 1'b0;
                end
                else begin
                    clock_ctr_next = 16'd0;
                    state_next = IDLE;

                    r_cs_next = 1'b1;
                    r_sck_next = cpol;
                end
            end

            READ:
            begin
                clock_ctr_next  = sck_div;
                // spi_cmd_next[12] = 1'b0;
                spi_ctrl_next[0] = 1'b0;
                if(bit_ctr == 16'd0) begin
                    miso_buffer_next[miso_tail-1] = spi_rdata;
                    miso_tail_next = miso_tail + 4'd1;
                    if(flow_ctr > 9'd0) begin
                        bit_ctr_next = (flow_ctr > 9'd32) ? 9'd32 : flow_ctr;
                        clock_ctr_next  = sck_div;
                        flow_ctr_next = (flow_ctr > 9'd32) ? (flow_ctr - 9'd32) : 9'd0;
                        state_next = READ;
                    end
                    else begin
                       state_next = IDLE;
                       clock_ctr_next = 16'd0;

                       r_cs_next = cs_active ? 1'b0 : 1'b1;
                       r_sck_next  = 1'b0;
                    end
                end
                else begin
                    r_sck_next  = ~r_sck_next;
                    state_next = READ;
                    if(!r_sck) begin
                        bit_ctr_next    = bit_ctr - 16'd1;
                        spi_rdata_next       = {spi_rdata[`FIFO_DEPTH-2:0], spi_miso_i};
                    end
                end
            end

            WRITE:
            begin
                clock_ctr_next  = sck_div;
                // spi_cmd_next[13] = 1'b0;
                spi_ctrl_next[0] = 1'b0;
                if(bit_ctr == 16'd0) begin
                    mosi_buffer_next[0] = mosi_buffer[1];
                    mosi_buffer_next[1] = mosi_buffer[2];
                    mosi_buffer_next[2] = mosi_buffer[3];
                    mosi_buffer_next[3] = mosi_buffer[4];
                    mosi_buffer_next[4] = mosi_buffer[5];
                    mosi_buffer_next[5] = mosi_buffer[6];
                    mosi_buffer_next[6] = mosi_buffer[7];
                    mosi_buffer_next[7] = 32'd0;

                    mosi_tail_next = mosi_tail - 4'd1;
                    if(flow_ctr > 9'd0) begin
                        clock_ctr_next = sck_div;
                        bit_ctr_next = (flow_ctr > 9'd32) ? 9'd32 : flow_ctr;
                        flow_ctr_next = (flow_ctr > 9'd32) ? (flow_ctr - 9'd32) : 9'd0;
                        state_next = WRITE;

                        spi_wdata_next = {1'b0, mosi_buffer[0]};
                    end
                    else begin
                       state_next = IDLE;
                       clock_ctr_next = 16'd0;

                       r_cs_next = cs_active ? 1'b0 : 1'b1;
                       r_sck_next  = 1'b0;
                    end
                end
                else begin
                    r_sck_next  = ~r_sck_next;
                    state_next = WRITE;
                    if(!r_sck) begin
                        bit_ctr_next = bit_ctr - 16'd1;
                        spi_wdata_next = {spi_wdata[`FIFO_DEPTH-1:0], 1'b0};
                    end
                end
            end
            endcase



            case(wb_adres_i[4:0])

            STATUS: // Sadece okuma yazmaci
            begin
                if(wb_gecerli_i) begin
                    spi_rdata_next = {miso_empty, mosi_empty, miso_full, mosi_full};
                    valid_next = 1'b1;
                end
            end

            CTRL:
            begin
                if(wb_yaz_etkin_i && wb_gecerli_i) begin
                    spi_ctrl_next = wb_yaz_veri_i;// && 32'hFFFF000F;
                    valid_next = 1'b1;
                end
                else if(wb_gecerli_i) begin
                    spi_rdata_next = spi_ctrl;
                    valid_next = 1'b1;
                end
            end

            CMD:
            begin
                if(wb_yaz_etkin_i && wb_gecerli_i) begin
                    spi_cmd_next = wb_yaz_veri_i;//&& 32'h000031FF; // 0011_0011_1111_1111 *********************************** mask yanli
                    valid_next = 1'b1;
                end
                else if(wb_gecerli_i) begin
                    spi_rdata_next = spi_cmd;
                    valid_next = 1'b1;
                end
            end

            RDATA:
            begin
                if(!miso_empty && wb_gecerli_i) begin
                    spi_rdata_next = miso_buffer[0];
                    valid_next = 1'b1;

                    miso_buffer_next[0] = miso_buffer[1];
                    miso_buffer_next[1] = miso_buffer[2];
                    miso_buffer_next[2] = miso_buffer[3];
                    miso_buffer_next[3] = miso_buffer[4];
                    miso_buffer_next[4] = miso_buffer[5];
                    miso_buffer_next[5] = miso_buffer[6];
                    miso_buffer_next[6] = miso_buffer[7];
                    miso_buffer_next[7] = 32'd0;

                    miso_tail_next = miso_tail - 4'd1;
                    valid_next = 1'b1;
                end
                else begin
                    valid_next = 1'b0;
                end
            end

            WDATA:
            begin
                if(!mosi_full && wb_yaz_etkin_i && wb_gecerli_i) begin
                    mosi_buffer_next[(mosi_empty?mosi_tail:(mosi_tail-1))] = wb_yaz_veri_i;
                    mosi_tail_next = mosi_tail + 4'b1;

                    valid_next = 1'b1;
                end
                else begin
                    valid_next = 1'b0;
                end
            end
            endcase

        end


    end

    always@(posedge clk_i) begin
        if(spi_rst || rst_g) begin
            for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
            miso_buffer[loop_counter] <= 32'd0;
            end
            miso_tail <= 4'd0;
            for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
                mosi_buffer[loop_counter] <= 32'd0;
            end
            mosi_tail <= 4'd0;
            spi_ctrl <= 32'd0;
            spi_rdata <= 32'd0;
            spi_wdata <= 33'd0;
            spi_cmd <= 14'd0;

            r_cs <= 1'b1;
            r_sck <= 1'b0;
            r_spi_sr <= 1'b0;
            state <= 3'b001;
            clock_ctr <= 16'd0;
            bit_ctr <= 9'd0;
            flow_ctr <= 9'd0;
            valid <= 1'b0;
            busy <= 1'b0;
        end
        else begin
            for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
            miso_buffer[loop_counter] <= miso_buffer_next[loop_counter];
            end
            miso_tail <= miso_tail_next;
            for(loop_counter=0; loop_counter<8; loop_counter=loop_counter+1) begin
                mosi_buffer[loop_counter] <= mosi_buffer_next[loop_counter];
            end
            mosi_tail <= mosi_tail_next;
            spi_ctrl <= spi_ctrl_next;
            spi_rdata <= spi_rdata_next;
            spi_wdata <= spi_wdata_next;
            spi_cmd <= spi_cmd_next;

            r_cs <= r_cs_next;
            r_sck <= r_sck_next;
            r_spi_sr <= r_spi_sr_next;
            state <= state_next;
            clock_ctr <= clock_ctr_next;
            bit_ctr <= bit_ctr_next;
            flow_ctr <= flow_ctr_next;
            valid <= valid_next;
            busy <= busy_next;
        end

    end

endmodule
