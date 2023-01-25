`timescale 1ns / 1ps

`include "tanimlamalar.vh"
`define ATLAMAMALIYDI 2'd0
`define ATLAMALIYDI   2'd1
`define SORUN_YOK     2'd2

// Modul taniminda sinyallerin nereden geldigi isminde ddb_ -> denetim durum biriminden gelen/giden sinyal
// cyo_l1b_adr -> hem coze hem l1b'ye giden sinyal
module getir (
        input  wire clk_i,
        input  wire rst_i,

        //  Denetim Durum Birimi
        input  wire ddb_durdur_i,
        input  wire ddb_bosalt_i,
        output wire ddb_hazir_o,
        output reg  ddb_yanlis_tahmin_o,

        //  L1 Buyruk Onbellegi
        input  wire        l1b_bekle_i,
        input  wire [31:0] l1b_deger_i,
        output wire        l1b_chip_select_n_o,

        // Yurut
        input wire        yrt_atlanan_ps_gecerli_i,
        input wire [31:1] yrt_atlanan_ps_i,

        // Coz Yazmacoku
        output reg  [31:0] cyo_buyruk_o,
        output reg  [31:0] cyo_ps_artmis_o,

        // Coz ve L1 Buyruk Onbellegi
        output wire [31:1] cyo_l1b_ps_o
    );

    reg  [15:0] buyruk_tamponu;
    reg  [31:1] ps;
    reg  [31:1] ps_next;
    reg  [31:1] ps_artmis;
    wire [31:1] ongorulen_ps;
    wire [31:1] yrt_ps;
    reg  [31:0] buyruk_genis;
    wire [ 1:0] hata_duzelt;
    wire        yrt_buyruk_ctipi;
    wire        ongorulen_ps_gecerli;
    reg         tahmin_et;
    reg         parcaparca;
    reg         parcaparca_next;

    wire buyruk_hizali = ~ps[1]; // ps 4un kat mi

    wire buyruk_ctipi = buyruk_hizali ? ~(l1b_deger_i   [ 1: 0] == 2'b11) :
                                        ~(buyruk_tamponu[ 1: 0] == 2'b11);
    always @(*) begin
        case(l1b_deger_i[6:2])
            5'b11000: begin tahmin_et = 1'b1; end // B-tipi
            5'b11011: begin tahmin_et = 1'b1; end // jal
            5'b00101: begin tahmin_et = 1'b1; end // auipc // add upper immediate to pc // tahmin et
            default:  begin tahmin_et = 1'b0; end
        endcase
    end

    dallanma_ongorucu do(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .ddb_durdur_i(ddb_durdur_i),
        // Tahmin okuma.
        .ps_i                  (ps),
        .buyruk_ctipi_i        (buyruk_ctipi),
        .tahmin_et_i           (tahmin_et),
        .ongorulen_ps_o        (ongorulen_ps),
        .ongorulen_ps_gecerli_o(ongorulen_ps_gecerli),
        // Kalibrasyon sinyalleri
        .atlanan_ps_i          (yrt_atlanan_ps_i),
        .atlanan_ps_gecerli_i  (yrt_atlanan_ps_gecerli_i),
        // hata duzeltme
        .hata_duzelt_o         (hata_duzelt),
        .yrt_ps_o              (yrt_ps),
        .yrt_buyruk_ctipi_o    (yrt_buyruk_ctipi)
    );

    reg bufferdan_okuyor_next;
    reg bufferdan_okuyor;
    always @(*) begin
        ddb_yanlis_tahmin_o = 1'b0;
        if(buyruk_ctipi) begin
            ps_artmis = ps + 1; // son bit yok b10  -> b1  oluyor.
        end else begin
            ps_artmis = ps + 2; // son bit yok b100 -> b10 oluyor.
        end
        case(hata_duzelt)
            `ATLAMALIYDI: begin
                ps_next = yrt_atlanan_ps_i;
                ddb_yanlis_tahmin_o = 1'b1;
            end
            `ATLAMAMALIYDI: begin
                ddb_yanlis_tahmin_o = 1'b1;
                if(yrt_buyruk_ctipi) begin
                    ps_next = yrt_ps + 1; // son bit yok 10 -> 1 oluyor.
                end else begin
                    ps_next = yrt_ps + 2; // son bit yok 100 ->10 oluyor.
                end
            end
            default: begin
                if(tahmin_et && ongorulen_ps_gecerli) begin
                    ps_next = ongorulen_ps;
                end else begin
                    if(~bufferdan_okuyor)begin
                        ps_next = ps_artmis;
                    end
                end
            end
        endcase
    end


    `ifdef SIMULATION
        reg [88*13:1] hizali_durum_str;
        reg [88*13:1] ctipi_coz_str;
    `endif

    reg getir_hazir_next;
    reg getir_hazir;
    reg [31:0] cyo_buyruk_next;
    always @(*) begin
        getir_hazir_next     = 1'b1;
        bufferdan_okuyor_next = 1'b0;
        parcaparca_next = 1'b0;
        casex({parcaparca,buyruk_hizali,buyruk_ctipi})
            3'b001: begin
                cyo_buyruk_next = buyruk_genis;
                `ifdef SIMULATION  hizali_durum_str = "[16][??]"; `endif
            end
            3'b010: begin
                cyo_buyruk_next = l1b_deger_i;
                `ifdef SIMULATION  hizali_durum_str = "[32_1][32_0]"; `endif
            end
            3'b011: begin
                cyo_buyruk_next = buyruk_genis;
                `ifdef SIMULATION  hizali_durum_str = "[??][16]"; `endif
            end
            3'b000: begin
                cyo_buyruk_next = 32'hxxxx_xxxx;
                getir_hazir_next     = 1'b0;
                parcaparca_next = 1'b1;
                `ifdef SIMULATION  hizali_durum_str = "[32_0][????]"; `endif
            end
            3'b1?0: begin
                cyo_buyruk_next = {l1b_deger_i[15:0], buyruk_tamponu};
                parcaparca_next = 1'b1;
                `ifdef SIMULATION  hizali_durum_str = "[32_0][32_1]"; `endif
            end
            3'b1?1: begin
                cyo_buyruk_next = buyruk_genis;
                bufferdan_okuyor_next = 1'b1;
                `ifdef SIMULATION  hizali_durum_str = "[16][32_1]"; `endif
            end
        endcase
    end

    assign ddb_hazir_o = ~l1b_bekle_i && getir_hazir;

    wire [15:0] buyruk_16com = buyruk_hizali ? l1b_deger_i[15:0] : buyruk_tamponu;

    always @(buyruk_16com) begin
        casex (buyruk_16com)
            `C_EBREAK   : begin buyruk_genis = {32'h00_10_00_73};                                                                                                                                                                   end  // c.ebreak  -> ebreak
            `C_JR       : begin buyruk_genis = {12'b0, buyruk_16com[11:7], 3'b0, 5'b0, 7'h67};                                                                                                                                      end // c.jr       -> jalr x0, rd/rs1, 0
            `C_JALR     : begin buyruk_genis = {12'b0, buyruk_16com[11:7], 3'b000, 5'b00001, 7'h67};                                                                                                                                end // c.jalr     -> jalr x1, rs1, 0
            `C_NOP      : begin buyruk_genis = {{6 {buyruk_16com[12]}}, buyruk_16com[12], buyruk_16com[6:2], buyruk_16com[11:7], 3'b0, buyruk_16com[11:7], 7'h13};                                                                  end // c.nop      -> addi, 0, 0, 0
            `C_ADDI16SP : begin buyruk_genis = {{3 {buyruk_16com[12]}}, buyruk_16com[4:3], buyruk_16com[5], buyruk_16com[2], buyruk_16com[6], 4'b0, 5'h02, 3'b000, 5'h02, 7'h13};                                                   end // c.addi16sp -> addi x2, x2, nzimm
            `C_AND      : begin buyruk_genis = {7'b0, 2'b01, buyruk_16com[4:2], 2'b01, buyruk_16com[9:7], 3'b111, 2'b01, buyruk_16com[9:7], 7'h33};                                                                                 end // c.and      -> and rd', rd', rs2'
            `C_SUB      : begin buyruk_genis = {2'b01, 5'b0, 2'b01, buyruk_16com[4:2], 2'b01, buyruk_16com[9:7], 3'b000, 2'b01, buyruk_16com[9:7], 7'h33};                                                                          end  // c.sub     -> sub rd', rd', rs2'
            `C_OR       : begin buyruk_genis = {7'b0, 2'b01, buyruk_16com[4:2], 2'b01, buyruk_16com[9:7], 3'b110, 2'b01, buyruk_16com[9:7], 7'h33};                                                                                 end // c.or       -> or  rd', rd', rs2'
            `C_XOR      : begin buyruk_genis = {7'b0, 2'b01, buyruk_16com[4:2], 2'b01, buyruk_16com[9:7], 3'b100, 2'b01, buyruk_16com[9:7], 7'h33};                                                                                 end // c.xor      -> xor rd', rd', rs2'
            `C_SRAI     , // c.srli -> srli rd, rd, shamt // c.srai -> srai rd, rd, shamt
            `C_SRLI     : begin buyruk_genis = {1'b0, buyruk_16com[10], 5'b0, buyruk_16com[6:2], 2'b01, buyruk_16com[9:7], 3'b101, 2'b01, buyruk_16com[9:7], 7'h13};                                                                end
            `C_ANDI     : begin buyruk_genis = {{6 {buyruk_16com[12]}}, buyruk_16com[12], buyruk_16com[6:2], 2'b01, buyruk_16com[9:7], 3'b111, 2'b01, buyruk_16com[9:7], 7'h13};                                                    end // c.andi     -> andi rd,     rd, imm
            `C_MV       : begin buyruk_genis = {7'b0, buyruk_16com[6:2], 5'b0, 3'b0, buyruk_16com[11:7], 7'h33};                                                                                                                    end // c.mv       -> add  rd/rs1, x0, rs2
            `C_SLLI     : begin buyruk_genis = {7'b0, buyruk_16com[6:2], buyruk_16com[11:7], 3'b001, buyruk_16com[11:7], 7'h13};                                                                                                    end // c.slli     -> slli rd,     rd, shamt
            `C_ADD      : begin buyruk_genis = {7'b0, buyruk_16com[6:2], buyruk_16com[11:7], 3'b0, buyruk_16com[11:7], 7'h33};                                                                                                      end // c.add      -> add  rd,     rd, rs2
            `C_ADDI     : begin buyruk_genis = {{6 {buyruk_16com[12]}}, buyruk_16com[12], buyruk_16com[6:2], buyruk_16com[11:7], 3'b0, buyruk_16com[11:7], 7'h13};                                                                  end // c.addi     -> addi rd,     rd, nzimm
            `C_ADDI4SPN : begin buyruk_genis = {2'b0, buyruk_16com[10:7], buyruk_16com[12:11], buyruk_16com[5], buyruk_16com[6], 2'b00, 5'h02, 3'b000, 2'b01, buyruk_16com[4:2], 7'h13};                                            end // c.addi4spn -> addi rd',    x2, nzuimm
            `C_BEQZ     , // c.beqz -> beq rs1', x0, imm // c.bnez -> bne rs1', x0, imm
            `C_BNEZ     : begin buyruk_genis = {{4 {buyruk_16com[12]}}, buyruk_16com[6:5], buyruk_16com[2], 5'b0, 2'b01, buyruk_16com[9:7], 2'b00, buyruk_16com[13], buyruk_16com[11:10], buyruk_16com[4:3], buyruk_16com[12], 7'h63};         end
            `C_J        , // c.jal -> jal x1, imm // c.j   -> jal x0, imm
            `C_JAL      : begin buyruk_genis = {buyruk_16com[12], buyruk_16com[8], buyruk_16com[10:9], buyruk_16com[6], buyruk_16com[7], buyruk_16com[2], buyruk_16com[11], buyruk_16com[5:3], {9 {buyruk_16com[12]}}, 4'b0, ~buyruk_16com[15], 7'h6f};end
            `C_LI       : begin buyruk_genis = {{6 {buyruk_16com[12]}}, buyruk_16com[12], buyruk_16com[6:2], 5'b0, 3'b0, buyruk_16com[11:7], 7'h13};                                                                                                   end // c.li   -> addi  rd ,   x0, imm
            `C_LUI      : begin buyruk_genis = {{15 {buyruk_16com[12]}}, buyruk_16com[6:2], buyruk_16com[11:7], 7'h37};                                                                                                                                end // c.lui  -> lui   rd ,  nzimm
            `C_LW       : begin buyruk_genis = {5'b0, buyruk_16com[5], buyruk_16com[12:10], buyruk_16com[6], 2'b00, 2'b01, buyruk_16com[9:7], 3'b010, 2'b01, buyruk_16com[4:2], 7'h03};                                                                end // c.lw   -> lw    rd',   uimm(rs1')
            `C_LWSP     : begin buyruk_genis = {4'b0, buyruk_16com[3:2], buyruk_16com[12], buyruk_16com[6:4], 2'b00, 5'h02, 3'b010, buyruk_16com[11:7], 7'h03};                                                                                        end // c.lwsp -> lw    rd ,   uimm(x2)
            `C_SW       : begin buyruk_genis = {5'b0, buyruk_16com[5], buyruk_16com[12], 2'b01, buyruk_16com[4:2], 2'b01, buyruk_16com[9:7], 3'b010, buyruk_16com[11:10], buyruk_16com[6], 2'b00, 7'h23};                                              end // c.sw   -> sw   rs2',   uimm(rs1')
            `C_SWSP     : begin buyruk_genis = {4'b0, buyruk_16com[8:7], buyruk_16com[12], buyruk_16com[6:2], 5'h02, 3'b010, buyruk_16com[11:9], 2'b00, 7'h23};                                                                                        end // c.swsp -> sw   rs2 ,   uimm(x2)
            default     : begin
                buyruk_genis = 32'hxxxx_xxxx;
            end
        endcase
    end

    `ifdef SIMULATION
        always @(buyruk_16com,buyruk_ctipi) begin
            casex (buyruk_16com)
                `C_EBREAK   : begin ctipi_coz_str = "`C_EBREAK   ";                                             end  // c.ebreak  -> ebreak
                `C_JR       : begin ctipi_coz_str = "`C_JR       ";                                             end // c.jr       -> jalr x0, rd/rs1, 0
                `C_JALR     : begin ctipi_coz_str = "`C_JALR     ";                                             end // c.jalr     -> jalr x1, rs1, 0
                `C_NOP      : begin ctipi_coz_str = "`C_NOP      ";                                             end // c.nop      -> addi, 0, 0, 0
                `C_ADDI16SP : begin ctipi_coz_str = "`C_ADDI16SP ";                                             end // c.addi16sp -> addi x2, x2, nzimm
                `C_AND      : begin ctipi_coz_str = "`C_AND      ";                                             end // c.and      -> and rd', rd', rs2'
                `C_SUB      : begin ctipi_coz_str = "`C_SUB      ";                                             end  // c.sub     -> sub rd', rd', rs2'
                `C_OR       : begin ctipi_coz_str = "`C_OR       ";                                             end // c.or       -> or  rd', rd', rs2'
                `C_XOR      : begin ctipi_coz_str = "`C_XOR      ";                                             end // c.xor      -> xor rd', rd', rs2'
                `C_SRAI     , // c.srli -> srli rd, rd, shamt // c.srai -> srai rd, rd, shamt
                `C_SRLI     : begin ctipi_coz_str = "`C_SRLI     ";                                        end
                `C_ANDI     : begin ctipi_coz_str = "`C_ANDI     ";                                        end // c.andi     -> andi rd,     rd, imm
                `C_MV       : begin ctipi_coz_str = "`C_MV       ";                                        end // c.mv       -> add  rd/rs1, x0, rs2
                `C_SLLI     : begin ctipi_coz_str = "`C_SLLI     ";                                        end // c.slli     -> slli rd,     rd, shamt
                `C_ADD      : begin ctipi_coz_str = "`C_ADD      ";                                        end // c.add      -> add  rd,     rd, rs2
                `C_ADDI     : begin ctipi_coz_str = "`C_ADDI     ";                                        end // c.addi     -> addi rd,     rd, nzimm
                `C_ADDI4SPN : begin ctipi_coz_str = "`C_ADDI4SPN ";                                        end // c.addi4spn -> addi rd',    x2, nzuimm
                `C_BEQZ     , // c.beqz -> beq rs1', x0, imm // c.bnez -> bne rs1', x0, imm
                `C_BNEZ     : begin ctipi_coz_str = "`C_BNEZ     ";                                 end
                `C_J        , // c.jal -> jal x1, imm  // c.j   ->  jal x0, imm
                `C_JAL      : begin ctipi_coz_str = "`C_JAL      ";                                        end
                `C_LI       : begin ctipi_coz_str = "`C_LI       ";                                        end // c.li   -> addi  rd ,   x0, imm
                `C_LUI      : begin ctipi_coz_str = "`C_LUI      ";                                        end // c.lui  -> lui   rd ,  nzimm
                `C_LW       : begin ctipi_coz_str = "`C_LW       ";                                        end // c.lw   -> lw    rd',   uimm(rs1')
                `C_LWSP     : begin ctipi_coz_str = "`C_LWSP     ";                                        end // c.lwsp -> lw    rd ,   uimm(x2)
                `C_SW       : begin ctipi_coz_str = "`C_SW       ";                                        end // c.sw   -> sw   rs2',   uimm(rs1')
                `C_SWSP     : begin ctipi_coz_str = "`C_SWSP     ";                                        end // c.swsp -> sw   rs2 ,   uimm(x2)
                default     : begin ctipi_coz_str = "C_DEFAULT";                                             end
            endcase
            if(~buyruk_ctipi)
                ctipi_coz_str = "Ctipi degil";

            // $monitor("%s",ctipi_coz_str);
        end
    `endif

    assign cyo_l1b_ps_o = ps;

    always @(posedge clk_i) begin
        if (rst_i || ddb_bosalt_i) begin
            ps              <= 0;
            cyo_buyruk_o    <= 0;
            parcaparca      <= 0;
            buyruk_tamponu  <= 0;
            bufferdan_okuyor<= 0;
            getir_hazir     <= 1;
        end
        else if(~ddb_durdur_i)begin
            getir_hazir    <= getir_hazir_next;
            bufferdan_okuyor <= bufferdan_okuyor_next;
            ps             <= ps_next;
            cyo_buyruk_o   <= cyo_buyruk_next;
            parcaparca     <= parcaparca_next;
            buyruk_tamponu <= l1b_deger_i[31:16];
            cyo_ps_artmis_o<= ps_artmis;
        end
    end

endmodule
