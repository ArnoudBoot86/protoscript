# bwstop.gp
# Plots up to 3 bandwidth magnitude measurements made with 
# bode_sweeper.vi
# Datafiles are in three tab-delimited columns: 
# frequency (Hz)    Magnitude (linear)    Phase (degrees)
#
# Fits the first curve to a single-pole lowpass function
#
# Usage: call 'plotbw.gp' 'data1.dat' ('data2.dat') ('data3.dat')
reset
set logscale x
# set logscale y
set mxtics 10
set format x '%0.1s %c'
set format y '%1.2s %c'

set xlabel 'Frequency (Hz)'
set ylabel 'Lin mag transfer function'
#set title '$0'
set key top right
#set xrange [1e2:1.3e7]
set xrange [*:*]


plot '$0' using 1:2 with lines
# Restrict xc to the range of [0:fmax]


#######################################################################
# Fit the frequency response to a first-order lowpass
#
# Choose initial fmax, flatband parameters
#######################################################################
fmax = 1e7 # Maximum frequency for fit parameter
flatband = 6.5e-3

xc(a) = fmax * (((1/pi) * atan(a)) + 0.5) # Runs from 0 to fmax for all a
a = -10 # Initial value -- starts trying with frequencies ~fmax/10
f(x) = flatband /( sqrt( 1 + (x/xc(a))**2))
fit f(x) '$0' using 1:2 via a,flatband
replot f(x) with lines title 'First plot fit to single-pole low pass'

if ($# >= 2)\
    replot '$1' using 1:2 with lines

if ($# == 3)\
    replot '$2' using 1:2 with lines

# Print the fit results to the terminal
print '--------------------------------------------------------'
print 'The fit corner frequency is '.gprintf('%3.2s%c',xc(a)).'Hz'
print '--------------------------------------------------------'
