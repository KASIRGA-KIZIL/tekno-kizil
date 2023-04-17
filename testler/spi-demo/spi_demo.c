#include "spi_driver.h"

int main(){
    SPI_WDATA = 0x98;
    SPI_CTRL = 0x000F0001;
    SPI_CMD = 0x00002000;
    while(!((SPI_STATUS>>1)%2));
    SPI_WDATA = 0x98;
    SPI_CTRL = 0x000F0005;
    SPI_CMD = 0x00002000;
    while(!((SPI_STATUS>>1)%2));
    SPI_WDATA = 0x98;
    SPI_CTRL = 0x000F0009;
    SPI_CMD = 0x00002000;
    while(!((SPI_STATUS>>1)%2));
    SPI_WDATA = 0x98;
    SPI_CTRL = 0x000F000D;
    SPI_CMD = 0x00002000;
    while(1);

}
