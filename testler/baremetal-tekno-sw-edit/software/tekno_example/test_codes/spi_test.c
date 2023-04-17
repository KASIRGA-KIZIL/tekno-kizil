#include <stdio.h>

void spi_test()
{
	char buffer[100];
	int length = 0;
	int term_loop = 1;
	uint32_t spi_read_data;
		
	while(term_loop){
		tekno_printf("\n[tutel@tubitak.gov.tr spi]$ ");
		
		length = zscan(buffer, 100, 1);
		
		if (!length) // nothing to be done
		continue;
		
		if (!strcmp(buffer, "help")) {
			tekno_printf( 
				"\n"
				"Available commands:\n"
				"  help         : show this text\n"
				"  test         : test code\n\n"
			);
		}
		else if (!strcmp(buffer, "test")) {		
			spi_ctrl spi_control;
			spi_control.fields.spi_en  = 0x1;
			spi_control.fields.spi_rst = 0x0;
			spi_control.fields.cpol    = 0x0;
			spi_control.fields.cpha    = 0x0;
			spi_control.fields.sck_div = 0x2c;
			
			SPI_CTRL = spi_control.bits;	
			
			tekno_printf("\n\n\nSPI Module Started.\n");
		
			tekno_printf("\nSending data form mosi.");
			SPI_WDATA = 0x00000003;   
			SPI_CMD   = 0x00002200;   // 1  byte mosi, 03 
			SPI_WDATA = 0x00000000;
			SPI_CMD   = 0x00002202;   // 3  byte mosi, 000000	
			SPI_CMD   = 0x00001007;   // 8  byte miso, cs low	       
						
			tekno_printf("\nSPI NOR FLASH Read Cmd    : 0x03\n");
			tekno_printf("\nSPI NOR FLASH Read Addr   : 0x000000\n");
			
			while(spi_miso_empty());
			spi_read_data = SPI_RDATA;
			tekno_printf("\nSPI NOR FLASH Read Data[0]: 0x%x\n", spi_read_data);
		
			while(spi_miso_empty());
			spi_read_data = SPI_RDATA; 
			tekno_printf("\nSPI NOR FLASH Read Data[1]: 0x%x\n", spi_read_data);

			tekno_printf("\n\nSPI test completed.\n");	  
		}
		else if (!strcmp(buffer, "exit")) {
			term_loop = 0;
		}
		else {
		tekno_printf("\nInvalid command. Type 'help' to see all commands.\n");
		}		
	}
}