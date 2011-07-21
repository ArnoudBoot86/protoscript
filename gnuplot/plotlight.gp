# plotlight.gp
# Plots emission spectra from all growlights in revB
#
# Usage: gnuplot> call 'plotlight.gp'
#
# The third argument of "using" is the weight applied to each point for
# smoothing with acsplines.  A larger number here makes a larger priority
# for the polynomial to go through the point.
#
# The every ::18 statement skips all the experimental format lines in the file
set xrange [400:700]
set title 'Emission spectra from rev B grow lights'
set xlabel 'Wavelength (nm)'
set ylabel 'Intensity (arbitrary units)'
set key top right
set pointsize 0.1
plot '../../revB/data/kit5led1.txt' every ::18 using 1:2:(.001) \
    with lines smooth acsplines title 'Board 1'
replot '../../revB/data/kit5led2.txt' every ::18 using 1:2:(.001) \
    with lines smooth acsplines title 'Board 2'   
replot '../../revB/data/kit5led3.txt' every ::18 using 1:2:(.001) \
    with lines smooth acsplines title 'Board 3' 
replot '../../revB/data/kit5led4.txt' every ::18 using 1:2:(.001) \
    with lines smooth acsplines title 'Board 4'       

