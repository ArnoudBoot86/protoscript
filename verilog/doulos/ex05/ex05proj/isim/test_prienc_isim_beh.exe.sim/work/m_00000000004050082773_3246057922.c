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
static const char *ng3 = "C:/training/verilog/ex04/source/test_prienc.v";
static int ng4[] = {0, 0};
static int ng5[] = {1, 0};
static int ng6[] = {9, 0};
static const char *ng7 = "ns";
static int ng8[] = {7, 0};
static const char *ng9 = "Time Input(a) Output(f)";

void Monitor_47_2(char *);
void Monitor_47_2(char *);


static void Monitor_47_2_Func(char *t0)
{
    char t1[16];
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t2 = xsi_vlog_time(t1, 1000.0000000000000, 1.0000000000000000);
    xsi_vlogfile_write(0, 0, 3, ng0, 2, t0, (char)118, t1, 64);
    xsi_vlogfile_write(0, 0, 3, ng1, 1, t0);
    t3 = (t0 + 828);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    xsi_vlogfile_write(0, 0, 3, ng2, 2, t0, (char)118, t5, 4);
    xsi_vlogfile_write(0, 0, 3, ng1, 1, t0);
    t6 = (t0 + 600U);
    t7 = *((char **)t6);
    xsi_vlogfile_write(1, 0, 3, ng2, 2, t0, (char)118, t7, 2);

LAB1:    return;
}

static void Initial_23_0(char *t0)
{
    char t7[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;

LAB0:    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(23, ng3);

LAB4:    xsi_set_current_line(24, ng3);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 828);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 4);
    xsi_set_current_line(25, ng3);
    t2 = (t0 + 1252);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(25, ng3);
    t3 = (t0 + 828);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng5)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 32, t5, 4, t6, 32);
    t8 = (t0 + 828);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 4);
    xsi_set_current_line(26, ng3);
    t2 = (t0 + 1252);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(26, ng3);
    t3 = (t0 + 828);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng5)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 32, t5, 4, t6, 32);
    t8 = (t0 + 828);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 4);
    xsi_set_current_line(27, ng3);
    t2 = (t0 + 1252);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB7;
    goto LAB1;

LAB7:    xsi_set_current_line(27, ng3);
    t3 = (t0 + 828);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng5)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 32, t5, 4, t6, 32);
    t8 = (t0 + 828);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 4);
    xsi_set_current_line(28, ng3);
    t2 = (t0 + 1252);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB8;
    goto LAB1;

LAB8:    xsi_set_current_line(28, ng3);
    t3 = (t0 + 828);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng5)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 32, t5, 4, t6, 32);
    t8 = (t0 + 828);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 4);
    xsi_set_current_line(29, ng3);
    t2 = (t0 + 1252);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB9;
    goto LAB1;

LAB9:    xsi_set_current_line(29, ng3);
    t3 = (t0 + 828);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng5)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 32, t5, 4, t6, 32);
    t8 = (t0 + 828);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 4);
    xsi_set_current_line(30, ng3);
    t2 = (t0 + 1252);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB10;
    goto LAB1;

LAB10:    xsi_set_current_line(30, ng3);
    t3 = (t0 + 828);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng5)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 32, t5, 4, t6, 32);
    t8 = (t0 + 828);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 4);
    xsi_set_current_line(31, ng3);
    t2 = (t0 + 1252);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB11:    xsi_set_current_line(31, ng3);
    t3 = (t0 + 828);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng5)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 32, t5, 4, t6, 32);
    t8 = (t0 + 828);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 4);
    xsi_set_current_line(32, ng3);
    t2 = (t0 + 1252);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB12;
    goto LAB1;

LAB12:    xsi_set_current_line(32, ng3);
    t3 = (t0 + 828);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng5)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 32, t5, 4, t6, 32);
    t8 = (t0 + 828);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 4);
    goto LAB1;

}

static void Initial_43_1(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 1496U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(43, ng3);

LAB4:    xsi_set_current_line(44, ng3);
    t2 = (t0 + 1396);
    xsi_process_wait(t2, 0LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(45, ng3);
    t2 = ((char*)((ng6)));
    memset(t3, 0, 8);
    xsi_vlog_signed_unary_minus(t3, 32, t2, 32);
    t4 = ((char*)((ng5)));
    t5 = ((char*)((ng8)));
    xsi_vlog_setTimeFormat(*((unsigned int *)t3), *((unsigned int *)t4), ng7, 0, *((unsigned int *)t5));
    xsi_set_current_line(46, ng3);
    xsi_vlogfile_write(1, 0, 0, ng9, 1, t0);
    xsi_set_current_line(47, ng3);
    Monitor_47_2(t0);
    goto LAB1;

}

void Monitor_47_2(char *t0)
{
    char *t1;
    char *t2;

LAB0:    t1 = (t0 + 1540);
    t2 = (t0 + 1836);
    xsi_vlogfile_monitor((void *)Monitor_47_2_Func, t1, t2);

LAB1:    return;
}


extern void work_m_00000000004050082773_3246057922_init()
{
	static char *pe[] = {(void *)Initial_23_0,(void *)Initial_43_1,(void *)Monitor_47_2};
	xsi_register_didat("work_m_00000000004050082773_3246057922", "isim/test_prienc_isim_beh.exe.sim/work/m_00000000004050082773_3246057922.didat");
	xsi_register_executes(pe);
}
