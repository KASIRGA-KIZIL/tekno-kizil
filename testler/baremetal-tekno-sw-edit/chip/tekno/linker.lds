/*-- Assembler Linker --*/
/*-- There is ram and rom --*/
OUTPUT_ARCH( "riscv" )

MEMORY{  
    ram ( wxa!ri ) : ORIGIN = 0x40000000, LENGTH = 0x20000
}

SECTIONS
{

  /* text: test code section */
 . = 0x40000000;   

  PROVIDE( __global_pointer$ = . + 0x02000 );

    /* The program code and other data goes into ROM */
  .text : {
		. = ALIGN(4);
        *(.text)           /* .text sections (code) */
        *(.text*)          /* .text* sections (code) */
        *(.rodata)         /* .rodata sections (constants, strings, etc.) */
        *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
        *(.data)           /* .data sections */
        *(.data*)          /* .data* sections */
        *(.sdata)           /* .sdata sections */
        *(.sdata*)          /* .sdata* sections */
        *(.srodata)        /* .rodata sections (constants, strings, etc.) */
        *(.srodata*)       /* .rodata* sections (constants, strings, etc.) */
		. = ALIGN(4);
	} > ram


    .bss :                 /* uninitialized data */
    {
        . = ALIGN(4);
        *(.bss)
        *(.bss*)
        *(.sbss)
        *(.sbss*)
        *(COMMON)

        . = ALIGN(4);
    } > ram
  
}

