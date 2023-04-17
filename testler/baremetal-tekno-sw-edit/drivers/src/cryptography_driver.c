
///////////////////////////////////////////////////////////////////////////////////////////////////
// Company:     TUTEL
// Project:     Teknofest Chip Competition 2023
//***********************************************************************************************// 
// Create Date: 13/01/2023
// Module Name: cryptography_driver.c
// Description: Cryptography driver for teknofest.
//
///////////////////////////////////////////////////////////////////////////////////////////////////

int inst_hmdst(int source1, int source2, int result)
{
	asm volatile("hmdst %[rd], %[rs1], %[rs2]\n\t"
				:[rd] "=r" (result)
				:[rs1] "r" (source1), [rs2] "r" (source2));
	return result;
}

int inst_pkg(int source1, int source2, int result)
{
	asm volatile("pkg %[rd], %[rs1], %[rs2]\n\t"
				:[rd] "=r" (result)
				:[rs1] "r" (source1), [rs2] "r" (source2));
	return result;
}

int inst_sladd(int source1, int source2, int result)
{
	asm volatile("sladd %[rd], %[rs1], %[rs2]\n\t"
				:[rd] "=r" (result)
				:[rs1] "r" (source1), [rs2] "r" (source2));
	return result;
}

int inst_rvrs(int source1, int result)
{
	asm volatile("rvrs %[rd], %[rs1]\n\t"
				:[rd] "=r" (result)
				:[rs1] "r" (source1));
	return result;
}
  
int inst_cntz(int source1, int result)
{
	asm volatile("cntz %[rd], %[rs1]\n\t"
				:[rd] "=r" (result)
				:[rs1] "r" (source1));
	return result;
}

int inst_cntp(int source1, int result)
{
	asm volatile("cntp %[rd], %[rs1]\n\t"
				:[rd] "=r" (result)
				:[rs1] "r" (source1));
	return result;
}