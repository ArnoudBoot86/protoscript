#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Name: ploteis.gp 
#
# Description:  Plots up to 3 impedance measurements made with the
#               eis_sweeper.vi LabVIEW program. 
#
# Datafiles:    Datafiles are in four whitespace-delimited columns: 
#               frequency (Hz)    |Z| (ohms)    Phase (degrees)  Range 
#               * Range is related to the log of the current range used
#                 for the measurement.  
#                 0 --> 1A
#                 1 --> 100mA
#                 2 --> 10mA
#
# Usage:        gnuplot> call 'ploteis.gp' 'data1.dat' ('data2.dat') ('data3.dat')
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

reset
set terminal wxt
# Set the relative (or absolute) path to your datafiles.  
datapath = "../../2011-nov-8/"
# Choose whether or not to add a flatband line to the plot:
# fit_flatband = 'yes' -- Add the flatband line
# fit_flatband = 'no' -- Just plot the data without adding any fitted lines
fit_flatband = 'no'

# set logscale x
set mxtics 10
set format x '%0.0s %c'
set format y '%1.2s %c'
set title 'ploteis.gp'
set xlabel 'Frequency (Hz)'
set ylabel '|Z| (ohms)'
#set key top right
set key bottom left
#set key top left
#set xrange [1e2:1.3e7]
set xrange [*:*]

plot datapath.'$0' using 1:2 with lines title datapath.'$0'

if ($# >= 2)\
    replot datapath.'$1' using 1:2 with lines title datapath.'$1'

if ($# == 3)\
    replot datapath.'$2' using 1:2 with lines title datapath.'$2'


#Draw a line starting at the first data point to show flatness
if (fit_flatband eq 'yes');\
    f(x) = flatamp;\
    fit f(x) datapath.'$0' every 1::1::2 using 1:2 via flatamp;\
    replot datapath.'$0' using 1:(flatamp) title 'Passband amplitude' with lines;\
    replot datapath.'$0' using 1:(flatamp * 1.1) title '+10%' with lines \
        linetype 13;\
    replot datapath.'$0' using 1:(flatamp * 1.01) title '+1%' with lines \
        linetype 0;\
    replot datapath.'$0' using 1:(flatamp * 0.99) title '-1%' with lines \
        linetype 0;\
    replot datapath.'$0' using 1:(flatamp * 0.9) title '-10%' with lines \
        linetype 13;
    
# end if


    

    
