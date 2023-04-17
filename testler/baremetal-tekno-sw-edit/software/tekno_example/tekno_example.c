/*
 *   TEKNOFEST 2023 CHIP DESIGN COMPETITION SOFTWARE EXAMPLE
 *
 * - A example of software created according to the chip design to be designed.
 *
 * - You can create your own test systems by updating the driver and test codes.
 *
 * - Compile Command: make software PROGRAM=tekno_example BOARD=tekno
 *
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

// Drivers for peripherals and extensions //
#include "../../chip/tekno/platform.h"

// Test codes for peripherals and extensions //
#include "test_codes/uart_test.c"
#include "test_codes/spi_test.c"
#include "test_codes/pwm_test.c"
#include "test_codes/accelerator_test.c"
#include "test_codes/cryptography_test.c"

#define CPU_CLK 60000000
#define BAUD_RATE 115200
	
static int __strcmp(char* s1, char* s2, int len)
{
    for(int i = 0 ; i < len ; i++)
    {
        if (s1[i] != s2[i])
            return 0;
    }
    return 1;
}

int main()
{
	// Initializing uart
	uart_ctrl uart_control;
	uart_control.fields.tx_en = 0x1; 
	uart_control.fields.rx_en = 0x1; 
	uart_control.fields.baud_div = CPU_CLK/BAUD_RATE; 
	
	UART_CTRL = uart_control.bits;

	tekno_printf("\n"
	"-------------------------------------------------------------------------------------\n"
	"<<<<<<<<<<<<<< TEKNOFEST 2023 CHIP DESIGN COMPETITION SOFTWARE EXAMPLE >>>>>>>>>>>>>>\n"
	"-------------------------------------------------------------------------------------\n"); 
	
	char cmd_buf[8];
	
	while(1)
    {
        // butun komutlarin 8 bayta
        // sigdigini varsayiyoruz
        for (int i = 0 ; i < 8 ; i++)
        {
            while(uart_rxempty());
            cmd_buf[i] = UART_RDATA;
            tekno_printf("rx%d,%c\n",i,cmd_buf[i]);
        }
        
        if (__strcmp(cmd_buf,"logo",sizeof("logo")-1))
        {
            tekno_printf("###girdi####\n");
            break;
        }

    }

		uart_test();
		spi_test();
		pwm_test();
		accelerator_test();
		cryptography_test();
	return 0;
}
