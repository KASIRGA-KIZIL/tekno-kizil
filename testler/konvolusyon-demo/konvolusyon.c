#define RED 0
#define GREEN 1
#define BLUE 2
#include <stdint.h>
char logo[128][128][3] = {};
char weight[4][4][3] =  {};
uint32_t result[125][125][3];

int main(){
    int i,j;
    
    inst_conv_ld_w(1,weight[0][0][RED],weight[0][1][RED]);
    inst_conv_ld_w(1,weight[0][2][RED],weight[0][3][RED]);
    inst_conv_ld_w(1,weight[1][0][RED],weight[1][1][RED]);
    inst_conv_ld_w(1,weight[1][2][RED],weight[1][3][RED]);
    inst_conv_ld_w(1,weight[2][0][RED],weight[2][1][RED]);
    inst_conv_ld_w(1,weight[2][2][RED],weight[2][3][RED]);
    inst_conv_ld_w(1,weight[3][0][RED],weight[3][1][RED]);
    inst_conv_ld_w(1,weight[3][2][RED],weight[3][3][RED]);

    for(i = 0; i < 125; i++)
        for(j = 0; j < 125; j++){
            inst_conv_ld_x(1,logo[i][j][RED],       logo[i][j+1][RED]);
            inst_conv_ld_x(1,logo[i][j+2][RED],     logo[i][j+3][RED]);
            inst_conv_ld_x(1,logo[i+1][j][RED],     logo[i+1][j+1][RED]);
            inst_conv_ld_x(1,logo[i+1][j+2][RED],   logo[i+1][j+3][RED]);
            inst_conv_ld_x(1,logo[i+2][j][RED],     logo[i+2][j+1][RED]);
            inst_conv_ld_x(1,logo[i+2][j+2][RED],   logo[i+2][j+3][RED]);
            inst_conv_ld_x(1,logo[i+3][j][RED],     logo[i+3][j+1][RED]);
            inst_conv_ld_x(1,logo[i+3][j+2][RED],   logo[i+3][j+3][RED]);
            inst_conv_run(result[i][j][RED]);
            inst_conv_clr_x();
        }
    inst_conv_clr_w();
    
    inst_conv_ld_w(1,weight[0][0][GREEN],weight[0][1][GREEN]);
    inst_conv_ld_w(1,weight[0][2][GREEN],weight[0][3][GREEN]);
    inst_conv_ld_w(1,weight[1][0][GREEN],weight[1][1][GREEN]);
    inst_conv_ld_w(1,weight[1][2][GREEN],weight[1][3][GREEN]);
    inst_conv_ld_w(1,weight[2][0][GREEN],weight[2][1][GREEN]);
    inst_conv_ld_w(1,weight[2][2][GREEN],weight[2][3][GREEN]);
    inst_conv_ld_w(1,weight[3][0][GREEN],weight[3][1][GREEN]);
    inst_conv_ld_w(1,weight[3][2][GREEN],weight[3][3][GREEN]);

    for(i = 0; i < 125; i++)
        for(j = 0; j < 125; j++){
            inst_conv_ld_x(1,logo[i][j][GREEN],       logo[i][j+1][GREEN]);
            inst_conv_ld_x(1,logo[i][j+2][GREEN],     logo[i][j+3][GREEN]);
            inst_conv_ld_x(1,logo[i+1][j][GREEN],     logo[i+1][j+1][GREEN]);
            inst_conv_ld_x(1,logo[i+1][j+2][GREEN],   logo[i+1][j+3][GREEN]);
            inst_conv_ld_x(1,logo[i+2][j][GREEN],     logo[i+2][j+1][GREEN]);
            inst_conv_ld_x(1,logo[i+2][j+2][GREEN],   logo[i+2][j+3][GREEN]);
            inst_conv_ld_x(1,logo[i+3][j][GREEN],     logo[i+3][j+1][GREEN]);
            inst_conv_ld_x(1,logo[i+3][j+2][GREEN],   logo[i+3][j+3][GREEN]);
            inst_conv_run(result[i][j][GREEN]);
            inst_conv_clr_x();
        }
    inst_conv_clr_w();

    inst_conv_ld_w(1,weight[0][0][BLUE],weight[0][1][BLUE]);
    inst_conv_ld_w(1,weight[0][2][BLUE],weight[0][3][BLUE]);
    inst_conv_ld_w(1,weight[1][0][BLUE],weight[1][1][BLUE]);
    inst_conv_ld_w(1,weight[1][2][BLUE],weight[1][3][BLUE]);
    inst_conv_ld_w(1,weight[2][0][BLUE],weight[2][1][BLUE]);
    inst_conv_ld_w(1,weight[2][2][BLUE],weight[2][3][BLUE]);
    inst_conv_ld_w(1,weight[3][0][BLUE],weight[3][1][BLUE]);
    inst_conv_ld_w(1,weight[3][2][BLUE],weight[3][3][BLUE]);

    for(i = 0; i < 125; i++)
        for(j = 0; j < 125; j++){
            inst_conv_ld_x(1,logo[i][j][BLUE],       logo[i][j+1][BLUE]);
            inst_conv_ld_x(1,logo[i][j+2][BLUE],     logo[i][j+3][BLUE]);
            inst_conv_ld_x(1,logo[i+1][j][BLUE],     logo[i+1][j+1][BLUE]);
            inst_conv_ld_x(1,logo[i+1][j+2][BLUE],   logo[i+1][j+3][BLUE]);
            inst_conv_ld_x(1,logo[i+2][j][BLUE],     logo[i+2][j+1][BLUE]);
            inst_conv_ld_x(1,logo[i+2][j+2][BLUE],   logo[i+2][j+3][BLUE]);
            inst_conv_ld_x(1,logo[i+3][j][BLUE],     logo[i+3][j+1][BLUE]);
            inst_conv_ld_x(1,logo[i+3][j+2][BLUE],   logo[i+3][j+3][BLUE]);
            inst_conv_run(result[i][j][BLUE]);
            inst_conv_clr_x();
        }
    inst_conv_clr_w();
         
    for(i = 0; i < 125; i++)
        for(j = 0; j < 125; j++)
            ee_printf("%x,",result[i][j][RED]);
            
    for(i = 0; i < 125; i++)
        for(j = 0; j < 125; j++)
            ee_printf("%x,",result[i][j][GREEN]);
            
    for(i = 0; i < 125; i++)
        for(j = 0; j < 125; j++)
            ee_printf("%x,",result[i][j][BLUE]);
    return 0;
}
