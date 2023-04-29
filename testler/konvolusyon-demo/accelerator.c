
///////////////////////////////////////////////////////////////////////////////////////////////////
// Company:     TUTEL
// Project:     Teknofest Chip Competition 2023
//***********************************************************************************************// 
// Create Date: 13/01/2023
// Module Name: accelerator_driver.c
// Description: Accelerator driver for teknofest.
//
///////////////////////////////////////////////////////////////////////////////////////////////////

void inst_conv_ld_w(int enable, int source1, int source2)         
{
	if(enable == 0){
		asm volatile("conv.ld.w %[rs1], %[rs2]\n\t"
					:/*no output*/
					:[rs1] "r" (source1), [rs2] "r" (source2));
	} else {
		asm volatile("conv.ld.w.en %[rs1], %[rs2]\n\t"
					:/*no output*/
					:[rs1] "r" (source1), [rs2] "r" (source2));
	}
}

void inst_conv_clr_w()
{
    asm volatile("conv.clr.w\n\t"
                :/*no output*/
                :/*no input*/);
}

void inst_conv_ld_x(int enable, int source1, int source2)          
{
	if(enable == 0){
		asm volatile("conv.ld.x %[rs1], %[rs2]\n\t"
					:/*no output*/
					:[rs1] "r" (source1), [rs2] "r" (source2));
	} else {
		asm volatile("conv.ld.x.en %[rs1], %[rs2]\n\t"
					:/*no output*/
					:[rs1] "r" (source1), [rs2] "r" (source2));
	}
}

void inst_conv_clr_x()
{
    asm volatile("conv.clr.x\n\t"
                :/*no output*/
                :/*no input*/);
}

int inst_conv_run(int result)
{
    asm volatile("conv.run %[rd]\n\t"
                :[rd] "=r" (result)
                :/*no input*/);   
    return result;
}