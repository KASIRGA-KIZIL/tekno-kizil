# 0 "dhry_1.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "dhry_1.c"
# 18 "dhry_1.c"
# 1 "dhry.h" 1
# 385 "dhry.h"
  typedef int Enumeration;
# 401 "dhry.h"
typedef int One_Thirty;
typedef int One_Fifty;
typedef char Capital_Letter;
typedef int Boolean;
typedef char Str_30 [31];
typedef int Arr_1_Dim [50];
typedef int Arr_2_Dim [50] [50];

typedef struct record
    {
    struct record *Ptr_Comp;
    Enumeration Discr;
    union {
          struct {
                  Enumeration Enum_Comp;
                  int Int_Comp;
                  char Str_Comp [31];
                  } var_1;
          struct {
                  Enumeration E_Comp_2;
                  char Str_2_Comp [31];
                  } var_2;
          struct {
                  char Ch_1_Comp;
                  char Ch_2_Comp;
                  } var_3;
          } variant;
      } Rec_Type, *Rec_Pointer;
# 19 "dhry_1.c" 2
# 1 "ee_printf.h" 1
# 18 "ee_printf.h"
# 1 "/home/shc/projects/riscv32im-toolchain/_install/lib/gcc/riscv32-unknown-elf/12.2.0/include/stdarg.h" 1 3 4
# 40 "/home/shc/projects/riscv32im-toolchain/_install/lib/gcc/riscv32-unknown-elf/12.2.0/include/stdarg.h" 3 4

# 40 "/home/shc/projects/riscv32im-toolchain/_install/lib/gcc/riscv32-unknown-elf/12.2.0/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 99 "/home/shc/projects/riscv32im-toolchain/_install/lib/gcc/riscv32-unknown-elf/12.2.0/include/stdarg.h" 3 4
typedef __gnuc_va_list va_list;
# 19 "ee_printf.h" 2

# 1 "/home/shc/projects/riscv32im-toolchain/_install/lib/gcc/riscv32-unknown-elf/12.2.0/include/stdint.h" 1 3 4
# 11 "/home/shc/projects/riscv32im-toolchain/_install/lib/gcc/riscv32-unknown-elf/12.2.0/include/stdint.h" 3 4
# 1 "/home/shc/projects/riscv32im-toolchain/_install/lib/gcc/riscv32-unknown-elf/12.2.0/include/stdint-gcc.h" 1 3 4
# 34 "/home/shc/projects/riscv32im-toolchain/_install/lib/gcc/riscv32-unknown-elf/12.2.0/include/stdint-gcc.h" 3 4
typedef signed char int8_t;


typedef short int int16_t;


typedef long int int32_t;


typedef long long int int64_t;


typedef unsigned char uint8_t;


typedef short unsigned int uint16_t;


typedef long unsigned int uint32_t;


typedef long long unsigned int uint64_t;




typedef signed char int_least8_t;
typedef short int int_least16_t;
typedef long int int_least32_t;
typedef long long int int_least64_t;
typedef unsigned char uint_least8_t;
typedef short unsigned int uint_least16_t;
typedef long unsigned int uint_least32_t;
typedef long long unsigned int uint_least64_t;



typedef int int_fast8_t;
typedef int int_fast16_t;
typedef int int_fast32_t;
typedef long long int int_fast64_t;
typedef unsigned int uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned int uint_fast32_t;
typedef long long unsigned int uint_fast64_t;




typedef int intptr_t;


typedef unsigned int uintptr_t;




typedef long long int intmax_t;
typedef long long unsigned int uintmax_t;
# 12 "/home/shc/projects/riscv32im-toolchain/_install/lib/gcc/riscv32-unknown-elf/12.2.0/include/stdint.h" 2 3 4
# 21 "ee_printf.h" 2



# 23 "ee_printf.h"
typedef long ee_size_t;

char heap_memory2[1024];
int heap_memory_used2 = 0;

char *malloc(int size)
{
 char *p = heap_memory2 + heap_memory_used2;

 heap_memory_used2 += size;
 if (heap_memory_used2 > 1024)
  asm volatile ("ebreak");
 return p;
}

char *strcpy(char* dst, const char* src)
{
 char *r = dst;

 while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
 {
  char c = *(src++);
  *(dst++) = c;
  if (!c) return r;
 }

 while (1)
 {
  uint32_t v = *(uint32_t*)src;

  if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
  {
   dst[0] = v & 0xff;
   if ((v & 0xff) == 0)
    return r;
   v = v >> 8;

   dst[1] = v & 0xff;
   if ((v & 0xff) == 0)
    return r;
   v = v >> 8;

   dst[2] = v & 0xff;
   if ((v & 0xff) == 0)
    return r;
   v = v >> 8;

   dst[3] = v & 0xff;
   return r;
  }

  *(uint32_t*)dst = v;
  src += 4;
  dst += 4;
 }
}







unsigned long int mytime()
{
 return (*(volatile uint32_t*)0x30000000);
}
# 99 "ee_printf.h"
typedef union
{
 struct {
  unsigned int tx_en : 1;
  unsigned int rx_en : 1;
  unsigned int null : 14;
  unsigned int baud_div : 16;
 } fields;
 uint32_t bits;
}uart_ctrl;

typedef union
{
 struct {
  unsigned int tx_full : 1;
  unsigned int rx_full : 1;
  unsigned int tx_empty : 1;
  unsigned int rx_empty : 1;
  unsigned int null : 28;
 } fields;
 uint32_t bits;
}uart_status;

int uart_txfull(){
 uart_status uart_stat;
 uart_stat.bits = (*(volatile uint32_t*)0x20000004);
 return uart_stat.fields.tx_full;
}

void zputchar(char c)
{
 while(uart_txfull());
 if (c == '\n')
  zputchar('\r');
 (*(volatile uint32_t*)0x2000000c) = c;
}
# 146 "ee_printf.h"
static char * digits = "0123456789abcdefghijklmnopqrstuvwxyz";
static char * upper_digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
static ee_size_t strnlen(const char *s, ee_size_t count);

static ee_size_t
strnlen(const char *s, ee_size_t count)
{
    const char *sc;
    for (sc = s; *sc != '\0' && count--; ++sc)
        ;
    return sc - s;
}

static int
skip_atoi(const char **s)
{
    int i = 0;
    while (((**s) >= '0' && (**s) <= '9'))
        i = i * 10 + *((*s)++) - '0';
    return i;
}

static char *
number(char *str, long num, int base, int size, int precision, int type)
{
    char c, sign, tmp[66];
    char *dig = digits;
    int i;

    if (type & (1 << 6))
        dig = upper_digits;
    if (type & (1 << 4))
        type &= ~(1 << 0);
    if (base < 2 || base > 36)
        return 0;

    c = (type & (1 << 0)) ? '0' : ' ';
    sign = 0;
    if (type & (1 << 1))
    {
        if (num < 0)
        {
            sign = '-';
            num = -num;
            size--;
        }
        else if (type & (1 << 2))
        {
            sign = '+';
            size--;
        }
        else if (type & (1 << 3))
        {
            sign = ' ';
            size--;
        }
    }

    if (type & (1 << 5))
    {
        if (base == 16)
            size -= 2;
        else if (base == 8)
            size--;
    }

    i = 0;

    if (num == 0)
        tmp[i++] = '0';
    else
    {
        while (num != 0)
        {
            tmp[i++] = dig[((unsigned long)num) % (unsigned)base];
            num = ((unsigned long)num) / (unsigned)base;
        }
    }

    if (i > precision)
        precision = i;
    size -= precision;
    if (!(type & ((1 << 0) | (1 << 4))))
        while (size-- > 0)
            *str++ = ' ';
    if (sign)
        *str++ = sign;

    if (type & (1 << 5))
    {
        if (base == 8)
            *str++ = '0';
        else if (base == 16)
        {
            *str++ = '0';
            *str++ = digits[33];
        }
    }

    if (!(type & (1 << 4)))
        while (size-- > 0)
            *str++ = c;
    while (i < precision--)
        *str++ = '0';
    while (i-- > 0)
        *str++ = tmp[i];
    while (size-- > 0)
        *str++ = ' ';

    return str;
}

static char *
eaddr(char *str, unsigned char *addr, int size, int precision, int type)
{
    char tmp[24];
    char *dig = digits;
    int i, len;

    if (type & (1 << 6))
        dig = upper_digits;
    len = 0;
    for (i = 0; i < 6; i++)
    {
        if (i != 0)
            tmp[len++] = ':';
        tmp[len++] = dig[addr[i] >> 4];
        tmp[len++] = dig[addr[i] & 0x0F];
    }

    if (!(type & (1 << 4)))
        while (len < size--)
            *str++ = ' ';
    for (i = 0; i < len; ++i)
        *str++ = tmp[i];
    while (len < size--)
        *str++ = ' ';

    return str;
}

static char *
iaddr(char *str, unsigned char *addr, int size, int precision, int type)
{
    char tmp[24];
    int i, n, len;

    len = 0;
    for (i = 0; i < 4; i++)
    {
        if (i != 0)
            tmp[len++] = '.';
        n = addr[i];

        if (n == 0)
            tmp[len++] = digits[0];
        else
        {
            if (n >= 100)
            {
                tmp[len++] = digits[n / 100];
                n = n % 100;
                tmp[len++] = digits[n / 10];
                n = n % 10;
            }
            else if (n >= 10)
            {
                tmp[len++] = digits[n / 10];
                n = n % 10;
            }

            tmp[len++] = digits[n];
        }
    }

    if (!(type & (1 << 4)))
        while (len < size--)
            *str++ = ' ';
    for (i = 0; i < len; ++i)
        *str++ = tmp[i];
    while (len < size--)
        *str++ = ' ';

    return str;
}
# 576 "ee_printf.h"
static int
ee_vsprintf(char *buf, const char *fmt, va_list args)
{
    int len;
    unsigned long num;
    int i, base;
    char * str;
    char * s;

    int flags;

    int field_width;
    int precision;

    int qualifier;

    for (str = buf; *fmt; fmt++)
    {
        if (*fmt != '%')
        {
            *str++ = *fmt;
            continue;
        }


        flags = 0;
    repeat:
        fmt++;
        switch (*fmt)
        {
            case '-':
                flags |= (1 << 4);
                goto repeat;
            case '+':
                flags |= (1 << 2);
                goto repeat;
            case ' ':
                flags |= (1 << 3);
                goto repeat;
            case '#':
                flags |= (1 << 5);
                goto repeat;
            case '0':
                flags |= (1 << 0);
                goto repeat;
        }


        field_width = -1;
        if (((*fmt) >= '0' && (*fmt) <= '9'))
            field_width = skip_atoi(&fmt);
        else if (*fmt == '*')
        {
            fmt++;
            field_width = 
# 630 "ee_printf.h" 3 4
                         __builtin_va_arg(
# 630 "ee_printf.h"
                         args
# 630 "ee_printf.h" 3 4
                         ,
# 630 "ee_printf.h"
                         int
# 630 "ee_printf.h" 3 4
                         )
# 630 "ee_printf.h"
                                          ;
            if (field_width < 0)
            {
                field_width = -field_width;
                flags |= (1 << 4);
            }
        }


        precision = -1;
        if (*fmt == '.')
        {
            ++fmt;
            if (((*fmt) >= '0' && (*fmt) <= '9'))
                precision = skip_atoi(&fmt);
            else if (*fmt == '*')
            {
                ++fmt;
                precision = 
# 648 "ee_printf.h" 3 4
                           __builtin_va_arg(
# 648 "ee_printf.h"
                           args
# 648 "ee_printf.h" 3 4
                           ,
# 648 "ee_printf.h"
                           int
# 648 "ee_printf.h" 3 4
                           )
# 648 "ee_printf.h"
                                            ;
            }
            if (precision < 0)
                precision = 0;
        }


        qualifier = -1;
        if (*fmt == 'l' || *fmt == 'L')
        {
            qualifier = *fmt;
            fmt++;
        }


        base = 10;

        switch (*fmt)
        {
            case 'c':
                if (!(flags & (1 << 4)))
                    while (--field_width > 0)
                        *str++ = ' ';
                *str++ = (unsigned char)
# 671 "ee_printf.h" 3 4
                                       __builtin_va_arg(
# 671 "ee_printf.h"
                                       args
# 671 "ee_printf.h" 3 4
                                       ,
# 671 "ee_printf.h"
                                       int
# 671 "ee_printf.h" 3 4
                                       )
# 671 "ee_printf.h"
                                                        ;
                while (--field_width > 0)
                    *str++ = ' ';
                continue;

            case 's':
                s = 
# 677 "ee_printf.h" 3 4
                   __builtin_va_arg(
# 677 "ee_printf.h"
                   args
# 677 "ee_printf.h" 3 4
                   ,
# 677 "ee_printf.h"
                   char *
# 677 "ee_printf.h" 3 4
                   )
# 677 "ee_printf.h"
                                       ;
                if (!s)
                    s = "<NULL>";
                len = strnlen(s, precision);
                if (!(flags & (1 << 4)))
                    while (len < field_width--)
                        *str++ = ' ';
                for (i = 0; i < len; ++i)
                    *str++ = *s++;
                while (len < field_width--)
                    *str++ = ' ';
                continue;

            case 'p':
                if (field_width == -1)
                {
                    field_width = 2 * sizeof(void *);
                    flags |= (1 << 0);
                }
                str = number(str,
                             (unsigned long)
# 697 "ee_printf.h" 3 4
                                           __builtin_va_arg(
# 697 "ee_printf.h"
                                           args
# 697 "ee_printf.h" 3 4
                                           ,
# 697 "ee_printf.h"
                                           void *
# 697 "ee_printf.h" 3 4
                                           )
# 697 "ee_printf.h"
                                                               ,
                             16,
                             field_width,
                             precision,
                             flags);
                continue;

            case 'A':
                flags |= (1 << 6);

            case 'a':
                if (qualifier == 'l')
                    str = eaddr(str,
                                
# 710 "ee_printf.h" 3 4
                               __builtin_va_arg(
# 710 "ee_printf.h"
                               args
# 710 "ee_printf.h" 3 4
                               ,
# 710 "ee_printf.h"
                               unsigned char *
# 710 "ee_printf.h" 3 4
                               )
# 710 "ee_printf.h"
                                                            ,
                                field_width,
                                precision,
                                flags);
                else
                    str = iaddr(str,
                                
# 716 "ee_printf.h" 3 4
                               __builtin_va_arg(
# 716 "ee_printf.h"
                               args
# 716 "ee_printf.h" 3 4
                               ,
# 716 "ee_printf.h"
                               unsigned char *
# 716 "ee_printf.h" 3 4
                               )
# 716 "ee_printf.h"
                                                            ,
                                field_width,
                                precision,
                                flags);
                continue;


            case 'o':
                base = 8;
                break;

            case 'X':
                flags |= (1 << 6);

            case 'x':
                base = 16;
                break;

            case 'd':
            case 'i':
                flags |= (1 << 1);

            case 'u':
                break;
# 754 "ee_printf.h"
            default:
                if (*fmt != '%')
                    *str++ = '%';
                if (*fmt)
                    *str++ = *fmt;
                else
                    --fmt;
                continue;
        }

        if (qualifier == 'l')
            num = 
# 765 "ee_printf.h" 3 4
                 __builtin_va_arg(
# 765 "ee_printf.h"
                 args
# 765 "ee_printf.h" 3 4
                 ,
# 765 "ee_printf.h"
                 unsigned long
# 765 "ee_printf.h" 3 4
                 )
# 765 "ee_printf.h"
                                            ;
        else if (flags & (1 << 1))
            num = 
# 767 "ee_printf.h" 3 4
                 __builtin_va_arg(
# 767 "ee_printf.h"
                 args
# 767 "ee_printf.h" 3 4
                 ,
# 767 "ee_printf.h"
                 int
# 767 "ee_printf.h" 3 4
                 )
# 767 "ee_printf.h"
                                  ;
        else
            num = 
# 769 "ee_printf.h" 3 4
                 __builtin_va_arg(
# 769 "ee_printf.h"
                 args
# 769 "ee_printf.h" 3 4
                 ,
# 769 "ee_printf.h"
                 unsigned int
# 769 "ee_printf.h" 3 4
                 )
# 769 "ee_printf.h"
                                           ;

        str = number(str, num, base, field_width, precision, flags);
    }

    *str = '\0';
    return str - buf;
}

void
uart_send_char(char c)
{
# 795 "ee_printf.h"
    zputchar(c);
}

int
ee_printf(const char *fmt, ...)
{
    char buf[1024], *p;
    va_list args;
    int n = 0;

    
# 805 "ee_printf.h" 3 4
   __builtin_va_start(
# 805 "ee_printf.h"
   args
# 805 "ee_printf.h" 3 4
   ,
# 805 "ee_printf.h"
   fmt
# 805 "ee_printf.h" 3 4
   )
# 805 "ee_printf.h"
                      ;
    ee_vsprintf(buf, fmt, args);
    
# 807 "ee_printf.h" 3 4
   __builtin_va_end(
# 807 "ee_printf.h"
   args
# 807 "ee_printf.h" 3 4
   )
# 807 "ee_printf.h"
               ;
    p = buf;
    while (*p)
    {
        uart_send_char(*p);
        n++;
        p++;
    }

    return n;
}

void init_uart(){
    uart_ctrl uart_control;
    uart_control.fields.tx_en = 0x1;
    uart_control.fields.tx_en = 0x1;
    uart_control.fields.baud_div = 60000000/115200;
    (*(volatile uint32_t*)0x20000000) = uart_control.bits;
}
# 20 "dhry_1.c" 2






typedef unsigned long int CORE_TICKS;
typedef double secs_ret;


static unsigned long int start_time_val, stop_time_val;




void
start_time(void)
{
    (*&start_time_val = mytime());
}

void
stop_time(void)
{
    (*&stop_time_val = mytime());
}

CORE_TICKS
get_time(void)
{
    CORE_TICKS elapsed
        = (CORE_TICKS)(((stop_time_val) - (start_time_val)));
    return elapsed;
}

secs_ret
time_in_secs(CORE_TICKS ticks)
{
    secs_ret retval = ((secs_ret)ticks) / (secs_ret)60000000;
    return retval;
}



Rec_Pointer Ptr_Glob,
                Next_Ptr_Glob;
int Int_Glob;
Boolean Bool_Glob;
char Ch_1_Glob,
                Ch_2_Glob;
int Arr_1_Glob [50];
int Arr_2_Glob [50] [50];

extern char *malloc ();
Enumeration Func_1 ();



        Boolean Reg = 0;
# 106 "dhry_1.c"
long Begin_Time,
                End_Time,
                User_Time;
float Microseconds,
                Dhrystones_Per_Second;




main ()




{
  init_uart();
  ee_printf ("Dhrystone Benchmark");
        One_Fifty Int_1_Loc;
  One_Fifty Int_2_Loc;
        One_Fifty Int_3_Loc;
  char Ch_Index;
        Enumeration Enum_Loc;
        Str_30 Str_1_Loc;
        Str_30 Str_2_Loc;
  int Run_Index;
  int Number_Of_Runs;



  Next_Ptr_Glob = (Rec_Pointer) malloc (sizeof (Rec_Type));
  Ptr_Glob = (Rec_Pointer) malloc (sizeof (Rec_Type));

  Ptr_Glob->Ptr_Comp = Next_Ptr_Glob;
  Ptr_Glob->Discr = 0;
  Ptr_Glob->variant.var_1.Enum_Comp = 2;
  Ptr_Glob->variant.var_1.Int_Comp = 40;
  strcpy (Ptr_Glob->variant.var_1.Str_Comp,
          "DHRYSTONE PROGRAM, SOME STRING");
  strcpy (Str_1_Loc, "DHRYSTONE PROGRAM, 1'ST STRING");

  Arr_2_Glob [8][7] = 10;





  ee_printf ("\n");
  ee_printf ("Dhrystone Benchmark, Version 2.1 (Language: C)\n");
  ee_printf ("\n");
  if (Reg)
  {
    ee_printf ("Program compiled with 'register' attribute\n");
    ee_printf ("\n");
  }
  else
  {
    ee_printf ("Program compiled without 'register' attribute\n");
    ee_printf ("\n");
  }

  Number_Of_Runs = 2000000;
# 177 "dhry_1.c"
  ee_printf ("Execution starts, %d runs through Dhrystone\n", Number_Of_Runs);
# 196 "dhry_1.c"
  for (Run_Index = 1; Run_Index <= Number_Of_Runs; ++Run_Index)
  {

    Proc_5();
    Proc_4();

    Int_1_Loc = 2;
    Int_2_Loc = 3;
    strcpy (Str_2_Loc, "DHRYSTONE PROGRAM, 2'ND STRING");
    Enum_Loc = 1;
    Bool_Glob = ! Func_2 (Str_1_Loc, Str_2_Loc);

    while (Int_1_Loc < Int_2_Loc)
    {
      Int_3_Loc = 5 * Int_1_Loc - Int_2_Loc;

      Proc_7 (Int_1_Loc, Int_2_Loc, &Int_3_Loc);

      Int_1_Loc += 1;
    }

    Proc_8 (Arr_1_Glob, Arr_2_Glob, Int_1_Loc, Int_3_Loc);

    Proc_1 (Ptr_Glob);
    for (Ch_Index = 'A'; Ch_Index <= Ch_2_Glob; ++Ch_Index)

    {
      if (Enum_Loc == Func_1 (Ch_Index, 'C'))

        {
        Proc_6 (0, &Enum_Loc);
        strcpy (Str_2_Loc, "DHRYSTONE PROGRAM, 3'RD STRING");
        Int_2_Loc = Run_Index;
        Int_Glob = Run_Index;
        }
    }

    Int_2_Loc = Int_2_Loc * Int_1_Loc;
    Int_1_Loc = Int_2_Loc / Int_3_Loc;
    Int_2_Loc = 7 * (Int_2_Loc - Int_3_Loc) - Int_1_Loc;

    Proc_2 (&Int_1_Loc);


  }
# 257 "dhry_1.c"
  stop_time();
  End_Time = get_time();


  ee_printf ("Execution ends\n");
  ee_printf ("\n");
  ee_printf ("Final values of the variables used in the benchmark:\n");
  ee_printf ("\n");
  ee_printf ("Int_Glob:            %d\n", Int_Glob);
  ee_printf ("        should be:   %d\n", 5);
  ee_printf ("Bool_Glob:           %d\n", Bool_Glob);
  ee_printf ("        should be:   %d\n", 1);
  ee_printf ("Ch_1_Glob:           %c\n", Ch_1_Glob);
  ee_printf ("        should be:   %c\n", 'A');
  ee_printf ("Ch_2_Glob:           %c\n", Ch_2_Glob);
  ee_printf ("        should be:   %c\n", 'B');
  ee_printf ("Arr_1_Glob[8]:       %d\n", Arr_1_Glob[8]);
  ee_printf ("        should be:   %d\n", 7);
  ee_printf ("Arr_2_Glob[8][7]:    %d\n", Arr_2_Glob[8][7]);
  ee_printf ("        should be:   Number_Of_Runs + 10\n");
  ee_printf ("Ptr_Glob->\n");
  ee_printf ("  Ptr_Comp:          %d\n", (int) Ptr_Glob->Ptr_Comp);
  ee_printf ("        should be:   (implementation-dependent)\n");
  ee_printf ("  Discr:             %d\n", Ptr_Glob->Discr);
  ee_printf ("        should be:   %d\n", 0);
  ee_printf ("  Enum_Comp:         %d\n", Ptr_Glob->variant.var_1.Enum_Comp);
  ee_printf ("        should be:   %d\n", 2);
  ee_printf ("  Int_Comp:          %d\n", Ptr_Glob->variant.var_1.Int_Comp);
  ee_printf ("        should be:   %d\n", 17);
  ee_printf ("  Str_Comp:          %s\n", Ptr_Glob->variant.var_1.Str_Comp);
  ee_printf ("        should be:   DHRYSTONE PROGRAM, SOME STRING\n");
  ee_printf ("Next_Ptr_Glob->\n");
  ee_printf ("  Ptr_Comp:          %d\n", (int) Next_Ptr_Glob->Ptr_Comp);
  ee_printf ("        should be:   (implementation-dependent), same as above\n");
  ee_printf ("  Discr:             %d\n", Next_Ptr_Glob->Discr);
  ee_printf ("        should be:   %d\n", 0);
  ee_printf ("  Enum_Comp:         %d\n", Next_Ptr_Glob->variant.var_1.Enum_Comp);
  ee_printf ("        should be:   %d\n", 1);
  ee_printf ("  Int_Comp:          %d\n", Next_Ptr_Glob->variant.var_1.Int_Comp);
  ee_printf ("        should be:   %d\n", 18);
  ee_printf ("  Str_Comp:          %s\n",
                                Next_Ptr_Glob->variant.var_1.Str_Comp);
  ee_printf ("        should be:   DHRYSTONE PROGRAM, SOME STRING\n");
  ee_printf ("Int_1_Loc:           %d\n", Int_1_Loc);
  ee_printf ("        should be:   %d\n", 5);
  ee_printf ("Int_2_Loc:           %d\n", Int_2_Loc);
  ee_printf ("        should be:   %d\n", 13);
  ee_printf ("Int_3_Loc:           %d\n", Int_3_Loc);
  ee_printf ("        should be:   %d\n", 7);
  ee_printf ("Enum_Loc:            %d\n", Enum_Loc);
  ee_printf ("        should be:   %d\n", 1);
  ee_printf ("Str_1_Loc:           %s\n", Str_1_Loc);
  ee_printf ("        should be:   DHRYSTONE PROGRAM, 1'ST STRING\n");
  ee_printf ("Str_2_Loc:           %s\n", Str_2_Loc);
  ee_printf ("        should be:   DHRYSTONE PROGRAM, 2'ND STRING\n");
  ee_printf ("\n");

  User_Time = get_time();

  if (User_Time < 2)
  {
    ee_printf ("Measured time too small to obtain meaningful results\n");
    ee_printf ("Please increase number of runs\n");
    ee_printf ("\n");
  }
  else
  {





    Microseconds = (float) User_Time * 1000000
                        / ((float) 60000000 * ((float) Number_Of_Runs));
    Dhrystones_Per_Second = ((float) 60000000 * (float) Number_Of_Runs)
                        / (float) User_Time;

    ee_printf ("Microseconds for one run through Dhrystone: ");

    ee_printf ("%d \n", (int)Microseconds);
    ee_printf ("Dhrystones per Second:                      ");

    ee_printf ("%d \n", (int)Dhrystones_Per_Second);
    ee_printf ("\n");
  }

}


Proc_1 (Ptr_Val_Par)


 Rec_Pointer Ptr_Val_Par;

{
  Rec_Pointer Next_Record = Ptr_Val_Par->Ptr_Comp;




  *Ptr_Val_Par->Ptr_Comp = *Ptr_Glob;
  Ptr_Val_Par->variant.var_1.Int_Comp = 5;
  Next_Record->variant.var_1.Int_Comp
        = Ptr_Val_Par->variant.var_1.Int_Comp;
  Next_Record->Ptr_Comp = Ptr_Val_Par->Ptr_Comp;
  Proc_3 (&Next_Record->Ptr_Comp);


  if (Next_Record->Discr == 0)

  {
    Next_Record->variant.var_1.Int_Comp = 6;
    Proc_6 (Ptr_Val_Par->variant.var_1.Enum_Comp,
           &Next_Record->variant.var_1.Enum_Comp);
    Next_Record->Ptr_Comp = Ptr_Glob->Ptr_Comp;
    Proc_7 (Next_Record->variant.var_1.Int_Comp, 10,
           &Next_Record->variant.var_1.Int_Comp);
  }
  else
    *Ptr_Val_Par = *Ptr_Val_Par->Ptr_Comp;
}


Proc_2 (Int_Par_Ref)




One_Fifty *Int_Par_Ref;
{
  One_Fifty Int_Loc;
  Enumeration Enum_Loc;

  Int_Loc = *Int_Par_Ref + 10;
  do
    if (Ch_1_Glob == 'A')

    {
      Int_Loc -= 1;
      *Int_Par_Ref = Int_Loc - Int_Glob;
      Enum_Loc = 0;
    }
  while (Enum_Loc != 0);
}


Proc_3 (Ptr_Ref_Par)




Rec_Pointer *Ptr_Ref_Par;

{
  if (Ptr_Glob != 0)

    *Ptr_Ref_Par = Ptr_Glob->Ptr_Comp;
  Proc_7 (10, Int_Glob, &Ptr_Glob->variant.var_1.Int_Comp);
}


Proc_4 ()


{
  Boolean Bool_Loc;

  Bool_Loc = Ch_1_Glob == 'A';
  Bool_Glob = Bool_Loc | Bool_Glob;
  Ch_2_Glob = 'B';
}


Proc_5 ()


{
  Ch_1_Glob = 'A';
  Bool_Glob = 0;
}
