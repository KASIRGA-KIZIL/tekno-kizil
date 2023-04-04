#include "tekno.h"
#include <math.h>
#include <string.h>

/*
void int_to_bin_digit(unsigned int in, int count, int* out)
{
    // assert: count <= sizeof(int)*CHAR_BIT
    unsigned int mask = 1U << (count-1);
    int i;
    for (i = 0; i < count; i++) {
        out[i] = (in & mask) ? 1 : 0;
        in <<= 1;
    }
}
*/

int main() {
    init_uart();
    
    /*
    int digit[8];
    int_to_bin_digit(0xeb, 8, digit);
    
    for(int a=0; a<8; a++)
        ee_printf("%d",digit[i]);
    
    ee_printf("\n");
    */

    float A = 0, B = 0;
    float i, j;
    int k;
    float z[1760];
    char b[1760];
    ee_printf("\x1b[2J");
    for(;;) {
        memset(b,32,1760);
        memset(z,0,7040);
        for(j=0; j < 6.28; j += 0.07) {
            for(i=0; i < 6.28; i += 0.02) {
                float c = sin(i);
                float d = cos(j);
                float e = sin(A);
                float f = sin(j);
                float g = cos(A);
                float h = d + 2;
                float D = 1 / (c * h * e + f * g + 5);
                float l = cos(i);
                float m = cos(B);
                float n = sin(B);
                float t = c * h * g - f * e;
                int x = 40 + 30 * D * (l * h * m - t * n);
                int y= 12 + 15 * D * (l * h * n + t * m);
                int o = x + 80 * y;
                int N = 8 * ((f * e - c * d * g) * m - c * d * e - f * g - l * d * n);
                if(22 > y && y > 0 && x > 0 && 80 > x && D > z[o]) {
                    z[o] = D;
                    b[o] = ".,-~:;=!*#$@"[N > 0 ? N : 0];
                }
            }
        }
        ee_printf("\x1b[H");
        for(k = 0; k < 1761; k++) {
            zputchar(k % 80 ? b[k] : 10);
            A += 0.00004;
            B += 0.00002;
        }
        //usleep(30000);
        for(int e = 0; i<1000; i++)
        	ee_printf("");
    }
    return 0;
}
