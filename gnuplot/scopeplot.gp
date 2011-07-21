# scopeplot.gp
# Plots data taken with the TDS2014C oscilloscope.
#
#
# Usage: call 'scopeplot.gp' 'data1.csv' ('data2.csv') ('data3.csv')
reset
datapath = "../../2011-jul-7/"
set datafile separator "," # For comma-delimited files
set format x '%1.1s %c'
set format y '%1.1s %c'
set title 'scopeplot.gp'
set xlabel 'Time (s)'
set ylabel 'Potential (V)'
set key top left
set xrange [-1:0.5]

# plot '$0' every 1::20 using 4:5 # with linespoints
plot datapath."$0" every 1::20 using 4:5 \
    title datapath."$0" # with linespoints

if ($# >= 2)\
    replot datapath."$1" every 1::20 using 4:5  \
    title datapath."$1" # with linespoints

if ($# == 3)\
    replot datapath."$2" every 1::20 using 4:5 \
    title datapath."$2" # with linespoints
