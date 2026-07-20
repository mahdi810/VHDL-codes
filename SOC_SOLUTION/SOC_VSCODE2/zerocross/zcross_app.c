/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include <string.h>
#include <unistd.h>

#include "xparameters.h"

#define reg(k) *(volatile unsigned int *)(XPAR_ZCROSS_0_S00_AXI_BASEADDR + (4*k))
#define cmd_len 64

void print_help(){
	printf("h     : to show this help menu \n");
	printf("x     : to close the application \n");
	printf("start : to start the calculation \n");
}

void my_getline(char *cmd, int size){
	int i;
	char c;
	for(i = 0; i < size - 1; i++){
		c = getchar();
		if(c == '\r' || c == '\n'){
			c = '\0';
			putchar('\r');
			putchar('\n');
			break;
		}
		cmd[i] = c;
		putchar(c);
	}
	cmd[i] = '\0';
}

int main()
{
	int terminat = 0;
	char cmd[cmd_len];
	unsigned int xdata;
    init_platform();

    print_help();
    do{
    	printf(">> "); fflush(stdout);
    	my_getline(cmd, cmd_len);
    	if(!strcmp(cmd, "x")){
    		terminat = 1;
    	} else if(!strncmp(cmd, "write", 5)){
    		unsigned int regnum;
    		unsigned int regval;
    		if(sscanf(cmd, "write %d %d", &regnum, &regval) != 2){
    			printf("the value was wrote correctly, right usage is write <regnum> <regval> \n");
    		} else {
    			reg(regnum) = regval;
    			printf("the value %d has been written to reg%d. \n", regval, regnum);
    		}
    	} else if(!strcmp(cmd, "start")){
    		double rightv_f, leftv_f;
    		unsigned int rightv, leftv;
    		printf("please enter the value for rightv and leftv. (int_16.10), <rightv> <leftv> \n");
    		my_getline(cmd, cmd_len);
    		if(sscanf(cmd, "%lf %lf", &rightv_f, &leftv_f) != 2){
    			printf("you did not enter the values correctly \n");
    		} else {
    			rightv = (unsigned int)(rightv_f * (1 << 10));
    			leftv = (unsigned int)(leftv_f * (1 << 10));

    			reg(0) = leftv;
    			reg(1) = rightv;
    			printf("%d : has be written to reg(0) \n", leftv);
    			printf("%d : has be written to reg(1) \n", rightv);

    			//triggering the start signal
    			reg(2) = 1;

    			//polling for done signal
    			do{
    				xdata = reg(2);
    				usleep(10);
    			}while(!(xdata & 0x1));
    			printf("done flage raised \n");

    			//xdata = reg(2);
    			printf("xdata = reg(2) = %d \n", xdata);

    			short unsigned int newx, newy;
    			double newx_f, newy_f;
    			xdata = (xdata >> 1);
    			newx = *(short unsigned int*)&(xdata);
    			newx_f = (double)newx / (double)(1 << 10);

    			xdata = reg(3);
    			printf("xdata = %d \n", xdata);
    			newy = *(short unsigned int*)&(xdata);
    			newy_f = (double)newy / (double)(1 << 10);

    			printf("the zerocrossing value for this program has been found \n");
    			printf("the zerocrossing is : %d (%lf) \n", newx, newx_f);
    			printf("the correspoding y value is : %d (%lf) \n", newy, newy_f);
    		}
    	}
    }while(terminat == 0);

    print("Thanks for using the zcross application\n\r");
    print("Successfully ran application");
    cleanup_platform();
    return 0;
}
