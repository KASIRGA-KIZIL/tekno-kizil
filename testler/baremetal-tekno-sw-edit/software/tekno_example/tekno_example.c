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

 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include <unistd.h> // notice this! you need it!

//#include "intfract.h"

#define clear() tekno_printf("\033[H\033[J")
#define gotoxy(x,y) tekno_printf("\033[%d;%dH", (y), (x))



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
	
	/*uint32_t veri;
    SPI_CTRL = 0x00036000D;
    SPI_WDATA = 0x03;
    SPI_CMD = 0x00002200;
    SPI_WDATA = 0x00000000;
    SPI_CMD = 0x00002202;
    SPI_CMD = 0x00001007;
    tekno_printf("#BASLA\n\n");
    while(((SPI_STATUS>>3)%2));
    veri = SPI_RDATA;
    tekno_printf("DATA0: 0x%x\n",veri);
    while(((SPI_STATUS>>3)%2));
    veri = SPI_RDATA;
    tekno_printf("DATA1: 0x%x\n",veri);
    tekno_printf("\n#BITTI\n");*/
    
    while(1){
    pwm_set_period_counter(0, 100000);
    pwm_set_threshold_counter(0, 0, 5000);
    pwm_set_threshold_counter(0, 1, 2000);
    pwm_set_step_counter(0, 1);
    pwm_set_control(0, PWM_HEARTBEAT);
    
    for(int i = 0; i<100; i++)
        	tekno_printf("---------------");
    
    pwm_set_period_counter(0, 5000);
    pwm_set_threshold_counter(0, 0, 5000);
    pwm_set_threshold_counter(0, 1, 2000);
    pwm_set_step_counter(0, 1);
    pwm_set_control(0, PWM_HEARTBEAT);
	}



    //while(1);

   /*int i=0;
	
	char cmd_buf[8];
	
	while(1)
    {
        //for (int i = 0 ; i < 10000000000 ; i++)
        while(1)
        { i++;
            while(uart_rxempty());
            //cmd_buf[i] = UART_RDATA;
            tekno_printf("rx%d,%c\n",i,UART_RDATA);
   			
        
        if (__strcmp(cmd_buf,"logo",sizeof("logo")-1))
        {
            tekno_printf("###girdi####\n");
            break;
        }

    }*/

		uart_test();
		spi_test();
		pwm_test();
		accelerator_test();
		cryptography_test();
	return 0;
}
