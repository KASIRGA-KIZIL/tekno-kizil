#include <stdio.h>

void pwm_test()
{
	char buffer[100];
	int length = 0;
	int term_loop = 1;
	
	while(term_loop){
		tekno_printf("\n[tutel@tubitak.gov.tr pwm]$ ");
		
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
			pwm_set_period_counter(0, 100000000);		
			pwm_set_threshold_counter(0, 0, 5000000);					
			pwm_set_control(0, PWM_STANDARD);	
			
			pwm_set_period_counter(1, 100000000);	
			pwm_set_threshold_counter(1, 0, 25000000);
			pwm_set_threshold_counter(1, 1, 75000000);
			pwm_set_step_counter(1, 1);		
			pwm_set_control(1, PWM_HEARTBEAT);
			
			int value;
			value = pwm_get_period_counter(0);		
			tekno_printf("\nPeriod: %d", value);
			value = pwm_get_threshold_counter(0, 0);	
			tekno_printf("\nThreshold: %d", value);
			value = pwm_get_step_counter(0);				
			tekno_printf("\nStep: %d", value);
		}
		else if (!strcmp(buffer, "exit")) {
			term_loop = 0;
		}
		else {
		tekno_printf("\nInvalid command. Type 'help' to see all commands.\n");
		}		
	}
}
