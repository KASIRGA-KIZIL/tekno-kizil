
///////////////////////////////////////////////////////////////////////////////////////////////////
// Company:     TUTEL
// Project:     Teknofest Chip Competition 2023
//***********************************************************************************************// 
// Create Date: 13/01/2023
// Module Name: pwm_driver.c
// Description: PWM driver for teknofest.
//
///////////////////////////////////////////////////////////////////////////////////////////////////

// #include <stdio.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <stdbool.h>

#include "../../chip/tekno/platform.h"

// Setting & getting control of different PWM signals
void pwm_set_control (unsigned int pwm_number, pwm_mode_t mode){
	if (pwm_number == 0){
        PWM0_CTRL = mode;
    } 
    else if (pwm_number == 1){
        PWM1_CTRL = mode;
    }
    else {
                
    }
}
int pwm_get_control (unsigned int pwm_number){
	pwm_mode_t mode;
	if (pwm_number == 0){
		mode = PWM0_CTRL;
    } 
    else if (pwm_number == 1){
        mode = PWM1_CTRL;
    }
    else {
        return 0;     
    }
	return mode;
}

// Setting & getting period of different PWM signals
void pwm_set_period_counter (unsigned int pwm_number, unsigned int period_counter){
	if (pwm_number == 0){
        PWM0_PERIOD = period_counter;
    } 
    else if (pwm_number == 1){
        PWM1_PERIOD = period_counter;
    }
    else {
                
    }
}
int pwm_get_period_counter (unsigned int pwm_number){
	int period_counter;
	if (pwm_number == 0){
		period_counter = PWM0_PERIOD;
    } 
    else if (pwm_number == 1){
        period_counter = PWM1_PERIOD;
    }
    else {
        return 0;     
    }
	return period_counter;
}
// Setting & getting threshold of different PWM signals
void pwm_set_threshold_counter (unsigned int pwm_number, unsigned int threshold_number, unsigned int threshold_counter){
	if (pwm_number == 0 && threshold_number == 0){
        PWM0_THRESHOLD_1 = threshold_counter;
    } 
    else if (pwm_number == 0 && threshold_number == 1){
        PWM0_THRESHOLD_2 = threshold_counter;
    }
	else if (pwm_number == 1 && threshold_number == 0){
        PWM1_THRESHOLD_1 = threshold_counter;
    }
	else if (pwm_number == 1 && threshold_number == 1){
        PWM1_THRESHOLD_2 = threshold_counter;
    }
    else {
                
    }
}
int pwm_get_threshold_counter (unsigned int pwm_number, unsigned int threshold_number){
	int threshold_counter;
	if (pwm_number == 0 && threshold_number == 0){
        threshold_counter = PWM0_THRESHOLD_1;
    } 
    else if (pwm_number == 0 && threshold_number == 1){
        threshold_counter = PWM0_THRESHOLD_2;
    }
	else if (pwm_number == 1 && threshold_number == 0){
        threshold_counter = PWM1_THRESHOLD_1;
    }
	else if (pwm_number == 1 && threshold_number == 1){
        threshold_counter = PWM1_THRESHOLD_2;
    }
    else {
        return 0;    
    }
	return threshold_counter;	
}
// Setting & getting step of different PWM signals
void pwm_set_step_counter (unsigned int pwm_number, unsigned int step_counter){
	if (pwm_number == 0){
        PWM0_STEP = step_counter;
    } 
    else if (pwm_number == 1){
        PWM1_STEP = step_counter;
    }
    else {
                
    }
}
int pwm_get_step_counter (unsigned int pwm_number){
	int step_counter;
	if (pwm_number == 0){
		step_counter = PWM0_STEP;
    } 
    else if (pwm_number == 1){
        step_counter = PWM1_STEP;
    }
    else {
        return 0;     
    }
	return step_counter;
}
// Getting output of different PWM signals
int pwm_get_output (unsigned int pwm_number){
	int output;
	if (pwm_number == 0){
		output = PWM0_OUTPUT;
    } 
    else if (pwm_number == 1){
        output = PWM1_OUTPUT;
    }
    else {
        return 0;     
    }
	return output;
}