# cgr_cal.py
#
# Automates slope and offset calibration


import time     # For making pauses
import os       # For basic file I/O


import cgrlib

#------------------- Configure logging -------------------
import logging
logging.basicConfig(filename='cgrlog.log',level=logging.DEBUG)
logging.debug('This message should go to the log file')



# For the Gnuplot module
from numpy import * # For gnuplot.py
import Gnuplot, Gnuplot.funcutils # For gnuplot.py

# Use this option to turn off fifo if you get warnings like:
# line 0: warning: Skipping unreadable file "/tmp/tmpakexra.gnuplot/fifo"
Gnuplot.GnuplotOpts.prefer_fifo_data = 0


#--------------------- Begin configure --------------------

triglev = 0.1 # Volts -- the trigger level
trigsrc = 0 # 0: Channel A, 1: Channel B, 2: External
trigpol = 0 # 0: Rising,    1: Falling
trigpts = 1000 # The number of points to capture after trigger
fsamp = 1e5 # Hz -- the sample rate
cha_gain = 0 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )
chb_gain = 0 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )

#---------------------- End configure ---------------------

cmdterm = '\r\n' # Terminates each command





    

# caldata(offlist,declist)
#
# Convert the list of decimal data points to voltages.  Return the
# list of voltages.
#
# The decimal data list contains samples from both channels.  Channel
# A samples are at odd indexes, and channel B samples are at even
# indexes.
def caldata(offlist,decdata):
    if cha_gain == 0:
        # Channel A has 1x gain
        cha_adStepSize = 0.00592
        cha_offcounts = offlist[0]
    elif cha_gain == 1:
        # Channel A has 10x gain
        cha_adStepSize = 0.0521
        cha_offcounts = offlist[1]
    if chb_gain == 0:
        # Channel B has 1x gain
        chb_adStepSize = 0.00592
        chb_offcounts = offlist[0]
    elif chb_gain == 1:
        # Channel B has 10x gain
        chb_adStepSize = 0.0521
        chb_offcounts = offlist[1]
    # Process channel A data
    cha_voltdata = []
    for sample in decdata[0]:
        cha_voltdata.append((511 - (sample + 16))*cha_adStepSize)
    # Process channel B data
    chb_voltdata = []
    for sample in decdata[1]:
        chb_voltdata.append((511 - (sample + 16))*chb_adStepSize)
    return [cha_voltdata,chb_voltdata]

# plotdata()
#
# Plot data from one channel.
def plotdata(voltdata):
    gplot = Gnuplot.Gnuplot(debug=1)
    gplot('set terminal x11')
    gplot('set title "Data"')
    gplot('set style data lines')
    gplot('set key bottom left')
    gplot.xlabel('Time (s)')
    gplot.ylabel('Voltage (V)')
    gplot("set format x '%0.0s %c'")
    gplot('set pointsize 1')
    timedata = cgrlib.get_timelist(fsamp)
    gplot('set arrow from ' + str(timedata[1024-trigpts]) +
          ',0 to ' +str(timedata[1024-trigpts]) +',1 nohead')
    gdata_cha = Gnuplot.PlotItems.Data(
        timedata,voltdata[0],title='Channel A')
    gdata_chb = Gnuplot.PlotItems.Data(
        timedata,voltdata[1],title='Channel B')
    gplot.plot(gdata_cha,gdata_chb)
    raw_input('* Press return to exit...')

        
def main(): 
    cgr = cgrlib.get_cgr()
    offlist = cgrlib.get_offlist(cgr)
    print('* Offset list')
    print(offlist)
    cgrlib.set_hw_gain(cgr,cha_gain,chb_gain)
    ctrl_reg = cgrlib.set_ctrl_reg(cgr,fsamp,trigsrc,trigpol)
    # Start the offset calibration
    raw_input('* Remove all inputs and press return...')
    cgrlib.force_trigger(cgr, ctrl_reg)
    tracedata = cgrlib.get_uncal_forced_data(cgr,ctrl_reg)
    print(tracedata[0][0:100])
    print('* Channel B uncal data')
    print(tracedata[1][0:100])
    voltdata = caldata(offlist,tracedata) # List of voltages
    print('* Channel A data')
    print(voltdata[0][0:100])
    print('* Channel B data')
    print(voltdata[1][0:100])
    plotdata(voltdata)


# Execute main() from command line
if __name__ == '__main__':
    main()
