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
static const char *ng0 = "C:/training/verilog/ex10/alutf.v";
static int ng1[] = {0, 0};
static unsigned int ng2[] = {0U, 0U};
static int ng3[] = {1, 0};
static unsigned int ng4[] = {1U, 0U};
static int ng5[] = {2, 0};
static unsigned int ng6[] = {3U, 0U};
static int ng7[] = {3, 0};
static unsigned int ng8[] = {8U, 0U};
static int ng9[] = {4, 0};
static unsigned int ng10[] = {15U, 0U};
static int ng11[] = {5, 0};
static unsigned int ng12[] = {128U, 0U};
static int ng13[] = {6, 0};
static unsigned int ng14[] = {248U, 0U};
static int ng15[] = {7, 0};
static unsigned int ng16[] = {255U, 0U};
static int ng17[] = {8, 0};
static int ng18[] = {15, 0};
static const char *ng19 = "alu.out";
static unsigned int ng20[] = {255U, 255U};
static const char *ng21 = "Failed to produce expected output on F at %d";
static unsigned int ng22[] = {1U, 1U};
static const char *ng23 = "Failed to produce expected output on Cout at %d";
static const char *ng24 = "Failed to produce expected output on Equal at %d";
static const char *ng25 = "Finished checking output";



static void Initial_14_0(char *t0)
{
    char t6[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;

LAB0:    t1 = (t0 + 3004U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(15, ng0);

LAB4:    t2 = (t0 + 148);
    xsi_vlog_namedbase_setdisablestate(t2, &&LAB5);
    t3 = (t0 + 2904);
    xsi_vlog_namedbase_pushprocess(t2, t3);

LAB6:    xsi_set_current_line(16, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 1560);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(17, ng0);

LAB7:    xsi_set_current_line(17, ng0);
    t2 = (t0 + 2904);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB8;

LAB1:    return;
LAB5:    t3 = (t0 + 2904);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB1;

LAB8:    xsi_set_current_line(18, ng0);
    t3 = (t0 + 1560);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t5);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB12;

LAB10:    if (*((unsigned int *)t7) == 0)
        goto LAB9;

LAB11:    t13 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t13) = 1;

LAB12:    t14 = (t0 + 1560);
    xsi_vlogvar_assign_value(t14, t6, 0, 0, 1);
    goto LAB7;

LAB9:    *((unsigned int *)t6) = 1;
    goto LAB12;

LAB13:    t2 = (t0 + 148);
    xsi_vlog_namedbase_popprocess(t2);
    goto LAB5;

}

static void Initial_21_1(char *t0)
{
    char t6[8];
    char t7[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    int t17;
    char *t18;
    unsigned int t19;
    int t20;
    int t21;
    unsigned int t22;
    unsigned int t23;
    int t24;
    int t25;
    unsigned int t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;

LAB0:    t1 = (t0 + 3148U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(22, ng0);

LAB4:    t2 = (t0 + 304);
    xsi_vlog_namedbase_setdisablestate(t2, &&LAB5);
    t3 = (t0 + 3048);
    xsi_vlog_namedbase_pushprocess(t2, t3);

LAB6:    xsi_set_current_line(25, ng0);
    t4 = ((char*)((ng2)));
    t5 = (t0 + 2204);
    t8 = (t0 + 2204);
    t9 = (t8 + 44U);
    t10 = *((char **)t9);
    t11 = (t0 + 2204);
    t12 = (t11 + 40U);
    t13 = *((char **)t12);
    t14 = ((char*)((ng3)));
    xsi_vlog_generic_convert_array_indices(t6, t7, t10, t13, 2, 1, t14, 32, 1);
    t15 = (t6 + 4);
    t16 = *((unsigned int *)t15);
    t17 = (!(t16));
    t18 = (t7 + 4);
    t19 = *((unsigned int *)t18);
    t20 = (!(t19));
    t21 = (t17 && t20);
    if (t21 == 1)
        goto LAB7;

LAB8:    xsi_set_current_line(26, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2204);
    t4 = (t0 + 2204);
    t5 = (t4 + 44U);
    t8 = *((char **)t5);
    t9 = (t0 + 2204);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    t12 = ((char*)((ng5)));
    xsi_vlog_generic_convert_array_indices(t6, t7, t8, t11, 2, 1, t12, 32, 1);
    t13 = (t6 + 4);
    t16 = *((unsigned int *)t13);
    t17 = (!(t16));
    t14 = (t7 + 4);
    t19 = *((unsigned int *)t14);
    t20 = (!(t19));
    t21 = (t17 && t20);
    if (t21 == 1)
        goto LAB9;

LAB10:    xsi_set_current_line(27, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 2204);
    t4 = (t0 + 2204);
    t5 = (t4 + 44U);
    t8 = *((char **)t5);
    t9 = (t0 + 2204);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    t12 = ((char*)((ng7)));
    xsi_vlog_generic_convert_array_indices(t6, t7, t8, t11, 2, 1, t12, 32, 1);
    t13 = (t6 + 4);
    t16 = *((unsigned int *)t13);
    t17 = (!(t16));
    t14 = (t7 + 4);
    t19 = *((unsigned int *)t14);
    t20 = (!(t19));
    t21 = (t17 && t20);
    if (t21 == 1)
        goto LAB11;

LAB12:    xsi_set_current_line(28, ng0);
    t2 = ((char*)((ng8)));
    t3 = (t0 + 2204);
    t4 = (t0 + 2204);
    t5 = (t4 + 44U);
    t8 = *((char **)t5);
    t9 = (t0 + 2204);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    t12 = ((char*)((ng9)));
    xsi_vlog_generic_convert_array_indices(t6, t7, t8, t11, 2, 1, t12, 32, 1);
    t13 = (t6 + 4);
    t16 = *((unsigned int *)t13);
    t17 = (!(t16));
    t14 = (t7 + 4);
    t19 = *((unsigned int *)t14);
    t20 = (!(t19));
    t21 = (t17 && t20);
    if (t21 == 1)
        goto LAB13;

LAB14:    xsi_set_current_line(29, ng0);
    t2 = ((char*)((ng10)));
    t3 = (t0 + 2204);
    t4 = (t0 + 2204);
    t5 = (t4 + 44U);
    t8 = *((char **)t5);
    t9 = (t0 + 2204);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    t12 = ((char*)((ng11)));
    xsi_vlog_generic_convert_array_indices(t6, t7, t8, t11, 2, 1, t12, 32, 1);
    t13 = (t6 + 4);
    t16 = *((unsigned int *)t13);
    t17 = (!(t16));
    t14 = (t7 + 4);
    t19 = *((unsigned int *)t14);
    t20 = (!(t19));
    t21 = (t17 && t20);
    if (t21 == 1)
        goto LAB15;

LAB16:    xsi_set_current_line(30, ng0);
    t2 = ((char*)((ng12)));
    t3 = (t0 + 2204);
    t4 = (t0 + 2204);
    t5 = (t4 + 44U);
    t8 = *((char **)t5);
    t9 = (t0 + 2204);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    t12 = ((char*)((ng13)));
    xsi_vlog_generic_convert_array_indices(t6, t7, t8, t11, 2, 1, t12, 32, 1);
    t13 = (t6 + 4);
    t16 = *((unsigned int *)t13);
    t17 = (!(t16));
    t14 = (t7 + 4);
    t19 = *((unsigned int *)t14);
    t20 = (!(t19));
    t21 = (t17 && t20);
    if (t21 == 1)
        goto LAB17;

LAB18:    xsi_set_current_line(31, ng0);
    t2 = ((char*)((ng14)));
    t3 = (t0 + 2204);
    t4 = (t0 + 2204);
    t5 = (t4 + 44U);
    t8 = *((char **)t5);
    t9 = (t0 + 2204);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    t12 = ((char*)((ng15)));
    xsi_vlog_generic_convert_array_indices(t6, t7, t8, t11, 2, 1, t12, 32, 1);
    t13 = (t6 + 4);
    t16 = *((unsigned int *)t13);
    t17 = (!(t16));
    t14 = (t7 + 4);
    t19 = *((unsigned int *)t14);
    t20 = (!(t19));
    t21 = (t17 && t20);
    if (t21 == 1)
        goto LAB19;

LAB20:    xsi_set_current_line(32, ng0);
    t2 = ((char*)((ng16)));
    t3 = (t0 + 2204);
    t4 = (t0 + 2204);
    t5 = (t4 + 44U);
    t8 = *((char **)t5);
    t9 = (t0 + 2204);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    t12 = ((char*)((ng17)));
    xsi_vlog_generic_convert_array_indices(t6, t7, t8, t11, 2, 1, t12, 32, 1);
    t13 = (t6 + 4);
    t16 = *((unsigned int *)t13);
    t17 = (!(t16));
    t14 = (t7 + 4);
    t19 = *((unsigned int *)t14);
    t20 = (!(t19));
    t21 = (t17 && t20);
    if (t21 == 1)
        goto LAB21;

LAB22:    xsi_set_current_line(34, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t2 + 4);
    t16 = *((unsigned int *)t3);
    t19 = (~(t16));
    t22 = *((unsigned int *)t2);
    t17 = (t22 & t19);
    t4 = (t0 + 4804);
    *((int *)t4) = t17;

LAB23:    t5 = (t0 + 4804);
    if (*((int *)t5) > 0)
        goto LAB24;

LAB25:    t2 = (t0 + 304);
    xsi_vlog_namedbase_popprocess(t2);

LAB5:    t3 = (t0 + 3048);
    xsi_vlog_dispose_process_subprogram_invocation(t3);

LAB1:    return;
LAB7:    t22 = *((unsigned int *)t6);
    t23 = *((unsigned int *)t7);
    t24 = (t22 - t23);
    t25 = (t24 + 1);
    xsi_vlogvar_assign_value(t5, t4, 0, *((unsigned int *)t7), t25);
    goto LAB8;

LAB9:    t22 = *((unsigned int *)t6);
    t23 = *((unsigned int *)t7);
    t24 = (t22 - t23);
    t25 = (t24 + 1);
    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t7), t25);
    goto LAB10;

LAB11:    t22 = *((unsigned int *)t6);
    t23 = *((unsigned int *)t7);
    t24 = (t22 - t23);
    t25 = (t24 + 1);
    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t7), t25);
    goto LAB12;

LAB13:    t22 = *((unsigned int *)t6);
    t23 = *((unsigned int *)t7);
    t24 = (t22 - t23);
    t25 = (t24 + 1);
    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t7), t25);
    goto LAB14;

LAB15:    t22 = *((unsigned int *)t6);
    t23 = *((unsigned int *)t7);
    t24 = (t22 - t23);
    t25 = (t24 + 1);
    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t7), t25);
    goto LAB16;

LAB17:    t22 = *((unsigned int *)t6);
    t23 = *((unsigned int *)t7);
    t24 = (t22 - t23);
    t25 = (t24 + 1);
    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t7), t25);
    goto LAB18;

LAB19:    t22 = *((unsigned int *)t6);
    t23 = *((unsigned int *)t7);
    t24 = (t22 - t23);
    t25 = (t24 + 1);
    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t7), t25);
    goto LAB20;

LAB21:    t22 = *((unsigned int *)t6);
    t23 = *((unsigned int *)t7);
    t24 = (t22 - t23);
    t25 = (t24 + 1);
    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t7), t25);
    goto LAB22;

LAB24:    xsi_set_current_line(35, ng0);

LAB26:    xsi_set_current_line(36, ng0);
    xsi_set_current_line(36, ng0);
    t8 = ((char*)((ng3)));
    t9 = (t0 + 1928);
    xsi_vlogvar_assign_value(t9, t8, 0, 0, 32);

LAB27:    t2 = (t0 + 1928);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng17)));
    memset(t6, 0, 8);
    xsi_vlog_signed_leq(t6, 32, t4, 32, t5, 32);
    t8 = (t6 + 4);
    t16 = *((unsigned int *)t8);
    t19 = (~(t16));
    t22 = *((unsigned int *)t6);
    t23 = (t22 & t19);
    t26 = (t23 != 0);
    if (t26 > 0)
        goto LAB28;

LAB29:    xsi_set_current_line(49, ng0);
    t2 = (t0 + 148);
    t3 = (t0 + 3048);
    t17 = xsi_vlog_namedbase_disable(t2, t3);
    if (t17 == 1)
        goto LAB1;

LAB40:    t2 = (t0 + 4804);
    t17 = *((int *)t2);
    *((int *)t2) = (t17 - 1);
    goto LAB23;

LAB28:    xsi_set_current_line(37, ng0);

LAB30:    xsi_set_current_line(38, ng0);
    t9 = (t0 + 2204);
    t10 = (t9 + 36U);
    t11 = *((char **)t10);
    t12 = (t0 + 2204);
    t13 = (t12 + 44U);
    t14 = *((char **)t13);
    t15 = (t0 + 2204);
    t18 = (t15 + 40U);
    t27 = *((char **)t18);
    t28 = (t0 + 1928);
    t29 = (t28 + 36U);
    t30 = *((char **)t29);
    xsi_vlog_generic_get_array_select_value(t7, 8, t11, t14, t27, 2, 1, t30, 32, 1);
    t31 = (t0 + 1744);
    xsi_vlogvar_assign_value(t31, t7, 0, 0, 8);
    xsi_set_current_line(39, ng0);
    xsi_set_current_line(39, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 2020);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB31:    t2 = (t0 + 2020);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng17)));
    memset(t6, 0, 8);
    xsi_vlog_signed_leq(t6, 32, t4, 32, t5, 32);
    t8 = (t6 + 4);
    t16 = *((unsigned int *)t8);
    t19 = (~(t16));
    t22 = *((unsigned int *)t6);
    t23 = (t22 & t19);
    t26 = (t23 != 0);
    if (t26 > 0)
        goto LAB32;

LAB33:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 1928);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t8 = (t0 + 1928);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 32);
    goto LAB27;

LAB32:    xsi_set_current_line(40, ng0);

LAB34:    xsi_set_current_line(41, ng0);
    t9 = (t0 + 2204);
    t10 = (t9 + 36U);
    t11 = *((char **)t10);
    t12 = (t0 + 2204);
    t13 = (t12 + 44U);
    t14 = *((char **)t13);
    t15 = (t0 + 2204);
    t18 = (t15 + 40U);
    t27 = *((char **)t18);
    t28 = (t0 + 2020);
    t29 = (t28 + 36U);
    t30 = *((char **)t29);
    xsi_vlog_generic_get_array_select_value(t7, 8, t11, t14, t27, 2, 1, t30, 32, 1);
    t31 = (t0 + 1652);
    xsi_vlogvar_assign_value(t31, t7, 0, 0, 8);
    xsi_set_current_line(42, ng0);
    xsi_set_current_line(42, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2112);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB35:    t2 = (t0 + 2112);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng18)));
    memset(t6, 0, 8);
    xsi_vlog_signed_leq(t6, 32, t4, 32, t5, 32);
    t8 = (t6 + 4);
    t16 = *((unsigned int *)t8);
    t19 = (~(t16));
    t22 = *((unsigned int *)t6);
    t23 = (t22 & t19);
    t26 = (t23 != 0);
    if (t26 > 0)
        goto LAB36;

LAB37:    xsi_set_current_line(39, ng0);
    t2 = (t0 + 2020);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t8 = (t0 + 2020);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 32);
    goto LAB31;

LAB36:    xsi_set_current_line(43, ng0);

LAB38:    xsi_set_current_line(44, ng0);
    t9 = (t0 + 2112);
    t10 = (t9 + 36U);
    t11 = *((char **)t10);
    t12 = (t0 + 1836);
    xsi_vlogvar_assign_value(t12, t11, 0, 0, 4);
    xsi_set_current_line(45, ng0);
    t2 = (t0 + 3048);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB39;
    goto LAB1;

LAB39:    xsi_set_current_line(42, ng0);
    t2 = (t0 + 2112);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t8 = (t0 + 2112);
    xsi_vlogvar_assign_value(t8, t6, 0, 0, 32);
    goto LAB35;

}

static void Initial_55_2(char *t0)
{
    char t7[8];
    char t16[8];
    char t28[8];
    char t35[8];
    char t36[8];
    char t72[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    unsigned int t27;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    char *t48;
    char *t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    int t58;
    int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    char *t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    char *t73;
    char *t74;

LAB0:    t1 = (t0 + 3292U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(56, ng0);

LAB4:    t2 = (t0 + 460);
    xsi_vlog_namedbase_setdisablestate(t2, &&LAB5);
    t3 = (t0 + 3192);
    xsi_vlog_namedbase_pushprocess(t2, t3);

LAB6:    xsi_set_current_line(62, ng0);
    t4 = (t0 + 2296);
    xsi_vlogfile_readmemb(ng19, 0, t4, 0, 0, 0, 0);
    xsi_set_current_line(64, ng0);
    t2 = (t0 + 3192);
    xsi_process_wait(t2, 6000LL);
    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB5:    t3 = (t0 + 3192);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB1;

LAB7:    xsi_set_current_line(65, ng0);
    xsi_set_current_line(65, ng0);
    t3 = ((char*)((ng3)));
    t4 = (t0 + 2480);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 32);

LAB8:    t2 = (t0 + 2480);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = (t0 + 732);
    t6 = *((char **)t5);
    memset(t7, 0, 8);
    xsi_vlog_signed_leq(t7, 32, t4, 32, t6, 32);
    t5 = (t7 + 4);
    t8 = *((unsigned int *)t5);
    t9 = (~(t8));
    t10 = *((unsigned int *)t7);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB9;

LAB10:    xsi_set_current_line(76, ng0);
    t2 = (t0 + 460);
    xsi_vlogfile_write(1, 0, 0, ng25, 1, t2);
    t2 = (t0 + 460);
    xsi_vlog_namedbase_popprocess(t2);
    goto LAB5;

LAB9:    xsi_set_current_line(66, ng0);

LAB11:    xsi_set_current_line(67, ng0);
    t13 = (t0 + 2296);
    t14 = (t13 + 36U);
    t15 = *((char **)t14);
    t17 = (t0 + 2296);
    t18 = (t17 + 44U);
    t19 = *((char **)t18);
    t20 = (t0 + 2296);
    t21 = (t20 + 40U);
    t22 = *((char **)t21);
    t23 = (t0 + 2480);
    t24 = (t23 + 36U);
    t25 = *((char **)t24);
    xsi_vlog_generic_get_array_select_value(t16, 10, t15, t19, t22, 2, 1, t25, 32, 1);
    t26 = (t0 + 2388);
    xsi_vlogvar_assign_value(t26, t16, 0, 0, 10);
    xsi_set_current_line(68, ng0);
    t2 = (t0 + 1148U);
    t3 = *((char **)t2);
    t2 = (t0 + 2388);
    t4 = (t2 + 36U);
    t5 = *((char **)t4);
    memset(t7, 0, 8);
    t6 = (t7 + 4);
    t13 = (t5 + 4);
    t8 = *((unsigned int *)t5);
    t9 = (t8 >> 2);
    *((unsigned int *)t7) = t9;
    t10 = *((unsigned int *)t13);
    t11 = (t10 >> 2);
    *((unsigned int *)t6) = t11;
    t12 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t12 & 255U);
    t27 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t27 & 255U);
    memset(t16, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t7))
        goto LAB13;

LAB12:    t14 = (t3 + 4);
    t15 = (t7 + 4);
    if (*((unsigned int *)t14) != *((unsigned int *)t15))
        goto LAB13;

LAB14:    t17 = (t0 + 2388);
    t18 = (t17 + 36U);
    t19 = *((char **)t18);
    memset(t28, 0, 8);
    t20 = (t28 + 4);
    t21 = (t19 + 4);
    t29 = *((unsigned int *)t19);
    t30 = (t29 >> 2);
    *((unsigned int *)t28) = t30;
    t31 = *((unsigned int *)t21);
    t32 = (t31 >> 2);
    *((unsigned int *)t20) = t32;
    t33 = *((unsigned int *)t28);
    *((unsigned int *)t28) = (t33 & 255U);
    t34 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t34 & 255U);
    t22 = ((char*)((ng20)));
    memset(t35, 0, 8);
    if (*((unsigned int *)t28) != *((unsigned int *)t22))
        goto LAB16;

LAB15:    t23 = (t28 + 4);
    t24 = (t22 + 4);
    if (*((unsigned int *)t23) != *((unsigned int *)t24))
        goto LAB16;

LAB17:    t37 = *((unsigned int *)t16);
    t38 = *((unsigned int *)t35);
    t39 = (t37 & t38);
    *((unsigned int *)t36) = t39;
    t25 = (t16 + 4);
    t26 = (t35 + 4);
    t40 = (t36 + 4);
    t41 = *((unsigned int *)t25);
    t42 = *((unsigned int *)t26);
    t43 = (t41 | t42);
    *((unsigned int *)t40) = t43;
    t44 = *((unsigned int *)t40);
    t45 = (t44 != 0);
    if (t45 == 1)
        goto LAB18;

LAB19:
LAB20:    t66 = (t36 + 4);
    t67 = *((unsigned int *)t66);
    t68 = (~(t67));
    t69 = *((unsigned int *)t36);
    t70 = (t69 & t68);
    t71 = (t70 != 0);
    if (t71 > 0)
        goto LAB21;

LAB22:
LAB23:    xsi_set_current_line(70, ng0);
    t2 = (t0 + 1240U);
    t3 = *((char **)t2);
    t2 = (t0 + 2388);
    t4 = (t2 + 36U);
    t5 = *((char **)t4);
    memset(t7, 0, 8);
    t6 = (t7 + 4);
    t13 = (t5 + 4);
    t8 = *((unsigned int *)t5);
    t9 = (t8 >> 1);
    t10 = (t9 & 1);
    *((unsigned int *)t7) = t10;
    t11 = *((unsigned int *)t13);
    t12 = (t11 >> 1);
    t27 = (t12 & 1);
    *((unsigned int *)t6) = t27;
    memset(t16, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t7))
        goto LAB25;

LAB24:    t14 = (t3 + 4);
    t15 = (t7 + 4);
    if (*((unsigned int *)t14) != *((unsigned int *)t15))
        goto LAB25;

LAB26:    t17 = (t0 + 2388);
    t18 = (t17 + 36U);
    t19 = *((char **)t18);
    memset(t28, 0, 8);
    t20 = (t28 + 4);
    t21 = (t19 + 4);
    t29 = *((unsigned int *)t19);
    t30 = (t29 >> 1);
    t31 = (t30 & 1);
    *((unsigned int *)t28) = t31;
    t32 = *((unsigned int *)t21);
    t33 = (t32 >> 1);
    t34 = (t33 & 1);
    *((unsigned int *)t20) = t34;
    t22 = ((char*)((ng22)));
    memset(t35, 0, 8);
    if (*((unsigned int *)t28) != *((unsigned int *)t22))
        goto LAB28;

LAB27:    t23 = (t28 + 4);
    t24 = (t22 + 4);
    if (*((unsigned int *)t23) != *((unsigned int *)t24))
        goto LAB28;

LAB29:    t37 = *((unsigned int *)t16);
    t38 = *((unsigned int *)t35);
    t39 = (t37 & t38);
    *((unsigned int *)t36) = t39;
    t25 = (t16 + 4);
    t26 = (t35 + 4);
    t40 = (t36 + 4);
    t41 = *((unsigned int *)t25);
    t42 = *((unsigned int *)t26);
    t43 = (t41 | t42);
    *((unsigned int *)t40) = t43;
    t44 = *((unsigned int *)t40);
    t45 = (t44 != 0);
    if (t45 == 1)
        goto LAB30;

LAB31:
LAB32:    t66 = (t36 + 4);
    t67 = *((unsigned int *)t66);
    t68 = (~(t67));
    t69 = *((unsigned int *)t36);
    t70 = (t69 & t68);
    t71 = (t70 != 0);
    if (t71 > 0)
        goto LAB33;

LAB34:
LAB35:    xsi_set_current_line(72, ng0);
    t2 = (t0 + 1332U);
    t3 = *((char **)t2);
    t2 = (t0 + 2388);
    t4 = (t2 + 36U);
    t5 = *((char **)t4);
    memset(t7, 0, 8);
    t6 = (t7 + 4);
    t13 = (t5 + 4);
    t8 = *((unsigned int *)t5);
    t9 = (t8 >> 0);
    t10 = (t9 & 1);
    *((unsigned int *)t7) = t10;
    t11 = *((unsigned int *)t13);
    t12 = (t11 >> 0);
    t27 = (t12 & 1);
    *((unsigned int *)t6) = t27;
    memset(t16, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t7))
        goto LAB37;

LAB36:    t14 = (t3 + 4);
    t15 = (t7 + 4);
    if (*((unsigned int *)t14) != *((unsigned int *)t15))
        goto LAB37;

LAB38:    t17 = (t0 + 2388);
    t18 = (t17 + 36U);
    t19 = *((char **)t18);
    memset(t28, 0, 8);
    t20 = (t28 + 4);
    t21 = (t19 + 4);
    t29 = *((unsigned int *)t19);
    t30 = (t29 >> 0);
    t31 = (t30 & 1);
    *((unsigned int *)t28) = t31;
    t32 = *((unsigned int *)t21);
    t33 = (t32 >> 0);
    t34 = (t33 & 1);
    *((unsigned int *)t20) = t34;
    t22 = ((char*)((ng22)));
    memset(t35, 0, 8);
    if (*((unsigned int *)t28) != *((unsigned int *)t22))
        goto LAB40;

LAB39:    t23 = (t28 + 4);
    t24 = (t22 + 4);
    if (*((unsigned int *)t23) != *((unsigned int *)t24))
        goto LAB40;

LAB41:    t37 = *((unsigned int *)t16);
    t38 = *((unsigned int *)t35);
    t39 = (t37 & t38);
    *((unsigned int *)t36) = t39;
    t25 = (t16 + 4);
    t26 = (t35 + 4);
    t40 = (t36 + 4);
    t41 = *((unsigned int *)t25);
    t42 = *((unsigned int *)t26);
    t43 = (t41 | t42);
    *((unsigned int *)t40) = t43;
    t44 = *((unsigned int *)t40);
    t45 = (t44 != 0);
    if (t45 == 1)
        goto LAB42;

LAB43:
LAB44:    t66 = (t36 + 4);
    t67 = *((unsigned int *)t66);
    t68 = (~(t67));
    t69 = *((unsigned int *)t36);
    t70 = (t69 & t68);
    t71 = (t70 != 0);
    if (t71 > 0)
        goto LAB45;

LAB46:
LAB47:    xsi_set_current_line(74, ng0);
    t2 = (t0 + 3192);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB48;
    goto LAB1;

LAB13:    *((unsigned int *)t16) = 1;
    goto LAB14;

LAB16:    *((unsigned int *)t35) = 1;
    goto LAB17;

LAB18:    t46 = *((unsigned int *)t36);
    t47 = *((unsigned int *)t40);
    *((unsigned int *)t36) = (t46 | t47);
    t48 = (t16 + 4);
    t49 = (t35 + 4);
    t50 = *((unsigned int *)t16);
    t51 = (~(t50));
    t52 = *((unsigned int *)t48);
    t53 = (~(t52));
    t54 = *((unsigned int *)t35);
    t55 = (~(t54));
    t56 = *((unsigned int *)t49);
    t57 = (~(t56));
    t58 = (t51 & t53);
    t59 = (t55 & t57);
    t60 = (~(t58));
    t61 = (~(t59));
    t62 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t62 & t60);
    t63 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t63 & t61);
    t64 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t64 & t60);
    t65 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t65 & t61);
    goto LAB20;

LAB21:    xsi_set_current_line(69, ng0);
    *((int *)t72) = xsi_vlog_stime(1000.0000000000000, 1.0000000000000000);
    t73 = (t72 + 4);
    *((int *)t73) = 0;
    t74 = (t0 + 460);
    xsi_vlogfile_write(1, 0, 0, ng21, 2, t74, (char)118, t72, 32);
    goto LAB23;

LAB25:    *((unsigned int *)t16) = 1;
    goto LAB26;

LAB28:    *((unsigned int *)t35) = 1;
    goto LAB29;

LAB30:    t46 = *((unsigned int *)t36);
    t47 = *((unsigned int *)t40);
    *((unsigned int *)t36) = (t46 | t47);
    t48 = (t16 + 4);
    t49 = (t35 + 4);
    t50 = *((unsigned int *)t16);
    t51 = (~(t50));
    t52 = *((unsigned int *)t48);
    t53 = (~(t52));
    t54 = *((unsigned int *)t35);
    t55 = (~(t54));
    t56 = *((unsigned int *)t49);
    t57 = (~(t56));
    t58 = (t51 & t53);
    t59 = (t55 & t57);
    t60 = (~(t58));
    t61 = (~(t59));
    t62 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t62 & t60);
    t63 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t63 & t61);
    t64 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t64 & t60);
    t65 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t65 & t61);
    goto LAB32;

LAB33:    xsi_set_current_line(71, ng0);
    *((int *)t72) = xsi_vlog_stime(1000.0000000000000, 1.0000000000000000);
    t73 = (t72 + 4);
    *((int *)t73) = 0;
    t74 = (t0 + 460);
    xsi_vlogfile_write(1, 0, 0, ng23, 2, t74, (char)118, t72, 32);
    goto LAB35;

LAB37:    *((unsigned int *)t16) = 1;
    goto LAB38;

LAB40:    *((unsigned int *)t35) = 1;
    goto LAB41;

LAB42:    t46 = *((unsigned int *)t36);
    t47 = *((unsigned int *)t40);
    *((unsigned int *)t36) = (t46 | t47);
    t48 = (t16 + 4);
    t49 = (t35 + 4);
    t50 = *((unsigned int *)t16);
    t51 = (~(t50));
    t52 = *((unsigned int *)t48);
    t53 = (~(t52));
    t54 = *((unsigned int *)t35);
    t55 = (~(t54));
    t56 = *((unsigned int *)t49);
    t57 = (~(t56));
    t58 = (t51 & t53);
    t59 = (t55 & t57);
    t60 = (~(t58));
    t61 = (~(t59));
    t62 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t62 & t60);
    t63 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t63 & t61);
    t64 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t64 & t60);
    t65 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t65 & t61);
    goto LAB44;

LAB45:    xsi_set_current_line(73, ng0);
    *((int *)t72) = xsi_vlog_stime(1000.0000000000000, 1.0000000000000000);
    t73 = (t72 + 4);
    *((int *)t73) = 0;
    t74 = (t0 + 460);
    xsi_vlogfile_write(1, 0, 0, ng24, 2, t74, (char)118, t72, 32);
    goto LAB47;

LAB48:    xsi_set_current_line(65, ng0);
    t2 = (t0 + 2480);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t7, 0, 8);
    xsi_vlog_signed_add(t7, 32, t4, 32, t5, 32);
    t6 = (t0 + 2480);
    xsi_vlogvar_assign_value(t6, t7, 0, 0, 32);
    goto LAB8;

}


extern void work_m_00000000001744190159_2700757778_init()
{
	static char *pe[] = {(void *)Initial_14_0,(void *)Initial_21_1,(void *)Initial_55_2};
	xsi_register_didat("work_m_00000000001744190159_2700757778", "isim/alutf_isim_beh.exe.sim/work/m_00000000001744190159_2700757778.didat");
	xsi_register_executes(pe);
}
