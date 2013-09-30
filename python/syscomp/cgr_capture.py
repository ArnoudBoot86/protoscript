# cgr_capture.py
#
# Captures one buffer of data from the cgr-101 USB scope


import time     # For making pauses
import os       # For basic file I/O
import testlib  # For colored error messages



#------------------- Configure logging -------------------
import logging
from colorlog import ColoredFormatter

# create logger
logger = logging.getLogger('root')
logger.setLevel(logging.DEBUG)

# create console handler and set level to debug
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)

# create file handler and set level to debug
fh = logging.FileHandler('cgrlog.log',mode='a',encoding=None,delay=False)
fh.setLevel(logging.DEBUG)

color_formatter = ColoredFormatter(
    "%(log_color)s%(levelname)-8s%(reset)s %(white)s%(message)s",
    datefmt=None,
    reset=True,
    log_colors={
        'DEBUG':    'cyan',
        'INFO':     'green',
        'WARNING':  'yellow',
        'ERROR':    'red',
        'CRITICAL': 'red',
    }
)

plain_formatter = logging.Formatter(
    '%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    '%Y-%m-%d %H:%M:%S'
)

# Colored output goes to the console
ch.setFormatter(color_formatter)
logger.addHandler(ch)

# Plain output goes to the file
fh.setFormatter(plain_formatter)
logger.addHandler(fh)

import cgrlib

# For the Gnuplot module
from numpy import * # For gnuplot.py
import Gnuplot, Gnuplot.funcutils # For gnuplot.py

# Use this option to turn off fifo if you get warnings like:
# line 0: warning: Skipping unreadable file "/tmp/tmpakexra.gnuplot/fifo"
Gnuplot.GnuplotOpts.prefer_fifo_data = 0


#--------------------- Begin configure --------------------

triglev = 1 # Volts -- the trigger level
trigsrc = 1 # 0: Channel A, 1: Channel B, 2: External
trigpol = 1 # 0: Rising,    1: Falling
trigpts = 512 # The number of points to capture after trigger
fsamp_req = 100e3 # Hz -- the requested sample rate
cha_gain = 0 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )
chb_gain = 0 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )

#---------------------- End configure ---------------------

cmdterm = '\r\n' # Terminates each command




# plotdata()
#
# Plot data from one channel.
def plotdata(timedata, voltdata, trigdict):
    # Set debug=1 to see gnuplot commands
    gplot = Gnuplot.Gnuplot(debug=0)
    gplot('set terminal x11')
    titlestr = ('Trigger at sample ' +
                ' ({:0.3f} ms)'.format(1000 * timedata[1]))
    gplot('set title "' + titlestr + '"')
    gplot('set style data lines')
    gplot('set key bottom left')
    gplot.xlabel('Time (s)')
    gplot.ylabel('Voltage (V)')
    gplot("set yrange [*:*]")
    gplot("set format x '%0.0s %c'")
    gplot('set pointsize 1') 
    gdata_cha_notime = Gnuplot.PlotItems.Data(
        voltdata[0],title='Channel A')
    gdata_cha = Gnuplot.PlotItems.Data(
        timedata,voltdata[0],title='Channel A')
    gdata_chb = Gnuplot.PlotItems.Data(
        timedata,voltdata[1],title='Channel B')
    gplot.plot(gdata_cha,gdata_chb) # Plot the data
    # Add the trigger crosshair
    trigtime = timedata[1024-trigdict['trigpts']]
    gplot('set arrow from ' + str(trigtime) + ',graph 0 to ' + 
          str(trigtime) + ',graph 1 nohead linetype 0')
    gplot('set arrow from graph 0,first ' + str(trigdict['triglev']) +
          ' to graph 1,first ' + str(trigdict['triglev']) + 
          ' nohead linetype 0')
    gplot('replot')
    savefilename = ('trig.eps')
    gplot('set terminal postscript eps color')
    gplot("set output '" + savefilename + "'")
    gplot('replot')
    gplot('set terminal x11')
    raw_input('* Press return to exit...')

        
def main():
    logger.debug('Starting main')
    cgr = cgrlib.get_cgr()
    cgrlib.init_config()
    caldict = cgrlib.load_cal()
    trigdict = cgrlib.get_trig_dict( trigsrc, triglev, trigpol, trigpts)
    gainlist = cgrlib.set_hw_gain(cgr, [cha_gain,chb_gain])

    cgrlib.set_trig_level(cgr, caldict, gainlist, trigsrc, triglev)
    cgrlib.set_trig_samples(cgr,trigpts)
    [ctrl_reg, fsamp_act] = cgrlib.set_ctrl_reg(cgr, fsamp_req, 
                                                trigsrc, trigpol)
    if not (fsamp_act == fsamp_req):
        logger.warning('Requested sample frequency ' + 
                       '{:0.3f} kHz '.format(float(fsamp_req)/1000) +
                       'adjusted to ' + 
                       '{:0.3f} kHz '.format(float(fsamp_act)/1000))
        testlib.warnmessage('Requested sample frequency ' + 
                            '{:0.3f} kHz '.format(float(fsamp_req)/1000) +
                            'adjusted to ' + 
                            '{:0.3f} kHz '.format(float(fsamp_act)/1000))

    # Wait for trigger, then return uncalibrated data
    [ctrl_reg, fsamp_act] = cgrlib.set_ctrl_reg(cgr, fsamp_req, 
                                                trigsrc, trigpol)
    tracedata = cgrlib.get_uncal_triggered_data(cgr,trigdict)

    # Apply calibration
    voltdata = cgrlib.get_cal_data(caldict,gainlist,[tracedata[0],tracedata[1]])
    timedata = cgrlib.get_timelist(fsamp_act)
    plotdata(timedata, voltdata, trigdict)


# Execute main() from command line
if __name__ == '__main__':
    main()
