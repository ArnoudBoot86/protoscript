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
static const char *ng0 = " %t   %b    %b     %b     %b     %b     %b     %b   %b";
static const char *ng1 = "C:/training/verilog/ex07/updownCounterTF.v";
static unsigned int ng2[] = {0U, 0U};
static const char *ng3 = " ***** First error detected at time %t! *****";
static int ng4[] = {9, 0};
static int ng5[] = {0, 0};
static const char *ng6 = " ns";
static int ng7[] = {7, 0};
static const char *ng8 = "                                                Data        Q      ";
static const char *ng9 = "   time   OK  Clock Reset Enable Load Up1Dn0  76543210   76543210  ";
static const char *ng10 = "|~~~~~~~~|~~~|~~~~~|~~~~~|~~~~~~|~~~~|~~~~~~|~~~~~~~~~~|~~~~~~~~~~|";
static int ng11[] = {1, 0};
static unsigned int ng12[] = {127U, 0U};
static unsigned int ng13[] = {240U, 0U};
static const char *ng14 = "Test finished OK";
static const char *ng15 = "Test finished with errors";
static unsigned int ng16[] = {2U, 0U};
static unsigned int ng17[] = {254U, 0U};
static unsigned int ng18[] = {3U, 0U};
static unsigned int ng19[] = {4U, 0U};
static unsigned int ng20[] = {129U, 0U};
static const char *ng21 = "\n   ************************************************************";
static const char *ng22 = "\n   **************** DOULOS CODING STYLE CHECK *****************";
static const char *ng23 = "\n   *                                                          *";
static const char *ng24 = "\n   *  It seems that you have used blocking assignment (=) to  *";
static const char *ng25 = "\n   *  update a variable (reg) that is an output of a clocked  *";
static const char *ng26 = "\n   *  always block.  You should invariably use nonblocking    *";
static const char *ng27 = "\n   *  assignment (<=) for this purpose.  Please correct this  *";
static const char *ng28 = "\n   *  mistake before proceeding any further.                  *";
static const char *ng29 = "\n   *  If you are sure that you have not made this error,      *";
static const char *ng30 = "\n   *  please ask your course leader to investigate.           *";
static int ng31[] = {0, 0, 0, 0};
static const char *ng32 = "\n   *  The test fixture detected an output change that was     *";
static const char *ng33 = "\n   *  not synchronised to the active edge of reset or clock.  *";
static const char *ng34 = "\n   *  This is probably caused by an incorrectly coded         *";
static const char *ng35 = "\n   *  sensitivity list on a clocked always block, or because  *";
static const char *ng36 = "\n   *  you used a #delay when assigning to an output.  Please  *";
static const char *ng37 = "\n   *  correct this mistake before proceeding any further.     *";

void Monitor_37_2(char *);
void Monitor_37_2(char *);


static void Monitor_37_2_Func(char *t0)
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
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;

LAB0:    t2 = xsi_vlog_time(t1, 1000.0000000000000, 1.0000000000000000);
    t3 = (t0 + 1692);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = (t0 + 1140);
    t7 = (t6 + 36U);
    t8 = *((char **)t7);
    t9 = (t0 + 1232);
    t10 = (t9 + 36U);
    t11 = *((char **)t10);
    t12 = (t0 + 1324);
    t13 = (t12 + 36U);
    t14 = *((char **)t13);
    t15 = (t0 + 1416);
    t16 = (t15 + 36U);
    t17 = *((char **)t16);
    t18 = (t0 + 1508);
    t19 = (t18 + 36U);
    t20 = *((char **)t19);
    t21 = (t0 + 1600);
    t22 = (t21 + 36U);
    t23 = *((char **)t22);
    t24 = (t0 + 912U);
    t25 = *((char **)t24);
    xsi_vlogfile_write(1, 0, 3, ng0, 10, t0, (char)118, t1, 64, (char)118, t5, 1, (char)118, t8, 1, (char)118, t11, 1, (char)118, t14, 1, (char)118, t17, 1, (char)118, t20, 1, (char)118, t23, 8, (char)118, t25, 8);

LAB1:    return;
}

static void Always_26_0(char *t0)
{
    char t8[8];
    char t30[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t31;

LAB0:    t1 = (t0 + 2492U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(26, ng1);
    t2 = (t0 + 3696);
    *((int *)t2) = 1;
    t3 = (t0 + 2520);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(27, ng1);
    t4 = (t0 + 1692);
    t5 = (t4 + 36U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng2)));
    memset(t8, 0, 8);
    t9 = (t6 + 4);
    t10 = (t7 + 4);
    t11 = *((unsigned int *)t6);
    t12 = *((unsigned int *)t7);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t9);
    t15 = *((unsigned int *)t10);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t9);
    t19 = *((unsigned int *)t10);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB8;

LAB5:    if (t20 != 0)
        goto LAB7;

LAB6:    *((unsigned int *)t8) = 1;

LAB8:    t24 = (t8 + 4);
    t25 = *((unsigned int *)t24);
    t26 = (~(t25));
    t27 = *((unsigned int *)t8);
    t28 = (t27 & t26);
    t29 = (t28 != 0);
    if (t29 > 0)
        goto LAB9;

LAB10:
LAB11:    goto LAB2;

LAB7:    t23 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB8;

LAB9:    xsi_set_current_line(28, ng1);
    t31 = xsi_vlog_time(t30, 1000.0000000000000, 1.0000000000000000);
    xsi_vlogfile_write(1, 0, 0, ng3, 2, t0, (char)118, t30, 64);
    goto LAB11;

}

static void Initial_32_1(char *t0)
{
    char t1[8];
    char *t2;
    char *t3;
    char *t4;

LAB0:    xsi_set_current_line(32, ng1);

LAB2:    xsi_set_current_line(33, ng1);
    t2 = ((char*)((ng4)));
    memset(t1, 0, 8);
    xsi_vlog_signed_unary_minus(t1, 32, t2, 32);
    t3 = ((char*)((ng5)));
    t4 = ((char*)((ng7)));
    xsi_vlog_setTimeFormat(*((unsigned int *)t1), *((unsigned int *)t3), ng6, 0, *((unsigned int *)t4));
    xsi_set_current_line(34, ng1);
    xsi_vlogfile_write(1, 0, 0, ng8, 1, t0);
    xsi_set_current_line(35, ng1);
    xsi_vlogfile_write(1, 0, 0, ng9, 1, t0);
    xsi_set_current_line(36, ng1);
    xsi_vlogfile_write(1, 0, 0, ng10, 1, t0);
    xsi_set_current_line(37, ng1);
    Monitor_37_2(t0);

LAB1:    return;
}

static void Always_43_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;

LAB0:    t1 = (t0 + 2780U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(44, ng1);

LAB4:    xsi_set_current_line(45, ng1);
    t2 = (t0 + 2680);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(45, ng1);
    t3 = ((char*)((ng11)));
    t4 = (t0 + 1140);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    xsi_set_current_line(46, ng1);
    t2 = (t0 + 2680);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(46, ng1);
    t3 = ((char*)((ng5)));
    t4 = (t0 + 1140);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    goto LAB2;

}

static void Initial_51_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;

LAB0:    t1 = (t0 + 2924U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(52, ng1);

LAB4:    xsi_set_current_line(53, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1324);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(54, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1416);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(55, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1508);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(56, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1232);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(57, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(58, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1232);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(59, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(60, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1324);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(61, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 20000LL);
    *((char **)t1) = &&LAB7;
    goto LAB1;

LAB7:    xsi_set_current_line(62, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1508);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(63, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 40000LL);
    *((char **)t1) = &&LAB8;
    goto LAB1;

LAB8:    xsi_set_current_line(64, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1508);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(65, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 40000LL);
    *((char **)t1) = &&LAB9;
    goto LAB1;

LAB9:    xsi_set_current_line(66, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1232);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(67, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB10;
    goto LAB1;

LAB10:    xsi_set_current_line(68, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1232);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(69, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 30000LL);
    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB11:    xsi_set_current_line(70, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1324);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(71, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB12;
    goto LAB1;

LAB12:    xsi_set_current_line(72, ng1);
    t2 = ((char*)((ng12)));
    t3 = (t0 + 1600);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(73, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1416);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(74, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB13;
    goto LAB1;

LAB13:    xsi_set_current_line(75, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1416);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(76, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1324);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(77, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB14;
    goto LAB1;

LAB14:    xsi_set_current_line(78, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1416);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(79, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB15:    xsi_set_current_line(80, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1416);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(81, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 20000LL);
    *((char **)t1) = &&LAB16;
    goto LAB1;

LAB16:    xsi_set_current_line(82, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1324);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(83, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB17;
    goto LAB1;

LAB17:    xsi_set_current_line(84, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1508);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(85, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB18;
    goto LAB1;

LAB18:    xsi_set_current_line(86, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1324);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(87, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 20000LL);
    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB19:    xsi_set_current_line(88, ng1);
    t2 = ((char*)((ng13)));
    t3 = (t0 + 1600);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(89, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1416);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(90, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB20;
    goto LAB1;

LAB20:    xsi_set_current_line(91, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1232);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(92, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB21;
    goto LAB1;

LAB21:    xsi_set_current_line(93, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1416);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(94, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1508);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(95, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB22;
    goto LAB1;

LAB22:    xsi_set_current_line(96, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1232);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(97, ng1);
    t2 = (t0 + 2824);
    xsi_process_wait(t2, 2560000LL);
    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB23:    xsi_set_current_line(98, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1324);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(99, ng1);
    t2 = (t0 + 1692);
    t3 = (t2 + 36U);
    t4 = *((char **)t3);
    t5 = (t4 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (~(t6));
    t8 = *((unsigned int *)t4);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB24;

LAB25:    xsi_set_current_line(102, ng1);
    xsi_vlogfile_write(1, 0, 0, ng15, 1, t0);

LAB26:    xsi_set_current_line(103, ng1);
    xsi_vlog_finish(1);
    goto LAB1;

LAB24:    xsi_set_current_line(100, ng1);
    xsi_vlogfile_write(1, 0, 0, ng14, 1, t0);
    goto LAB26;

}

static void Initial_108_5(char *t0)
{
    char t4[8];
    char *t1;
    char *t2;
    char *t3;
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

LAB0:    t1 = (t0 + 3068U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(109, ng1);

LAB4:    xsi_set_current_line(110, ng1);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 1692);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(111, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 9000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(112, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB7;

LAB6:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB7;

LAB8:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB9;

LAB10:
LAB11:    xsi_set_current_line(115, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB12;
    goto LAB1;

LAB7:    *((unsigned int *)t4) = 1;
    goto LAB8;

LAB9:    xsi_set_current_line(113, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB11;

LAB12:    xsi_set_current_line(116, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB14;

LAB13:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB14;

LAB15:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB16;

LAB17:
LAB18:    xsi_set_current_line(119, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 20000LL);
    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB14:    *((unsigned int *)t4) = 1;
    goto LAB15;

LAB16:    xsi_set_current_line(117, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB18;

LAB19:    xsi_set_current_line(120, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng16)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB21;

LAB20:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB21;

LAB22:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB23;

LAB24:
LAB25:    xsi_set_current_line(123, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 40000LL);
    *((char **)t1) = &&LAB26;
    goto LAB1;

LAB21:    *((unsigned int *)t4) = 1;
    goto LAB22;

LAB23:    xsi_set_current_line(121, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB25;

LAB26:    xsi_set_current_line(124, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng17)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB28;

LAB27:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB28;

LAB29:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB30;

LAB31:
LAB32:    xsi_set_current_line(127, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 40000LL);
    *((char **)t1) = &&LAB33;
    goto LAB1;

LAB28:    *((unsigned int *)t4) = 1;
    goto LAB29;

LAB30:    xsi_set_current_line(125, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB32;

LAB33:    xsi_set_current_line(128, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng16)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB35;

LAB34:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB35;

LAB36:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB37;

LAB38:
LAB39:    xsi_set_current_line(131, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB40;
    goto LAB1;

LAB35:    *((unsigned int *)t4) = 1;
    goto LAB36;

LAB37:    xsi_set_current_line(129, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB39;

LAB40:    xsi_set_current_line(132, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB42;

LAB41:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB42;

LAB43:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB44;

LAB45:
LAB46:    xsi_set_current_line(135, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 30000LL);
    *((char **)t1) = &&LAB47;
    goto LAB1;

LAB42:    *((unsigned int *)t4) = 1;
    goto LAB43;

LAB44:    xsi_set_current_line(133, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB46;

LAB47:    xsi_set_current_line(136, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng18)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB49;

LAB48:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB49;

LAB50:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB51;

LAB52:
LAB53:    xsi_set_current_line(139, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB54;
    goto LAB1;

LAB49:    *((unsigned int *)t4) = 1;
    goto LAB50;

LAB51:    xsi_set_current_line(137, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB53;

LAB54:    xsi_set_current_line(140, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng18)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB56;

LAB55:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB56;

LAB57:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB58;

LAB59:
LAB60:    xsi_set_current_line(143, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB61;
    goto LAB1;

LAB56:    *((unsigned int *)t4) = 1;
    goto LAB57;

LAB58:    xsi_set_current_line(141, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB60;

LAB61:    xsi_set_current_line(144, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng18)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB63;

LAB62:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB63;

LAB64:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB65;

LAB66:
LAB67:    xsi_set_current_line(147, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB68;
    goto LAB1;

LAB63:    *((unsigned int *)t4) = 1;
    goto LAB64;

LAB65:    xsi_set_current_line(145, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB67;

LAB68:    xsi_set_current_line(148, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng19)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB70;

LAB69:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB70;

LAB71:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB72;

LAB73:
LAB74:    xsi_set_current_line(151, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB75;
    goto LAB1;

LAB70:    *((unsigned int *)t4) = 1;
    goto LAB71;

LAB72:    xsi_set_current_line(149, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB74;

LAB75:    xsi_set_current_line(152, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng12)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB77;

LAB76:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB77;

LAB78:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB79;

LAB80:
LAB81:    xsi_set_current_line(155, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 20000LL);
    *((char **)t1) = &&LAB82;
    goto LAB1;

LAB77:    *((unsigned int *)t4) = 1;
    goto LAB78;

LAB79:    xsi_set_current_line(153, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB81;

LAB82:    xsi_set_current_line(156, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng20)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB84;

LAB83:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB84;

LAB85:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB86;

LAB87:
LAB88:    xsi_set_current_line(159, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB89;
    goto LAB1;

LAB84:    *((unsigned int *)t4) = 1;
    goto LAB85;

LAB86:    xsi_set_current_line(157, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB88;

LAB89:    xsi_set_current_line(160, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng20)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB91;

LAB90:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB91;

LAB92:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB93;

LAB94:
LAB95:    xsi_set_current_line(163, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB96;
    goto LAB1;

LAB91:    *((unsigned int *)t4) = 1;
    goto LAB92;

LAB93:    xsi_set_current_line(161, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB95;

LAB96:    xsi_set_current_line(164, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng20)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB98;

LAB97:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB98;

LAB99:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB100;

LAB101:
LAB102:    xsi_set_current_line(167, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 20000LL);
    *((char **)t1) = &&LAB103;
    goto LAB1;

LAB98:    *((unsigned int *)t4) = 1;
    goto LAB99;

LAB100:    xsi_set_current_line(165, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB102;

LAB103:    xsi_set_current_line(168, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng12)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB105;

LAB104:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB105;

LAB106:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB107;

LAB108:
LAB109:    xsi_set_current_line(171, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB110;
    goto LAB1;

LAB105:    *((unsigned int *)t4) = 1;
    goto LAB106;

LAB107:    xsi_set_current_line(169, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB109;

LAB110:    xsi_set_current_line(172, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng13)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB112;

LAB111:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB112;

LAB113:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB114;

LAB115:
LAB116:    xsi_set_current_line(175, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB117;
    goto LAB1;

LAB112:    *((unsigned int *)t4) = 1;
    goto LAB113;

LAB114:    xsi_set_current_line(173, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB116;

LAB117:    xsi_set_current_line(176, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB119;

LAB118:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB119;

LAB120:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB121;

LAB122:
LAB123:    xsi_set_current_line(179, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB124;
    goto LAB1;

LAB119:    *((unsigned int *)t4) = 1;
    goto LAB120;

LAB121:    xsi_set_current_line(177, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB123;

LAB124:    xsi_set_current_line(180, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB126;

LAB125:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB126;

LAB127:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB128;

LAB129:
LAB130:    xsi_set_current_line(183, ng1);
    t2 = (t0 + 2968);
    xsi_process_wait(t2, 2560000LL);
    *((char **)t1) = &&LAB131;
    goto LAB1;

LAB126:    *((unsigned int *)t4) = 1;
    goto LAB127;

LAB128:    xsi_set_current_line(181, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB130;

LAB131:    xsi_set_current_line(184, ng1);
    t2 = (t0 + 912U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t4, 0, 8);
    if (*((unsigned int *)t3) != *((unsigned int *)t2))
        goto LAB133;

LAB132:    t5 = (t3 + 4);
    t6 = (t2 + 4);
    if (*((unsigned int *)t5) != *((unsigned int *)t6))
        goto LAB133;

LAB134:    t7 = (t4 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB135;

LAB136:
LAB137:    goto LAB1;

LAB133:    *((unsigned int *)t4) = 1;
    goto LAB134;

LAB135:    xsi_set_current_line(185, ng1);
    t13 = ((char*)((ng5)));
    t14 = (t0 + 1692);
    xsi_vlogvar_assign_value(t14, t13, 0, 0, 1);
    goto LAB137;

}

static void Always_203_6(char *t0)
{
    char t6[16];
    char t10[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    char *t9;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;

LAB0:    t1 = (t0 + 3212U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(203, ng1);
    t2 = (t0 + 3704);
    *((int *)t2) = 1;
    t3 = (t0 + 3240);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(203, ng1);

LAB5:    t4 = (t0 + 148);
    xsi_vlog_namedbase_setdisablestate(t4, &&LAB6);
    t5 = (t0 + 3112);
    xsi_vlog_namedbase_pushprocess(t4, t5);

LAB7:    xsi_set_current_line(205, ng1);
    t7 = xsi_vlog_time(t6, 1000.0000000000000, 1.0000000000000000);
    t8 = (t0 + 5484);
    t9 = *((char **)t8);
    xsi_vlogvar_assign_value(((char*)(t9)), t6, 0, 0, 64);
    xsi_set_current_line(206, ng1);
    t2 = (t0 + 3112);
    xsi_process_wait(t2, 0LL);
    *((char **)t1) = &&LAB8;
    goto LAB1;

LAB6:    t3 = (t0 + 3112);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB2;

LAB8:    xsi_set_current_line(206, ng1);
    t3 = (t0 + 3112);
    xsi_process_wait(t3, 0LL);
    *((char **)t1) = &&LAB9;
    goto LAB1;

LAB9:    xsi_set_current_line(206, ng1);
    t4 = (t0 + 912U);
    t5 = *((char **)t4);
    t4 = (t0 + 1784);
    t7 = (t4 + 36U);
    t8 = *((char **)t7);
    memset(t10, 0, 8);
    if (*((unsigned int *)t5) != *((unsigned int *)t8))
        goto LAB11;

LAB10:    t9 = (t5 + 4);
    t11 = (t8 + 4);
    if (*((unsigned int *)t9) != *((unsigned int *)t11))
        goto LAB11;

LAB12:    t12 = (t10 + 4);
    t13 = *((unsigned int *)t12);
    t14 = (~(t13));
    t15 = *((unsigned int *)t10);
    t16 = (t15 & t14);
    t17 = (t16 != 0);
    if (t17 > 0)
        goto LAB13;

LAB14:
LAB15:    t2 = (t0 + 148);
    xsi_vlog_namedbase_popprocess(t2);
    goto LAB6;

LAB11:    *((unsigned int *)t10) = 1;
    goto LAB12;

LAB13:    xsi_set_current_line(206, ng1);

LAB16:    xsi_set_current_line(207, ng1);
    t18 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng21, 1, t18);
    t19 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng22, 1, t19);
    t20 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng21, 1, t20);
    t21 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng23, 1, t21);
    t22 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng24, 1, t22);
    t23 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng25, 1, t23);
    t24 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng26, 1, t24);
    t25 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng27, 1, t25);
    t26 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng28, 1, t26);
    t27 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng23, 1, t27);
    t28 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng29, 1, t28);
    t29 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng30, 1, t29);
    t30 = (t0 + 148);
    xsi_vlogfile_write(0, 0, 0, ng23, 1, t30);
    t31 = (t0 + 148);
    xsi_vlogfile_write(1, 0, 0, ng21, 1, t31);
    xsi_set_current_line(222, ng1);
    xsi_vlog_stop(1);
    xsi_set_current_line(222, ng1);
    xsi_vlog_finish(1);
    goto LAB15;

}

static void Always_228_7(char *t0)
{
    char t9[16];
    char t10[8];
    char t26[16];
    char t27[8];
    char t35[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    char *t34;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    char *t39;
    char *t40;
    char *t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    char *t49;
    char *t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    int t59;
    int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    char *t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;

LAB0:    t1 = (t0 + 3356U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(228, ng1);
    t2 = (t0 + 3712);
    *((int *)t2) = 1;
    t3 = (t0 + 3384);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(228, ng1);

LAB5:    t4 = (t0 + 304);
    xsi_vlog_namedbase_setdisablestate(t4, &&LAB6);
    t5 = (t0 + 3256);
    xsi_vlog_namedbase_pushprocess(t4, t5);

LAB7:    xsi_set_current_line(230, ng1);
    t6 = (t0 + 912U);
    t7 = *((char **)t6);
    t6 = (t0 + 5508);
    t8 = *((char **)t6);
    xsi_vlogvar_wait_assign_value(((char*)(t8)), t7, 0, 0, 8, 1000LL);
    xsi_set_current_line(231, ng1);
    t2 = xsi_vlog_time(t9, 1000.0000000000000, 1.0000000000000000);
    t3 = (t0 + 1876);
    xsi_vlogvar_assign_value(t3, t9, 0, 0, 64);
    xsi_set_current_line(232, ng1);
    t2 = (t0 + 3256);
    xsi_process_wait(t2, 1000LL);
    *((char **)t1) = &&LAB8;
    goto LAB1;

LAB6:    t3 = (t0 + 3256);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB2;

LAB8:    xsi_set_current_line(232, ng1);
    t3 = (t0 + 1876);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng31)));
    xsi_vlog_unsigned_greater(t9, 64, t5, 64, t6, 32);
    memset(t10, 0, 8);
    t7 = (t9 + 4);
    t11 = *((unsigned int *)t7);
    t12 = (~(t11));
    t13 = *((unsigned int *)t9);
    t14 = (t13 & t12);
    t15 = (t14 & 1U);
    if (t15 != 0)
        goto LAB9;

LAB10:    if (*((unsigned int *)t7) != 0)
        goto LAB11;

LAB12:    t16 = (t10 + 4);
    t17 = *((unsigned int *)t10);
    t18 = *((unsigned int *)t16);
    t19 = (t17 || t18);
    if (t19 > 0)
        goto LAB13;

LAB14:    memcpy(t35, t10, 8);

LAB15:    t67 = (t35 + 4);
    t68 = *((unsigned int *)t67);
    t69 = (~(t68));
    t70 = *((unsigned int *)t35);
    t71 = (t70 & t69);
    t72 = (t71 != 0);
    if (t72 > 0)
        goto LAB23;

LAB24:
LAB25:    t2 = (t0 + 304);
    xsi_vlog_namedbase_popprocess(t2);
    goto LAB6;

LAB9:    *((unsigned int *)t10) = 1;
    goto LAB12;

LAB11:    t8 = (t10 + 4);
    *((unsigned int *)t10) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB12;

LAB13:    t20 = (t0 + 1876);
    t21 = (t20 + 36U);
    t22 = *((char **)t21);
    t23 = (t0 + 1968);
    t24 = (t23 + 36U);
    t25 = *((char **)t24);
    xsi_vlog_unsigned_case_noteq(t26, 64, t22, 64, t25, 64);
    memset(t27, 0, 8);
    t28 = (t26 + 4);
    t29 = *((unsigned int *)t28);
    t30 = (~(t29));
    t31 = *((unsigned int *)t26);
    t32 = (t31 & t30);
    t33 = (t32 & 1U);
    if (t33 != 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t28) != 0)
        goto LAB18;

LAB19:    t36 = *((unsigned int *)t10);
    t37 = *((unsigned int *)t27);
    t38 = (t36 & t37);
    *((unsigned int *)t35) = t38;
    t39 = (t10 + 4);
    t40 = (t27 + 4);
    t41 = (t35 + 4);
    t42 = *((unsigned int *)t39);
    t43 = *((unsigned int *)t40);
    t44 = (t42 | t43);
    *((unsigned int *)t41) = t44;
    t45 = *((unsigned int *)t41);
    t46 = (t45 != 0);
    if (t46 == 1)
        goto LAB20;

LAB21:
LAB22:    goto LAB15;

LAB16:    *((unsigned int *)t27) = 1;
    goto LAB19;

LAB18:    t34 = (t27 + 4);
    *((unsigned int *)t27) = 1;
    *((unsigned int *)t34) = 1;
    goto LAB19;

LAB20:    t47 = *((unsigned int *)t35);
    t48 = *((unsigned int *)t41);
    *((unsigned int *)t35) = (t47 | t48);
    t49 = (t10 + 4);
    t50 = (t27 + 4);
    t51 = *((unsigned int *)t10);
    t52 = (~(t51));
    t53 = *((unsigned int *)t49);
    t54 = (~(t53));
    t55 = *((unsigned int *)t27);
    t56 = (~(t55));
    t57 = *((unsigned int *)t50);
    t58 = (~(t57));
    t59 = (t52 & t54);
    t60 = (t56 & t58);
    t61 = (~(t59));
    t62 = (~(t60));
    t63 = *((unsigned int *)t41);
    *((unsigned int *)t41) = (t63 & t61);
    t64 = *((unsigned int *)t41);
    *((unsigned int *)t41) = (t64 & t62);
    t65 = *((unsigned int *)t35);
    *((unsigned int *)t35) = (t65 & t61);
    t66 = *((unsigned int *)t35);
    *((unsigned int *)t35) = (t66 & t62);
    goto LAB22;

LAB23:    xsi_set_current_line(232, ng1);

LAB26:    xsi_set_current_line(233, ng1);
    t73 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng21, 1, t73);
    t74 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng22, 1, t74);
    t75 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng21, 1, t75);
    t76 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng23, 1, t76);
    t77 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng32, 1, t77);
    t78 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng33, 1, t78);
    t79 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng34, 1, t79);
    t80 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng35, 1, t80);
    t81 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng36, 1, t81);
    t82 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng37, 1, t82);
    t83 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng23, 1, t83);
    t84 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng29, 1, t84);
    t85 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng30, 1, t85);
    t86 = (t0 + 304);
    xsi_vlogfile_write(0, 0, 0, ng23, 1, t86);
    t87 = (t0 + 304);
    xsi_vlogfile_write(1, 0, 0, ng21, 1, t87);
    xsi_set_current_line(249, ng1);
    xsi_vlog_stop(1);
    xsi_set_current_line(249, ng1);
    xsi_vlog_finish(1);
    goto LAB25;

}

void Monitor_37_2(char *t0)
{
    char *t1;
    char *t2;

LAB0:    t1 = (t0 + 3400);
    t2 = (t0 + 3720);
    xsi_vlogfile_monitor((void *)Monitor_37_2_Func, t1, t2);

LAB1:    return;
}


extern void work_m_00000000000302972666_1934276987_init()
{
	static char *pe[] = {(void *)Always_26_0,(void *)Initial_32_1,(void *)Always_43_3,(void *)Initial_51_4,(void *)Initial_108_5,(void *)Always_203_6,(void *)Always_228_7,(void *)Monitor_37_2};
	xsi_register_didat("work_m_00000000000302972666_1934276987", "isim/updownCounterTF_isim_beh.exe.sim/work/m_00000000000302972666_1934276987.didat");
	xsi_register_executes(pe);
}
