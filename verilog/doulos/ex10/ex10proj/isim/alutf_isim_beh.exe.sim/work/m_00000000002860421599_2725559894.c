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
static const char *ng0 = "C:/training/verilog/ex10/alu.v";
static unsigned int ng1[] = {1U, 0U};
static unsigned int ng2[] = {0U, 0U};
static unsigned int ng3[] = {2U, 0U};
static unsigned int ng4[] = {4U, 0U};
static unsigned int ng5[] = {5U, 0U};
static unsigned int ng6[] = {6U, 0U};
static unsigned int ng7[] = {7U, 0U};
static unsigned int ng8[] = {8U, 0U};
static unsigned int ng9[] = {9U, 0U};
static unsigned int ng10[] = {10U, 0U};
static unsigned int ng11[] = {11U, 0U};
static unsigned int ng12[] = {14U, 0U};
static int ng13[] = {0, 0};
static unsigned int ng14[] = {15U, 0U};
static int ng15[] = {1, 0};



static void Always_18_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t1 = (t0 + 2060U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(18, ng0);
    t2 = (t0 + 2400);
    *((int *)t2) = 1;
    t3 = (t0 + 2088);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(18, ng0);

LAB5:    xsi_set_current_line(19, ng0);
    t4 = (t0 + 1536);
    t5 = (t4 + 36U);
    t6 = *((char **)t5);
    t7 = (t0 + 1260);
    xsi_vlogvar_wait_assign_value(t7, t6, 0, 0, 8, 0LL);
    goto LAB2;

}

static void Always_23_1(char *t0)
{
    char t9[8];
    char t18[8];
    char t20[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    int t17;
    unsigned int t19;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t28;

LAB0:    t1 = (t0 + 2204U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(23, ng0);
    t2 = (t0 + 2408);
    *((int *)t2) = 1;
    t3 = (t0 + 2232);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(23, ng0);

LAB5:    t4 = (t0 + 148);
    xsi_vlog_namedbase_setdisablestate(t4, &&LAB6);
    t5 = (t0 + 2104);
    xsi_vlog_namedbase_pushprocess(t4, t5);

LAB7:    xsi_set_current_line(24, ng0);
    t6 = (t0 + 848U);
    t7 = *((char **)t6);
    t6 = (t0 + 940U);
    t8 = *((char **)t6);
    memset(t9, 0, 8);
    xsi_vlog_signed_equal(t9, 8, t7, 8, t8, 8);
    t6 = (t9 + 4);
    t10 = *((unsigned int *)t6);
    t11 = (~(t10));
    t12 = *((unsigned int *)t9);
    t13 = (t12 & t11);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB8;

LAB9:    xsi_set_current_line(27, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1444);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);

LAB10:    xsi_set_current_line(28, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);

LAB11:    t2 = ((char*)((ng2)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB12;

LAB13:    t2 = ((char*)((ng1)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB14;

LAB15:    t2 = ((char*)((ng3)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB16;

LAB17:    t2 = ((char*)((ng4)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB18;

LAB19:    t2 = ((char*)((ng5)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB20;

LAB21:    t2 = ((char*)((ng6)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB22;

LAB23:    t2 = ((char*)((ng7)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB24;

LAB25:    t2 = ((char*)((ng8)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB26;

LAB27:    t2 = ((char*)((ng9)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB28;

LAB29:    t2 = ((char*)((ng10)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB30;

LAB31:    t2 = ((char*)((ng11)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB32;

LAB33:    t2 = ((char*)((ng12)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB34;

LAB35:    t2 = ((char*)((ng14)));
    t17 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 4);
    if (t17 == 1)
        goto LAB36;

LAB37:
LAB39:
LAB38:    xsi_set_current_line(42, ng0);
    t2 = ((char*)((ng13)));
    t4 = (t0 + 1536);
    xsi_vlogvar_assign_value(t4, t2, 0, 0, 8);
    t5 = (t0 + 1352);
    xsi_vlogvar_assign_value(t5, t2, 8, 0, 1);

LAB40:    t2 = (t0 + 148);
    xsi_vlog_namedbase_popprocess(t2);

LAB6:    t4 = (t0 + 2104);
    xsi_vlog_dispose_process_subprogram_invocation(t4);
    goto LAB2;

LAB8:    xsi_set_current_line(25, ng0);
    t15 = ((char*)((ng1)));
    t16 = (t0 + 1444);
    xsi_vlogvar_assign_value(t16, t15, 0, 0, 1);
    goto LAB10;

LAB12:    xsi_set_current_line(29, ng0);
    t4 = (t0 + 848U);
    t5 = *((char **)t4);
    t4 = (t0 + 940U);
    t6 = *((char **)t4);
    memset(t9, 0, 8);
    xsi_vlog_signed_add(t9, 9, t5, 8, t6, 8);
    t4 = (t0 + 1536);
    xsi_vlogvar_assign_value(t4, t9, 0, 0, 8);
    t7 = (t0 + 1352);
    xsi_vlogvar_assign_value(t7, t9, 8, 0, 1);
    goto LAB40;

LAB14:    xsi_set_current_line(30, ng0);
    t4 = (t0 + 848U);
    t5 = *((char **)t4);
    t4 = (t0 + 940U);
    t6 = *((char **)t4);
    memset(t9, 0, 8);
    xsi_vlog_signed_minus(t9, 9, t5, 8, t6, 8);
    t4 = (t0 + 1536);
    xsi_vlogvar_assign_value(t4, t9, 0, 0, 8);
    t7 = (t0 + 1352);
    xsi_vlogvar_assign_value(t7, t9, 8, 0, 1);
    goto LAB40;

LAB16:    xsi_set_current_line(31, ng0);
    t4 = (t0 + 940U);
    t5 = *((char **)t4);
    t4 = (t0 + 848U);
    t6 = *((char **)t4);
    memset(t9, 0, 8);
    xsi_vlog_signed_minus(t9, 9, t5, 8, t6, 8);
    t4 = (t0 + 1536);
    xsi_vlogvar_assign_value(t4, t9, 0, 0, 8);
    t7 = (t0 + 1352);
    xsi_vlogvar_assign_value(t7, t9, 8, 0, 1);
    goto LAB40;

LAB18:    xsi_set_current_line(32, ng0);
    t4 = (t0 + 848U);
    t5 = *((char **)t4);
    t4 = (t0 + 848U);
    t6 = *((char **)t4);
    memset(t18, 0, 8);
    t4 = (t18 + 4);
    t7 = (t6 + 4);
    t10 = *((unsigned int *)t6);
    t11 = (t10 >> 7);
    t12 = (t11 & 1);
    *((unsigned int *)t18) = t12;
    t13 = *((unsigned int *)t7);
    t14 = (t13 >> 7);
    t19 = (t14 & 1);
    *((unsigned int *)t4) = t19;
    xsi_vlogtype_concat(t9, 9, 9, 2U, t18, 1, t5, 8);
    t8 = (t0 + 1536);
    xsi_vlogvar_assign_value(t8, t9, 0, 0, 8);
    t15 = (t0 + 1352);
    xsi_vlogvar_assign_value(t15, t9, 8, 0, 1);
    goto LAB40;

LAB20:    xsi_set_current_line(33, ng0);
    t4 = (t0 + 940U);
    t5 = *((char **)t4);
    t4 = (t0 + 940U);
    t6 = *((char **)t4);
    memset(t18, 0, 8);
    t4 = (t18 + 4);
    t7 = (t6 + 4);
    t10 = *((unsigned int *)t6);
    t11 = (t10 >> 7);
    t12 = (t11 & 1);
    *((unsigned int *)t18) = t12;
    t13 = *((unsigned int *)t7);
    t14 = (t13 >> 7);
    t19 = (t14 & 1);
    *((unsigned int *)t4) = t19;
    xsi_vlogtype_concat(t9, 9, 9, 2U, t18, 1, t5, 8);
    t8 = (t0 + 1536);
    xsi_vlogvar_assign_value(t8, t9, 0, 0, 8);
    t15 = (t0 + 1352);
    xsi_vlogvar_assign_value(t15, t9, 8, 0, 1);
    goto LAB40;

LAB22:    xsi_set_current_line(34, ng0);
    t4 = (t0 + 848U);
    t5 = *((char **)t4);
    memset(t9, 0, 8);
    xsi_vlog_signed_unary_minus(t9, 9, t5, 8);
    t4 = (t0 + 1536);
    xsi_vlogvar_assign_value(t4, t9, 0, 0, 8);
    t6 = (t0 + 1352);
    xsi_vlogvar_assign_value(t6, t9, 8, 0, 1);
    goto LAB40;

LAB24:    xsi_set_current_line(35, ng0);
    t4 = (t0 + 940U);
    t5 = *((char **)t4);
    memset(t9, 0, 8);
    xsi_vlog_signed_unary_minus(t9, 9, t5, 8);
    t4 = (t0 + 1536);
    xsi_vlogvar_assign_value(t4, t9, 0, 0, 8);
    t6 = (t0 + 1352);
    xsi_vlogvar_assign_value(t6, t9, 8, 0, 1);
    goto LAB40;

LAB26:    xsi_set_current_line(36, ng0);
    t4 = ((char*)((ng2)));
    t5 = (t0 + 848U);
    t6 = *((char **)t5);
    memset(t18, 0, 8);
    t5 = (t18 + 4);
    t7 = (t6 + 4);
    t10 = *((unsigned int *)t6);
    t11 = (t10 >> 0);
    *((unsigned int *)t18) = t11;
    t12 = *((unsigned int *)t7);
    t13 = (t12 >> 0);
    *((unsigned int *)t5) = t13;
    t14 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t14 & 127U);
    t19 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t19 & 127U);
    t8 = (t0 + 848U);
    t15 = *((char **)t8);
    memset(t20, 0, 8);
    t8 = (t20 + 4);
    t16 = (t15 + 4);
    t21 = *((unsigned int *)t15);
    t22 = (t21 >> 7);
    t23 = (t22 & 1);
    *((unsigned int *)t20) = t23;
    t24 = *((unsigned int *)t16);
    t25 = (t24 >> 7);
    t26 = (t25 & 1);
    *((unsigned int *)t8) = t26;
    xsi_vlogtype_concat(t9, 9, 9, 3U, t20, 1, t18, 7, t4, 1);
    t27 = (t0 + 1536);
    xsi_vlogvar_assign_value(t27, t9, 0, 0, 8);
    t28 = (t0 + 1352);
    xsi_vlogvar_assign_value(t28, t9, 8, 0, 1);
    goto LAB40;

LAB28:    xsi_set_current_line(37, ng0);
    t4 = (t0 + 848U);
    t5 = *((char **)t4);
    memset(t18, 0, 8);
    t4 = (t18 + 4);
    t6 = (t5 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (t10 >> 1);
    *((unsigned int *)t18) = t11;
    t12 = *((unsigned int *)t6);
    t13 = (t12 >> 1);
    *((unsigned int *)t4) = t13;
    t14 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t14 & 127U);
    t19 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t19 & 127U);
    t7 = ((char*)((ng2)));
    t8 = ((char*)((ng2)));
    xsi_vlogtype_concat(t9, 9, 9, 3U, t8, 1, t7, 1, t18, 7);
    t15 = (t0 + 1536);
    xsi_vlogvar_assign_value(t15, t9, 0, 0, 8);
    t16 = (t0 + 1352);
    xsi_vlogvar_assign_value(t16, t9, 8, 0, 1);
    goto LAB40;

LAB30:    xsi_set_current_line(38, ng0);
    t4 = (t0 + 848U);
    t5 = *((char **)t4);
    memset(t18, 0, 8);
    t4 = (t18 + 4);
    t6 = (t5 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (t10 >> 7);
    t12 = (t11 & 1);
    *((unsigned int *)t18) = t12;
    t13 = *((unsigned int *)t6);
    t14 = (t13 >> 7);
    t19 = (t14 & 1);
    *((unsigned int *)t4) = t19;
    t7 = (t0 + 848U);
    t8 = *((char **)t7);
    memset(t20, 0, 8);
    t7 = (t20 + 4);
    t15 = (t8 + 4);
    t21 = *((unsigned int *)t8);
    t22 = (t21 >> 0);
    *((unsigned int *)t20) = t22;
    t23 = *((unsigned int *)t15);
    t24 = (t23 >> 0);
    *((unsigned int *)t7) = t24;
    t25 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t25 & 255U);
    t26 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t26 & 255U);
    xsi_vlogtype_concat(t9, 9, 9, 2U, t20, 8, t18, 1);
    t16 = (t0 + 1536);
    xsi_vlogvar_assign_value(t16, t9, 0, 0, 8);
    t27 = (t0 + 1352);
    xsi_vlogvar_assign_value(t27, t9, 8, 0, 1);
    goto LAB40;

LAB32:    xsi_set_current_line(39, ng0);
    t4 = (t0 + 848U);
    t5 = *((char **)t4);
    memset(t18, 0, 8);
    t4 = (t18 + 4);
    t6 = (t5 + 4);
    t10 = *((unsigned int *)t5);
    t11 = (t10 >> 1);
    *((unsigned int *)t18) = t11;
    t12 = *((unsigned int *)t6);
    t13 = (t12 >> 1);
    *((unsigned int *)t4) = t13;
    t14 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t14 & 127U);
    t19 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t19 & 127U);
    t7 = (t0 + 848U);
    t8 = *((char **)t7);
    memset(t20, 0, 8);
    t7 = (t20 + 4);
    t15 = (t8 + 4);
    t21 = *((unsigned int *)t8);
    t22 = (t21 >> 0);
    t23 = (t22 & 1);
    *((unsigned int *)t20) = t23;
    t24 = *((unsigned int *)t15);
    t25 = (t24 >> 0);
    t26 = (t25 & 1);
    *((unsigned int *)t7) = t26;
    t16 = ((char*)((ng2)));
    xsi_vlogtype_concat(t9, 9, 9, 3U, t16, 1, t20, 1, t18, 7);
    t27 = (t0 + 1536);
    xsi_vlogvar_assign_value(t27, t9, 0, 0, 8);
    t28 = (t0 + 1352);
    xsi_vlogvar_assign_value(t28, t9, 8, 0, 1);
    goto LAB40;

LAB34:    xsi_set_current_line(40, ng0);
    t4 = ((char*)((ng13)));
    t5 = (t0 + 1536);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 8);
    t6 = (t0 + 1352);
    xsi_vlogvar_assign_value(t6, t4, 8, 0, 1);
    goto LAB40;

LAB36:    xsi_set_current_line(41, ng0);
    t4 = ((char*)((ng15)));
    memset(t9, 0, 8);
    xsi_vlog_signed_unary_minus(t9, 32, t4, 32);
    t5 = (t0 + 1536);
    xsi_vlogvar_assign_value(t5, t9, 0, 0, 8);
    t6 = (t0 + 1352);
    xsi_vlogvar_assign_value(t6, t9, 8, 0, 1);
    goto LAB40;

}


extern void work_m_00000000002860421599_2725559894_init()
{
	static char *pe[] = {(void *)Always_18_0,(void *)Always_23_1};
	xsi_register_didat("work_m_00000000002860421599_2725559894", "isim/alutf_isim_beh.exe.sim/work/m_00000000002860421599_2725559894.didat");
	xsi_register_executes(pe);
}
