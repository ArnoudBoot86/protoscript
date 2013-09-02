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

triglev = 0.1 # Volts -- the trigger level
trigsrc = 0 # 0: Channel A, 1: Channel B, 2: External
trigpol = 0 # 0: Rising,    1: Falling
trigpts = 1000 # The number of points to capture after trigger
fsamp = 1e5 # Hz -- the sample rate
cha_gain = 0 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )
chb_gain = 0 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )

#---------------------- End configure ---------------------

cmdterm = '\r\n' # Terminates each command





# ctrl_reg_val()
#
# Compute the control register value.  We have to keep track of the
# control register value in between writes.
#
# Returns the control register value.
def ctrl_reg_value():
    reg_value = 0
    reg_value += cgrlib.get_samplebits(fsamp) # Set sample rate
    # Configure the trigger source
    if trigsrc == 0:
        # Trigger on channel A
        reg_value += (0 << 4)
    elif trigsrc == 1:
        # Trigger on channel B
        reg_value += (1 << 4)
    elif trigsrc == 2:
        # Trigger on external input
        reg_value += (1 << 6)
    # Configure the trigger polarity
    if trigpol == 0:
        # Rising edge
        reg_value += (0 << 5)
    elif trigpol == 1:
        # Falling edge
        reg_value += (1 << 5)
    return reg_value

# ctrl_reg_set(handle)
#
# Set the value for the control register.
def ctrl_reg_set(handle):
    handle.open()
    cgrlib.sendcmd(handle,('S R ' + str(ctrl_reg_value())))
    print('Control register set to ' + str(ctrl_reg_value()))
    handle.close()

# set_hw_gain(handle)
#
# Set the gains for both channels.
def set_hw_gain(handle):
    handle.open()
    if cha_gain == 0:
        # Set channel A gain to 1x
        cgrlib.sendcmd(handle,('S P A'))
    elif cha_gain == 1:
        # Set channel A gain to 10x
        cgrlib.sendcmd(handle,('S P a'))
    if chb_gain == 0:
        # Set channel B gain to 1x
        cgrlib.sendcmd(handle,('S P B'))
    elif chb_gain == 1:
        # Set channel B gain to 10x
        cgrlib.sendcmd(handle,('S P b'))
    handle.close()

# trig_level_set(handle)
# 
# Set the trigger level to the global triglev value.
def trig_level_set(handle):
    trig_coeff = 0.052421484375 # Scale factor for trigger
    handle.open()
    if (cha_gain == 0 and trigsrc == 0):
        # Channel A gain is 1x
        trigval = 511 - int(triglev / trig_coeff)
    elif (cha_gain == 1 and trigsrc == 0):
        # Channel A gain is 10x
        trigval = 511 - 10 * int(triglev / trig_coeff)
    elif (chb_gain == 0 and trigsrc == 1):
        # Channel B gain is 1x
        trigval = 511 - int(triglev / trig_coeff)
    elif (chb_gain == 1 and trigsrc == 1):
        # Channel B gain is 10x
        trigval = 511 - 10 * int(triglev / trig_coeff)
    else:
        trigval = 511 # 0V
    trigval_l = int(trigval%(2**8))
    trigval_h = int((trigval%(2**16))/(2**8))
    cgrlib.sendcmd(handle,('S T ' + str(trigval_h) + ' ' + str(trigval_l)))
    handle.close()


    

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
    set_hw_gain(cgr)
    trig_level_set(cgr)
    cgrlib.set_trig_samples(cgr,trigpts)
    ctrl_reg_set(cgr)
    tracedata = cgrlib.get_uncal_data(cgr) # List of uncalibrated
                                           # integer values
    print('* Channel A uncal data')
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
