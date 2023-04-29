# 0 "dhry_2.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "dhry_2.c"
# 18 "dhry_2.c"
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
# 19 "dhry_2.c" 2







extern int Int_Glob;
extern char Ch_1_Glob;


Proc_6 (Enum_Val_Par, Enum_Ref_Par)




Enumeration Enum_Val_Par;
Enumeration *Enum_Ref_Par;
{
  *Enum_Ref_Par = Enum_Val_Par;
  if (! Func_3 (Enum_Val_Par))

    *Enum_Ref_Par = 3;
  switch (Enum_Val_Par)
  {
    case 0:
      *Enum_Ref_Par = 0;
      break;
    case 1:
      if (Int_Glob > 100)

      *Enum_Ref_Par = 0;
      else *Enum_Ref_Par = 3;
      break;
    case 2:
      *Enum_Ref_Par = 1;
      break;
    case 3: break;
    case 4:
      *Enum_Ref_Par = 2;
      break;
  }
}


Proc_7 (Int_1_Par_Val, Int_2_Par_Val, Int_Par_Ref)
# 73 "dhry_2.c"
One_Fifty Int_1_Par_Val;
One_Fifty Int_2_Par_Val;
One_Fifty *Int_Par_Ref;
{
  One_Fifty Int_Loc;

  Int_Loc = Int_1_Par_Val + 2;
  *Int_Par_Ref = Int_2_Par_Val + Int_Loc;
}


Proc_8 (Arr_1_Par_Ref, Arr_2_Par_Ref, Int_1_Par_Val, Int_2_Par_Val)




Arr_1_Dim Arr_1_Par_Ref;
Arr_2_Dim Arr_2_Par_Ref;
int Int_1_Par_Val;
int Int_2_Par_Val;
{
  One_Fifty Int_Index;
  One_Fifty Int_Loc;

  Int_Loc = Int_1_Par_Val + 5;
  Arr_1_Par_Ref [Int_Loc] = Int_2_Par_Val;
  Arr_1_Par_Ref [Int_Loc+1] = Arr_1_Par_Ref [Int_Loc];
  Arr_1_Par_Ref [Int_Loc+30] = Int_Loc;
  for (Int_Index = Int_Loc; Int_Index <= Int_Loc+1; ++Int_Index)
    Arr_2_Par_Ref [Int_Loc] [Int_Index] = Int_Loc;
  Arr_2_Par_Ref [Int_Loc] [Int_Loc-1] += 1;
  Arr_2_Par_Ref [Int_Loc+20] [Int_Loc] = Arr_1_Par_Ref [Int_Loc];
  Int_Glob = 5;
}


Enumeration Func_1 (Ch_1_Par_Val, Ch_2_Par_Val)






Capital_Letter Ch_1_Par_Val;
Capital_Letter Ch_2_Par_Val;
{
  Capital_Letter Ch_1_Loc;
  Capital_Letter Ch_2_Loc;

  Ch_1_Loc = Ch_1_Par_Val;
  Ch_2_Loc = Ch_1_Loc;
  if (Ch_2_Loc != Ch_2_Par_Val)

    return (0);
  else
  {
    Ch_1_Glob = Ch_1_Loc;
    return (1);
   }
}


Boolean Func_2 (Str_1_Par_Ref, Str_2_Par_Ref)





Str_30 Str_1_Par_Ref;
Str_30 Str_2_Par_Ref;
{
  One_Thirty Int_Loc;
      Capital_Letter Ch_Loc;

  Int_Loc = 2;
  while (Int_Loc <= 2)
    if (Func_1 (Str_1_Par_Ref[Int_Loc],
                Str_2_Par_Ref[Int_Loc+1]) == 0)

    {
      Ch_Loc = 'A';
      Int_Loc += 1;
    }
  if (Ch_Loc >= 'W' && Ch_Loc < 'Z')

    Int_Loc = 7;
  if (Ch_Loc == 'R')

    return (1);
  else
  {
    if (strcmp (Str_1_Par_Ref, Str_2_Par_Ref) > 0)

    {
      Int_Loc += 7;
      Int_Glob = Int_Loc;
      return (1);
    }
    else
      return (0);
  }
}


Boolean Func_3 (Enum_Par_Val)



Enumeration Enum_Par_Val;
{
  Enumeration Enum_Loc;

  Enum_Loc = Enum_Par_Val;
  if (Enum_Loc == 2)

    return (1);
  else
    return (0);
}
