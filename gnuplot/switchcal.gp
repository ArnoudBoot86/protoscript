# switchcal.gp
# Plots correct and incorrect E out traces during AC switch charge
# injection calibration.
#
# Usage: gnuplot> call 'switchcal.gp'
#
# The every ::18 statement skips all the experimental format lines in the file
reset
set terminal windows
# set title 'Good and bad switchoff curves'
set xlabel 'Time (s)'
set format x "%4.1s %c"
set ylabel 'Volts'
# set key
# Use [top right] for upper right corner
# Use [nokey] for no legend
set nokey
set datafile separator ","
set label 'Overcompensated' at 6.3e-7,0.28
plot 'undercomp.csv' every ::18 using 4:5 \
    with lines title 'Good'
set label 'Just right' at 6.3e-7,0.053   
replot 'justright.csv' every ::18 using 4:5 \
    with lines title 'Board 2'
set label 'Undercompensated' at 6.3e-7,-0.214 
replot 'overcomp.csv' every ::18 using 4:5 \
    with lines title 'Board 3' 
#replot '../../revB/data/kit5led4.txt' every ::18 using 1:2:(.001) \
#    with lines smooth acsplines title 'Board 4'       
