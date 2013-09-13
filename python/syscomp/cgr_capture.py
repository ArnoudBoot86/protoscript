# cgr_capture.py
#
# Captures one buffer of data from the cgr-101 USB scope


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

triglev = 1 # Volts -- the trigger level
trigsrc = 1 # 0: Channel A, 1: Channel B, 2: External
trigpol = 0 # 0: Rising,    1: Falling
trigpts = 100 # The number of points to capture after trigger
fsamp = 20e3 # Hz -- the sample rate
cha_gain = 0 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )
chb_gain = 0 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )

#---------------------- End configure ---------------------

cmdterm = '\r\n' # Terminates each command




# plotdata()
#
# Plot data from one channel.
def plotdata(timedata, voltdata, trigpos):
    gplot = Gnuplot.Gnuplot(debug=0)
    gplot('set terminal x11')
    gplot('set title "Data"')
    gplot('set style data lines')
    gplot('set key bottom left')
    gplot.xlabel('Time (s)')
    gplot.ylabel('Voltage (V)')
    gplot("set yrange [-2:2]")
    gplot("set format x '%0.0s %c'")
    gplot('set pointsize 1')
    timedata = cgrlib.get_timelist(fsamp)
    if (trigpos < 511):
        gplot('set arrow from ' + str(timedata[trigpos]) + ',0 to ' +
              str(timedata[trigpos]) + ',1 nohead') 
    gdata_cha_notime = Gnuplot.PlotItems.Data(
        voltdata[0],title='Channel A')
    gdata_cha = Gnuplot.PlotItems.Data(
        timedata,voltdata[0],title='Channel A')
    gdata_chb = Gnuplot.PlotItems.Data(
        timedata,voltdata[1],title='Channel B')
    gplot.plot(gdata_cha,gdata_chb)
    # gplot.plot(gdata_cha_notime)
    gplot('set terminal postscript eps color')
    gplot("set output 'temp.eps'")
    gplot('replot')
    gplot('set terminal x11')
    raw_input('* Press return to exit...')

        
def main(): 
    caldict = cgrlib.load_cal()
    trigdict = cgrlib.get_trig_dict( trigsrc, triglev, trigpol, trigpts)
    cgr = cgrlib.get_cgr()
    cgrlib.reset(cgr)
    gainlist = cgrlib.set_hw_gain(cgr, [cha_gain,chb_gain])

    cgrlib.set_trig_level(cgr, caldict, gainlist, trigsrc, triglev)
    cgrlib.set_trig_samples(cgr,trigpts)
    ctrl_reg = cgrlib.set_ctrl_reg(cgr, fsamp, trigsrc, trigpol)
    
    # Wait for trigger, then return uncalibrated data
    tracedata = cgrlib.get_uncal_triggered_data(cgr,trigdict)
    trigpos = tracedata[2]

    # Apply calibration
    voltdata = cgrlib.get_cal_data(caldict,gainlist,[tracedata[0],tracedata[1]])
    timedata = cgrlib.get_timelist(fsamp)
    plotdata(timedata, voltdata, trigpos)


# Execute main() from command line
if __name__ == '__main__':
    main()
