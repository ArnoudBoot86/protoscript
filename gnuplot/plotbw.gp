# plotbw.gp # Plots up to 3 bandwidth magnitude measurements made with 
# bode_sweeper.vi 
# Datafiles are in three tab-delimited columns: 
# frequency (Hz)    Magnitude (linear)    Phase (degrees) 
# 
# Overlays a "flatband" amplitude line to guide the eye # 
# Usage: call 'plotbw.gp' 'data1.dat' ('data2.dat') ('data3.dat')

reset
set logscale x
# set logscale y
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


plot '$0' using 1:2 with lines
#Draw a line starting at the first data point to show flatness
f(x) = flatamp
fit f(x) '$0' every 1::1::2 using 1:2 via flatamp
replot '$0' using 1:(flatamp) title 'Passband amplitude' with lines
replot '$0' using 1:(flatamp * 1.01) title '+1%' with lines \
    linecolor 'black' linetype 'dashed'
replot '$0' using 1:(flatamp * 0.99) title '-1%' with lines \
    linecolor 'black' linetype 'dashed'

if ($# >= 2)\
    replot '$1' using 1:2 with lines

if ($# == 3)\
    replot '$2' using 1:2 with lines
  
# Figure out if the axis limits have been set too tightly.  If they're
# less than +/-2% of the flatamp, increase them to that point.
if (GPVAL_Y_MAX < (flatamp + 2*flatamp*0.01));\
    set yrange [*:(flatamp + 2*flatamp*0.01)];\
    replot
    
if (GPVAL_Y_MIN > (flatamp - 2*flatamp*0.01));\
    set yrange [(flatamp - 2*flatamp*0.01):];\
    replot


# replot (flatamp * 0.707) title '-3dB level'
# replot '100kHz.dat' using 1:2 with lines
# replot '10kHz.dat' using 1:2 with lines
# replot '1kHz.dat' using 1:2 with lines
# replot '100Hz.dat' using 1:2 with lines
# replot '10Hz.dat' using 1:2 with lines
