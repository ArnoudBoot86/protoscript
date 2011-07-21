# plotlcr.gp # Plots shunt R and shunt C data taken with sr830_lcr 
# Datafiles are in three tab-delimited columns: 
# frequency (Hz)   Shunt resistance (ohms)    Shunt capacitance (Farads) 

reset
set title 'plotlcr.gp'

set xlabel 'Frequency (Hz)'
set format x '%0.1s %c'
set logscale x
set xrange [*:*]
set mxtics 10

#set key top right

#set key top left
#set xrange [1e2:1.3e7]

# Plot the resistance datasets
set terminal wxt 0
set ylabel 'Resistance (Ohms)'
set format y '%1.2s %c'
set key top left
plot '$0' using 1:2 with lines
if ($# >= 2)\
    replot '$1' using 1:2 with lines
if ($# == 3)\
    replot '$2' using 1:2 with lines
#set output 'resplot.eps'
#set terminal postscript eps solid color
#replot
#pause 1 'Printing to resplot.eps'

# Plot the capacitance datasets
set terminal wxt 1
set ylabel 'Capacitance (Farads)'
set format y '%1.2s %c'
set key top right
plot '$0' using 1:3 with lines
if ($# >= 2)\
    replot '$1' using 1:3 with lines
if ($# == 3)\
    replot '$2' using 1:3 with lines
#set output 'capplot.eps'
#set terminal postscript eps solid color
#replot
#pause 1 'Printing to capplot.eps'


