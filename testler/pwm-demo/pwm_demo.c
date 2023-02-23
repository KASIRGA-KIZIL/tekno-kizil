#include "pwm_driver.h"

int main(){
    pwm_set_period_counter(0, 100000000);		
    pwm_set_threshold_counter(0, 0, 5000000);	
    pwm_set_step_counter(0, 1);				
    pwm_set_control(0, PWM_STANDARD);	

    return 0;

}
