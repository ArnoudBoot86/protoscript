#plotvolt.gp
#Plots voltage transfer function from external input
#to front panel E output
#Assumes a 50ohm termination on current output
#
#Usage: call 'plotvolt.gp' 'datafile.dat' 'datafile.dat' 'datafile.dat'
reset
set logscale x
set format x '%0.1s %c'
set format y '%1.2s %c'
set xlabel 'Frequency (Hz)'
set ylabel 'Mag transfer function'
set key bottom left


if ($# >= 1)\
	plot '$0' using 1:(2 * column(2)) with lines
	
if ($# >= 2)\
	replot '$1' using 1:(2 * column(2)) with lines
	
if ($# >= 3)\
	replot '$2' using 1:(2 * column(2)) with lines