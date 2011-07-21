#overplot.gp
#Plots a few data files acquired with the TDS2014 scope.  
#Allows scaling of waveforms
reset
file1 = 'opa564_1vpp.dat'
file2 = 'opa564_2vpp.dat'
file3 = 'opa564_5vpp.dat'
file4 = 'opa564_6vpp.dat'
file5 = 'opa564_8vpp.dat'






set ylabel 'Amplitude (V)'
set xlabel 'Time (s)'
set format x '%0.1s %c'
set key bottom center

plot file1 using 1:(1*column(2)) with lines title "1 Vpp data"
replot file2 using 1:(0.5*column(2)) with lines title "2 Vpp data scaled by 1/2"
replot file3 using 1:(0.2*column(2)) with lines title "5 Vpp data scaled by 1/5"
replot file4 using 1:(0.167*column(2)) with lines title "6 Vpp data scaled by 1/6"
replot file5 using 1:(0.125*column(2)) with lines title "8 Vpp data scaled by 0.125"