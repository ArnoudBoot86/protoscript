#plotz.gp
#Plots impedance measurements stored in 3 column format:
#Frequency    Magnitude    Angle (degrees)
#
#<range> is the current range in amps.  Each plot should have a range
#associated with it.
#
#Usage: call 'plotz.gp' <range1> 'datafile1.dat' <range2> 'datafile2.dat' <range3> 'datafile3.dat'
reset
set logscale x
set mxtics 10
set format x '%0.1s %c'
set format y '%1.2s %c'
set xlabel 'Frequency (Hz)'
set ylabel '|Z| (ohms)'
set label "ec100 impedance accuracy spec is 10% to 1MHz" at graph 0.05,0.95
set key bottom left width -10 height 1

if ($# >= 2)\
	plot '$1' using 1:(column(2) / $0) with lines
	
if ($# >= 4)\
	replot '$3' using 1:(column(2) / $2) with lines
	
if ($# >= 6)\
	replot '$5' using 1:(column(2) / $4) with lines

#Draw a line starting at the first data point to show flatness	
f(x) = a
fit f(x) '$1' every 1::1::2 using 1:(column(2) / $0) via a
replot f(x) title 'Lowest frequency |Z|'
replot f(x) * 1.1 title '+10% bound'
replot f(x) * 0.90 title '-10% bound'
set yrange [a * 0.7 : a * 1.15]
replot

