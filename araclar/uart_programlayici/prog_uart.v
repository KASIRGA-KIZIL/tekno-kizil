// BASYS3 PROGRAMLAYICI UART
// Programlayici icin tek cikis da verilebilirdi. Ayni anda 8 FPGA'yi programlayabilirsiniz.
// 
// K17 ya da L17 portlarindan cikis alarak islemcinin calistigi FPGA'de program_rx_i portuna baglayin.
// Bu programlayiciyi attiginiz FPGA uzerindeki USB portunu uart_send_data.py dosyasinda belirterek diger ana FPGA'yi programlayin.
`timescale 1ns / 1ps

module prog_uart(
    input uart_rx_i, // USB rx
    output program_tx1_o, // K17 pmod header'dan cikan 1. programlama cikis tx portu
    output program_tx2_o, // L17 pmod header'dan cikan 2. programlama cikis tx portu
    output program_tx3_o, // M18 pmod header'dan cikan 3. programlama cikis tx portu
    output program_tx4_o, // M19 pmod header'dan cikan 4. programlama cikis tx portu
    output program_tx5_o, // N17 pmod header'dan cikan 5. programlama cikis tx portu
    output program_tx6_o, // P17 pmod header'dan cikan 6. programlama cikis tx portu
    output program_tx7_o, // P18 pmod header'dan cikan 7. programlama cikis tx portu
    output program_tx8_o, // R18 pmod header'dan cikan 8. programlama cikis tx portu
    output led_tx_o // tx'e bagli led, programlanirken hizli hizli yanip sonuyor
);
    
    assign program_tx1_o = uart_rx_i;
    assign program_tx2_o = uart_rx_i;
    assign program_tx3_o = uart_rx_i;
    assign program_tx4_o = uart_rx_i;
    assign program_tx5_o = uart_rx_i;
    assign program_tx6_o = uart_rx_i;
    assign program_tx7_o = uart_rx_i;
    assign program_tx8_o = uart_rx_i;
    assign led_tx_o = program_tx1_o;
endmodule
