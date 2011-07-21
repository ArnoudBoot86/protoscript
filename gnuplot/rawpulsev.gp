# rawpulsev.gp
# Plots up to three sets of time-series voltage data taken from a pulse
# experiment.
#
# Data is in the format: Time <tab> Volts
#
# Usage: call 'rawpulsev.gp' 'data1.dat' ('data2.dat') ('data3.dat')
reset
set format x '%1.0s %c'
set format y '%1.0s %c'
set title 'rawpulsev.gp'
set xlabel 'Time (s)'
set ylabel 'Potential (V)'
set key bottom left
set xrange [*:*]


plot '$0' using 1:2 # with linespoints

if ($# >= 2)\
    replot '$1' using 1:2 # with linespoints

if ($# == 3)\
    replot '$2' using 1:2 # with linespoints
