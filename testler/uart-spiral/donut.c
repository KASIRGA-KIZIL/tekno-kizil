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

 #define ASM_ITERATE

// Define to use double (floating point operations), otherwise integer
// arithmetics is used.
//#define USE_DOUBLE

// maximum number of iterations of the inner loop
#define MAXITERATE 64


#define IT8(x) ((x) * 255 / MAXITERATE)

#ifdef USE_DOUBLE
#ifndef __ASSEMBLER__
typedef double nint_t;
#endif
#define NORM_FACT 1
#else
#ifdef __ASSEMBLER__
#define NORM_FACT (1 << NORM_BITS)
#else
typedef long nint_t;
#define NORM_FACT ((nint_t)1 << NORM_BITS)
#endif
#define NORM_BITS 13
#endif

#ifndef __ASSEMBLER__
// prototype for iterate()
int iterate(nint_t real0, nint_t imag0);
#endif
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include <unistd.h> // notice this! you need it!

//#include "intfract.h"

#define clear() ee_printf("\033[H\033[J")
#define gotoxy(x,y) ee_printf("\033[%d;%dH", (y), (x))
int iterate(nint_t real0, nint_t imag0)
{
   nint_t realq, imagq, real, imag;
   int i;

   real = real0;
   imag = imag0;
   for (i = 0; i < MAXITERATE; i++)
   {
     realq = (real * real) >> NORM_BITS;
     imagq = (imag * imag) >> NORM_BITS;

     if ((realq + imagq) > (nint_t) 4 * NORM_FACT)
        break;

     imag = ((real * imag) >> (NORM_BITS - 1)) + imag0;
     real = realq - imagq + real0;
   }
   return i;
}
/*! This function contains the outer loop, i.e. calculate the coordinates
 * within the complex plane for each pixel and then call iterate().
 * @param image Pointer to image array of size hres * vres elements.
 * @param realmin Minimun real value of image.
 * @param imagmin Minimum imaginary value of image.
 * @param realmax Maximum real value.
 * @param imagmax Maximum imaginary value.
 * @param hres Pixel width of image.
 * @param vres Pixel height of image.
 */
void mand_calc(int *image, nint_t realmin, nint_t imagmin, nint_t realmax, nint_t imagmax, int hres, int vres)
{
  nint_t deltareal, deltaimag, real0,  imag0;
  int x, y;

  deltareal = (realmax - realmin) / hres;
  deltaimag = (imagmax - imagmin) / vres;

  real0 = realmin;
  for (x = 0; x < hres; x++)
  {
    imag0 = imagmax;
    for (y = 0; y < vres; y++)
    {
      *(image + x + hres * y) = iterate(real0, imag0);
      imag0 -= deltaimag;
    }
    real0 += deltareal;
  }
}


// Macros for extracting the red, green, and blue components from an RGB565 color value
#define RED(color)   (((color) >> 11) & 0x1f)
#define GREEN(color) (((color) >> 5) & 0x3f)
#define BLUE(color)  ((color) & 0x1f)
   const char brightnessMap[] = {
      '@', // brightness < 20
      '#', // brightness < 40
      '*', // brightness < 60
      '+', // brightness < 80
      '=', // brightness < 100
      '-', // brightness < 120
      ':', // brightness < 140
      '.', // brightness < 160
      ' ', // brightness < 180
      ' '  // brightness >= 180
   };
char mapColorToAscii(int color) {
   // Calculate the brightness of the color
   int brightness = ((RED(color)) + (GREEN(color)) + (BLUE(color))) / 4;
   // Map the brightness to an ASCII character
   return brightnessMap[(brightness)];
}

#include <math.h>

#define WIDTH 80
#define HEIGHT 20

int main() {
    init_uart();
    
    /*
    int digit[8];
    int_to_bin_digit(0xeb, 8, digit);
    
    for(int a=0; a<8; a++)
        ee_printf("%d",digit[i]);
    
    ee_printf("\n");
    */
/*
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
        	ee_printf("--------------------");
    }
    */
    
      
      
      int x, y;
    double t, r;
    for (t = 0; ; t += 0.1) {
        for (r = 0; r < WIDTH / 2; r += 0.1) {
            x = WIDTH / 2 + r * cos(t + r / 10);
            y = HEIGHT / 2 + r * sin(t + r / 10);
            gotoxy(x,y);
            ee_printf("%d;%d", y, x);
        }
        
        for(int i = 0; i<200; i++)
        	ee_printf("");
        clear();
        
        for (int i = 0 ; i < 8 ; i++)
        {
            while(UART_STATUS & 0xf >= 8);
            ee_printf("rx%d,%c\n",i,UART_RDATA);
        }
    }
    return 0;
}
