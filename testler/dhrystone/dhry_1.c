/*
 ****************************************************************************
 *
 *                   "DHRYSTONE" Benchmark Program
 *                   -----------------------------
 *                                                                            
 *  Version:    C, Version 2.1
 *                                                                            
 *  File:       dhry_1.c (part 2 of 3)
 *
 *  Date:       May 25, 1988
 *
 *  Author:     Reinhold P. Weicker
 *
 ****************************************************************************
 */

#include "dhry.h"
#include "ee_printf.h"

#ifndef DHRY_ITERS
#define DHRY_ITERS 2000000
#endif

#define CORETIMETYPE unsigned long int
typedef unsigned long int CORE_TICKS;
typedef double secs_ret;
#define GETMYTIME(_t)              (*_t = mytime())
#define MYTIMEDIFF(fin, ini)       ((fin) - (ini))
static CORETIMETYPE start_time_val, stop_time_val;

#define EE_TICKS_PER_SEC 100000000
#define HZ 100000000

void
start_time(void)
{
    GETMYTIME(&start_time_val);
}

void
stop_time(void)
{
    GETMYTIME(&stop_time_val);
}

CORE_TICKS
get_time(void)
{
    CORE_TICKS elapsed
        = (CORE_TICKS)(MYTIMEDIFF(stop_time_val, start_time_val));
    return elapsed;
}

secs_ret
time_in_secs(CORE_TICKS ticks)
{
    secs_ret retval = ((secs_ret)ticks) / (secs_ret)EE_TICKS_PER_SEC;
    return retval;
}

/* Global Variables: */

Rec_Pointer     Ptr_Glob,
                Next_Ptr_Glob;
int             Int_Glob;
Boolean         Bool_Glob;
char            Ch_1_Glob,
                Ch_2_Glob;
int             Arr_1_Glob [50];
int             Arr_2_Glob [50] [50];

extern char     *malloc ();
Enumeration     Func_1 ();
  /* forward declaration necessary since Enumeration may not simply be int */

#ifndef REG
        Boolean Reg = false;
#define REG
        /* REG becomes defined as empty */
        /* i.e. no register variables   */
#else
        Boolean Reg = true;
#endif

/* variables for time measurement: */

#ifdef TIMES
struct tms      time_info;
extern  int     times ();
                /* see library function "times" */
#define Too_Small_Time (2*HZ)
                /* Measurements should last at least about 2 seconds */
#endif
#ifdef TIME
//extern long     time();
                /* see library function "time"  */
#define Too_Small_Time 2
                /* Measurements should last at least 2 seconds */
#endif
#ifdef MSC_CLOCK
//extern clock_t	clock();
#define Too_Small_Time (2*HZ)
#endif

long            Begin_Time,
                End_Time,
                User_Time;
float           Microseconds,
                Dhrystones_Per_Second;

/* end of variables for time measurement */


main ()
/*****/

  /* main program, corresponds to procedures        */
  /* Main and Proc_0 in the Ada version             */
{
  init_uart();
  ee_printf ("Dhrystone Benchmark");
        One_Fifty       Int_1_Loc;
  REG   One_Fifty       Int_2_Loc;
        One_Fifty       Int_3_Loc;
  REG   char            Ch_Index;
        Enumeration     Enum_Loc;
        Str_30          Str_1_Loc;
        Str_30          Str_2_Loc;
  REG   int             Run_Index;
  REG   int             Number_Of_Runs;

  /* Initializations */

  Next_Ptr_Glob = (Rec_Pointer) malloc (sizeof (Rec_Type));
  Ptr_Glob = (Rec_Pointer) malloc (sizeof (Rec_Type));

  Ptr_Glob->Ptr_Comp                    = Next_Ptr_Glob;
  Ptr_Glob->Discr                       = Ident_1;
  Ptr_Glob->variant.var_1.Enum_Comp     = Ident_3;
  Ptr_Glob->variant.var_1.Int_Comp      = 40;
  strcpy (Ptr_Glob->variant.var_1.Str_Comp, 
          "DHRYSTONE PROGRAM, SOME STRING");
  strcpy (Str_1_Loc, "DHRYSTONE PROGRAM, 1'ST STRING");

  Arr_2_Glob [8][7] = 10;
        /* Was missing in published program. Without this statement,    */
        /* Arr_2_Glob [8][7] would have an undefined value.             */
        /* Warning: With 16-Bit processors and Number_Of_Runs > 32000,  */
        /* overflow may occur for this array element.                   */

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
#ifdef DHRY_ITERS
  Number_Of_Runs = DHRY_ITERS;
#else
  ee_printf ("Please give the number of runs through the benchmark: ");
  {
    int n;
    scanf ("%d", &n);
    Number_Of_Runs = n;
  }
  ee_printf ("\n");
#endif

  ee_printf ("Execution starts, %d runs through Dhrystone\n", Number_Of_Runs);

  /***************/
  /* Start timer */
  /***************/
 
#ifdef TIMES
  times (&time_info);
  Begin_Time = (long) time_info.tms_utime;
#endif
#ifdef TIME
  //Begin_Time = time ( (long *) 0);
#endif
#ifdef MSC_CLOCK
  //Begin_Time = clock();
  start_time();
  Begin_Time = get_time(); //time_in_secs(get_time());
#endif

  for (Run_Index = 1; Run_Index <= Number_Of_Runs; ++Run_Index)
  {

    Proc_5();
    Proc_4();
      /* Ch_1_Glob == 'A', Ch_2_Glob == 'B', Bool_Glob == true */
    Int_1_Loc = 2;
    Int_2_Loc = 3;
    strcpy (Str_2_Loc, "DHRYSTONE PROGRAM, 2'ND STRING");
    Enum_Loc = Ident_2;
    Bool_Glob = ! Func_2 (Str_1_Loc, Str_2_Loc);
      /* Bool_Glob == 1 */
    while (Int_1_Loc < Int_2_Loc)  /* loop body executed once */
    {
      Int_3_Loc = 5 * Int_1_Loc - Int_2_Loc;
        /* Int_3_Loc == 7 */
      Proc_7 (Int_1_Loc, Int_2_Loc, &Int_3_Loc);
        /* Int_3_Loc == 7 */
      Int_1_Loc += 1;
    } /* while */
      /* Int_1_Loc == 3, Int_2_Loc == 3, Int_3_Loc == 7 */
    Proc_8 (Arr_1_Glob, Arr_2_Glob, Int_1_Loc, Int_3_Loc);
      /* Int_Glob == 5 */
    Proc_1 (Ptr_Glob);
    for (Ch_Index = 'A'; Ch_Index <= Ch_2_Glob; ++Ch_Index)
                             /* loop body executed twice */
    {
      if (Enum_Loc == Func_1 (Ch_Index, 'C'))
          /* then, not executed */
        {
        Proc_6 (Ident_1, &Enum_Loc);
        strcpy (Str_2_Loc, "DHRYSTONE PROGRAM, 3'RD STRING");
        Int_2_Loc = Run_Index;
        Int_Glob = Run_Index;
        }
    }
      /* Int_1_Loc == 3, Int_2_Loc == 3, Int_3_Loc == 7 */
    Int_2_Loc = Int_2_Loc * Int_1_Loc;
    Int_1_Loc = Int_2_Loc / Int_3_Loc;
    Int_2_Loc = 7 * (Int_2_Loc - Int_3_Loc) - Int_1_Loc;
      /* Int_1_Loc == 1, Int_2_Loc == 13, Int_3_Loc == 7 */
    Proc_2 (&Int_1_Loc);
      /* Int_1_Loc == 5 */

  } /* loop "for Run_Index" */

  /**************/
  /* Stop timer */
  /**************/

#define MSC_CLOCK 1
  
#ifdef TIMES
  times (&time_info);
  End_Time = (long) time_info.tms_utime;
#endif
#ifdef TIME
  //End_Time = time ( (long *) 0);
#endif
#ifdef MSC_CLOCK
  //End_Time = clock();
  stop_time();
  End_Time = get_time(); //time_in_secs(get_time());
#endif

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

  User_Time = get_time(); //End_Time - Begin_Time;

  if (User_Time < Too_Small_Time)
  {
    ee_printf ("Measured time too small to obtain meaningful results\n");
    ee_printf ("Please increase number of runs\n");
    ee_printf ("\n");
  }
  else
  {
//#ifdef TIME
    //Microseconds = (float) User_Time * Mic_secs_Per_Second 
    //                    / (float) Number_Of_Runs;
    //Dhrystones_Per_Second = (float) Number_Of_Runs / (float) User_Time;
//#else
    Microseconds = (float) User_Time * Mic_secs_Per_Second 
                        / ((float) HZ * ((float) Number_Of_Runs));
    Dhrystones_Per_Second = ((float) HZ * (float) Number_Of_Runs)
                        / (float) User_Time;
//#endif
    ee_printf ("Microseconds for one run through Dhrystone: ");
    //ee_printf ("%6.1f \n", Microseconds);
    ee_printf ("%d \n", (int)Microseconds);
    ee_printf ("Dhrystones per Second:                      ");
    //ee_printf ("%6.1f \n", Dhrystones_Per_Second);
    ee_printf ("%d \n", (int)Dhrystones_Per_Second);
    ee_printf ("\n");
  }
  
}


Proc_1 (Ptr_Val_Par)
/******************/

REG Rec_Pointer Ptr_Val_Par;
    /* executed once */
{
  REG Rec_Pointer Next_Record = Ptr_Val_Par->Ptr_Comp;  
                                        /* == Ptr_Glob_Next */
  /* Local variable, initialized with Ptr_Val_Par->Ptr_Comp,    */
  /* corresponds to "rename" in Ada, "with" in Pascal           */
  
  structassign (*Ptr_Val_Par->Ptr_Comp, *Ptr_Glob); 
  Ptr_Val_Par->variant.var_1.Int_Comp = 5;
  Next_Record->variant.var_1.Int_Comp 
        = Ptr_Val_Par->variant.var_1.Int_Comp;
  Next_Record->Ptr_Comp = Ptr_Val_Par->Ptr_Comp;
  Proc_3 (&Next_Record->Ptr_Comp);
    /* Ptr_Val_Par->Ptr_Comp->Ptr_Comp 
                        == Ptr_Glob->Ptr_Comp */
  if (Next_Record->Discr == Ident_1)
    /* then, executed */
  {
    Next_Record->variant.var_1.Int_Comp = 6;
    Proc_6 (Ptr_Val_Par->variant.var_1.Enum_Comp, 
           &Next_Record->variant.var_1.Enum_Comp);
    Next_Record->Ptr_Comp = Ptr_Glob->Ptr_Comp;
    Proc_7 (Next_Record->variant.var_1.Int_Comp, 10, 
           &Next_Record->variant.var_1.Int_Comp);
  }
  else /* not executed */
    structassign (*Ptr_Val_Par, *Ptr_Val_Par->Ptr_Comp);
} /* Proc_1 */


Proc_2 (Int_Par_Ref)
/******************/
    /* executed once */
    /* *Int_Par_Ref == 1, becomes 4 */

One_Fifty   *Int_Par_Ref;
{
  One_Fifty  Int_Loc;  
  Enumeration   Enum_Loc;

  Int_Loc = *Int_Par_Ref + 10;
  do /* executed once */
    if (Ch_1_Glob == 'A')
      /* then, executed */
    {
      Int_Loc -= 1;
      *Int_Par_Ref = Int_Loc - Int_Glob;
      Enum_Loc = Ident_1;
    } /* if */
  while (Enum_Loc != Ident_1); /* true */
} /* Proc_2 */


Proc_3 (Ptr_Ref_Par)
/******************/
    /* executed once */
    /* Ptr_Ref_Par becomes Ptr_Glob */

Rec_Pointer *Ptr_Ref_Par;

{
  if (Ptr_Glob != Null)
    /* then, executed */
    *Ptr_Ref_Par = Ptr_Glob->Ptr_Comp;
  Proc_7 (10, Int_Glob, &Ptr_Glob->variant.var_1.Int_Comp);
} /* Proc_3 */


Proc_4 () /* without parameters */
/*******/
    /* executed once */
{
  Boolean Bool_Loc;

  Bool_Loc = Ch_1_Glob == 'A';
  Bool_Glob = Bool_Loc | Bool_Glob;
  Ch_2_Glob = 'B';
} /* Proc_4 */


Proc_5 () /* without parameters */
/*******/
    /* executed once */
{
  Ch_1_Glob = 'A';
  Bool_Glob = false;
} /* Proc_5 */


        /* Procedure for the assignment of structures,          */
        /* if the C compiler doesn't support this feature       */
#ifdef  NOSTRUCTASSIGN
memcpy (d, s, l)
register char   *d;
register char   *s;
register int    l;
{
        while (l--) *d++ = *s++;
}
#endif


