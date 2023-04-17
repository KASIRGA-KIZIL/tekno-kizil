
///////////////////////////////////////////////////////////////////////////////////////////////////
// Company:     TUTEL
// Project:     Teknofest Chip Competition 2023
//***********************************************************************************************// 
// Create Date: 13/01/2023
// Module Name: uart_driver.c
// Description: UART driver for teknofest.
//
///////////////////////////////////////////////////////////////////////////////////////////////////

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <stdbool.h>

#include "../../chip/tekno/platform.h"

//-----------------------------------------------
// print a single character.
//-----------------------------------------------
int uart_txfull(){
	uart_status uart_stat;
	uart_stat.bits = UART_STATUS;
	return uart_stat.fields.tx_full;
}

void zputchar(char c)
{
	while(uart_txfull());
	UART_WDATA = c;
}

//-----------------------------------------------
// print a string (char*).
//-----------------------------------------------

void print(const char *p)
{
	while (*p)
		zputchar(*(p++));
}

void tekno_printf(const char *fmt, ...)
{
	va_list vl;
	bool is_format, is_long, is_char;
	char c, string_buf[11];

	va_start(vl, fmt);
	is_format = false;
	is_long = false;
	is_char = false;
	while ((c = *fmt++) != '\0') {
		if (is_format) {
			switch (c) {
			case 'l':
				is_long = true;
				is_format = true;
				is_char = false;
				continue;
			case 'h':
				is_char = true;
				is_format = false;
				is_long = false;
				continue;
			case 'f': 	
			case 'x': {
				unsigned long n;
				long i;
				if (is_long) {
					n = va_arg(vl, unsigned long);
					i = (sizeof(unsigned long) << 3) - 4;
				} else {
					n = va_arg(vl, unsigned int);
					i = is_char ? 4 : (sizeof(unsigned int) << 3) - 4;
				}
				for (; i >= 0; i -= 4) {
					long d;
					d = (n >> i) & 0xF;
					zputchar(d < 10 ? '0' + d : 'a' + d - 10);
				}
				is_format = false;
				is_long = false;
				is_char = false;
				break;
			}
			case 'd': {
                long num = is_long ? va_arg(vl, long) : va_arg(vl, int);
                if (num < 0) {
                    num = -num;
                        zputchar( '-');
                }
                long digits = 1;
                char digit_array[20];
                for (long nn = num; nn /= 10; digits++)
                    ;
                for (int i = digits-1; i >= 0; i--) {
                    digit_array[i] = '0' + (num % 10);                
                    num /= 10;
                }
                for(int i = 0; i<digits; i++){
                  zputchar(digit_array[i]);
                }
				is_format = false;
				is_long = false;
				is_char = false;
                break;
            }
			case 'u': {
                long unsigned num = is_long ? va_arg(vl, long) : va_arg(vl, int);
                long digits = 1;
                for (long nn = num; nn /= 10; digits++)
                    ;
                for (int i = digits-1; i >= 0; i--) {
                    zputchar('0' + (num % 10));                    
                    num /= 10;
                }
				is_format = false;
				is_long = false;
				is_char = false;
                break;
            }				
			case 's':
				print(va_arg(vl, const char *));
				is_format = false;
				is_long = false;
				is_char = false;
				break;
			case 'c':
				zputchar(va_arg(vl, int));
				is_format = false;
				is_long = false;
				is_char = false;
				break;
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
				break;			
			default:
				print(" unknown instruction ");
				is_format = false;
				is_long = false;
				is_char = false;
				break;
			}
		} else if (c == '%') {
			is_format = true;
		} else {
			zputchar(c);
			if(c == '\n'){
				zputchar('\r');
			}
		}
	}
	va_end(vl);
}

//-----------------------------------------------
// scan a single character.
//-----------------------------------------------

int uart_rxempty(){
	uart_status uart_stat;
	uart_stat.bits  = UART_STATUS;
	return uart_stat.fields.rx_empty;
}

char zgetchar()
{
	while(1){
		if (!uart_rxempty()){
			return(char)UART_RDATA;
		}
	}
}

//-----------------------------------------------
// scan multiple characters.
//-----------------------------------------------

int zscan(char *buffer, int max_size, int echo) 
{
  char c = 0;
  int length = 0;

  while (1) {
    c = zgetchar();
    if (c == '\b') { // BACKSPACE
      if (length != 0) {
        if (echo) {
          print("\b \b"); // delete last char in console
        }
        buffer--;
        length--;
      }
    }
    else if (c == '\r') // carriage return
      break;
    else if ((c >= ' ') && (c <= '~') && (length < (max_size-1))) {
      if (echo) {
        zputchar(c); // echo
      }
      *buffer++ = c;
      length++;
    }
  }
  *buffer = '\0'; // terminate string
  print("\n");

  return length;
}

//-----------------------------------------------
// string compare.
// compares all chars in two strings.
//-----------------------------------------------

int strcmp(const char *p1, const char *p2)
{
	const unsigned char *s1 = (const unsigned char *) p1;
	const unsigned char *s2 = (const unsigned char *) p2;
	unsigned char c1, c2;
	do{
		c1 = (unsigned char) *s1++;
		c2 = (unsigned char) *s2++;
		if(c1 == '\0')
			return c1 - c2;
	}
	while(c1 == c2);
	return c1 - c2;
}

//-----------------------------------------------
// strlen
//-----------------------------------------------

size_t strlen(const char *s)
{
  const char *p = s;
  while (*p)
    p++;
  return p - s;
}
