# npulse.gp
# Plots up to three curves taken with the par273_npulse.py script
#
# Data is in the format: E <tab> (difference I)
#
# Usage: call 'npulse.gp' 'data1.dif' ('data2.dif') ('data3.dif')
reset
datapath = "../../2011-aug-2/"
# set format x '%0.1s %c'
set format y '%1.0s %c'
set title 'npulse.gp'
set xlabel 'E (Volts vs reference)'
set ylabel 'Difference current (A)'
set key bottom right
set xrange [-0.15:0.2] reverse
rval = 9.88e3 # The test resistor value (ohms)
reste = 0.2 # The resting potential (volts)

plot datapath."$0" using 1:2 \
    title datapath."$0" # with linespoints
# replot datapath."$0" using 1:( reste - column(1) )/rval with lines \
#     title "Calculated using ".gprintf("%0.3s%c",rval)

if ($# >= 2)\
    replot datapath."$1" using 1:2 \
    title datapath."$1" # with linespoints

if ($# == 3)\
    replot datapath."$2" using 1:2 \
    title datapath."$2" # with linespoints

