# print.gp
# Prints current plot to 'print.eps'
# Usage: call 'print.gp'
set output 'print.eps'
#
# set terminal
# Choose [postscript eps solid color] for color
set terminal postscript eps solid color
replot
pause 1 'Printing to print.eps'
set output 'plot.png'
set terminal png
replot
pause 1 'Dumping plot.png'
unset output
set terminal wxt # Window created by wxWidgets library
