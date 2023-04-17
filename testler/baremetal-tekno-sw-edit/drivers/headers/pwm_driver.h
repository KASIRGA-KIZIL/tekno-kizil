typedef enum {
        PWM_IDLE = 0,
        PWM_STANDARD = 1,
        PWM_HEARTBEAT = 2
} pwm_mode_t;

void pwm_set_control (unsigned int pwm_number, pwm_mode_t mode);
int pwm_get_control (unsigned int pwm_number);
void pwm_set_period_counter (unsigned int pwm_number, unsigned int period_counter);
int pwm_get_period_counter (unsigned int pwm_number);
void pwm_set_threshold_counter (unsigned int pwm_number, unsigned int threshold_number, unsigned int threshold_counter);
int pwm_get_threshold_counter (unsigned int pwm_number, unsigned int threshold_number);
void pwm_set_step_counter (unsigned int pwm_number, unsigned int step_counter);
int pwm_get_step_counter (unsigned int pwm_number);
int pwm_get_output (unsigned int pwm_number);


