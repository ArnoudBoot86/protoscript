/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x79f3f3a8 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/training/verilog/ex08/shiftertf.v";
static unsigned int ng1[] = {0U, 0U};
static const char *ng2 = "  ***  Error %0d detected at time %t  ***";
static int ng3[] = {9, 0};
static int ng4[] = {0, 0};
static const char *ng5 = "ns";
static const char *ng6 = "Starting...";
static unsigned int ng7[] = {0U, 7U};
static int ng8[] = {4, 0};
static unsigned int ng9[] = {1U, 1U};
static int ng10[] = {1, 0};
static int ng11[] = {2, 0};
static int ng12[] = {3, 0};
static int ng13[] = {5, 0};
static int ng14[] = {6, 0};
static int ng15[] = {7, 0};
static unsigned int ng16[] = {1U, 0U};
static int ng17[] = {8, 0};
static unsigned int ng18[] = {2U, 0U};
static int ng19[] = {10, 0};
static int ng20[] = {11, 0};
static int ng21[] = {12, 0};
static int ng22[] = {13, 0};
static int ng23[] = {14, 0};
static int ng24[] = {15, 0};
static int ng25[] = {16, 0};
static int ng26[] = {17, 0};
static unsigned int ng27[] = {5U, 0U};
static int ng28[] = {18, 0};
static int ng29[] = {19, 0};
static int ng30[] = {20, 0};
static unsigned int ng31[] = {6U, 0U};
static int ng32[] = {21, 0};
static int ng33[] = {22, 0};
static int ng34[] = {23, 0};
static unsigned int ng35[] = {7U, 0U};
static int ng36[] = {24, 0};
static int ng37[] = {25, 0};
static const char *ng38 = "Finished with no errors detected";
static const char *ng39 = "Finished with ERRORS - please check messages above";



static void Cont_25_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 1996U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(25, ng0);
    t2 = (t0 + 1380);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = (t0 + 2676);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 40U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 7U;
    t11 = t10;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t5, 0, 2);
    t18 = (t0 + 2624);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Always_40_1(char *t0)
{
    char t8[8];
    char t20[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t21;

LAB0:    t1 = (t0 + 2140U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(40, ng0);
    t2 = (t0 + 2632);
    *((int *)t2) = 1;
    t3 = (t0 + 2168);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(40, ng0);
    t4 = (t0 + 1472);
    t5 = (t4 + 36U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng1)));
    memset(t8, 0, 8);
    if (*((unsigned int *)t6) != *((unsigned int *)t7))
        goto LAB6;

LAB5:    t9 = (t6 + 4);
    t10 = (t7 + 4);
    if (*((unsigned int *)t9) != *((unsigned int *)t10))
        goto LAB6;

LAB7:    t11 = (t8 + 4);
    t12 = *((unsigned int *)t11);
    t13 = (~(t12));
    t14 = *((unsigned int *)t8);
    t15 = (t14 & t13);
    t16 = (t15 != 0);
    if (t16 > 0)
        goto LAB8;

LAB9:
LAB10:    goto LAB2;

LAB6:    *((unsigned int *)t8) = 1;
    goto LAB7;

LAB8:    xsi_set_current_line(41, ng0);
    t17 = (t0 + 1472);
    t18 = (t17 + 36U);
    t19 = *((char **)t18);
    t21 = xsi_vlog_time(t20, 1000.0000000000000, 1000.0000000000000);
    xsi_vlogfile_write(1, 0, 0, ng2, 3, t0, (char)118, t19, 8, (char)118, t20, 64);
    goto LAB10;

}

static void Always_46_2(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;

LAB0:    t1 = (t0 + 2284U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(46, ng0);
    t2 = (t0 + 2184);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(47, ng0);
    t4 = (t0 + 920);
    t5 = (t4 + 36U);
    t6 = *((char **)t5);
    memset(t3, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t7) == 0)
        goto LAB5;

LAB7:    t13 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t13) = 1;

LAB8:    t14 = (t0 + 920);
    xsi_vlogvar_assign_value(t14, t3, 0, 0, 1);
    goto LAB2;

LAB5:    *((unsigned int *)t3) = 1;
    goto LAB8;

}

static void Initial_57_3(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    int t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t24;

LAB0:    t1 = (t0 + 2428U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(58, ng0);

LAB4:    xsi_set_current_line(59, ng0);
    t2 = ((char*)((ng3)));
    memset(t3, 0, 8);
    xsi_vlog_signed_unary_minus(t3, 32, t2, 32);
    t4 = ((char*)((ng4)));
    t5 = ((char*)((ng4)));
    xsi_vlog_setTimeFormat(*((unsigned int *)t3), *((unsigned int *)t4), ng5, 0, *((unsigned int *)t5));
    xsi_set_current_line(60, ng0);
    xsi_vlogfile_write(1, 0, 0, ng6, 1, t0);
    xsi_set_current_line(62, ng0);
    t2 = ((char*)((ng4)));
    t4 = (t0 + 1472);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 8);
    xsi_set_current_line(64, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 1012);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    t5 = (t0 + 1104);
    xsi_vlogvar_assign_value(t5, t2, 1, 0, 1);
    t6 = (t0 + 1196);
    xsi_vlogvar_assign_value(t6, t2, 2, 0, 1);
    xsi_set_current_line(65, ng0);
    t2 = ((char*)((ng4)));
    t4 = (t0 + 920);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(66, ng0);
    t2 = ((char*)((ng4)));
    t4 = (t0 + 1288);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(67, ng0);
    t2 = ((char*)((ng7)));
    t4 = (t0 + 1380);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 3);
    xsi_set_current_line(70, ng0);
    t2 = ((char*)((ng8)));
    t4 = (t2 + 4);
    t7 = *((unsigned int *)t4);
    t8 = (~(t7));
    t9 = *((unsigned int *)t2);
    t10 = (t9 & t8);
    t5 = (t0 + 3968);
    *((int *)t5) = t10;

LAB5:    t6 = (t0 + 3968);
    if (*((int *)t6) > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(74, ng0);
    t2 = (t0 + 692U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng7)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t4) != *((unsigned int *)t2))
        goto LAB17;

LAB16:    t5 = (t4 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB17;

LAB18:    t11 = (t3 + 4);
    t7 = *((unsigned int *)t11);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB19;

LAB20:
LAB21:    xsi_set_current_line(77, ng0);
    t2 = ((char*)((ng10)));
    t4 = (t0 + 1012);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(78, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 30000LL);
    *((char **)t1) = &&LAB22;

LAB1:    return;
LAB6:    xsi_set_current_line(71, ng0);

LAB8:    xsi_set_current_line(72, ng0);
    t11 = (t0 + 2328);
    xsi_process_wait(t11, 10000LL);
    *((char **)t1) = &&LAB9;
    goto LAB1;

LAB9:    xsi_set_current_line(72, ng0);
    t12 = (t0 + 600U);
    t13 = *((char **)t12);
    t12 = ((char*)((ng9)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t13) != *((unsigned int *)t12))
        goto LAB11;

LAB10:    t14 = (t13 + 4);
    t15 = (t12 + 4);
    if (*((unsigned int *)t14) != *((unsigned int *)t15))
        goto LAB11;

LAB12:    t16 = (t3 + 4);
    t17 = *((unsigned int *)t16);
    t18 = (~(t17));
    t19 = *((unsigned int *)t3);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB13;

LAB14:
LAB15:    t2 = (t0 + 3968);
    t10 = *((int *)t2);
    *((int *)t2) = (t10 - 1);
    goto LAB5;

LAB11:    *((unsigned int *)t3) = 1;
    goto LAB12;

LAB13:    xsi_set_current_line(72, ng0);
    t22 = ((char*)((ng10)));
    t23 = (t0 + 1472);
    xsi_vlogvar_assign_value(t23, t22, 0, 0, 8);
    goto LAB15;

LAB17:    *((unsigned int *)t3) = 1;
    goto LAB18;

LAB19:    xsi_set_current_line(74, ng0);
    t12 = ((char*)((ng11)));
    t13 = (t0 + 1472);
    xsi_vlogvar_assign_value(t13, t12, 0, 0, 8);
    goto LAB21;

LAB22:    xsi_set_current_line(79, ng0);
    t4 = ((char*)((ng8)));
    t5 = (t4 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (~(t7));
    t9 = *((unsigned int *)t4);
    t10 = (t9 & t8);
    t6 = (t0 + 3972);
    *((int *)t6) = t10;

LAB23:    t11 = (t0 + 3972);
    if (*((int *)t11) > 0)
        goto LAB24;

LAB25:    xsi_set_current_line(83, ng0);
    t2 = (t0 + 692U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng7)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t4) != *((unsigned int *)t2))
        goto LAB35;

LAB34:    t5 = (t4 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB35;

LAB36:    t11 = (t3 + 4);
    t7 = *((unsigned int *)t11);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB37;

LAB38:
LAB39:    xsi_set_current_line(86, ng0);
    t2 = ((char*)((ng10)));
    t4 = (t0 + 1288);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(87, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB40;
    goto LAB1;

LAB24:    xsi_set_current_line(80, ng0);

LAB26:    xsi_set_current_line(81, ng0);
    t12 = (t0 + 2328);
    xsi_process_wait(t12, 10000LL);
    *((char **)t1) = &&LAB27;
    goto LAB1;

LAB27:    xsi_set_current_line(81, ng0);
    t13 = (t0 + 600U);
    t14 = *((char **)t13);
    t13 = ((char*)((ng1)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t14) != *((unsigned int *)t13))
        goto LAB29;

LAB28:    t15 = (t14 + 4);
    t16 = (t13 + 4);
    if (*((unsigned int *)t15) != *((unsigned int *)t16))
        goto LAB29;

LAB30:    t22 = (t3 + 4);
    t17 = *((unsigned int *)t22);
    t18 = (~(t17));
    t19 = *((unsigned int *)t3);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB31;

LAB32:
LAB33:    t2 = (t0 + 3972);
    t10 = *((int *)t2);
    *((int *)t2) = (t10 - 1);
    goto LAB23;

LAB29:    *((unsigned int *)t3) = 1;
    goto LAB30;

LAB31:    xsi_set_current_line(81, ng0);
    t23 = ((char*)((ng12)));
    t24 = (t0 + 1472);
    xsi_vlogvar_assign_value(t24, t23, 0, 0, 8);
    goto LAB33;

LAB35:    *((unsigned int *)t3) = 1;
    goto LAB36;

LAB37:    xsi_set_current_line(83, ng0);
    t12 = ((char*)((ng8)));
    t13 = (t0 + 1472);
    xsi_vlogvar_assign_value(t13, t12, 0, 0, 8);
    goto LAB39;

LAB40:    xsi_set_current_line(87, ng0);
    t4 = (t0 + 600U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB42;

LAB41:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB42;

LAB43:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB44;

LAB45:
LAB46:    xsi_set_current_line(88, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB47;
    goto LAB1;

LAB42:    *((unsigned int *)t3) = 1;
    goto LAB43;

LAB44:    xsi_set_current_line(87, ng0);
    t13 = ((char*)((ng13)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB46;

LAB47:    xsi_set_current_line(88, ng0);
    t4 = (t0 + 600U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB49;

LAB48:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB49;

LAB50:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB51;

LAB52:
LAB53:    xsi_set_current_line(89, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB54;
    goto LAB1;

LAB49:    *((unsigned int *)t3) = 1;
    goto LAB50;

LAB51:    xsi_set_current_line(88, ng0);
    t13 = ((char*)((ng14)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB53;

LAB54:    xsi_set_current_line(89, ng0);
    t4 = (t0 + 600U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB56;

LAB55:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB56;

LAB57:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB58;

LAB59:
LAB60:    xsi_set_current_line(90, ng0);
    t2 = ((char*)((ng8)));
    t4 = (t2 + 4);
    t7 = *((unsigned int *)t4);
    t8 = (~(t7));
    t9 = *((unsigned int *)t2);
    t10 = (t9 & t8);
    t5 = (t0 + 3976);
    *((int *)t5) = t10;

LAB61:    t6 = (t0 + 3976);
    if (*((int *)t6) > 0)
        goto LAB62;

LAB63:    xsi_set_current_line(94, ng0);
    t2 = (t0 + 692U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng7)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t4) != *((unsigned int *)t2))
        goto LAB73;

LAB72:    t5 = (t4 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB73;

LAB74:    t11 = (t3 + 4);
    t7 = *((unsigned int *)t11);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB75;

LAB76:
LAB77:    xsi_set_current_line(97, ng0);
    t2 = ((char*)((ng4)));
    t4 = (t0 + 1012);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(98, ng0);
    t2 = ((char*)((ng10)));
    t4 = (t0 + 1104);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(99, ng0);
    t2 = ((char*)((ng18)));
    t4 = (t0 + 1380);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 3);
    xsi_set_current_line(100, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB78;
    goto LAB1;

LAB56:    *((unsigned int *)t3) = 1;
    goto LAB57;

LAB58:    xsi_set_current_line(89, ng0);
    t13 = ((char*)((ng15)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB60;

LAB62:    xsi_set_current_line(91, ng0);

LAB64:    xsi_set_current_line(92, ng0);
    t11 = (t0 + 2328);
    xsi_process_wait(t11, 10000LL);
    *((char **)t1) = &&LAB65;
    goto LAB1;

LAB65:    xsi_set_current_line(92, ng0);
    t12 = (t0 + 600U);
    t13 = *((char **)t12);
    t12 = ((char*)((ng16)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t13) != *((unsigned int *)t12))
        goto LAB67;

LAB66:    t14 = (t13 + 4);
    t15 = (t12 + 4);
    if (*((unsigned int *)t14) != *((unsigned int *)t15))
        goto LAB67;

LAB68:    t16 = (t3 + 4);
    t17 = *((unsigned int *)t16);
    t18 = (~(t17));
    t19 = *((unsigned int *)t3);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB69;

LAB70:
LAB71:    t2 = (t0 + 3976);
    t10 = *((int *)t2);
    *((int *)t2) = (t10 - 1);
    goto LAB61;

LAB67:    *((unsigned int *)t3) = 1;
    goto LAB68;

LAB69:    xsi_set_current_line(92, ng0);
    t22 = ((char*)((ng17)));
    t23 = (t0 + 1472);
    xsi_vlogvar_assign_value(t23, t22, 0, 0, 8);
    goto LAB71;

LAB73:    *((unsigned int *)t3) = 1;
    goto LAB74;

LAB75:    xsi_set_current_line(94, ng0);
    t12 = ((char*)((ng3)));
    t13 = (t0 + 1472);
    xsi_vlogvar_assign_value(t13, t12, 0, 0, 8);
    goto LAB77;

LAB78:    xsi_set_current_line(100, ng0);
    t4 = (t0 + 600U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng16)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB80;

LAB79:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB80;

LAB81:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB82;

LAB83:
LAB84:    xsi_set_current_line(101, ng0);
    t2 = (t0 + 692U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng18)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t4) != *((unsigned int *)t2))
        goto LAB86;

LAB85:    t5 = (t4 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB86;

LAB87:    t11 = (t3 + 4);
    t7 = *((unsigned int *)t11);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB88;

LAB89:
LAB90:    xsi_set_current_line(104, ng0);
    t2 = ((char*)((ng4)));
    t4 = (t0 + 1104);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(105, ng0);
    t2 = ((char*)((ng7)));
    t4 = (t0 + 1380);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 3);
    xsi_set_current_line(106, ng0);
    t2 = ((char*)((ng8)));
    t4 = (t2 + 4);
    t7 = *((unsigned int *)t4);
    t8 = (~(t7));
    t9 = *((unsigned int *)t2);
    t10 = (t9 & t8);
    t5 = (t0 + 3980);
    *((int *)t5) = t10;

LAB91:    t6 = (t0 + 3980);
    if (*((int *)t6) > 0)
        goto LAB92;

LAB93:    xsi_set_current_line(110, ng0);
    t2 = (t0 + 692U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng7)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t4) != *((unsigned int *)t2))
        goto LAB103;

LAB102:    t5 = (t4 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB103;

LAB104:    t11 = (t3 + 4);
    t7 = *((unsigned int *)t11);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB105;

LAB106:
LAB107:    xsi_set_current_line(113, ng0);
    t2 = ((char*)((ng10)));
    t4 = (t0 + 1196);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(114, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 1000LL);
    *((char **)t1) = &&LAB108;
    goto LAB1;

LAB80:    *((unsigned int *)t3) = 1;
    goto LAB81;

LAB82:    xsi_set_current_line(100, ng0);
    t13 = ((char*)((ng19)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB84;

LAB86:    *((unsigned int *)t3) = 1;
    goto LAB87;

LAB88:    xsi_set_current_line(101, ng0);
    t12 = ((char*)((ng20)));
    t13 = (t0 + 1472);
    xsi_vlogvar_assign_value(t13, t12, 0, 0, 8);
    goto LAB90;

LAB92:    xsi_set_current_line(107, ng0);

LAB94:    xsi_set_current_line(108, ng0);
    t11 = (t0 + 2328);
    xsi_process_wait(t11, 10000LL);
    *((char **)t1) = &&LAB95;
    goto LAB1;

LAB95:    xsi_set_current_line(108, ng0);
    t12 = (t0 + 600U);
    t13 = *((char **)t12);
    t12 = ((char*)((ng16)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t13) != *((unsigned int *)t12))
        goto LAB97;

LAB96:    t14 = (t13 + 4);
    t15 = (t12 + 4);
    if (*((unsigned int *)t14) != *((unsigned int *)t15))
        goto LAB97;

LAB98:    t16 = (t3 + 4);
    t17 = *((unsigned int *)t16);
    t18 = (~(t17));
    t19 = *((unsigned int *)t3);
    t20 = (t19 & t18);
    t21 = (t20 != 0);
    if (t21 > 0)
        goto LAB99;

LAB100:
LAB101:    t2 = (t0 + 3980);
    t10 = *((int *)t2);
    *((int *)t2) = (t10 - 1);
    goto LAB91;

LAB97:    *((unsigned int *)t3) = 1;
    goto LAB98;

LAB99:    xsi_set_current_line(108, ng0);
    t22 = ((char*)((ng21)));
    t23 = (t0 + 1472);
    xsi_vlogvar_assign_value(t23, t22, 0, 0, 8);
    goto LAB101;

LAB103:    *((unsigned int *)t3) = 1;
    goto LAB104;

LAB105:    xsi_set_current_line(110, ng0);
    t12 = ((char*)((ng22)));
    t13 = (t0 + 1472);
    xsi_vlogvar_assign_value(t13, t12, 0, 0, 8);
    goto LAB107;

LAB108:    xsi_set_current_line(114, ng0);
    t4 = (t0 + 692U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng18)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB110;

LAB109:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB110;

LAB111:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB112;

LAB113:
LAB114:    xsi_set_current_line(115, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 9000LL);
    *((char **)t1) = &&LAB115;
    goto LAB1;

LAB110:    *((unsigned int *)t3) = 1;
    goto LAB111;

LAB112:    xsi_set_current_line(114, ng0);
    t13 = ((char*)((ng23)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB114;

LAB115:    xsi_set_current_line(115, ng0);
    t4 = (t0 + 600U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng16)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB117;

LAB116:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB117;

LAB118:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB119;

LAB120:
LAB121:    xsi_set_current_line(119, ng0);
    t2 = ((char*)((ng10)));
    t4 = (t0 + 1012);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 1);
    xsi_set_current_line(120, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 4000LL);
    *((char **)t1) = &&LAB122;
    goto LAB1;

LAB117:    *((unsigned int *)t3) = 1;
    goto LAB118;

LAB119:    xsi_set_current_line(115, ng0);
    t13 = ((char*)((ng24)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB121;

LAB122:    xsi_set_current_line(120, ng0);
    t4 = (t0 + 692U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng18)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB124;

LAB123:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB124;

LAB125:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB126;

LAB127:
LAB128:    xsi_set_current_line(121, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB129;
    goto LAB1;

LAB124:    *((unsigned int *)t3) = 1;
    goto LAB125;

LAB126:    xsi_set_current_line(120, ng0);
    t13 = ((char*)((ng25)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB128;

LAB129:    xsi_set_current_line(121, ng0);
    t4 = (t0 + 600U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB131;

LAB130:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB131;

LAB132:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB133;

LAB134:
LAB135:    xsi_set_current_line(122, ng0);
    t2 = (t0 + 692U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng27)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t4) != *((unsigned int *)t2))
        goto LAB137;

LAB136:    t5 = (t4 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB137;

LAB138:    t11 = (t3 + 4);
    t7 = *((unsigned int *)t11);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB139;

LAB140:
LAB141:    xsi_set_current_line(124, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 8000LL);
    *((char **)t1) = &&LAB142;
    goto LAB1;

LAB131:    *((unsigned int *)t3) = 1;
    goto LAB132;

LAB133:    xsi_set_current_line(121, ng0);
    t13 = ((char*)((ng26)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB135;

LAB137:    *((unsigned int *)t3) = 1;
    goto LAB138;

LAB139:    xsi_set_current_line(122, ng0);
    t12 = ((char*)((ng28)));
    t13 = (t0 + 1472);
    xsi_vlogvar_assign_value(t13, t12, 0, 0, 8);
    goto LAB141;

LAB142:    xsi_set_current_line(124, ng0);
    t4 = (t0 + 692U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng27)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB144;

LAB143:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB144;

LAB145:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB146;

LAB147:
LAB148:    xsi_set_current_line(125, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB149;
    goto LAB1;

LAB144:    *((unsigned int *)t3) = 1;
    goto LAB145;

LAB146:    xsi_set_current_line(124, ng0);
    t13 = ((char*)((ng29)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB148;

LAB149:    xsi_set_current_line(125, ng0);
    t4 = (t0 + 600U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng16)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB151;

LAB150:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB151;

LAB152:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB153;

LAB154:
LAB155:    xsi_set_current_line(126, ng0);
    t2 = (t0 + 692U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng31)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t4) != *((unsigned int *)t2))
        goto LAB157;

LAB156:    t5 = (t4 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB157;

LAB158:    t11 = (t3 + 4);
    t7 = *((unsigned int *)t11);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB159;

LAB160:
LAB161:    xsi_set_current_line(128, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 8000LL);
    *((char **)t1) = &&LAB162;
    goto LAB1;

LAB151:    *((unsigned int *)t3) = 1;
    goto LAB152;

LAB153:    xsi_set_current_line(125, ng0);
    t13 = ((char*)((ng30)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB155;

LAB157:    *((unsigned int *)t3) = 1;
    goto LAB158;

LAB159:    xsi_set_current_line(126, ng0);
    t12 = ((char*)((ng32)));
    t13 = (t0 + 1472);
    xsi_vlogvar_assign_value(t13, t12, 0, 0, 8);
    goto LAB161;

LAB162:    xsi_set_current_line(128, ng0);
    t4 = (t0 + 692U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng31)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB164;

LAB163:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB164;

LAB165:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB166;

LAB167:
LAB168:    xsi_set_current_line(129, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB169;
    goto LAB1;

LAB164:    *((unsigned int *)t3) = 1;
    goto LAB165;

LAB166:    xsi_set_current_line(128, ng0);
    t13 = ((char*)((ng33)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB168;

LAB169:    xsi_set_current_line(129, ng0);
    t4 = (t0 + 600U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB171;

LAB170:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB171;

LAB172:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB173;

LAB174:
LAB175:    xsi_set_current_line(130, ng0);
    t2 = (t0 + 692U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng35)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t4) != *((unsigned int *)t2))
        goto LAB177;

LAB176:    t5 = (t4 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB177;

LAB178:    t11 = (t3 + 4);
    t7 = *((unsigned int *)t11);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB179;

LAB180:
LAB181:    xsi_set_current_line(133, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 4000LL);
    *((char **)t1) = &&LAB182;
    goto LAB1;

LAB171:    *((unsigned int *)t3) = 1;
    goto LAB172;

LAB173:    xsi_set_current_line(129, ng0);
    t13 = ((char*)((ng34)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB175;

LAB177:    *((unsigned int *)t3) = 1;
    goto LAB178;

LAB179:    xsi_set_current_line(130, ng0);
    t12 = ((char*)((ng36)));
    t13 = (t0 + 1472);
    xsi_vlogvar_assign_value(t13, t12, 0, 0, 8);
    goto LAB181;

LAB182:    xsi_set_current_line(133, ng0);
    t4 = ((char*)((ng4)));
    t5 = (t0 + 1196);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(134, ng0);
    t2 = (t0 + 2328);
    xsi_process_wait(t2, 1000LL);
    *((char **)t1) = &&LAB183;
    goto LAB1;

LAB183:    xsi_set_current_line(134, ng0);
    t4 = (t0 + 692U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng7)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t4))
        goto LAB185;

LAB184:    t6 = (t5 + 4);
    t11 = (t4 + 4);
    if (*((unsigned int *)t6) != *((unsigned int *)t11))
        goto LAB185;

LAB186:    t12 = (t3 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB187;

LAB188:
LAB189:    xsi_set_current_line(136, ng0);
    t2 = (t0 + 1472);
    t4 = (t2 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng1)));
    memset(t3, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB192;

LAB190:    t11 = (t5 + 4);
    t12 = (t6 + 4);
    if (*((unsigned int *)t11) != *((unsigned int *)t12))
        goto LAB192;

LAB191:    *((unsigned int *)t3) = 1;

LAB192:    t13 = (t3 + 4);
    t7 = *((unsigned int *)t13);
    t8 = (~(t7));
    t9 = *((unsigned int *)t3);
    t17 = (t9 & t8);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB193;

LAB194:    xsi_set_current_line(139, ng0);
    xsi_vlogfile_write(1, 0, 0, ng39, 1, t0);

LAB195:    xsi_set_current_line(141, ng0);
    xsi_vlog_stop(1);
    xsi_set_current_line(141, ng0);
    xsi_vlog_finish(1);
    goto LAB1;

LAB185:    *((unsigned int *)t3) = 1;
    goto LAB186;

LAB187:    xsi_set_current_line(134, ng0);
    t13 = ((char*)((ng37)));
    t14 = (t0 + 1472);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 8);
    goto LAB189;

LAB193:    xsi_set_current_line(137, ng0);
    xsi_vlogfile_write(1, 0, 0, ng38, 1, t0);
    goto LAB195;

}


extern void work_m_00000000001575588139_0509448875_init()
{
	static char *pe[] = {(void *)Cont_25_0,(void *)Always_40_1,(void *)Always_46_2,(void *)Initial_57_3};
	xsi_register_didat("work_m_00000000001575588139_0509448875", "isim/shiftertf_isim_beh.exe.sim/work/m_00000000001575588139_0509448875.didat");
	xsi_register_executes(pe);
}
