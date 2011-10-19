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
static const char *ng0 = "%t";
static const char *ng1 = " ";
static const char *ng2 = "%b";
static const char *ng3 = "%d";
static const char *ng4 = "C:/training/verilog/ex06/minmaxtf.v";
static int ng5[] = {0, 0};
static int ng6[] = {16, 0};
static int ng7[] = {1, 0};
static const char *ng8 = "Got here";
static int ng9[] = {9, 0};
static const char *ng10 = "ns";
static int ng11[] = {7, 0};
static const char *ng12 = "Time MinMax X Y Output";

void Monitor_60_2(char *);
void Monitor_60_2(char *);


static void Monitor_60_2_Func(char *t0)
{
    char t1[16];
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    t2 = xsi_vlog_time(t1, 1000.0000000000000, 1.0000000000000000);
    xsi_vlogfile_write(0, 0, 3, ng0, 2, t0, (char)118, t1, 64);
    xsi_vlogfile_write(0, 0, 3, ng1, 1, t0);
    t3 = (t0 + 1168);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    xsi_vlogfile_write(0, 0, 3, ng2, 2, t0, (char)118, t5, 1);
    t6 = (t0 + 984);
    t7 = (t6 + 36U);
    t8 = *((char **)t7);
    xsi_vlogfile_write(0, 0, 3, ng3, 2, t0, (char)118, t8, 4);
    xsi_vlogfile_write(0, 0, 3, ng1, 1, t0);
    t9 = (t0 + 1076);
    t10 = (t9 + 36U);
    t11 = *((char **)t10);
    xsi_vlogfile_write(0, 0, 3, ng3, 2, t0, (char)118, t11, 4);
    xsi_vlogfile_write(0, 0, 3, ng1, 1, t0);
    t12 = (t0 + 756U);
    t13 = *((char **)t12);
    xsi_vlogfile_write(1, 0, 3, ng3, 2, t0, (char)118, t13, 4);

LAB1:    return;
}

static void Initial_30_0(char *t0)
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

LAB0:    t1 = (t0 + 1876U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(31, ng4);

LAB4:    t2 = (t0 + 148);
    xsi_vlog_namedbase_setdisablestate(t2, &&LAB5);
    t3 = (t0 + 1776);
    xsi_vlog_namedbase_pushprocess(t2, t3);

LAB6:    xsi_set_current_line(34, ng4);
    t4 = ((char*)((ng5)));
    t5 = (t0 + 1168);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(35, ng4);
    xsi_set_current_line(35, ng4);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1260);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB7:    t2 = (t0 + 1260);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng6)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB8;

LAB9:    xsi_set_current_line(44, ng4);
    t2 = (t0 + 148);
    xsi_vlogfile_write(1, 0, 0, ng8, 1, t2);
    xsi_set_current_line(45, ng4);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 1168);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(46, ng4);
    xsi_set_current_line(46, ng4);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1260);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB17:    t2 = (t0 + 1260);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng6)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB18;

LAB19:    t2 = (t0 + 148);
    xsi_vlog_namedbase_popprocess(t2);

LAB5:    t3 = (t0 + 1776);
    xsi_vlog_dispose_process_subprogram_invocation(t3);

LAB1:    return;
LAB8:    xsi_set_current_line(35, ng4);

LAB10:    xsi_set_current_line(36, ng4);
    t13 = (t0 + 1776);
    xsi_process_wait(t13, 10000LL);
    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB11:    xsi_set_current_line(37, ng4);
    t2 = (t0 + 1260);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = (t0 + 984);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 4);
    xsi_set_current_line(38, ng4);
    xsi_set_current_line(38, ng4);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1352);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB12:    t2 = (t0 + 1352);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng6)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB13;

LAB14:    xsi_set_current_line(35, ng4);
    t2 = (t0 + 1260);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng7)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 1260);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB7;

LAB13:    xsi_set_current_line(38, ng4);

LAB15:    xsi_set_current_line(39, ng4);
    t13 = (t0 + 1776);
    xsi_process_wait(t13, 10000LL);
    *((char **)t1) = &&LAB16;
    goto LAB1;

LAB16:    xsi_set_current_line(40, ng4);
    t2 = (t0 + 1352);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = (t0 + 1076);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 4);
    xsi_set_current_line(38, ng4);
    t2 = (t0 + 1352);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng7)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 1352);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB12;

LAB18:    xsi_set_current_line(46, ng4);

LAB20:    xsi_set_current_line(47, ng4);
    t13 = (t0 + 1776);
    xsi_process_wait(t13, 10000LL);
    *((char **)t1) = &&LAB21;
    goto LAB1;

LAB21:    xsi_set_current_line(48, ng4);
    t2 = (t0 + 1260);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = (t0 + 984);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 4);
    xsi_set_current_line(49, ng4);
    xsi_set_current_line(49, ng4);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1352);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB22:    t2 = (t0 + 1352);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng6)));
    memset(t6, 0, 8);
    xsi_vlog_signed_less(t6, 32, t4, 32, t5, 32);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB23;

LAB24:    xsi_set_current_line(46, ng4);
    t2 = (t0 + 1260);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng7)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 1260);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB17;

LAB23:    xsi_set_current_line(49, ng4);

LAB25:    xsi_set_current_line(50, ng4);
    t13 = (t0 + 1776);
    xsi_process_wait(t13, 10000LL);
    *((char **)t1) = &&LAB26;
    goto LAB1;

LAB26:    xsi_set_current_line(51, ng4);
    t2 = (t0 + 1352);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = (t0 + 1076);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 4);
    xsi_set_current_line(49, ng4);
    t2 = (t0 + 1352);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng7)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 1352);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB22;

}

static void Initial_56_1(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 2020U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(56, ng4);

LAB4:    xsi_set_current_line(57, ng4);
    t2 = (t0 + 1920);
    xsi_process_wait(t2, 0LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(58, ng4);
    t2 = ((char*)((ng9)));
    memset(t3, 0, 8);
    xsi_vlog_signed_unary_minus(t3, 32, t2, 32);
    t4 = ((char*)((ng7)));
    t5 = ((char*)((ng11)));
    xsi_vlog_setTimeFormat(*((unsigned int *)t3), *((unsigned int *)t4), ng10, 0, *((unsigned int *)t5));
    xsi_set_current_line(59, ng4);
    xsi_vlogfile_write(1, 0, 0, ng12, 1, t0);
    xsi_set_current_line(60, ng4);
    Monitor_60_2(t0);
    goto LAB1;

}

void Monitor_60_2(char *t0)
{
    char *t1;
    char *t2;

LAB0:    t1 = (t0 + 2064);
    t2 = (t0 + 2360);
    xsi_vlogfile_monitor((void *)Monitor_60_2_Func, t1, t2);

LAB1:    return;
}


extern void work_m_00000000001497822760_3677677180_init()
{
	static char *pe[] = {(void *)Initial_30_0,(void *)Initial_56_1,(void *)Monitor_60_2};
	xsi_register_didat("work_m_00000000001497822760_3677677180", "isim/MinMaxtf_isim_beh.exe.sim/work/m_00000000001497822760_3677677180.didat");
	xsi_register_executes(pe);
}
