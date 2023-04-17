#include <stdio.h>

void cryptography_test()
{
	char buffer[100];
	int length = 0;
	int term_loop = 1;
	
	while(term_loop){
		tekno_printf("\n[tutel@tubitak.gov.tr cryp]$ ");
		
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
			
			int result_hmdst;
			int result_pkg;
			int result_sladd;
			int result_rvrs;
			int result_cntz;
			int result_cntp;
			
			inst_hmdst(0, 1, result_hmdst);   // source1 = 0, source2 = 1, result = result_hmdst
			inst_pkg(0, 1, result_pkg);
			inst_sladd(0, 1, result_sladd);
			inst_rvrs(0, result_rvrs);      // source1 = 0, result = result_rvrs
			inst_cntz(0, result_cntz);
			inst_cntp(0, result_cntp);
			
			tekno_printf("Result hmdst: %x\n",result_hmdst);
			tekno_printf("Result pkg: %x\n",result_pkg);
			tekno_printf("Result sladd: %x\n",result_sladd);
			tekno_printf("Result rvrs: %x\n",result_rvrs);
			tekno_printf("Result cntz: %x\n",result_cntz);
			tekno_printf("Result cntp: %x\n",result_cntp);
			
		}
		else if (!strcmp(buffer, "exit")) {
			term_loop = 0;
		}
		else {
		tekno_printf("\nInvalid command. Type 'help' to see all commands.\n");
		}		
	}
}
