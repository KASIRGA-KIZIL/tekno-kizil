
///////////////////////////////////////////////////////////////////////////////////////////////////
// Company:     TUTEL
// Project:     Teknofest Chip Competition 2023
//***********************************************************************************************// 
// Create Date: 13/01/2023
// Module Name: spi_driver.c
// Description: SPI driver for teknofest.
//
///////////////////////////////////////////////////////////////////////////////////////////////////

#include <stdint.h>

#include "../../chip/tekno/platform.h"

int spi_miso_empty(){
	spi_status spi_stat;
	spi_stat.bits  = SPI_STATUS;
	return spi_stat.fields.miso_empty;
}