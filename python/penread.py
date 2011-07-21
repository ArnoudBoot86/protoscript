""" penread.py
    Triggers and plots data taken with the AVR butterfly """
from numpy import *
import serial
import Gnuplot, Gnuplot.funcutils
import os

os.environ['GDFONTPATH'] = '/usr/share/fonts/corefonts'
s = serial.Serial('/dev/ttyS0')
s.timeout=1.0
gplot = Gnuplot.Gnuplot(debug=0)

def ishex(s):
    try:
        int(s,16)
        return True
    except ValueError:
        return False

def main():
    s.open()
    s.write('\n')
    vdata = []
    idata = []
    rawvdata = s.readline()
    for datum in rawvdata.split(' '):
        if ishex(datum):
            number = int(datum,16)
            vdata.append(number)
    rawidata = s.readline()
    for datum in rawidata.split(' '):
        if ishex(datum):
            number = int(datum,16)
            idata.append(number)
    s.close()
    gdata = Gnuplot.Data(vdata,title='Voltage data')
    gplot.xlabel('Sample number')
    gplot.ylabel('Amplitude (arbitrary)')
    gplot('set style data lines')
    gplot('set yrange [0:150]')
    gplot.plot(gdata)
    gdata = Gnuplot.Data(idata,title='Current data')
    gplot.replot(gdata)
    gplot("set terminal png enhanced font 'verdana'")
    gplot("set output 'plot.png'")
    gplot.replot()
    raw_input('Please press return to continue...')

if __name__ == '__main__':
     main()
