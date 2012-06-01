#------------------------ plotmag.gp -----------------------------------
# plotmag.gp
# Plots bandwidth magnitude measurements and overlays a first-order
# lowpass
#
# Usage: call 'plotmag.gp' 'datafile.dat'
# 
# Author: John Peck
# Date: July 29, 2011
#-----------------------------------------------------------------------
reset
datapath = "../../2011-jul-29/"

# flatamp = 4.165e-4	#Passband gain
flatamp = 2.4e-3

set logscale x
#Uncomment these next two lines when using log scaling for y
#set logscale y
#set ytics .01,2	#second argument is multiplier for logarithmic scale 
set mxtics 10
#set mytics 10
set format x '%0.1s %c'
#set format y '%1.2s %c'



set xlabel 'Frequency (Hz)'
set ylabel 'Lin mag transfer function'
#set title '$0'
set key top left
#set xrange [1e3:2e7]
set yrange [0.5:3]


#Data file from bode_sweeper is frequency, magnitude, degrees
plot datapath.'$0' using 1:2 \
    title datapath.'$0' with lines
#replot '$0' using (5,1e7):(flatamp) title 'Passband amplitude' with lines
replot flatamp title 'Passband amplitude'
#replot '$0' using 1:(flatamp * 0.707) title '3dB corner' with lines
replot (flatamp * 0.707) title '-3dB level'

#fit curve
fthree = 10e6;
#replot [freq = 1e3:1e7] flatamp / sqrt( 1 + (freq/fthree)**2 )
#replot flatamp / sqrt( 1 + (x/fthree)**2 )
replot flatamp * abs( 1 / (1 + {0,1}*(x/fthree)))
