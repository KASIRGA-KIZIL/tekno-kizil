// See LICENSE for license details.

#include <stdint.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>
#include <limits.h>
#include <sys/signal.h>

#undef strcmp

// This is the function that is called first (by the linker). 
// Calls the main function from software.
void _init(int cid, int nc)
{
  // only single-threaded programs should ever get here.
  int ret = main(0, 0);
}

