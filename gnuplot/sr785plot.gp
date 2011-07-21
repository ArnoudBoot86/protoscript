#sr785plot.gp
#Plots data from the SR785 gathered in two tab-delimited
#columns: frequency and data
#Usage: call 'sr785plot.gp' 'datafile' 'datafile' 'datafile'
reset



set format x '%0.1s %c'
set format y '%1.2s %c'
set xlabel 'Frequency (Hz)'
set ylabel 'Amplitude (Vrms)'


if ($# >= 1)\
	plot '$0' using 1:2 with lines
	
if ($# >= 2)\
	replot '$1' using 1:2 with lines
	
if ($# >= 3)\
	replot '$2' using 1:2 with lines	

