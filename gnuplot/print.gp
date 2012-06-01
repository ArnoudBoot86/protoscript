# print.gp
# Prints current plot to filename
# Usage: call 'print.gp' <filename> (without extension)
#
# If no filename is specified, prints to print.eps and print.png

if ($# == 0)\
    set output 'print.eps'
if ($# == 1)\
    set output '$0'.'.eps'
#
# set terminal
# Choose [postscript eps solid color] for color
set terminal postscript eps solid color
replot
if ($# == 0)\
    pause 1 'Printing to print.eps'
if ($# == 1)\
    pause 1 'Printing to $0.eps'

if ($# == 0)\
    set output 'print.png'
if ($# == 1)\
    set output '$0'.'.png'

set terminal png
replot
if ($# == 0)\
    pause 1 'Printing to print.png'
if ($# == 1)\
    pause 1 'Printing to $0.png'

unset output
set terminal wxt # Window created by wxWidgets library

