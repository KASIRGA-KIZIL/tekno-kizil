// konvolusyon kodlari
#include <stdio.h>
int matris[16];	//X
int filtre[16];	//W
unsigned matris_ptr = 0;
unsigned filtre_ptr = 0;


void conv_ld_w(unsigned enable, int r1, int r2){
	filtre[filtre_ptr++] = r1;
	if(enable){
		filtre[filtre_ptr++] = r2;
	}
	return;
}

void conv_clr_w(void){
	int i;
	for(i = 0;i < 16;i++){
		filtre[i] = 0;
	}
	filtre_ptr = 0;
	return;
}

void conv_ld_x(unsigned enable, int r1, int r2){
	matris[matris_ptr++] = r1;
	if(enable){
		matris[matris_ptr++] = r2;
	}
	return;
}

void conv_clr_x(void){
	int i;
	for(i = 0;i < 16;i++){
		matris[i] = 0;
	}
	matris_ptr = 0;
	return;
}

int conv_run(void){
	int sonuc = 0;
	int i;
	if(filtre_ptr == matris_ptr){
		for(i = 0; i < matris_ptr; i++){
			sonuc += matris[i]*filtre[i];
		}
		return sonuc;
	}
	else{
		return 0;
	}
}

// filtre
// 32   4
// 189  2

// veri
// 5  16
// 28 677

int main(){
	conv_ld_w(1,32,4);
	conv_ld_w(0,189,2);
	conv_ld_w(0,2,189);
	
	conv_ld_x(1,5,16);
	conv_ld_x(0,28,677);
	conv_ld_x(0,677,28);
	
	printf("x9: %d\n", conv_run());

	conv_clr_x();
	conv_clr_w();
	
	printf("x22: %d\n", conv_run());
	
	conv_ld_w(1,32,4);
	conv_ld_w(0,189,2);
	conv_ld_w(0,2,189);
	
	conv_ld_x(1,5,16);
	conv_ld_x(0,28,677);
	conv_ld_x(0,677,28);
	
	printf("x10: %d\n", conv_run());
	
	conv_ld_w(1,323,14);
	conv_ld_w(1,1819,21);
	conv_ld_w(1,21,1819);
	conv_ld_w(0,1455,2);
	conv_ld_w(0,2,1455);
	conv_ld_w(1,3,4);
	conv_ld_w(1,11111,123);
	
	conv_ld_x(1,321,136);
	conv_ld_x(1,248,6577);
	conv_ld_x(1,6771,28);
	conv_ld_x(1,6771,28);
	conv_ld_x(1,6771,28);
	conv_ld_x(1,6771,28);
	
	printf("x11: %d\n", conv_run());
	
	//conv_ld_w(1,3,4);
	//conv_ld_w(1,3,4);
	//conv_ld_x(1,2,5);
	//conv_ld_x(1,2,5);
	//int a = conv_run();
	//printf("%d",a);
	
	
	return 0;
}

