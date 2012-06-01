#snubplot.gp
#Compares transient response plots taken with and without a snubber
reset
file1 = 'nosnub_8vpp.dat'
file2 = 'snub2_8vpp.dat'
#file3 = 'ths4031_5Vpp.dat'
#file4 = 'ths4031_6Vpp.dat'
#file5 = 'ths4031_8Vpp.dat'






set ylabel 'Amplitude (V)'
set xlabel 'Time (s)'
set format x '%0.1s %c'
set key bottom center

plot file1 using 1:(1*column(2)) with lines title "No snubber"
replot file2 using 1:(1*column(2)) with lines title "10ohms + 10nF snubber"
#replot file3 using 1:(0.2*column(2)) with lines title "5 Vpp data scaled by 1/5"
#replot file4 using 1:(0.167*column(2)) with lines title "6 Vpp data scaled by 1/6"
#replot file5 using 1:(0.125*column(2)) with lines title "8 Vpp data scaled by 0.125"