#define SPI_CTRL    (*(volatile uint32_t*) 0x20010000)
#define SPI_STATUS  (*(volatile uint32_t*) 0x20010004)
#define SPI_RDATA   (*(volatile uint32_t*) 0x20010008)
#define SPI_WDATA   (*(volatile uint32_t*) 0x2001000c)
#define SPI_CMD     (*(volatile uint32_t*) 0x20010010)
#include <stdint.h>
int spi_miso_empty();