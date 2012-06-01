#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Name: plotbw.gp 
#
# Description:  Plots up to 3 bandwidth magnitude measurements made with 
#               a frequency response analyzer (such as the LabVIEW
#               script bode_sweeper.vi used with the hp4192a impedance
#               analyzer.
#
#               Fits the first datafile to a constant "flatband" parameter
#               to show the gain of the system at low frequencies.
#               Use the bwstop.gp script instead to fit a system to a 
#               first-order lowpass.
#
# Datafiles:    Datafiles are in three whitespace-delimited columns: 
#               frequency (Hz)    Magnitude (linear)    Phase (degrees) 
#
# Usage:        gnuplot> call 'plotbw.gp' 'data1.dat' ('data2.dat') ('data3.dat')
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

reset
# Set the relative (or absolute) path to your datafiles.  
datapath = "../../2011-aug-16/"
# Choose whether or not to add a flatband line to the plot:
# fit_flatband = 'yes' -- Add the flatband line
# fit_flatband = 'no' -- Just plot the data without adding any fitted lines
fit_flatband = 'no'

set logscale x
set logscale y
set mxtics 10
set format x '%0.1s %c'
set format y '%1.2s %c'
set title 'plotbw.gp'
set xlabel 'Frequency (Hz)'
set ylabel 'Lin mag transfer function'
#set title '$0'
#set key top right
set key bottom left
#set key top left
#set xrange [1e2:1.3e7]

set xrange [*:*]


plot datapath.'$0' using 1:2 with lines title datapath.'$0'
#Draw a line starting at the first data point to show flatness
if (fit_flatband eq 'yes');\
    f(x) = flatamp;\
    fit f(x) datapath.'$0' every 1::1::2 using 1:2 via flatamp;\
    replot datapath.'$0' using 1:(flatamp) title 'Passband amplitude' with lines;\
    replot datapath.'$0' using 1:(flatamp * 1.01) title '+1%' with lines \
        linecolor 'black' linetype 'dashed';\
    replot datapath.'$0' using 1:(flatamp * 0.99) title '-1%' with lines \
        linecolor 'black' linetype 'dashed';
# end if

if ($# >= 2)\
    replot datapath.'$1' using 1:2 with lines

if ($# == 3)\
    replot datapath.'$2' using 1:2 with lines
  
# Figure out if the axis limits have been set too tightly.  If they're
# less than +/-2% of the flatamp, increase them to that point.
#if (GPVAL_Y_MAX < (flatamp + 2*flatamp*0.01));\
    #set yrange [*:(flatamp + 2*flatamp*0.01)];\
    #replot
    
#if (GPVAL_Y_MIN > (flatamp - 2*flatamp*0.01));\
    #set yrange [(flatamp - 2*flatamp*0.01):];\
    #replot


# replot (flatamp * 0.707) title '-3dB level'
# replot '100kHz.dat' using 1:2 with lines
# replot '10kHz.dat' using 1:2 with lines
# replot '1kHz.dat' using 1:2 with lines
# replot '100Hz.dat' using 1:2 with lines
# replot '10Hz.dat' using 1:2 with lines
