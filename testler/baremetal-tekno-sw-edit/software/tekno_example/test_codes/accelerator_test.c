#include <stdio.h>

void accelerator_test()
{
	char buffer[100];
	int length = 0;
	int term_loop = 1;
	
	while(term_loop){
		tekno_printf("\n[tutel@tubitak.gov.tr accel]$ ");
		
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
			
			// Basic usage shown, see drivers and competitive specs for details.
			
			int result_run; 
			
			inst_conv_ld_w(0,1,1);  // enable=0, source1=1, source2=1
			inst_conv_ld_w(1,3,2);  // enable=1, source1=3, source2=2
			inst_conv_clr_w(); 
			inst_conv_ld_x(1,1,1);    
			inst_conv_ld_x(0,1,1);    
			inst_conv_clr_x();   
			inst_conv_run(result_run);
			tekno_printf("Result conv_run: %x\n",result_run);
			
		}
		else if (!strcmp(buffer, "exit")) {
			term_loop = 0;
		}
		else {
		tekno_printf("\nInvalid command. Type 'help' to see all commands.\n");
		}		
	}
}
