/* jps_regs */
#include <stdio.h>
#include <stdlib.h>
#include "common.h"
#include "sport.h"
#include "jps_regs.h"
#include "ec100_flash.h"

/* Set some register addresses */
#define IV_REG_LOC 0xa6
#define BW_REG_LOC 0xa1
#define VM_REG_LOC 0xa7
#define BB_REG_LOC 0x80
#define SG_REG_LOC 0x2
#define AC_REG_LOC 0x5
#define BOOST_LOC 0xab
#define EREJ_LOC 0xa9

/* Set some register offsets */
#define OE_POS 17
#define ROT_BNC_POS 15
#define CEMON_BNC_POS 14
#define IV_BNC_POS 13
#define IV_BNC_FIL_POS 10
#define IRCOMP_POS 11
#define FCSINK_POS 22
#define BBCE_POS 13

/* Set some default values */
#define BW_REG_DEFAULT 0x5cde
#define IV_REG_DEFAULT 0x148
#define VM_REG_DEFAULT 0x161e
#define BB_REG_DEFAULT 0xcda

/* Quad DAC variables */
/* Quad DAC A */
int cemon_offset = 0x7ff;
int limit_dac_low = 0xfff;
int limit_dac_high = 0xfff;
int fp_iv_offset = 0x7ff;

/* Quad DAC B */
int rotator = 0x0;
int iv_reject = 0x7ff;
int iv_offset = 0x7ff;
int vm_offset = 0x7ff;

/* Initialize quad DAC data */
enum PASS_FAIL qdac_init() {
    enum PASS_FAIL fail = FAIL;
    enum PASS_FAIL pass = PASS;
    enum PASS_FAIL flag;
    flag = dacaUpdate(); // Set DACA defaults
    if (flag == FAIL)
        return (fail);
    flag = dacbUpdate(); // Set DACB defaults
    if (flag == FAIL)
        return (fail);
    return (pass);
} /* end qdac_init() */

/* Initialize other DACs */
enum PASS_FAIL odac_init() {
    enum PASS_FAIL fail = FAIL;
    enum PASS_FAIL pass = PASS;
    enum PASS_FAIL flag;
    UINT32 dacval = 0x7fff;
    UINT16 regloc = BOOST_LOC;
    if (sport0_write(dacval,regloc) == fail) {
        return (fail); // Boost DAC
    }
    wait_timer(WAIT_1ms);
    dacval = 0x7fff;
    regloc = EREJ_LOC;
    if (sport0_write(dacval,regloc) == fail) {
        return (fail); // E bias rejection DAC
    }
    return (pass);
} /* end odac_init()
    


/* Update daca data */
enum PASS_FAIL dacaUpdate() {
    int regloc = 0xa2;
    int regval = 0;
    enum PASS_FAIL fail = FAIL;
    enum PASS_FAIL pass = PASS;
    regval = 0x0 << 12; // Front panel I/V offset
    regval |= fp_iv_offset;
    if (sport0_write((UINT32)regval,(UINT16)regloc) == fail) {
        return (fail);
    }
    regval = 0x1 << 12; // Positive compliance limit
    regval |= limit_dac_high;
    if (sport0_write((UINT32)regval,(UINT16)regloc) == fail) {
        return (fail);
    }
    regval = 0x2 << 12; // Negative compliance limit
    regval |= limit_dac_low;
    if (sport0_write((UINT32)regval,(UINT16)regloc) == fail) {
        return (fail);
    }
    regval = 0x3 << 12; // CE monitor offset
    regval |= cemon_offset;
    if (sport0_write((UINT32)regval,(UINT16)regloc) == fail) {
        return (fail);
    }
    printf("Successfully updated DAC A\r\n");
    return (pass);
}

/* Update dacb data */
enum PASS_FAIL dacbUpdate() {
    int regloc = 0xa3;
    int regval = 0;
    enum PASS_FAIL fail = FAIL;
    enum PASS_FAIL pass = PASS;
    regval = 0x0 << 12; // Main voltmeter offset
    regval |= vm_offset;
    if (sport0_write((UINT32)regval,(UINT16)regloc) == fail)
        return (fail);
    regval = 0x1 << 12; // I/V raw offset
    regval |= iv_offset;
    if (sport0_write((UINT32)regval,(UINT16)regloc) == fail)
        return (fail);
    regval = 0x2 << 12; // I/V bias rejection
    regval |= iv_reject;
    if (sport0_write((UINT32)regval,(UINT16)regloc) == fail)
        return (fail);
    regval = 0x3 << 12; // Rotator -- this should cause SPI write
    regval |= rotator;
    if (sport0_write((UINT32)regval,(UINT16)regloc) == fail)
        return (fail);
    printf("Successfully updated DAC B\r\n");
    return (pass);
}

/* Program all analog board registers to defaults */
enum PASS_FAIL dfconfig() {
    int regval = 0;
    enum PASS_FAIL fail = FAIL;
    enum PASS_FAIL pass = PASS;
    enum PASS_FAIL flag = FAIL;
    regval = BW_REG_DEFAULT;
    wait_timer(WAIT_1ms);
    flag = sport0_write((UINT32)regval,(UINT16)BW_REG_LOC);
    if (flag == fail)
        return (fail);
    regval = IV_REG_DEFAULT;
    wait_timer(WAIT_1ms);
    flag = sport0_write((UINT32)regval,(UINT16)IV_REG_LOC);
    if (flag == fail)
        return (fail);
    regval = VM_REG_DEFAULT;
    wait_timer(WAIT_1ms);
    flag = sport0_write((UINT32)regval,(UINT16)VM_REG_LOC);
    if (flag == fail)
        return (fail);
    regval = BB_REG_DEFAULT;
    wait_timer(WAIT_1ms);
    flag = sport0_write((UINT32)regval,(UINT16)BB_REG_LOC);
    if (flag == fail)
        return (fail);
    /* Open AC switch */
    sport0_write(0,(UINT16)0x8);
    sport0_read((UINT16)AC_REG_LOC,&regval);
    regval = 0x0;
    sport0_write((UINT32)regval,(UINT16)AC_REG_LOC);
    return (pass);
}

/* Set value for boost DAC */
void boostdac(void) {
    UINT32 dacval = 0;
    UINT16 regloc = BOOST_LOC;
    printf("Enter boost DAC value (0x0000 --> 0xffff):\r\n");
    scanf("%x",&dacval);
    sport0_write(dacval,regloc);
    return;
}

/* Set value for E bias rejection DAC */
void ebias(void) {
    UINT32 dacval = 0;
    UINT16 regloc = EREJ_LOC;
    printf("Enter E bias reject DAC value (0x0000 --> 0xffff):\r\n");
    scanf("%x",&dacval);
    sport0_write(dacval,regloc);
    return;
}    

/* Bandwidth control register menu */
void bwconfig(void) {
    int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    UINT32 regval = 0;
    UINT16 regloc = BW_REG_LOC;
    for(;;) {
        printf("\r\nBandwidth register configuration:\r\n");
        printf("  1. Set defaults\r\n");
        printf("  2. Configure external input\r\n");
        printf("  3. Select main vm feedback (potentiostat)\r\n");
        printf("  4. Select I/V feedback (galvanostat)\r\n");
        printf("  5. Select zra feedback (zra)\r\n");
        printf("  6. Select local feedback\r\n");
        printf("  7. Select control bandwidth\r\n");
        printf("  8. Configure I/V ADC input\r\n");
        printf("  9. Return to main menu \r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : 
                regval = BW_REG_DEFAULT;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 2 :
                exconfig();
                goodsel = 1;
                break;
            case 3 : // Select main voltmeter feedback for potentiostat mode
                sport0_read(regloc,&regval);
                regval &= 0xe1ff;
                regval |= 0xd << 9;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 4 : // Select I/V feedback for galvanostat mode
                sport0_read(regloc,&regval);
                regval &= 0xe1ff;
                regval |= 0x7 << 9;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 5 : // Select zra feedback for zra mode
                sport0_read(regloc,&regval);
                regval &= 0xe1ff;
                regval |= 0xb << 9;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 6 : // Select local feedback
                sport0_read(regloc,&regval);
                regval &= 0xe1ff;
                regval |= 0xe << 9;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 7 : // Select control bandwidth
                bwsel();
                goodsel = 1;
                break;
            case 8 : // Configure I/V ADC input
                ivadc_config();
                goodsel = 1;
                break;
            case 9 :
                goodsel = 1;
                break;
            default: printf("\r\nInvalid selection\r\n"); 
                goodsel=0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel==1) {
            return;
        } // end if
    } // end for
}

/* bwsel()  
* Select control bandwidth. */
void bwsel(void) {
int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    UINT32 regmask = 0xff07;
    UINT16 regloc = BW_REG_LOC;
    UINT32 regval = 0;
    for(;;) {
        printf("\r\nChoose control bandwidth:\r\n");
        printf("  1. 10Hz\r\n");
        printf("  2. 100Hz\r\n");
        printf("  3. 1kHz\r\n");
        printf("  4. 10kHz\r\n");
        printf("  5. 100kHz\r\n");
        printf("  6. 1MHz\r\n");
        printf("  7. Return to main menu \r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : // 10Hz
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1e<<3;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 2 : // 100Hz
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1d<<3;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 3 : // 1kHz
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1b<<3;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 4 : // 10kHz
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x17<<3;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 5 : // 100kHz
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1f<<3;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;  
            case 6 : // 1MHz
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0xf<<3;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;            
            case 7 : 
                goodsel = 1; 
                break;
            default: printf("\r\nInvalid selection\r\n");
                goodsel = 0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel == 1) {
            sport0_read((UINT16)BW_REG_LOC,&regval);
            printf("Bandwidth register value is 0x");
            printf("%x\r\n",regval);
            return;
        } //end if
    } // end for
}   

/* I/V control register menu */
void ivconfig(void) {
    int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    UINT16 regloc = IV_REG_LOC;
    UINT32 regval = 0;
    for(;;) {
        printf("\r\nI/V register configuration:\r\n");
        printf("  1. Set defaults\r\n");
        printf("  2. Set 1A range\r\n");
        printf("  3. Set 100mA range\r\n");
        printf("  4. Set 10mA range\r\n");
        printf("  5. Set 1mA range\r\n");
        printf("  6. Set external ranges\r\n");
        printf("  7. Enable front panel I/V BNC filter\r\n");
        printf("  8. Disable front panel I/V BNC filter\r\n");
        printf("  9. Set positive feedback switch position\r\n");
        printf("  10. Set current interrupt switch position\r\n");
        printf("  11. Return to main menu \r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : 
                regval = IV_REG_DEFAULT;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 2 : 
                sport0_read(regloc,&regval);
                regval &= 0xff80; // Internal I/V current range mask
                regval |= 0x48; // For 1A range
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 3 : 
                sport0_read(regloc,&regval);
                regval &= 0xff80;
                regval |= 0x54; // For 100mA range
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 4 :
                sport0_read(regloc,&regval);
                regval &= 0xff80;
                regval |= 0x62; // For 10mA range
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 5 : // Set 1mA range
                sport0_read(regloc,&regval);
                regval &= 0xff80;
                regval |= 0x71;
                sport0_write(regval,regloc);
                goodsel = 1;
                break;  
            case 6 : // Set external ranges
                sport0_read(regloc,&regval);
                regval &= 0xff80;
                regval |= 0x30;
                sport0_write(regval,regloc);
                goodsel = 1;
                break; 
            case 7 : // enable the 10Hz front panel filter
                sport0_read(regloc,&regval);
                regval &= ~(1<<IV_BNC_FIL_POS);
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break; 
            case 8 : // disable the 10Hz front panel filter
                sport0_read(regloc,&regval);
                regval |= 1<<IV_BNC_FIL_POS;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;  
            case 9 : // set positive feedback switch position
                sport0_read(regloc,&regval);
                regval |= 1<<IRCOMP_POS;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 10 : // set current interrupt switch position
                sport0_read(regloc,&regval);
                regval &= ~(1<<IRCOMP_POS);
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;              
            case 11 : 
                goodsel = 1; 
                break;
            default: printf("\r\nInvalid selection\r\n");
                goodsel = 0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel == 1) {
            sport0_read((UINT16)IV_REG_LOC,&regval);
            printf("I/V register value is 0x");
            printf("%x\r\n",regval);
            return;
        } //end if
    } // end for
}

/* Voltmeter control register menu */
void vmconfig(void) {
    int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    UINT16 regloc = (UINT16)VM_REG_LOC;
    UINT32 regval = 0;
    for(;;) {
        printf("\r\nVoltmeter register configuration:\r\n");
        sport0_read(regloc,&regval);
        printf("Voltmeter register value is 0x");
        printf("%x\r\n",regval);
        printf("  1. Set defaults\r\n");
        printf("  2. Enable rotator BNC\r\n");
        printf("  3. Enable CE monitor BNC\r\n");
        printf("  4. Enable I/V BNCs (front and back)\r\n");
        printf("  5. Configure E BNCs\r\n");
        printf("  6. Apply 2.5V reference to E ADC\r\n");
        printf("  7. Apply 0V reference to E ADC\r\n");
        printf("  8. Route E ADC to trim main voltmeter CMRR\r\n");
        printf("  9. Route E ADC to trim zra voltmeter CMRR\r\n");
        printf("  10. Route synchronous ADC to +5V reference\r\n");
        printf("  11. Route synchronous ADC to 0V reference\r\n");
        printf("  12. Connect 10Hz E ADC filter\r\n");
        printf("  13. Remove all E ADC filters\r\n");
        printf("  14. Connect 10kHz E ADC filter\r\n");
        printf("  15. Set 5V E ADC range\r\n");
        printf("  16. Set 2V E ADC range\r\n");
        printf("  17. Set 15V E ADC range\r\n");  
        printf("  18. Return to main menu \r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : // Set defaults
                regval = VM_REG_DEFAULT;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 2 : // Enable rotator BNC
                sport0_read(regloc,&regval);
                regval |= 1<<ROT_BNC_POS;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 3 : // Enable CE monitor
                sport0_read(regloc,&regval);
                regval |= 1<<CEMON_BNC_POS;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 4 : // Enable I/V BNCs                                                                                                                       
                sport0_read(regloc,&regval);
                regval |= 1<<IV_BNC_POS;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 5 : // Configure E BNCs
                ebnc_config();
                goodsel = 1;
                break;
            case 6 : // Apply 2.5V reference to E ADC
                sport0_read(regloc,&regval);
                regval &= 0xe1ff;
                regval |= 0x8 << 9; // Select 2.5V reference for E ADC
                regval &= 0xffc7;
                regval |= 0x7 << 3; // Fieldcal mode for E ADC
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break; 
            case 7 : // Apply 0V reference to E ADC
                sport0_read(regloc,&regval);
                regval &= 0xe1ff;
                regval |= 0x9 << 9; // Select 2.5V reference for E ADC
                regval &= 0xffc7;
                regval |= 0x7 << 3; // Fieldcal mode for E ADC
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 8 : // Route E ADC to trim main voltmeter CMRR
                regval &= 0xe1ff;
                regval |= 0xb << 9; // Set default mode for E BNCs
                regval &= 0xfe3f;
                regval |= 0x4 << 6; // Default BNC connections
                regval &= 0xffc7;
                regval |= 0x6 << 3; // 10Hz E ADC filter
                regval &= 0xfff8;
                regval |= 0x3 << 3; // 2V E ADC range
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 9 : // Route E ADC to trim zra voltmeter CMRR
                regval &= 0xe1ff;
                regval |= 0xf << 9; // Route zra voltmeter
                regval &= 0xfe3f;
                regval |= 0x4 << 6; // Default BNC connections
                regval &= 0xffc7;
                regval |= 0x6 << 3; // 10Hz E ADC filter
                regval &= 0xfff8;
                regval |= 0x3 << 3; // 2V E ADC range
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;  
            case 10 : // Route synchronous ADC to +5V reference  
                regval &= 0xe1ff;
                regval |= 0x3 << 9; // Synch ADC connected to +5V
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 11 : // Route synchronous ADC to +0V reference  
                regval &= 0xe1ff;
                regval |= 0xb << 9; // Synch ADC connected to +0V
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break; 
            case 12 : // Connect 10Hz E ADC filter
                regval &= 0xffc7;
                regval |= 0x6 << 3; // 10Hz E ADC filter
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 13 : // Remove all E ADC filters
                regval &= 0xffc7;
                regval |= 0x5 << 3; // No E ADC filter
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 14 : // 10kHz E ADC filter
                regval &= 0xffc7;
                regval |= 0x3 << 3; // 10kHz ADC filter
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 15 : // Set 5V E ADC range
                regval &= 0xfff8;
                regval |= 0x5 << 3; // 5V E ADC range
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
            case 16 : // Set 2V E ADC range
                regval &= 0xfff8;
                regval |= 0x3 << 3; // 2V E ADC range
                sport0_write((UINT32)regval,regloc);
                goodsel = 1; 
            case 17 : // Set 15V E ADC range
                regval &= 0xfff8;
                regval |= 0x6 << 3; // 15V E ADC range
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;       
            case 18 :
                goodsel = 1;
                break;
            default: 
                printf("You entered ");
                printf("%u\r\n",choice);
                printf("Invalid selection\r\n");
                goodsel = 0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel == 1) {
            sport0_read(regloc,&regval);
            printf("Voltmeter register value is 0x");
            printf("%x\r\n",regval);
            return;
        } //end if
    } // end for
}

/* ebnc_config() */
void ebnc_config(void) {
    int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    UINT32 regmask = 0xfe3f;
    UINT16 regloc = VM_REG_LOC;
    UINT32 regval = 0;
    for(;;) {
        printf("\r\nE BNC configuration:\r\n");
        printf("  1. Route front panel E BNC to ADC for fieldcal, no filter\r\n");
        printf("  2. Route front panel E BNC to ADC for fieldcal, 10Hz filter\r\n");
        printf("  3. Route rear panel E BNC to ADC for fieldcal\r\n");
        printf("  4. Make front and rear E BNCs active with 10Hz filter\r\n");
        printf("  5. Make front and rear E BNCs active without filter\r\n");
        printf("  6. Return to main menu \r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : // Route front E BNC to ADC for fieldcal, no filter
                sport0_read(regloc,&regval);
                regval &= 0xe1ff;
                regval |= 0x9 << 9; // Route BNC
                regval &= regmask;
                regval |= 0x4 << 6; // Disconnect front BNC without filter
                regval &= 0xffc7;
                regval |= 0x7 << 3; // Fieldcal mode for E ADC 
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 2 : // Route front E BNC to ADC for fieldcal, 10Hz filter
                sport0_read(regloc,&regval);
                regval &= 0xe1ff;
                regval |= 0x9 << 9; // Route BNC
                regval &= regmask;
                regval |= 0x0 << 6; // Disconnect front BNC with filter
                regval &= 0xffc7;
                regval |= 0x7 << 3; // Fieldcal mode for E ADC
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;    
            case 3 : // Route rear E BNC to ADC for fieldcal
                sport0_read(regloc,&regval);
                regval &= 0xe1ff;
                regval |= 0x9 << 9; // Route BNC
                regval &= regmask;
                regval |= 0x6 << 6; // Disconnect rear BNC
                regval &= 0xffc7;
                regval |= 0x7 << 3; // Fieldcal mode for E ADC
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break; 
            case 4 : // Front and rear BNCs active with 10Hz filter
                regval &= regmask;
                regval |= 0x1 << 6; // BNCs active, front panel 10Hz
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 5 : // Front and rear BNCs active without filter 
                regval &= regmask;
                regval |= 0x5 << 6; // BNCs active, no filter
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;           
            case 6 : 
                goodsel = 1; 
                break;
            default: printf("\r\nInvalid selection\r\n");
                goodsel = 0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel == 1) {
            sport0_read((UINT16)VM_REG_LOC,&regval);
            printf("VM register value is 0x");
            printf("%x\r\n",regval);
            return;
        } //end if
    } // end for
}

/* Buddy box control register menu */
void bbconfig(void) {
    int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    UINT16 regloc = BB_REG_LOC;
    UINT32 regval = 0;
    for(;;) {
        printf("\r\nBuddy box register configuration:\r\n");
        printf("  1. Set defaults\r\n");
        printf("  2. Choose current range\r\n");
        printf("  3. Configure fieldcal voltages and currents\r\n");
        printf("  4. Return to main menu \r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : 
                regval = BB_REG_DEFAULT;
                sport0_write(regval,regloc);
                goodsel = 1;
                break;
            case 2 : // Choose current range
                bbrange();
                goodsel = 1;
                break;
            case 3 : // Configure fieldcal voltage and current sources
                bbfcal();
                goodsel = 1;
                break;
            case 4 : // Back to main menu
                goodsel = 1;
                break;
            default: printf("\r\nInvalid selection\r\n");
                goodsel = 0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel == 1) {
            return;
        } //end if
    } // end for
}

/* Signal generation board control register menu */
void sgconfig(void) {
    int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    UINT32 regval = 0;
    for(;;) {
        printf("\r\nSignal generation board configuration:\r\n");
        printf("  1. Enable the analog board shift registers\r\n");
        printf("  2. Close AC switch\r\n");
        printf("  3. Open AC switch\r\n");
        printf("  4. Return to main menu \r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : 
                sport0_read((UINT16)SG_REG_LOC,&regval);
                regval |= 1<<OE_POS;
                sport0_write((UINT32)regval,(UINT16)SG_REG_LOC);
                goodsel = 1;
                break;
            case 2: // Close the AC switch
                sport0_write(0,(UINT16)0x8);
                sport0_read((UINT16)AC_REG_LOC,&regval);
                regval = 0x1;
                sport0_write((UINT32)regval,(UINT16)AC_REG_LOC);
                goodsel = 1;
                break;
            case 3: // Open the AC switch
                sport0_write(0,(UINT16)0x8);
                sport0_read((UINT16)AC_REG_LOC,&regval);
                regval = 0x0;
                sport0_write((UINT32)regval,(UINT16)AC_REG_LOC);
                goodsel = 1;
                break;
            case 4 :
                goodsel = 1;
                break;
            default: printf("\r\nInvalid selection\r\n");
                goodsel = 0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel == 1) {
            return;
        } //end if
    } // end for
}

/* External input configuration menu */
void exconfig(void) {
    int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    UINT32 regmask = 0xfff8;
    UINT16 regloc = BW_REG_LOC;
    UINT32 regval = 0;
    for(;;) {
        printf("\r\nExternal input configuration:\r\n");
        printf("  1. Set default mode: potentiostat\r\n");
        printf("  2. Set galvanostat mode\r\n");
        printf("  3. Potentiostat mode with BNC disabled\r\n");
        printf("  4. Galvanostat mode with BNC disabled\r\n");
        printf("  5. Potentiostat mode with BNC grounded\r\n");
        printf("  6. Potentiostat mode with 1.25V BNC reference\r\n");
        printf("  7. Galvanostat mode with BNC grounded\r\n");
        printf("  8. Galvanostat mode with 1.25V BNC reference\r\n");
        printf("  9. Return to main menu \r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : // Potentiostat mode with BNC enabled
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x7;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 2 : // Galvanostat mode with BNC enabled
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x3;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 3 : // BNC disabled (potentiostat)
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x6;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 4 : // BNC disabled (galvanostat)
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x2;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 5 : // BNC grounded (potentiostat)
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x6;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;  
            case 6 : // 1.25V reference (potentiostat)
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x4;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break; 
            case 7 : // BNC grounded (galvanostat)
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x2;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;  
            case 8 : // 1.25V reference (galvanostat)
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x0;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;             
            case 9 : 
                goodsel = 1; 
                break;
            default: printf("\r\nInvalid selection\r\n");
                goodsel = 0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel == 1) {
            sport0_read((UINT16)IV_REG_LOC,&regval);
            printf("I/V register value is 0x");
            printf("%x\r\n",regval);
            return;
        } //end if
    } // end for
}

/* I/V ADC input configuration */
void ivadc_config(void) {
    int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    UINT32 regmask = 0x1fff;
    UINT16 regloc = BW_REG_LOC;
    UINT32 regval = 0;
    for(;;) {
        printf("\r\nI/V ADC input configuration:\r\n");
        printf("  1. I/V with 10kHz anti-alias filter\r\n");
        printf("  2. I/V with 10Hz filter\r\n");
        printf("  3. I/V with no filter\r\n");
        printf("  4. Front panel I/V BNC\r\n");
        printf("  5. 1.25V reference\r\n");
        printf("  6. 0V reference\r\n");
        printf("  7. Return to main menu \r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : // I/V with 10kHz anti-alias filter
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x2 << 13;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 2 : // I/V with 10Hz filter
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x0 << 13;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 3 : // I/V with no filter
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1 << 13;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 4 : // Front panel I/V BNC for fieldcal
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x3 << 13;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;
            case 5 : // 1.25V reference for fieldcal
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x4 << 13;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break;  
            case 6 : // 0V reference for fieldcal
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x5 << 13;
                sport0_write((UINT32)regval,regloc);
                goodsel = 1;
                break; 
            case 7 : 
                goodsel = 1; 
                break;
            default: printf("\r\nInvalid selection\r\n");
                goodsel = 0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel == 1) {
            sport0_read((UINT16)BW_REG_LOC,&regval);
            printf("Bandwidth configuration register value is 0x");
            printf("%x\r\n",regval);
            return;
        } //end if
    } // end for
}

/* Buddy box current range configuration */
void bbrange(void) {
    int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    UINT32 regmask = 0xc0ffff;
    UINT16 regloc = BB_REG_LOC;
    UINT32 regval = 0;
    for(;;) {
        printf("\r\nChoose buddy box current range:\r\n");
        printf("  1. 1nA\r\n");
        printf("  2. 10nA\r\n");
        printf("  3. 100nA\r\n");
        printf("  4. 1uA\r\n");
        printf("  5. 10uA\r\n");
        printf("  6. 100uA\r\n");
        printf("  7. Internal ranges\r\n");
        printf("  8. Return to main menu \r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : // 1nA
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1 << 16;
                sport0_write(regval,regloc);
                goodsel = 1;
                break;
            case 2 : // 10nA
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x21 << 16;
                sport0_write(regval,regloc);
                goodsel = 1;
                break;
            case 3 : // 100nA
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x31 << 16;
                sport0_write(regval,regloc);
                goodsel = 1;
                break;
            case 4 : // 1uA
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x39 << 16;
                sport0_write(regval,regloc);
                goodsel = 1;
                break;
            case 5 : // 10uA
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x3 << 16;
                sport0_write(regval,regloc);
                goodsel = 1;
                break;  
            case 6 : // 100uA
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x7 << 16;
                sport0_write(regval,regloc);
                goodsel = 1;
                break; 
            case 7 : // Internal ranges
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x0 << 16;
                sport0_write(regval,regloc);
                goodsel = 1;
                break;    
            case 8 : 
                goodsel = 1; 
                break;
            default: printf("\r\nInvalid selection\r\n");
                goodsel = 0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel == 1) {
            sport0_read(BB_REG_LOC,&regval);
            printf("Buddy box configuration register value is 0x");
            printf("%x\r\n",regval);
            return;
        } //end if
    } // end for
} 

/* Buddy box fieldcal configuration */
void bbfcal(void) {
    int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    UINT32 regmask = 0xfffe00;
    UINT16 regloc = BB_REG_LOC;
    UINT32 regval = 0;
    for(;;) {
        printf("\r\nBuddy box fieldcal configuration:\r\n");
        printf("  1. Source 1uA to WE\r\n");
        printf("  2. Source 10uA to WE\r\n");
        printf("  3. Source 100uA to WE\r\n");
        printf("  4. Apply 10V common-mode\r\n");
        printf("  5. Apply -10V common-mode\r\n");
        printf("  6. Apply 0V common-mode\r\n");
        printf("  7. Apply 10V differential-mode\r\n");
        printf("  8. Switch in 10k dummy load \r\n");
        printf("  9. Set defaults (no fieldcal)\r\n");
        printf(" 10. Back to main menu\r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : // Source 1uA to WE
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1dc; // Route 1uA source
                regval |= 1<<FCSINK_POS; // Connect fieldcal sink switch
                sport0_write(regval,regloc);
                goodsel = 1;
                break;
            case 2 : // Source 10uA to WE
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1bc; // Route 10uA source
                regval |= 1<<FCSINK_POS; // Connect fieldcal sink switch
                sport0_write(regval,regloc);
                goodsel = 1;
                break;
            case 3 : // Source 100uA to WE
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x17c;
                regval |= 1<<FCSINK_POS; // Connect fieldcal sink switch
                sport0_write(regval,regloc);
                goodsel = 1;
                break;
            case 4 : // Apply +10V common-mode
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1ed;
                regval &= ~(1<<FCSINK_POS); // Disconnect fieldcal sink switch
                sport0_write(regval,regloc);
                goodsel = 1;
                break;
            case 5 : // Apply -10V common-mode
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1e7;
                regval &= ~(1<<FCSINK_POS); // Disconnect fieldcal sink switch
                sport0_write(regval,regloc);
                goodsel = 1;
                break;  
            case 6 : // Apply 0V common-mode
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1eb;
                regval &= ~(1<<FCSINK_POS); // Disconnect fieldcal sink switch
                sport0_write(regval,regloc);
                goodsel = 1;
                break; 
            case 7 : // Apply +10V differential
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1ed;
                regval |= 1<<FCSINK_POS; // Connect fieldcal sink switch
                sport0_write(regval,regloc);
                goodsel = 1;
                break;     
            case 8 : // 10k dummy load
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x1fd;
                regval |= 1<<FCSINK_POS; // Connect fieldcal sink switch
                regval |= 1<<BBCE_POS; // Connect CE to dummy load
                sport0_write(regval,regloc);
                goodsel = 1;
                break; 
            case 9 : // Set defaults
                sport0_read(regloc,&regval);
                regval &= regmask;
                regval |= 0x0da;
                regval &= ~(1<<FCSINK_POS); // Disconnect fieldcal sink switch
                regval |= ~(1<<BBCE_POS); // Disconnect CE from dummy load
                sport0_write(regval,regloc);
                goodsel = 1;
                break;    
            case 10 : 
                goodsel = 1; 
                break;
            default: printf("\r\nInvalid selection\r\n");
                goodsel = 0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel == 1) {
            sport0_read(BB_REG_LOC,&regval);
            printf("Buddy box configuration register value is 0x");
            printf("%x\r\n",regval);
            return;
        } //end if
    } // end for
}     

/* Quad DAC control register menu */
void qdconfig(void) {
    int goodsel = 0;
    int choice = 1;
    int sendok = 0;
    int dacval = 0;
    UINT32 regval = 0;
    for(;;) {
        printf("\r\nQuad DAC configuration:\r\n");
        printf("  1. Set CE monitor offset\r\n");
        printf("  2. Set low compliance limit\r\n");
        printf("  3. Set high compliance limit\r\n");
        printf("  4. Set front panel I/V BNC offset \r\n");
        printf("  5. Set rotator voltage \r\n");
        printf("  6. Set front panel I/V bias rejection \r\n");
        printf("  7. Set raw I/V offset \r\n");
        printf("  8. Set main voltmeter offset \r\n");
        printf("  9. Initialize all DACs to defaults \r\n");
        printf("  10. Return to main menu \r\n");
        scanf("%u", &choice);
        switch(choice) {
            case 1 : /* Set CE monitor offset */
                printf("Enter CE monitor offset (0x000 --> 0xfff):\r\n");
                scanf("%x",&dacval);
                cemon_offset = dacval & 0xfff;
                dacaUpdate();
                goodsel = 1;
                break;
            case 2: /* Set the low compliance limit */
                printf("Enter the low compliance limit (0x000 --> 0xfff):\r\n");
                scanf("%x",&dacval);
                limit_dac_low = dacval & 0xfff;
                dacaUpdate();
                goodsel = 1;
                break;
            case 3: /* Set the high compliance limit */
                printf("Enter the high compliance limit (0x000 --> 0xfff):\r\n");
                scanf("%x",&dacval);
                limit_dac_high = dacval & 0xfff;
                dacaUpdate();
                goodsel = 1;
                break;
            case 4 : /* Set front panel I/V (fine) offset */
                printf("Enter the front panel I/V offset (0x000 --> 0xfff):\r\n");
                scanf("%x",&dacval);
                fp_iv_offset = dacval & 0xfff;
                dacaUpdate();
                goodsel = 1;
                break;
            case 5 : /* Set rotator voltage */
                printf("Enter the rotator value (0x000 --> 0xfff):\r\n");
                scanf("%x",&dacval);
                rotator = dacval & 0xfff;
                dacbUpdate();
                goodsel = 1;
                break;   
            case 6 : /* Set front panel I/V bias rejection */
                printf("Enter the front panel I/V bias reject value (0x000 --> 0xfff):\r\n");
                scanf("%x",&dacval);
                iv_reject = dacval & 0xfff;
                dacbUpdate();
                goodsel = 1;
                break;
            case 7 : /* Set raw I/V offset */
                printf("Enter the raw I/V offset value (0x000 --> 0xfff):\r\n");
                scanf("%x",&dacval);
                iv_offset = dacval & 0xfff;
                dacbUpdate();
                goodsel = 1;
                break; 
            case 8 : /* Set main voltmeter offset */
                printf("Enter the main voltmeter offset value (0x000 --> 0xfff):\r\n");
                scanf("%x",&dacval);
                vm_offset = dacval & 0xfff;
                dacbUpdate();
                goodsel = 1;
                break;
            case 9 : /* Initialize all DACs to defaults */
                qdac_init();
                goodsel = 1;
                break;
            
            case 10 : /* Return to main menu */
                goodsel = 1;
                break;  
            
                
            default: printf("\r\nInvalid selection\r\n");
                goodsel = 0;
        } // end switch
        if (sendok != 0) {
            printf("Write to sport0 failed.\r\n");
        }
        if (goodsel == 1) {
            printf("You entered 0x");
            printf("%x\r\n",dacval);
            return;
        } //end if
    } // end for
}
