// sifreleme c kodlari
#include <stdio.h>
unsigned popcount(unsigned reg1){
	unsigned bir_sayisi = 0;
	int i;
	for(i = 0; i < 32; i++){
		bir_sayisi += (unsigned) 1 & (reg1 >> i);
	}
	return bir_sayisi;
}

unsigned hamming_distance(unsigned reg1, unsigned reg2){
	unsigned hamming_dist = 0;
	unsigned differences = reg1 ^ reg2;
	return popcount(differences);
}

unsigned pkg(unsigned reg1, unsigned reg2){
	return (0xffff & reg1) + ((0xffff & reg2)<<16);
}

unsigned rvrs1(unsigned reg1){
	int i;
	unsigned rvrs_sonuc = 0;
	for(i = 0; i < 4; i++){
		rvrs_sonuc += (0xff & reg1>>(8*i))<<(24-8*i);
	}
	return rvrs_sonuc;
}

unsigned rvrs2(unsigned reg1){
	// return __builtin_bswap32(reg1);
	return ((0xff & reg1)<<24)+((0xff & (reg1>>8))<<16)+((0xff & (reg1>>16))<<8)+((0xff & (reg1>>24)));
}

unsigned sladd(unsigned reg1, unsigned reg2){
	return (reg1<<1) + reg2;
}

unsigned zero_count(unsigned reg1){
	int i;
	unsigned sifir_sayisi = 0;
	for(i = 0; i < 32; i++){
		if((reg1>>i)%2){
			break;
		}
		sifir_sayisi++;
	}
	return sifir_sayisi;
}


int main(){
	
	printf("hmdst: 0x%x\n", hamming_distance(0x95ef299f, 0x1065418b));
	
	printf("hmdsteq: 0x%x\n", hamming_distance(0x95ef299f, 0x95ef299f));
	
	printf("pkg: 0x%x\n", pkg(0x848207d6, 0xfdb9c3f9));
	
	printf("rvrs: 0x%x\n", rvrs1(0xd360a76b));
	printf("rvrs2: 0x%x\n", rvrs2(0xd360a76b));
	
	printf("sladd: 0x%x\n", sladd(0x6f49396e, 0x09c34577));
	
	printf("sladdeq: 0x%x\n", sladd(0x6f49396e, 0x6f49396e));
	
	printf("sladdzero: 0x%x\n", sladd(0x6f49396e, 0x0));
	
	printf("cntz: 0x%x\n", zero_count(0xdab54f04));
	
	printf("cntp: 0x%x\n", popcount(0xa7c9487b));
	
	//unsigned deneme = 0x700;
	//unsigned deneme2 = 0x10;
	
	//printf("pc: %x\nhd: %x\npkg: %x\nr1: %x\nr2: %x\nsladd: %x\nzc: %d\n",popcount(deneme),hamming_distance(deneme,deneme2),pkg(deneme,deneme2),rvrs1(deneme),rvrs2(deneme),sladd(deneme,deneme2),zero_count(deneme));
}

