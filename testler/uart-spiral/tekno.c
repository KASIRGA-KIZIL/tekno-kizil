#include "tekno.h"

int uart_txfull(){
	uart_status uart_stat;
	uart_stat.bits = UART_STATUS;
	return uart_stat.fields.tx_full;
}

void zputchar(char c)
{
	while(uart_txfull());
	if (c == '\n')
		zputchar('\r');
	UART_WDATA = c;
}

int uart_rxempty(){
	uart_status uart_stat;
	uart_stat.bits  = UART_STATUS;
	return uart_stat.fields.rx_empty;
}

char zgetchar()
{
	while(1){
		if (!uart_rxempty()){
			return(char)UART_RDATA;
		}
	}
}

void init_uart(){
    uart_ctrl uart_control;
    uart_control.fields.tx_en = 0x1; 
    uart_control.fields.tx_en = 0x1; 
    uart_control.fields.baud_div = CPU_CLK/BAUD_RATE;
    UART_CTRL = uart_control.bits;
}

uint32_t get_timer_low(){
    return TIMER_LOW;
}
uint32_t get_timer_high(){
    return TIMER_HIGH;
}
// TODO ust bitlere bakacaksak hem bura hem core_portme.hda degisiklik gerek
uint32_t /*uint64_t*/ get_timer(){
    //return (get_timer_high() << 32) + get_timer_low();
    return get_timer_low();
}
