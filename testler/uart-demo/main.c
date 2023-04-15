//#define UART_CTRL        (*(volatile uint32_t*)0x20000000)
//#define UART_STATUS      (*(volatile uint32_t*)0x20000004)
//#define UART_RDATA       (*(volatile uint32_t*)0x20000008)
//#define UART_WDATA       (*(volatile uint32_t*)0x2000000c)

#include "ee_printf.h"


int main()
{
    int i = 0;
    init_uart();
    ee_printf("hello");
    while(1){
        getchar();
        i = i + 1;
        if(i == 5)
            break;
    }
    ee_printf("done");
    while(1);
}
