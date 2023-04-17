
// DRIVERS
#include "../../drivers/headers/uart_driver.h"
#include "../../drivers/headers/spi_driver.h"
#include "../../drivers/headers/pwm_driver.h"
#include "../../drivers/headers/accelerator_driver.h"
#include "../../drivers/headers/cryptography_driver.h"

// UART CONTROL ADDRESSES
#define UART_CTRL        (*(volatile uint32_t*)0x20000000)
#define UART_STATUS      (*(volatile uint32_t*)0x20000004)
#define UART_RDATA       (*(volatile uint32_t*)0x20000008)
#define UART_WDATA       (*(volatile uint32_t*)0x2000000c)

// SPI CONTROL ADDRESSES
#define SPI_CTRL         (*(volatile uint32_t*)0x20010000)
#define SPI_STATUS       (*(volatile uint32_t*)0x20010004)
#define SPI_RDATA        (*(volatile uint32_t*)0x20010008)
#define SPI_WDATA        (*(volatile uint32_t*)0x2001000c)
#define SPI_CMD          (*(volatile uint32_t*)0x20010010)

// PWM CONTROL ADDRESSES 
#define PWM0_CTRL 	     (*(volatile uint32_t*)0x20020000)
#define PWM1_CTRL 	     (*(volatile uint32_t*)0x20020004)
#define PWM0_PERIOD      (*(volatile uint32_t*)0x20020008)
#define PWM1_PERIOD 	 (*(volatile uint32_t*)0x2002000c)
#define PWM0_THRESHOLD_1 (*(volatile uint32_t*)0x20020010)
#define PWM0_THRESHOLD_2 (*(volatile uint32_t*)0x20020014)
#define PWM1_THRESHOLD_1 (*(volatile uint32_t*)0x20020018)
#define PWM1_THRESHOLD_2 (*(volatile uint32_t*)0x2002001c)
#define PWM0_STEP 	     (*(volatile uint32_t*)0x20020020)
#define PWM1_STEP 	     (*(volatile uint32_t*)0x20020024)
#define PWM0_OUTPUT 	 (*(volatile uint32_t*)0x20020028)
#define PWM1_OUTPUT 	 (*(volatile uint32_t*)0x2002002c)

// TIMER CONTROL ADDRESSES
#define TIMER_LOW        (*(volatile uint32_t*)0x30000000)
#define TIMER_HIGH       (*(volatile uint32_t*)0x30000004)
