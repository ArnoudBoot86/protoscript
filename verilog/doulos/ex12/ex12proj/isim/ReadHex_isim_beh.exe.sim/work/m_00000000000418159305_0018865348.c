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
static const char *ng0 = "C:/training/verilog/ex12/readhex.v";
static const char *ng1 = "data.hex";
static const char *ng2 = "r";
static const char *ng3 = "Error: data.hex cannot be opened.";
static int ng4[] = {1, 0};
static int ng5[] = {58, 0};
static const char *ng6 = "%2h%4h%2h";
static int ng7[] = {0, 0};
static const char *ng8 = "%2h";
static const char *ng9 = "data.mem";
static const char *ng10 = "w";
static const char *ng11 = "";
static const char *ng12 = "%d";
static const char *ng13 = "reference.mem";
static const char *ng14 = "Error: reference.mem cannot be opened.";
static const char *ng15 = "Reference and file contents are ok";



static void Initial_41_0(char *t0)
{
    char t4[8];
    char t20[8];
    char t32[8];
    char t36[8];
    char t48[8];
    char t51[8];
    char t52[8];
    char t65[8];
    char t92[8];
    char t96[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    char *t31;
    char *t33;
    char *t34;
    char *t35;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;
    char *t49;
    char *t50;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;
    char *t64;
    char *t66;
    int t67;
    char *t68;
    int t69;
    int t70;
    int t71;
    int t72;
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
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    char *t93;
    unsigned int t94;
    char *t95;
    unsigned int t97;
    unsigned int t98;
    unsigned int t99;
    char *t100;
    char *t101;
    char *t102;
    unsigned int t103;
    unsigned int t104;
    unsigned int t105;
    unsigned int t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    char *t110;
    char *t111;
    unsigned int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    unsigned int t118;
    unsigned int t119;
    unsigned int t120;
    unsigned int t121;
    unsigned int t122;
    unsigned int t123;
    unsigned int t124;
    unsigned int t125;
    char *t126;
    unsigned int t127;
    unsigned int t128;
    unsigned int t129;
    unsigned int t130;
    unsigned int t131;
    char *t132;

LAB0:    t1 = (t0 + 3344U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(41, ng0);

LAB4:    t2 = (t0 + 148);
    xsi_vlog_namedbase_setdisablestate(t2, &&LAB5);
    t3 = (t0 + 3244);
    xsi_vlog_namedbase_pushprocess(t2, t3);

LAB6:    xsi_set_current_line(46, ng0);
    *((int *)t4) = xsi_vlogfile_file_open_of_cname_ctype(ng1, ng2);
    t5 = (t4 + 4);
    *((int *)t5) = 0;
    t6 = (t0 + 2084);
    xsi_vlogvar_assign_value(t6, t4, 0, 0, 32);
    xsi_set_current_line(47, ng0);
    t2 = (t0 + 2084);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    memset(t4, 0, 8);
    t6 = (t5 + 4);
    t7 = *((unsigned int *)t6);
    t8 = (~(t7));
    t9 = *((unsigned int *)t5);
    t10 = (t9 & t8);
    t11 = (t10 & 4294967295U);
    if (t11 != 0)
        goto LAB10;

LAB8:    if (*((unsigned int *)t6) == 0)
        goto LAB7;

LAB9:    t12 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t12) = 1;

LAB10:    t13 = (t4 + 4);
    t14 = *((unsigned int *)t13);
    t15 = (~(t14));
    t16 = *((unsigned int *)t4);
    t17 = (t16 & t15);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB11;

LAB12:
LAB13:    xsi_set_current_line(53, ng0);

LAB15:    t2 = (t0 + 304);
    xsi_vlog_namedbase_setdisablestate(t2, &&LAB16);
    t3 = (t0 + 3244);
    xsi_vlog_namedbase_pushprocess(t2, t3);

LAB17:    xsi_set_current_line(54, ng0);

LAB18:    xsi_set_current_line(54, ng0);

LAB19:    xsi_set_current_line(55, ng0);
    t5 = (t0 + 2084);
    t6 = (t5 + 36U);
    t12 = *((char **)t6);
    *((int *)t4) = xsi_vlogfile_fgetc(*((unsigned int *)t12));
    t13 = (t4 + 4);
    *((int *)t13) = 0;
    t19 = (t0 + 2452);
    xsi_vlogvar_assign_value(t19, t4, 0, 0, 32);
    xsi_set_current_line(56, ng0);
    t2 = (t0 + 2452);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng4)));
    memset(t4, 0, 8);
    xsi_vlog_signed_unary_minus(t4, 32, t6, 32);
    memset(t20, 0, 8);
    xsi_vlog_signed_equal(t20, 32, t5, 32, t4, 32);
    t12 = (t20 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t20);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB20;

LAB21:
LAB22:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 2452);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng5)));
    memset(t4, 0, 8);
    t12 = (t5 + 4);
    t13 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = *((unsigned int *)t6);
    t9 = (t7 ^ t8);
    t10 = *((unsigned int *)t12);
    t11 = *((unsigned int *)t13);
    t14 = (t10 ^ t11);
    t15 = (t9 | t14);
    t16 = *((unsigned int *)t12);
    t17 = *((unsigned int *)t13);
    t18 = (t16 | t17);
    t21 = (~(t18));
    t22 = (t15 & t21);
    if (t22 != 0)
        goto LAB27;

LAB24:    if (t18 != 0)
        goto LAB26;

LAB25:    *((unsigned int *)t4) = 1;

LAB27:    t23 = (t4 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t4);
    t27 = (t26 & t25);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB28;

LAB29:
LAB30:    goto LAB18;

LAB5:    t3 = (t0 + 3244);
    xsi_vlog_dispose_process_subprogram_invocation(t3);

LAB1:    return;
LAB7:    *((unsigned int *)t4) = 1;
    goto LAB10;

LAB11:    xsi_set_current_line(47, ng0);

LAB14:    xsi_set_current_line(48, ng0);
    t19 = (t0 + 148);
    xsi_vlogfile_write(1, 0, 0, ng3, 1, t19);
    xsi_set_current_line(49, ng0);
    xsi_vlog_finish(1);
    goto LAB13;

LAB16:    t3 = (t0 + 3244);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    xsi_set_current_line(63, ng0);

LAB33:    t2 = (t0 + 460);
    xsi_vlog_namedbase_setdisablestate(t2, &&LAB34);
    t3 = (t0 + 3244);
    xsi_vlog_namedbase_pushprocess(t2, t3);

LAB35:    xsi_set_current_line(68, ng0);

LAB36:    xsi_set_current_line(68, ng0);

LAB37:    xsi_set_current_line(69, ng0);
    t5 = (t0 + 2084);
    t6 = (t5 + 36U);
    t12 = *((char **)t6);
    t13 = (t0 + 2544);
    t19 = (t13 + 36U);
    t23 = *((char **)t19);
    xsi_vlog_bit_copy(t4, 0, t23, 0, 32);
    t29 = (t0 + 2636);
    t30 = (t29 + 36U);
    t31 = *((char **)t30);
    xsi_vlog_bit_copy(t20, 0, t31, 0, 32);
    t33 = (t0 + 2728);
    t34 = (t33 + 36U);
    t35 = *((char **)t34);
    xsi_vlog_bit_copy(t32, 0, t35, 0, 32);
    *((int *)t36) = xsi_vlogfile_fscanf(*((unsigned int *)t12), ng6, 4, t0, (char)119, t4, 32, (char)119, t20, 32, (char)119, t32, 32);
    t37 = (t36 + 4);
    *((int *)t37) = 0;
    t38 = (t0 + 2544);
    xsi_vlogvar_assign_value(t38, t4, 0, 0, 32);
    t39 = (t0 + 2636);
    xsi_vlogvar_assign_value(t39, t20, 0, 0, 32);
    t40 = (t0 + 2728);
    xsi_vlogvar_assign_value(t40, t32, 0, 0, 32);
    t41 = (t0 + 1808);
    xsi_vlogvar_assign_value(t41, t36, 0, 0, 32);
    xsi_set_current_line(71, ng0);
    t2 = (t0 + 1808);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng4)));
    memset(t4, 0, 8);
    xsi_vlog_signed_unary_minus(t4, 32, t6, 32);
    memset(t20, 0, 8);
    xsi_vlog_signed_equal(t20, 32, t5, 32, t4, 32);
    t12 = (t20 + 4);
    t7 = *((unsigned int *)t12);
    t8 = (~(t7));
    t9 = *((unsigned int *)t20);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB38;

LAB39:
LAB40:    xsi_set_current_line(72, ng0);
    xsi_set_current_line(72, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 1900);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB42:    t2 = (t0 + 1900);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t6 = (t0 + 2544);
    t12 = (t6 + 36U);
    t13 = *((char **)t12);
    memset(t4, 0, 8);
    xsi_vlog_signed_less(t4, 32, t5, 32, t13, 32);
    t19 = (t4 + 4);
    t7 = *((unsigned int *)t19);
    t8 = (~(t7));
    t9 = *((unsigned int *)t4);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB43;

LAB44:    xsi_set_current_line(74, ng0);
    t2 = (t0 + 2084);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t6 = (t0 + 2820);
    t12 = (t6 + 36U);
    t13 = *((char **)t12);
    xsi_vlog_bit_copy(t4, 0, t13, 0, 32);
    *((int *)t20) = xsi_vlogfile_fscanf(*((unsigned int *)t5), ng8, 2, t0, (char)119, t4, 32);
    t19 = (t20 + 4);
    *((int *)t19) = 0;
    t23 = (t0 + 2820);
    xsi_vlogvar_assign_value(t23, t4, 0, 0, 32);
    t29 = (t0 + 1808);
    xsi_vlogvar_assign_value(t29, t20, 0, 0, 32);
    goto LAB36;

LAB20:    xsi_set_current_line(56, ng0);
    goto LAB16;

LAB23:    goto LAB22;

LAB26:    t19 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t19) = 1;
    goto LAB27;

LAB28:    xsi_set_current_line(57, ng0);
    goto LAB16;

LAB31:    goto LAB30;

LAB32:    t2 = (t0 + 304);
    xsi_vlog_namedbase_popprocess(t2);
    goto LAB16;

LAB34:    t3 = (t0 + 3244);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    xsi_set_current_line(77, ng0);
    xsi_vlog_finish(1);
    xsi_set_current_line(85, ng0);
    *((int *)t4) = xsi_vlogfile_file_open_of_cname_ctype(ng9, ng10);
    t2 = (t4 + 4);
    *((int *)t2) = 0;
    t3 = (t0 + 2176);
    xsi_vlogvar_assign_value(t3, t4, 0, 0, 32);
    xsi_set_current_line(86, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 1900);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(87, ng0);

LAB48:    xsi_set_current_line(87, ng0);

LAB49:    t2 = (t0 + 616);
    xsi_vlog_namedbase_setdisablestate(t2, &&LAB50);
    t3 = (t0 + 3244);
    xsi_vlog_namedbase_pushprocess(t2, t3);

LAB51:    xsi_set_current_line(88, ng0);
    t5 = (t0 + 1900);
    t6 = (t5 + 36U);
    t12 = *((char **)t6);
    t13 = (t0 + 1992);
    t19 = (t13 + 36U);
    t23 = *((char **)t19);
    memset(t4, 0, 8);
    xsi_vlog_signed_not_equal(t4, 32, t12, 32, t23, 32);
    t29 = (t4 + 4);
    t7 = *((unsigned int *)t29);
    t8 = (~(t7));
    t9 = *((unsigned int *)t4);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB52;

LAB53:    xsi_set_current_line(93, ng0);

LAB56:    xsi_set_current_line(94, ng0);
    t2 = (t0 + 2176);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    xsi_vlogfile_fclose(*((unsigned int *)t5));
    xsi_set_current_line(95, ng0);

LAB50:    t3 = (t0 + 3244);
    xsi_vlog_dispose_process_subprogram_invocation(t3);
    goto LAB48;

LAB38:    xsi_set_current_line(71, ng0);
    goto LAB34;

LAB41:    goto LAB40;

LAB43:    xsi_set_current_line(73, ng0);
    t23 = (t0 + 2084);
    t29 = (t23 + 36U);
    t30 = *((char **)t29);
    t31 = (t0 + 1440);
    t33 = (t31 + 36U);
    t34 = *((char **)t33);
    t35 = (t0 + 1440);
    t37 = (t35 + 44U);
    t38 = *((char **)t37);
    t39 = (t0 + 1440);
    t40 = (t39 + 40U);
    t41 = *((char **)t40);
    t42 = (t0 + 2636);
    t43 = (t42 + 36U);
    t44 = *((char **)t43);
    t45 = (t0 + 1900);
    t46 = (t45 + 36U);
    t47 = *((char **)t46);
    memset(t36, 0, 8);
    xsi_vlog_signed_add(t36, 32, t44, 32, t47, 32);
    xsi_vlog_generic_get_array_select_value(t32, 8, t34, t38, t41, 2, 1, t36, 32, 1);
    xsi_vlog_bit_copy(t20, 0, t32, 0, 8);
    *((int *)t48) = xsi_vlogfile_fscanf(*((unsigned int *)t30), ng8, 2, t0, (char)118, t20, 8);
    t49 = (t48 + 4);
    *((int *)t49) = 0;
    t50 = (t0 + 1440);
    t53 = (t0 + 1440);
    t54 = (t53 + 44U);
    t55 = *((char **)t54);
    t56 = (t0 + 1440);
    t57 = (t56 + 40U);
    t58 = *((char **)t57);
    t59 = (t0 + 2636);
    t60 = (t59 + 36U);
    t61 = *((char **)t60);
    t62 = (t0 + 1900);
    t63 = (t62 + 36U);
    t64 = *((char **)t63);
    memset(t65, 0, 8);
    xsi_vlog_signed_add(t65, 32, t61, 32, t64, 32);
    xsi_vlog_generic_convert_array_indices(t51, t52, t55, t58, 2, 1, t65, 32, 1);
    t66 = (t51 + 4);
    t14 = *((unsigned int *)t66);
    t67 = (!(t14));
    t68 = (t52 + 4);
    t15 = *((unsigned int *)t68);
    t69 = (!(t15));
    t70 = (t67 && t69);
    if (t70 == 1)
        goto LAB45;

LAB46:    t73 = (t0 + 1808);
    xsi_vlogvar_assign_value(t73, t48, 0, 0, 32);
    xsi_set_current_line(72, ng0);
    t2 = (t0 + 1900);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng4)));
    memset(t4, 0, 8);
    xsi_vlog_signed_add(t4, 32, t5, 32, t6, 32);
    t12 = (t0 + 1900);
    xsi_vlogvar_assign_value(t12, t4, 0, 0, 32);
    goto LAB42;

LAB45:    t16 = *((unsigned int *)t51);
    t17 = *((unsigned int *)t52);
    t71 = (t16 - t17);
    t72 = (t71 + 1);
    xsi_vlogvar_assign_value(t50, t20, 0, *((unsigned int *)t52), t72);
    goto LAB46;

LAB47:    t2 = (t0 + 460);
    xsi_vlog_namedbase_popprocess(t2);
    goto LAB34;

LAB52:    xsi_set_current_line(88, ng0);

LAB55:    xsi_set_current_line(89, ng0);
    t30 = (t0 + 2176);
    t31 = (t30 + 36U);
    t33 = *((char **)t31);
    t34 = (t0 + 1440);
    t35 = (t34 + 36U);
    t37 = *((char **)t35);
    t38 = (t0 + 1440);
    t39 = (t38 + 44U);
    t40 = *((char **)t39);
    t41 = (t0 + 1440);
    t42 = (t41 + 40U);
    t43 = *((char **)t42);
    t44 = (t0 + 1900);
    t45 = (t44 + 36U);
    t46 = *((char **)t45);
    xsi_vlog_generic_get_array_select_value(t20, 8, t37, t40, t43, 2, 1, t46, 32, 1);
    t47 = (t0 + 616);
    xsi_vlogfile_fwrite(*((unsigned int *)t33), 0, 0, 1, ng11, 2, t47, (char)118, t20, 8);
    xsi_set_current_line(90, ng0);
    t2 = (t0 + 1900);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng4)));
    memset(t4, 0, 8);
    xsi_vlog_signed_add(t4, 32, t5, 32, t6, 32);
    t12 = (t0 + 1900);
    xsi_vlogvar_assign_value(t12, t4, 0, 0, 32);
    xsi_set_current_line(91, ng0);
    t2 = (t0 + 1900);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t6 = (t0 + 616);
    xsi_vlogfile_write(1, 0, 0, ng12, 2, t6, (char)119, t5, 32);

LAB54:    t2 = (t0 + 616);
    xsi_vlog_namedbase_popprocess(t2);
    goto LAB50;

LAB57:    goto LAB54;

LAB58:    xsi_set_current_line(106, ng0);
    *((int *)t4) = xsi_vlogfile_file_open_of_cname_ctype(ng13, ng2);
    t2 = (t4 + 4);
    *((int *)t2) = 0;
    t3 = (t0 + 2268);
    xsi_vlogvar_assign_value(t3, t4, 0, 0, 32);
    xsi_set_current_line(107, ng0);
    t2 = (t0 + 2268);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    memset(t4, 0, 8);
    t6 = (t5 + 4);
    t7 = *((unsigned int *)t6);
    t8 = (~(t7));
    t9 = *((unsigned int *)t5);
    t10 = (t9 & t8);
    t11 = (t10 & 4294967295U);
    if (t11 != 0)
        goto LAB62;

LAB60:    if (*((unsigned int *)t6) == 0)
        goto LAB59;

LAB61:    t12 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t12) = 1;

LAB62:    t13 = (t4 + 4);
    t14 = *((unsigned int *)t13);
    t15 = (~(t14));
    t16 = *((unsigned int *)t4);
    t17 = (t16 & t15);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB63;

LAB64:
LAB65:    xsi_set_current_line(111, ng0);
    t2 = (t0 + 1624);
    xsi_vlogfile_readmemb(ng13, 0, t2, 0, 0, 0, 0);
    xsi_set_current_line(112, ng0);
    t2 = (t0 + 1716);
    xsi_vlogfile_readmemb(ng9, 0, t2, 0, 0, 0, 0);
    xsi_set_current_line(120, ng0);
    xsi_set_current_line(120, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 1900);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB67:    t2 = (t0 + 1900);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t6 = (t0 + 888);
    t12 = *((char **)t6);
    memset(t4, 0, 8);
    xsi_vlog_signed_less(t4, 32, t5, 32, t12, 32);
    t6 = (t4 + 4);
    t7 = *((unsigned int *)t6);
    t8 = (~(t7));
    t9 = *((unsigned int *)t4);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB68;

LAB69:    t2 = (t0 + 148);
    xsi_vlog_namedbase_popprocess(t2);
    goto LAB5;

LAB59:    *((unsigned int *)t4) = 1;
    goto LAB62;

LAB63:    xsi_set_current_line(107, ng0);

LAB66:    xsi_set_current_line(108, ng0);
    t19 = (t0 + 148);
    xsi_vlogfile_write(1, 0, 0, ng14, 1, t19);
    xsi_set_current_line(109, ng0);
    xsi_vlog_finish(1);
    goto LAB65;

LAB68:    xsi_set_current_line(120, ng0);

LAB70:    xsi_set_current_line(121, ng0);
    t13 = (t0 + 1624);
    t19 = (t13 + 36U);
    t23 = *((char **)t19);
    t29 = (t0 + 1624);
    t30 = (t29 + 44U);
    t31 = *((char **)t30);
    t33 = (t0 + 1624);
    t34 = (t33 + 40U);
    t35 = *((char **)t34);
    t37 = (t0 + 1900);
    t38 = (t37 + 36U);
    t39 = *((char **)t38);
    xsi_vlog_generic_get_array_select_value(t20, 8, t23, t31, t35, 2, 1, t39, 32, 1);
    t40 = (t0 + 1440);
    t41 = (t40 + 36U);
    t42 = *((char **)t41);
    t43 = (t0 + 1440);
    t44 = (t43 + 44U);
    t45 = *((char **)t44);
    t46 = (t0 + 1440);
    t47 = (t46 + 40U);
    t49 = *((char **)t47);
    t50 = (t0 + 1900);
    t53 = (t50 + 36U);
    t54 = *((char **)t53);
    xsi_vlog_generic_get_array_select_value(t32, 8, t42, t45, t49, 2, 1, t54, 32, 1);
    memset(t36, 0, 8);
    if (*((unsigned int *)t20) != *((unsigned int *)t32))
        goto LAB73;

LAB71:    t55 = (t20 + 4);
    t56 = (t32 + 4);
    if (*((unsigned int *)t55) != *((unsigned int *)t56))
        goto LAB73;

LAB72:    *((unsigned int *)t36) = 1;

LAB73:    memset(t48, 0, 8);
    t57 = (t36 + 4);
    t14 = *((unsigned int *)t57);
    t15 = (~(t14));
    t16 = *((unsigned int *)t36);
    t17 = (t16 & t15);
    t18 = (t17 & 1U);
    if (t18 != 0)
        goto LAB74;

LAB75:    if (*((unsigned int *)t57) != 0)
        goto LAB76;

LAB77:    t59 = (t48 + 4);
    t21 = *((unsigned int *)t48);
    t22 = *((unsigned int *)t59);
    t24 = (t21 || t22);
    if (t24 > 0)
        goto LAB78;

LAB79:    memcpy(t96, t48, 8);

LAB80:    t126 = (t96 + 4);
    t127 = *((unsigned int *)t126);
    t128 = (~(t127));
    t129 = *((unsigned int *)t96);
    t130 = (t129 & t128);
    t131 = (t130 != 0);
    if (t131 > 0)
        goto LAB91;

LAB92:
LAB93:    xsi_set_current_line(120, ng0);
    t2 = (t0 + 1900);
    t3 = (t2 + 36U);
    t5 = *((char **)t3);
    t6 = ((char*)((ng4)));
    memset(t4, 0, 8);
    xsi_vlog_signed_add(t4, 32, t5, 32, t6, 32);
    t12 = (t0 + 1900);
    xsi_vlogvar_assign_value(t12, t4, 0, 0, 32);
    goto LAB67;

LAB74:    *((unsigned int *)t48) = 1;
    goto LAB77;

LAB76:    t58 = (t48 + 4);
    *((unsigned int *)t48) = 1;
    *((unsigned int *)t58) = 1;
    goto LAB77;

LAB78:    t60 = (t0 + 1624);
    t61 = (t60 + 36U);
    t62 = *((char **)t61);
    t63 = (t0 + 1624);
    t64 = (t63 + 44U);
    t66 = *((char **)t64);
    t68 = (t0 + 1624);
    t73 = (t68 + 40U);
    t74 = *((char **)t73);
    t75 = (t0 + 1900);
    t76 = (t75 + 36U);
    t77 = *((char **)t76);
    xsi_vlog_generic_get_array_select_value(t51, 8, t62, t66, t74, 2, 1, t77, 32, 1);
    t78 = (t0 + 1716);
    t79 = (t78 + 36U);
    t80 = *((char **)t79);
    t81 = (t0 + 1716);
    t82 = (t81 + 44U);
    t83 = *((char **)t82);
    t84 = (t0 + 1716);
    t85 = (t84 + 40U);
    t86 = *((char **)t85);
    t87 = (t0 + 1900);
    t88 = (t87 + 36U);
    t89 = *((char **)t88);
    xsi_vlog_generic_get_array_select_value(t52, 8, t80, t83, t86, 2, 1, t89, 32, 1);
    memset(t65, 0, 8);
    if (*((unsigned int *)t51) != *((unsigned int *)t52))
        goto LAB83;

LAB81:    t90 = (t51 + 4);
    t91 = (t52 + 4);
    if (*((unsigned int *)t90) != *((unsigned int *)t91))
        goto LAB83;

LAB82:    *((unsigned int *)t65) = 1;

LAB83:    memset(t92, 0, 8);
    t93 = (t65 + 4);
    t25 = *((unsigned int *)t93);
    t26 = (~(t25));
    t27 = *((unsigned int *)t65);
    t28 = (t27 & t26);
    t94 = (t28 & 1U);
    if (t94 != 0)
        goto LAB84;

LAB85:    if (*((unsigned int *)t93) != 0)
        goto LAB86;

LAB87:    t97 = *((unsigned int *)t48);
    t98 = *((unsigned int *)t92);
    t99 = (t97 & t98);
    *((unsigned int *)t96) = t99;
    t100 = (t48 + 4);
    t101 = (t92 + 4);
    t102 = (t96 + 4);
    t103 = *((unsigned int *)t100);
    t104 = *((unsigned int *)t101);
    t105 = (t103 | t104);
    *((unsigned int *)t102) = t105;
    t106 = *((unsigned int *)t102);
    t107 = (t106 != 0);
    if (t107 == 1)
        goto LAB88;

LAB89:
LAB90:    goto LAB80;

LAB84:    *((unsigned int *)t92) = 1;
    goto LAB87;

LAB86:    t95 = (t92 + 4);
    *((unsigned int *)t92) = 1;
    *((unsigned int *)t95) = 1;
    goto LAB87;

LAB88:    t108 = *((unsigned int *)t96);
    t109 = *((unsigned int *)t102);
    *((unsigned int *)t96) = (t108 | t109);
    t110 = (t48 + 4);
    t111 = (t92 + 4);
    t112 = *((unsigned int *)t48);
    t113 = (~(t112));
    t114 = *((unsigned int *)t110);
    t115 = (~(t114));
    t116 = *((unsigned int *)t92);
    t117 = (~(t116));
    t118 = *((unsigned int *)t111);
    t119 = (~(t118));
    t67 = (t113 & t115);
    t69 = (t117 & t119);
    t120 = (~(t67));
    t121 = (~(t69));
    t122 = *((unsigned int *)t102);
    *((unsigned int *)t102) = (t122 & t120);
    t123 = *((unsigned int *)t102);
    *((unsigned int *)t102) = (t123 & t121);
    t124 = *((unsigned int *)t96);
    *((unsigned int *)t96) = (t124 & t120);
    t125 = *((unsigned int *)t96);
    *((unsigned int *)t96) = (t125 & t121);
    goto LAB90;

LAB91:    xsi_set_current_line(122, ng0);

LAB94:    xsi_set_current_line(123, ng0);
    t132 = (t0 + 148);
    xsi_vlogfile_write(1, 0, 0, ng15, 1, t132);
    xsi_set_current_line(124, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2360);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB93;

}


extern void work_m_00000000000418159305_0018865348_init()
{
	static char *pe[] = {(void *)Initial_41_0};
	xsi_register_didat("work_m_00000000000418159305_0018865348", "isim/ReadHex_isim_beh.exe.sim/work/m_00000000000418159305_0018865348.didat");
	xsi_register_executes(pe);
}
