#noiseplot.gp
#Plots noise on the 0V control signal vs SR560 gain

#Data comes from noisedata.dat.  First column is SR560 gain
#Second column is noise measured with "high reserve" reserve
#Third column is measured with "low noise" reserve
#Fourth column is "high reserve" with PA fan on



reset
set logscale x
set xlabel "SR560 gain"
set ylabel "AC amplitude measured with HP34401A (Vrms)"
set format y '%0.0s %c'
set key bottom right
set title 'H:\Users\jpeck\ec100_data\control_loop\noise\gnuplot\noiseplot.gp'
plot 'noisedata.dat' using 1:(column(2)/column(1)) title 'High dynamic reserve' pt 4
replot 'noisedata.dat' using 1:(column(3)/column(1)) title 'Low noise reserve'
#replot 'noisedata.dat' using 1:(column(4)/column(1)) title 'High dynamic reserve with fan'
#replot 'noisedata.dat' using 1:3 title 'High dynamic reserve'