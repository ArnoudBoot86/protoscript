/*****************************************************************************
 * jpcode.c
 *****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "cdefBF532.h"
#include "common.h"
// #include "ec100.h"
#include "aux_adc.h"
#include "init_hw.h"
#include "test.h"
#include "uart.h"
#include "sport.h"
#include "tri_adc.h"
#include "dma.h"
#include "clock.h"
#include "jrunner.h"
#include "pm_adc.h"
#include "jps_regs.h"


extern void init_start(void);
extern enum PASS_FAIL ramp_gen(void);
extern enum PASS_FAIL ramp_gen1(void);
 

int main(void) {
    enum PASS_FAIL flag;
    int choice;
    int regval;
    
    UINT16 status;

    enum PASS_FAIL pass = PASS;
    enum PASS_FAIL fail = FAIL;
    
    // CPU init - Remove if to generate loader file
    init_start();
    
    /* Initialize swh hardware */
    init_hw();
    
    /* Initialize quad DACs */
    flag = qdac_init();
    if (flag == PASS)
        printf ("Successfully initialized quad DACs\r\n");
    else
        printf ("Failed to initialize quad DACs\r\n");
    
    /* Initialize analog board registers */
    flag = dfconfig();
    if (flag == PASS) {
        printf ("Successfully initialized analog board registers\r\n");
        sport0_read((UINT16)0x2,&regval);
        regval |= 1<<17;
        sport0_write((UINT32)regval,(UINT16)0x2);   
    }
    else
        printf ("Failed to initialize analog board registers\r\n");
        
    /* Initialize other DACs */
    flag = odac_init();
    if (flag == PASS) {
        printf ("Successfully initialized other DACs\r\n");   
    }
    else
        printf ("Failed to initialize analog board registers\r\n");    
   
  
    
     
        
    /* The main loop for John's analog hardware testing. */
    for(;;) {
        printf("\r\nMain menu:\r\n");
        printf("  1: Work with bandwidth register \r\n");
        printf("  2: Work with I/V register \r\n");
        printf("  3: Work with voltmeter register \r\n");
        printf("  4: Work with buddy box register \r\n");
        printf("  5: Work with signal generation board register \r\n");
        printf("  6: Work with quad DACs \r\n");
        printf("  7: Work with boost DAC \r\n");
        printf("  8: Work with E bias rejection DAC\r\n");
        printf("Select number to execute: \r\n");       
        scanf("%i", &choice);
        switch (choice) {
            case 1 : bwconfig(); break;
            case 2 : ivconfig(); break;
            case 3 : vmconfig(); break;
            case 4 : bbconfig(); break;
            case 5 : sgconfig(); break;
            case 6 : qdconfig(); break;
            case 7 : boostdac(); break;
            case 8 : ebias(); break;
            default: printf("Invalid selection\r\n");
        } // end switch 
    } // end main for loop
    return 0;
} // end main()
