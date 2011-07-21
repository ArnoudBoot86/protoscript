#plotcurr.gp
#Plots transresistance measurements given a current range.
#Assumes a 50ohm termination on current output
#
#Range is the current range in amps.
#Usage: call 'plotcurr.gp' <range> 'datafile.dat' 'datafile.dat' 'datafile.dat'
reset
set logscale x
set format x '%0.1s %c'
set format y '%1.2s %c'
set xlabel 'Frequency (Hz)'
set ylabel '|Z| (ohms)'


if ($# >= 2)\
	plot '$1' using 1:(1/(column(2) * $0 * 2)) with lines
	
if ($# >= 3)\
	replot '$2' using 1:(1/(column(2) * $0 * 2)) with lines
	
if ($# >= 4)\
	replot '$3' using 1:(1/(column(2) * $0 * 2)) with lines