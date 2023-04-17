#include <stdio.h>

void uart_test()
{
	char buffer[100];
	int length = 0;
	int term_loop = 1;
	
	while(term_loop){
		tekno_printf("\n[tutel@tubitak.gov.tr uart]$ ");
		
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
			tekno_printf("\nIt was basically tested with this terminal build.\n"
						 "\nEndpoints can be tested.\n");
		}
		else if (!strcmp(buffer, "exit")) {
			term_loop = 0;
		}
		else {
		tekno_printf("\nInvalid command. Type 'help' to see all commands.\n");
		}		
	}
}