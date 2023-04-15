#include <stdarg.h>
#include <stdint.h>


#define CPU_CLK 50000000
#define BAUD_RATE 115200

#define UART_STATUS_BASE      0x20000004
#define UART_RDATA_BASE       0x20000008
#define UART_WDATA_BASE       0x2000000c
#define UART_CTRL_BASE        0x20000000

#include <stdbool.h>

typedef struct {
    bool tx_en        : 1;
    bool rx_en        : 1;
    uint16_t null     : 14;
    uint16_t baud_div : 16;
}uart_ctrl_t;

typedef struct {
        bool tx_full  : 1;
        bool rx_full  : 1;
        bool tx_empty : 1;
        bool rx_empty : 1;
        uint32_t null : 28;
}uart_status_t;

#define uart_status               (*(volatile uart_status_t*)UART_STATUS_BASE)
#define uart_ctrl                 (*(volatile uart_ctrl_t*  )UART_CTRL_BASE  )
#define uart_wdata                (*(volatile char*)UART_WDATA_BASE)
#define uart_rdata                (*(volatile char*)UART_RDATA_BASE)


void init_uart(void);
int ee_printf(const char *fmt, ...);
char getchar(void);

