# sr830_sweep.py
# Plots a transfer function taken with the sr830
from numpy import *
import Gnuplot, Gnuplot.funcutils
import socket   # For TCP/IP sockets
import visa     # For GPIB or RS-232
import time     # For making pauses
import os       # For basic file I/O

# ------------------------- Begin configure ----------------------------
sr830ch = 30    # sr830 GPIB channel
drive = 0.03    # Vrms, the drive amplitude
fstart = 10      # Hz, the sweep begin frequency
fend = 100e3     # Hz, the sweep end frequency
fpoints = 100    # number of points in the sweep 
settle = 10    # Cycles to wait after frequency is set

gnupath = '..\\gnuplot' # The relative path to the gnuplot directory.
testname = 'junk'   # The filename base for saved data
# ------------------------- End configure ------------------------------
freqlist = logspace(log10(fstart),log10(fend),num=fpoints)
datafile = gnupath + '\\' + testname + '.dat'


# Set up gpib for sr830.  If successful, sr830 will become a global
# variable.  This function will return the creation as:
# true -- I created sr830
# false -- I failed
def get830():
    try:
        global sr830
        sr830 = visa.instrument('GPIB::' + str(sr830ch))
        return True
    except:
        return False

# send830
# Send an ascii command to the sr830        
def send830(cmdstr):
    sr830.write(cmdstr)

def ask830(cmdstr):
    data = sr830.ask(cmdstr)
    return data
    
# setup830()
# Configures static parameters for the sr830
def setup830():
    send830('fmod 1') # Set reference source (1: internal)
    send830('slvl ' + str(drive)) # Set drive amplitude
    send830('harm 1') # Set measurement harmonic
    send830('isrc 0') # Set input (0:A)
    send830('sync 1') # Set synchronous filter below 200Hz

# measplot()
# Makes a measurement and plots it
def measplot():
    rawmeas = []
    plotfreq = []
    gplot = Gnuplot.Gnuplot(debug=0)
    count = 0
    measdict = {}
    for freq in freqlist:
        send830('freq ' + str(round(freq)))
        time.sleep(settle * float(1)/freq)   # Set the settle time
        onemeas = ask830('outp? 3') # Make R measurement
        rawmeas.append(float(onemeas))
        plotfreq.append(freq)
        measdict[freq] = [onemeas]
        gplot('set logscale x')
        gplot('set mxtics 10')
        gplot("set format x '%0.1s %c'")
        gplot('set data style lines')
        gplot.xlabel('Frequency (Hz)')
        gplot.ylabel('Raw R value (V_{rms})')
        gdata = Gnuplot.Data(plotfreq,rawmeas)
        if count == 0:
            gplot.plot(gdata)
        else:
            gplot.replot(gdata)
    gplot.hardcopy('gplot.ps', enhanced=1, color=1)
    print('* Postscript output written to gplot.ps')
    raw_input('* Please press return to clear plot window...')
    return measdict

# writedata(dict)
# Writes measurement data.  Having the data values come in as a list
# allows for plotting multiple columns of data.
def writedata(measdict):
    fot = open(datafile,'w')
    keys = measdict.keys()
    keys.sort()
    valnum = len(measdict[keys[0]])
    for key in keys:
        fot.write(str(key) + '\t')
        count = 1
        for item in measdict[key]:
            # If count == valnum, this is the last value to be written.
            if count == valnum:
                fot.write(str(item))
            else:
                fot.write(str(item) + '\t')
            count += 1
            fot.write('\n')
    print('* Ascii data file written to ' + datafile)

    
    

        

def main():
    if get830():
        print('* SR830 ready on gpib channel ' + str(sr830ch))
        setup830()
        measdict = {}
        measdict = measplot()
        writedata(measdict)
    else:
        print('SR830 not found on gpib channel ' + str(sr830ch)) 

# when executed, just run main():
if __name__ == '__main__':
    main()
