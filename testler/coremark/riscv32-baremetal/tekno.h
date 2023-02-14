#ifndef TEKNO_H
#define TEKNO_H

#include <stdint.h>

#define UART_CTRL        (*(volatile uint32_t*)0x20000000)
#define UART_STATUS      (*(volatile uint32_t*)0x20000004)
#define UART_RDATA       (*(volatile uint32_t*)0x20000008)
#define UART_WDATA       (*(volatile uint32_t*)0x2000000c)

#define CPU_CLK 50000000  // 50 Mhz 
#define BAUD_RATE 115200

#define TIMER_LOW        (*(volatile uint32_t*)0x30000000)
#define TIMER_HIGH       (*(volatile uint32_t*)0x30000004)

typedef union
{
	struct {
		unsigned int tx_en    : 1;
		unsigned int rx_en 	  : 1;
		unsigned int null	  : 14;
		unsigned int baud_div : 16;
	} fields;
	uint32_t bits;
}uart_ctrl;

typedef union
{
	struct {
		unsigned int tx_full  : 1;
		unsigned int rx_full  : 1;
		unsigned int tx_empty : 1;
		unsigned int rx_empty : 1;
		unsigned int null	  : 28;
	} fields;
	uint32_t bits;
}uart_status;

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

#endif /* TEKNO_H */

