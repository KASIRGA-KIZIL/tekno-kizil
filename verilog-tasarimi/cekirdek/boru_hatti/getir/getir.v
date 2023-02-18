`timescale 1ns / 1ps

`include "tanimlamalar.vh"


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
    output wire [18:2] l1b_adr_o,

    // Yurut
    input wire        yrt_atlanan_ps_gecerli_i,
    input wire [18:1] yrt_atlanan_ps_i,

    // Coz Yazmacoku
    output reg [31:0] cyo_buyruk_o,
    output reg [18:1] cyo_ps_artmis_o,
    output reg [18:1] cyo_ps_o
);


    reg  [31:0] buyruk_tamponu_durdur;
    wire [31:0] suanki_buyruk = l1b_deger_i;

    reg  [15:0] buyruk_tamponu;
    reg  [18:1] ps;
    reg  [18:1] ps_next;
    reg  [18:1] ps_artmis;
    wire [18:1] ongorulen_ps;
    wire [18:1] yrt_ps;
    reg  [31:0] buyruk_genis;
    wire [ 1:0] hata_duzelt;
    wire        yrt_buyruk_ctipi;
    wire        ongorulen_ps_gecerli;
    reg         tahmin_et;
    reg         buyruk_jtipi;
    reg         parcaparca;
    reg         parcaparca_next;

    wire buyruk_hizali = ~ps[1]; // ps 4un kat mi

    wire buyruk_ctipi = buyruk_hizali ? ~(suanki_buyruk [ 1: 0] == 2'b11) :
                                        ~(buyruk_tamponu[ 1: 0] == 2'b11) ;
    always @(*) begin
        buyruk_jtipi = 1'b0;
        tahmin_et    = 1'b0;
        case(suanki_buyruk[6:2])
            5'b11000: begin tahmin_et = 1'b1; end // B-tipi
            5'b11001,
            5'b11011: begin tahmin_et = 1'b1;
                            buyruk_jtipi = 1'b1;
            end // jalr ve jal
            default:  begin tahmin_et = 1'b0; end
        endcase
    end

    dallanma_ongorucu dal_on(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .ddb_durdur_i(ddb_durdur_i),
        // Tahmin okuma.
        .ps_i                  (ps),
        .buyruk_ctipi_i        (buyruk_ctipi),
        .buyruk_jtipi_i        (buyruk_jtipi),
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
            ps_artmis = ps + 18'd1; // son bit yok b10  -> b1  oluyor.
        end else begin
            ps_artmis = ps + 18'd2; // son bit yok b100 -> b10 oluyor.
        end
        case(hata_duzelt)
            `YANLIS_ATLADI: begin
                ps_next = yrt_atlanan_ps_i;
                ddb_yanlis_tahmin_o = 1'b1;
            end
            `ATLAMALIYDI: begin
                ps_next = yrt_atlanan_ps_i;
                ddb_yanlis_tahmin_o = 1'b1;
            end
            `ATLAMAMALIYDI: begin
                ddb_yanlis_tahmin_o = 1'b1;
                if(yrt_buyruk_ctipi) begin
                    ps_next = yrt_ps + 18'd1; // son bit yok 10 -> 1 oluyor.
                end else begin
                    ps_next = yrt_ps + 18'd2; // son bit yok 100 ->10 oluyor.
                end
            end
            default: begin
                if(tahmin_et && ongorulen_ps_gecerli) begin
                    ps_next = ongorulen_ps;
                end else begin
                    if(~bufferdan_okuyor)begin
                        ps_next = ps_artmis;
                    end else begin
                        ps_next = ps;
                    end
                end
            end
        endcase
        // ps_next = ddb_durdur_i ? ps : ps_next;
    end


    `ifdef COCOTB_SIM
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
        casez({parcaparca,buyruk_hizali,buyruk_ctipi})
            3'b001: begin
                cyo_buyruk_next = buyruk_genis;
                `ifdef COCOTB_SIM  hizali_durum_str = "[16][??]"; `endif
            end
            3'b010: begin
                cyo_buyruk_next = suanki_buyruk;
                `ifdef COCOTB_SIM  hizali_durum_str = "[32_1][32_0]"; `endif
            end
            3'b011: begin
                cyo_buyruk_next = buyruk_genis;
                `ifdef COCOTB_SIM  hizali_durum_str = "[??][16]"; `endif
            end
            3'b000: begin
                cyo_buyruk_next = 32'hxxxx_xxxx;
                getir_hazir_next     = 1'b0;
                parcaparca_next = 1'b1;
                `ifdef COCOTB_SIM  hizali_durum_str = "[32_0][????]"; `endif
            end
            3'b1?0: begin
                cyo_buyruk_next = {suanki_buyruk[15:0], buyruk_tamponu};
                parcaparca_next = 1'b1;
                `ifdef COCOTB_SIM  hizali_durum_str = "[32_0][32_1]"; `endif
            end
            3'b1?1: begin
                cyo_buyruk_next = buyruk_genis;
                bufferdan_okuyor_next = 1'b1;
                `ifdef COCOTB_SIM  hizali_durum_str = "[16][32_1]"; `endif
            end
        endcase
    end

    assign ddb_hazir_o = (~l1b_bekle_i) && getir_hazir;

    wire [15:0] buyruk_16com = buyruk_hizali ? suanki_buyruk[15:0] : buyruk_tamponu;

    // compressed buyruklari genislet
    always @(buyruk_16com) begin
        casez(buyruk_16com)
            //`C_EBREAK,
            //`C_JALR, // c.jalr     -> jalr x1, rs1, 0
            `C_ADD     : begin buyruk_genis = (buyruk_16com[11:2] == 10'b0 ) ? {32'h00_10_00_73}                                   :
                                              (buyruk_16com[ 6:2] ==  5'b0 ) ? {12'b0, buyruk_16com[11:7], 3'b000, 5'b00001, 7'h67}:
                                                                               {7'b0, buyruk_16com[6:2], buyruk_16com[11:7], 3'b0, buyruk_16com[11:7], 7'h33};                                                                      end // c.add      -> add  rd,     rd, rs2
            //`C_JR,       // c.mv       -> add  rd/rs1, x0, rs2
            `C_MV       : begin buyruk_genis = (buyruk_16com[ 6:2] == 5'b0 ) ? {12'b0, buyruk_16com[11:7], 3'b0, 5'b0, 7'h67} : {7'b0, buyruk_16com[6:2], 5'b0, 3'b0, buyruk_16com[11:7], 7'h33};                                   end // c.jr       -> jalr x0, rd/rs1, 0
            //`C_NOP,      // c.nop      -> addi, 0, 0, 0
            `C_ADDI     : begin buyruk_genis = {{6 {buyruk_16com[12]}}, buyruk_16com[12], buyruk_16com[6:2], buyruk_16com[11:7], 3'b0, buyruk_16com[11:7], 7'h13};                                                                  end // c.addi     -> addi rd,     rd, nzimm
            //`C_ADDI16SP, // c.addi16sp -> addi x2, x2, nzimm
            `C_LUI      : begin buyruk_genis = (buyruk_16com[11:7] == 5'b0 ) ? {{3 {buyruk_16com[12]}}, buyruk_16com[4:3], buyruk_16com[5], buyruk_16com[2], buyruk_16com[6], 4'b0, 5'h02, 3'b000, 5'h02, 7'h13} : {{15 {buyruk_16com[12]}}, buyruk_16com[6:2], buyruk_16com[11:7], 7'h37}; end // c.lui      -> lui   rd ,  nzimm
            `C_AND      : begin buyruk_genis = {7'b0, 2'b01, buyruk_16com[4:2], 2'b01, buyruk_16com[9:7], 3'b111, 2'b01, buyruk_16com[9:7], 7'h33};                                                                                 end // c.and      -> and rd', rd', rs2'
            `C_SUB      : begin buyruk_genis = {2'b01, 5'b0, 2'b01, buyruk_16com[4:2], 2'b01, buyruk_16com[9:7], 3'b000, 2'b01, buyruk_16com[9:7], 7'h33};                                                                          end  // c.sub     -> sub rd', rd', rs2'
            `C_OR       : begin buyruk_genis = {7'b0, 2'b01, buyruk_16com[4:2], 2'b01, buyruk_16com[9:7], 3'b110, 2'b01, buyruk_16com[9:7], 7'h33};                                                                                 end // c.or       -> or  rd', rd', rs2'
            `C_XOR      : begin buyruk_genis = {7'b0, 2'b01, buyruk_16com[4:2], 2'b01, buyruk_16com[9:7], 3'b100, 2'b01, buyruk_16com[9:7], 7'h33};                                                                                 end // c.xor      -> xor rd', rd', rs2'
            `C_SRAI     , // c.srli -> srli rd, rd, shamt // c.srai -> srai rd, rd, shamt
            `C_SRLI     : begin buyruk_genis = {1'b0, buyruk_16com[10], 5'b0, buyruk_16com[6:2], 2'b01, buyruk_16com[9:7], 3'b101, 2'b01, buyruk_16com[9:7], 7'h13};                                                                end
            `C_ANDI     : begin buyruk_genis = {{6 {buyruk_16com[12]}}, buyruk_16com[12], buyruk_16com[6:2], 2'b01, buyruk_16com[9:7], 3'b111, 2'b01, buyruk_16com[9:7], 7'h13};                                                    end // c.andi     -> andi rd,     rd, imm
            `C_SLLI     : begin buyruk_genis = {7'b0, buyruk_16com[6:2], buyruk_16com[11:7], 3'b001, buyruk_16com[11:7], 7'h13};                                                                                                    end // c.slli     -> slli rd,     rd, shamt
            `C_ADDI4SPN : begin buyruk_genis = {2'b0, buyruk_16com[10:7], buyruk_16com[12:11], buyruk_16com[5], buyruk_16com[6], 2'b00, 5'h02, 3'b000, 2'b01, buyruk_16com[4:2], 7'h13};                                            end // c.addi4spn -> addi rd',    x2, nzuimm
            `C_BEQZ     , // c.beqz -> beq rs1', x0, imm // c.bnez -> bne rs1', x0, imm
            `C_BNEZ     : begin buyruk_genis = {{4 {buyruk_16com[12]}}, buyruk_16com[6:5], buyruk_16com[2], 5'b0, 2'b01, buyruk_16com[9:7], 2'b00, buyruk_16com[13], buyruk_16com[11:10], buyruk_16com[4:3], buyruk_16com[12], 7'h63};         end
            `C_J        , // c.jal -> jal x1, imm // c.j   -> jal x0, imm
            `C_JAL      : begin buyruk_genis = {buyruk_16com[12], buyruk_16com[8], buyruk_16com[10:9], buyruk_16com[6], buyruk_16com[7], buyruk_16com[2], buyruk_16com[11], buyruk_16com[5:3], {9 {buyruk_16com[12]}}, 4'b0, ~buyruk_16com[15], 7'h6f};end
            `C_LI       : begin buyruk_genis = {{6 {buyruk_16com[12]}}, buyruk_16com[12], buyruk_16com[6:2], 5'b0, 3'b0, buyruk_16com[11:7], 7'h13};                                                                                                   end // c.li   -> addi  rd ,   x0, imm
            `C_LW       : begin buyruk_genis = {5'b0, buyruk_16com[5], buyruk_16com[12:10], buyruk_16com[6], 2'b00, 2'b01, buyruk_16com[9:7], 3'b010, 2'b01, buyruk_16com[4:2], 7'h03};                                                                end // c.lw   -> lw    rd',   uimm(rs1')
            `C_LWSP     : begin buyruk_genis = {4'b0, buyruk_16com[3:2], buyruk_16com[12], buyruk_16com[6:4], 2'b00, 5'h02, 3'b010, buyruk_16com[11:7], 7'h03};                                                                                        end // c.lwsp -> lw    rd ,   uimm(x2)
            `C_SW       : begin buyruk_genis = {5'b0, buyruk_16com[5], buyruk_16com[12], 2'b01, buyruk_16com[4:2], 2'b01, buyruk_16com[9:7], 3'b010, buyruk_16com[11:10], buyruk_16com[6], 2'b00, 7'h23};                                              end // c.sw   -> sw   rs2',   uimm(rs1')
            `C_SWSP     : begin buyruk_genis = {4'b0, buyruk_16com[8:7], buyruk_16com[12], buyruk_16com[6:2], 5'h02, 3'b010, buyruk_16com[11:9], 2'b00, 7'h23};                                                                                        end // c.swsp -> sw   rs2 ,   uimm(x2)
            default     : begin
                buyruk_genis = 32'hxxxx_xxxx;
            end
        endcase
    end

    assign l1b_adr_o = ps[18:2];
    always @(posedge clk_i) begin
        if (rst_i) begin
            ps               <= 18'b0;
            cyo_buyruk_o     <= `EBREAK; // NOP ile ayni. 0-> LB buyruguyla cakisiyor.
            parcaparca       <= 0;
            buyruk_tamponu   <= 0;
            bufferdan_okuyor <= 0;
            getir_hazir      <= 1;
        end else if(~ddb_durdur_i) begin
                getir_hazir      <= getir_hazir_next;
                bufferdan_okuyor <= bufferdan_okuyor_next;
                ps               <= ps_next;
                cyo_buyruk_o     <= ddb_bosalt_i ? `EBREAK : cyo_buyruk_next;
                parcaparca       <= parcaparca_next;
                buyruk_tamponu   <= suanki_buyruk[31:16];
                cyo_ps_artmis_o  <= ps_artmis;
                cyo_ps_o         <= ps;
        end
    end

    // [TODO] Yanlis tahminde: buferdan_okuyor, ps, parcaparca'nin restore edilmesi gerek.

    `ifdef COCOTB_SIM
        wire [31:0] debug_ps = {8'h40,5'b0,ps,1'b0};
        always @(buyruk_16com,buyruk_ctipi) begin
            casez(buyruk_16com)
                //`C_EBREAK,
                //`C_JALR,
                `C_ADD      : begin ctipi_coz_str = "C_JALR C_EBREAK C_ADD";  end
                //`C_JR,
                `C_MV       : begin ctipi_coz_str = "C_JR C_MV";        end
                //`C_NOP,
                `C_ADDI     : begin ctipi_coz_str = "C_ADDI C_NOP";     end
                //`C_ADDI16SP,
                `C_LUI      : begin ctipi_coz_str = "`C_LUI C_ADDI16SP ";end
                `C_AND      : begin ctipi_coz_str = "`C_AND  ";          end
                `C_SUB      : begin ctipi_coz_str = "`C_SUB  ";          end
                `C_OR       : begin ctipi_coz_str = "`C_OR   ";          end
                `C_XOR      : begin ctipi_coz_str = "`C_XOR  ";          end
                `C_SRAI     ,
                `C_SRLI     : begin ctipi_coz_str = "`C_SRLI  C_SRAI   ";end
                `C_ANDI     : begin ctipi_coz_str = "`C_ANDI           ";end
                `C_SLLI     : begin ctipi_coz_str = "`C_SLLI           ";end
                `C_ADDI4SPN : begin ctipi_coz_str = "`C_ADDI4SPN       ";end
                `C_BEQZ     ,
                `C_BNEZ     : begin ctipi_coz_str = "`C_BNEZ, `C_BEQZ";  end
                `C_J        ,
                `C_JAL      : begin ctipi_coz_str = "`C_JAL, `C_J";  end
                `C_LI       : begin ctipi_coz_str = "`C_LI       ";  end
                `C_LW       : begin ctipi_coz_str = "`C_LW       ";  end
                `C_LWSP     : begin ctipi_coz_str = "`C_LWSP     ";  end
                `C_SW       : begin ctipi_coz_str = "`C_SW       ";  end
                `C_SWSP     : begin ctipi_coz_str = "`C_SWSP     ";  end
                default     : begin ctipi_coz_str = "C_DEFAULT";     end
            endcase
            if(~buyruk_ctipi)
                ctipi_coz_str = "Ctipi degil";

            // $monitor("%s",ctipi_coz_str);
        end
    `endif

    `ifdef COCOTB_SIM
        reg [88*13:1]  coz_str_debug;
        wire [`BUYRUK_COZ_BIT-1:0] buyruk_coz_debug = {cyo_buyruk_next[30:29], cyo_buyruk_next[27], cyo_buyruk_next[25], cyo_buyruk_next[21:20], cyo_buyruk_next[14:12], cyo_buyruk_next[6:2]};

        always @* begin
            casez(buyruk_coz_debug)
                `EBREAK_COZ:     begin coz_str_debug = "`NOP_MI";        end
                `ECALL_COZ:      begin coz_str_debug = "`NOP_MI";        end
                `CONV_CLR_W_COZ: begin coz_str_debug = "`CONV_CLR_W_MI"; end
                `CONV_CLR_X_COZ: begin coz_str_debug = "`CONV_CLR_X_MI"; end
                `CONV_RUN_COZ:   begin coz_str_debug = "`CONV_RUN_MI";   end
                `RVRS_COZ:       begin coz_str_debug = "`RVRS_MI";       end
                `CNTZ_COZ:       begin coz_str_debug = "`CNTZ_MI";       end
                `CNTP_COZ:       begin coz_str_debug = "`CNTP_MI";       end
                `CONV_LD_W_COZ:  begin coz_str_debug = "`CONV_LD_W_MI";  end
                `CONV_LD_X_COZ:  begin coz_str_debug = "`CONV_LD_X_MI";  end
                `ADD_COZ:        begin coz_str_debug = "`ADD_MI";        end
                `AND_COZ:        begin coz_str_debug = "`AND_MI";        end
                `DIV_COZ:        begin coz_str_debug = "`DIV_MI";        end
                `DIVU_COZ:       begin coz_str_debug = "`DIVU_MI";       end
                `MUL_COZ:        begin coz_str_debug = "`MUL_MI";        end
                `MULH_COZ:       begin coz_str_debug = "`MULH_MI";       end
                `MULHSU_COZ:     begin coz_str_debug = "`MULHSU_MI";     end
                `MULHU_COZ:      begin coz_str_debug = "`MULHU_MI";      end
                `OR_COZ:         begin coz_str_debug = "`OR_MI";         end
                `REM_COZ:        begin coz_str_debug = "`REM_MI";        end
                `REMU_COZ:       begin coz_str_debug = "`REMU_MI";       end
                `SLL_COZ:        begin coz_str_debug = "`SLL_MI";        end
                `SLT_COZ:        begin coz_str_debug = "`SLT_MI";        end
                `SLTU_COZ:       begin coz_str_debug = "`SLTU_MI";       end
                `SRA_COZ:        begin coz_str_debug = "`SRA_MI";        end
                `SRL_COZ:        begin coz_str_debug = "`SRL_MI";        end
                `SUB_COZ:        begin coz_str_debug = "`SUB_MI";        end
                `XOR_COZ:        begin coz_str_debug = "`XOR_MI";        end
                `HMDST_COZ:      begin coz_str_debug = "`HMDST_MI";      end
                `PKG_COZ:        begin coz_str_debug = "`PKG_MI";        end
                `SLADD_COZ:      begin coz_str_debug = "`SLADD_MI";      end
                `SLLI_COZ:       begin coz_str_debug = "`SLLI_MI";       end
                `SRAI_COZ:       begin coz_str_debug = "`SRAI_MI";       end
                `SRLI_COZ:       begin coz_str_debug = "`SRLI_MI";       end
                `ADDI_COZ:       begin coz_str_debug = "`ADDI_MI";       end
                `ANDI_COZ:       begin coz_str_debug = "`ANDI_MI";       end
                `BEQ_COZ:        begin coz_str_debug = "`BEQ_MI";        end
                `BGE_COZ:        begin coz_str_debug = "`BGE_MI";        end
                `BGEU_COZ:       begin coz_str_debug = "`BGEU_MI";       end
                `BLT_COZ:        begin coz_str_debug = "`BLT_MI";        end
                `BLTU_COZ:       begin coz_str_debug = "`BLTU_MI";       end
                `BNE_COZ:        begin coz_str_debug = "`BNE_MI";        end
                `FENCE_COZ:      begin coz_str_debug = "`NOP_MI";        end
                `FENCE_I_COZ:    begin coz_str_debug = "`NOP_MI";        end
                `JALR_COZ:       begin coz_str_debug = "`JALR_MI";       end
                `LB_COZ:         begin coz_str_debug = "`LB_MI";         end
                `LBU_COZ:        begin coz_str_debug = "`LBU_MI";        end
                `LH_COZ:         begin coz_str_debug = "`LH_MI";         end
                `LHU_COZ:        begin coz_str_debug = "`LHU_MI";        end
                `LW_COZ:         begin coz_str_debug = "`LW_MI";         end
                `ORI_COZ:        begin coz_str_debug = "`ORI_MI";        end
                `SB_COZ:         begin coz_str_debug = "`SB_MI";         end
                `SH_COZ:         begin coz_str_debug = "`SH_MI";         end
                `SLTI_COZ:       begin coz_str_debug = "`SLTI_MI";       end
                `SLTIU_COZ:      begin coz_str_debug = "`SLTIU_MI";      end
                `SW_COZ:         begin coz_str_debug = "`SW_MI";         end
                `XORI_COZ:       begin coz_str_debug = "`XORI_MI";       end
                `AUIPC_COZ:      begin coz_str_debug = "`AUIPC_MI";      end
                `JAL_COZ:        begin coz_str_debug = "`JAL_MI";        end
                `LUI_COZ:        begin coz_str_debug = "`LUI_MI";        end
                default:         begin coz_str_debug  = "DEFAULT_MI";    end
            endcase
            // $monitor("%s",coz_str);
        end
    `endif

endmodule
