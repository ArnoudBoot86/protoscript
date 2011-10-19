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
static const char *ng0 = "C:/training/verilog/ex07/updownCounter.v";
static int ng1[] = {0, 0};
static unsigned int ng2[] = {1U, 0U};
static int ng3[] = {1, 0};
static unsigned int ng4[] = {0U, 0U};



static void Always_14_0(char *t0)
{
    char t21[8];
    char *t1;
    char *t2;
    char *t3;
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
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    int t20;

LAB0:    t1 = (t0 + 1968U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(14, ng0);
    t2 = (t0 + 2164);
    *((int *)t2) = 1;
    t3 = (t0 + 1996);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(14, ng0);

LAB5:    t4 = (t0 + 148);
    xsi_vlog_namedbase_setdisablestate(t4, &&LAB6);
    t5 = (t0 + 1868);
    xsi_vlog_namedbase_pushprocess(t4, t5);

LAB7:    xsi_set_current_line(15, ng0);
    t6 = (t0 + 848U);
    t7 = *((char **)t6);
    t6 = (t7 + 4);
    t8 = *((unsigned int *)t6);
    t9 = (~(t8));
    t10 = *((unsigned int *)t7);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB8;

LAB9:    xsi_set_current_line(17, ng0);

LAB11:    xsi_set_current_line(18, ng0);
    t2 = (t0 + 940U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t8 = *((unsigned int *)t2);
    t9 = (~(t8));
    t10 = *((unsigned int *)t3);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB12;

LAB13:
LAB14:
LAB10:    t2 = (t0 + 148);
    xsi_vlog_namedbase_popprocess(t2);

LAB6:    t4 = (t0 + 1868);
    xsi_vlog_dispose_process_subprogram_invocation(t4);
    goto LAB2;

LAB8:    xsi_set_current_line(16, ng0);
    t13 = ((char*)((ng1)));
    t14 = (t0 + 1444);
    xsi_vlogvar_wait_assign_value(t14, t13, 0, 0, 8, 0LL);
    goto LAB10;

LAB12:    xsi_set_current_line(18, ng0);

LAB15:    xsi_set_current_line(19, ng0);
    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t15 = *((unsigned int *)t4);
    t16 = (~(t15));
    t17 = *((unsigned int *)t5);
    t18 = (t17 & t16);
    t19 = (t18 != 0);
    if (t19 > 0)
        goto LAB16;

LAB17:    xsi_set_current_line(21, ng0);

LAB19:    xsi_set_current_line(22, ng0);
    t2 = (t0 + 1124U);
    t3 = *((char **)t2);

LAB20:    t2 = ((char*)((ng2)));
    t20 = xsi_vlog_unsigned_case_compare(t3, 1, t2, 1);
    if (t20 == 1)
        goto LAB21;

LAB22:    t2 = ((char*)((ng4)));
    t20 = xsi_vlog_unsigned_case_compare(t3, 1, t2, 1);
    if (t20 == 1)
        goto LAB23;

LAB24:
LAB25:
LAB18:    goto LAB14;

LAB16:    xsi_set_current_line(20, ng0);
    t6 = (t0 + 1216U);
    t7 = *((char **)t6);
    t6 = (t0 + 1444);
    xsi_vlogvar_wait_assign_value(t6, t7, 0, 0, 8, 0LL);
    goto LAB18;

LAB21:    xsi_set_current_line(23, ng0);
    t4 = (t0 + 1444);
    t5 = (t4 + 36U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng3)));
    memset(t21, 0, 8);
    xsi_vlog_unsigned_add(t21, 32, t6, 8, t7, 32);
    t13 = (t0 + 1444);
    xsi_vlogvar_wait_assign_value(t13, t21, 0, 0, 8, 0LL);
    goto LAB25;

LAB23:    xsi_set_current_line(24, ng0);
    t4 = (t0 + 1444);
    t5 = (t4 + 36U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng3)));
    memset(t21, 0, 8);
    xsi_vlog_unsigned_minus(t21, 32, t6, 8, t7, 32);
    t13 = (t0 + 1444);
    xsi_vlogvar_wait_assign_value(t13, t21, 0, 0, 8, 0LL);
    goto LAB25;

}


extern void work_m_00000000002339891194_3322739285_init()
{
	static char *pe[] = {(void *)Always_14_0};
	xsi_register_didat("work_m_00000000002339891194_3322739285", "isim/updownCounterTF_isim_beh.exe.sim/work/m_00000000002339891194_3322739285.didat");
	xsi_register_executes(pe);
}
