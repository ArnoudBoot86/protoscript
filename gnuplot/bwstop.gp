#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Name: bwstop.gp 
#
# Description:  Plots up to 3 bandwidth magnitude measurements made with 
#               a frequency response analyzer (such as the LabVIEW
#               script bode_sweeper.vi used with the hp4192a impedance
#               analyzer.
#
#               Fits the first datafile to a first-order lowpass function
#               to show the system bandwidth.
#               Use the plotbw.gp script instead to fit a system to a 
#               single "flatband" parameter.
#
# Datafiles:    Datafiles are in three whitespace-delimited columns: 
#               frequency (Hz)    Magnitude (linear)    Phase (degrees) 
#
# Usage:        gnuplot> call 'bwstop.gp' 'data1.dat' ('data2.dat') ('data3.dat')
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
reset
# Set the relative (or absolute) path to your datafiles.  
datapath = "../../2011-aug-3/"

set logscale x
# set logscale y
set mxtics 10
set format x '%0.1s %c'
set format y '%1.2s %c'

set xlabel 'Frequency (Hz)'
set ylabel 'Lin mag transfer function'
set title 'bwstop.gp'
set key bottom left
#set xrange [1e2:1.3e7]
set xrange [*:*]

plot datapath.'$0' using 1:2 \
    title datapath.'$0' with lines

#-----------------------------------------------------------------------
# Fit the frequency response to a first-order lowpass
#
# Choose initial fmax, flatband parameters
#-----------------------------------------------------------------------
fmax = 1e7 # Maximum frequency for fit parameter
flatband = 6.5e-3

xc(a) = fmax * (((1/pi) * atan(a)) + 0.5) # Runs from 0 to fmax for all a
a = -10 # Initial value -- starts trying with frequencies ~fmax/10
f(x) = flatband /( sqrt( 1 + (x/xc(a))**2))
fit f(x) datapath.'$0' using 1:2 via a,flatband
replot f(x) with lines title \
    'First plot fit to single-pole low pass, fc = '.gprintf('%3.2s%c',xc(a)).'Hz'

if ($# >= 2)\
    replot datapath.'$1' using 1:2 \
    title datapath.'$1' with lines

if ($# == 3)\
    replot datapath.'$2' using 1:2 \
    title datapath.'$2' with lines

# Print the fit results to the terminal
print '--------------------------------------------------------'
print 'bwstop.gp: The fit corner frequency is '.gprintf('%3.2s%c',xc(a)).'Hz'
print '--------------------------------------------------------'
