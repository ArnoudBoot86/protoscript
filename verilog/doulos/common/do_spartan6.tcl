# do_spartan6.tcl
# ================

#########################################################################
#
# Xilinx ISE Tcl script. Developed and tested using ISE 9.2i SP4.
# Tested with ISE 10.1 SP1
#
# This is a generic script that is called from a specific
# do_spartan6.tcl, for example ex07/implement/do_spartan6.tcl.
# The caller sets up the files etc.
# This script may be run within "xtclsh". This script may also be run
# within the ISE Project Navigator, HOWEVER, the last bit (downloading
# with iMPACT) doesn't quite work, because "channel "stdin" wasn't opened
# for reading"
#
# This script was derived in part from the one used in Xilinx's
# Advanced FPGA Implementation course. The rest was adapted from ISE.pm.
#
# This script also uses the new LCD controller, and not the one that
# uses a PicoBlaze processor.
#
#  1.0  3/ 4/08 MJS First version
#  1.1  4/ 6/08 MJS Fixed for ISE 10.1
#  1.2  4/ 7/08 MJS Use iMPACT 9.2, not 10.1 on Linux
#  1.3 11/ 6/09 APF Remove Impact 9.2 after install of Xilinx 11.1 on Linux 
#  1.4 03/06/10 APF Changed project to .xise instead of .ise to match ISE 12
#                   Macro Search Path is always set.
#  1.5 30/09/10 DIL Changed to work with SP605 board
#  1.6 16/06/11 APF Use "project set top" for ISE 13.1
#
#########################################################################

#########################################################################
# Set cableserver host
#########################################################################

set cableserver_host {}
# If you are using VMWare or Linux, edit the following line to include
# the name of the Xilinx CableServer host PC and un-comment the line.
#set cableserver_host host_PC_name

#########################################################################
# Set Tcl Variables
#########################################################################

set version_number "1.6"

# If the "proj" variable is already set, use that value
# See ex01/implement/do_spartan3e.tcl
if { ! [info exists proj] } { set proj $top_name }

#########################################################################
# Welcome
#########################################################################

puts "\nRunning ISE Tcl script \"do_spartan6.tcl\" from Doulos, version $version_number."

if { $cableserver_host == "" } {
  puts "Running with SP605 board connected to the local PC.\n"
} else {
  puts "Running under VMWare or Linux, with SP605 board connected to $cableserver_host.\n"
}

#########################################################################
# Create a directory in which to run
#########################################################################

# Run in the compile directory
catch {file mkdir $compile_directory}
cd $compile_directory

#########################################################################
# Create a new project or open project
#########################################################################
# This if-then-else statement looks to see if this is the first time the 
# script has been run - if so, it will setup the project.  If not, the 
# project already exists - therefore, it will simply open the project.

set proj_exists [file exists $proj.xise]

if {$proj_exists == 0} {

    puts "Creating a new project ..."

    # Create new project
    project new $proj.xise

    # Project settings
    project set family Spartan6
    project set device xc6slx45t
    project set package fgg484
    project set speed -2

    # Add files to the project (must come after the settings)
    foreach filename $verilog_files {
      xfile add $filename
    }
    xfile add $constraints_file
    project set top $arch_name $top_name
    
} else {

    puts "Opening the existing project ..."

    # Open the previously created project
    project open $proj.xise
}

# Test to see if $source_directory is set ...
if { ! [catch {set source_directory $source_directory}] } {
  project set "Macro Search Path" $source_directory -process Translate 
}

#########################################################################
# Set Implementaiton Properties
#########################################################################
# MAP
#project set "Map Effort Level" Medium -process map
#project set "Perform Timing-Driven Packing and Placement" true -process map 
#project set "Register Duplication" true -process map
#project set "Retiming" true -process map
# 
# PAR
#project set "Place & Route Effort Level (Overall)" Standard
#project set "Extra Effort (Highest PAR level only)" Normal

#########################################################################
# Implement Design
#########################################################################
puts "Running ..."
process run "Generate Programming File"

#########################################################################
# Close Project
#########################################################################
project close

#########################################################################
# Download
#########################################################################

# The following code was adapted from ISE.pm

set impact_script_filename impact_script.scr
set bit_filename $top_name.bit

if [catch {set f_id [open $impact_script_filename w]} msg] {
  puts "Can't create $impact_script_filename"
  puts $msg
  exit
}

# Assume SP605 kit

if { $cableserver_host == "" } {
        # Assume using locally connected board (not using VMware or Linux via VNC)
        puts $f_id "setMode -bscan"
        puts $f_id "setCable -p usb21"

} else {
        # Assume using cableserver on cableserver_host
        puts $f_id "setMode -bscan"
        puts $f_id "setCable -p usb21 -server $cableserver_host"
}
puts $f_id "addDevice -p 1 -part xccace"
puts $f_id "addDevice -position 2 -file $bit_filename"
puts $f_id "readIdcode -p 2"
puts $f_id "program -p 2"
puts $f_id "quit"

close $f_id

puts "\n"
puts "  Switch on the SP605 board, connect the USB cable."
puts -nonewline "  Press Enter when you are ready to download...\a"
flush stdout

# The "gets" command fails with the following message, if running within
# the ISE Project Navigator GUI.
#
#   channel "stdin" wasn't opened for reading
 
if [catch {gets stdin ignore_me} msg] {
  puts "\n\n *** $msg"
  puts " *** Carrying on regardless ...\n"
  flush stdout
}

set impact impact

set impact_pipe [open "|$impact -batch $impact_script_filename" r]
while {![eof $impact_pipe]} { gets $impact_pipe line ; puts $line }
#close $impact_pipe

puts "\nEnd of ISE Tcl script.\n\n"
