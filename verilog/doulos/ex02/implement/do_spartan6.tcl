# Copyright (c) Doulos 2010
# 30 Sept  2010, DIL
#
# A Tcl script to automatically synthesize,
# implement and download a Xilinx design.
#

# Look for a Xilinx project in a subdirectory
set compile_directory Spartan6
        
# First find the subdirectories
if { [ catch { set dirs [glob -type d *] } ] } {
  puts "No existing project found"
} else {
        # Look for a .ise file in each of these
        foreach dir $dirs {
          set ise [glob -nocomplain $dir/*.ise]
          if {$ise != ""} {
             set compile_directory $dir
             set proj [file tail $ise]
                  regsub {.ise} $proj {} proj
             puts "Found ISE project, ${proj}, in $dir"
          }

        }
}

# top_name should be case sensitive match to top level module
# name, so script will work on Unix/Linux
set top_name              mux2
set arch_name             ""

set verilog_files {
                          ../../source/mux2.v
}
set constraints_file      ../../source/board_support/spartan6.ucf

# Implement the design
source ../../common/do_spartan6.tcl

