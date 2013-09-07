# cgr_cal.py
#
# Automates slope and offset calibration

import testlib # For colored status messages
import cgrlib

# For the Gnuplot module
from numpy import * # For gnuplot.py
import Gnuplot, Gnuplot.funcutils # For gnuplot.py

# Use this option to turn off fifo if you get warnings like:
# line 0: warning: Skipping unreadable file "/tmp/tmpakexra.gnuplot/fifo"
Gnuplot.GnuplotOpts.prefer_fifo_data = 0


#--------------------- Begin configure --------------------

fsamp = 1e5 # Hz -- the sample rate.  For calibration, this just
            # affects how long the DC voltage is sampled.

# Choose the gains to calibrate with.  Calibration coefficients for
# other gains will be left alone.  10x gains are for use with 10x
# scope probes.
cha_gain = 0 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )
chb_gain = 0 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )

calvolt = 3.3 # Volts -- the voltage used for calibrating gain.

#---------------------- End configure ---------------------


# get_offcal_data(caldict,gainlist,rawdata)
#
# Correct raw data for offset only.
def get_offcal_data(caldict, gainlist, rawdata):
    if gainlist[0] == 0: # Channel A has 1x gain
        chA_offset = caldict['chA_1x_offset']
    elif gainlist[0] == 1: # Channel A has 10x gain
        chA_offset = caldict['chA_10x_offset']
    if gainlist[1] == 0: # Channel B has 1x gain
        chB_offset = caldict['chB_1x_offset']
    elif gainlist[1] == 1: # Channel B has 10x gain
        chB_offset = caldict['chB_10x_offset']
    # Process channel A data
    cha_voltdata = []
    for sample in rawdata[0]:
        cha_voltdata.append(511 - (sample + chA_offset))
    # Process channel B data
    chb_voltdata = []
    for sample in rawdata[1]:
        chb_voltdata.append(511 - (sample + chB_offset))
    return [cha_voltdata,chb_voltdata]


# get_offsets(handle, ctrl_reg, gainlist, caldict)
#
# Walks you through the calibration of both channel offsets using the
# current gain settings.
#
# Arguments:
#  handle -- serial object representing the CGR-101
#  ctrl_reg -- value of the control register
#  gainlist -- [cha_gain, chb_gain]
#  caldict -- Dictionary of all calibration values
#
# Calibrated data is calculated with:
# volts = (511 - (rawdata + offset)) * slopevalue
# ...so offsets are calculated with:
# offset = 511 - rawdata
#
# Returns the calibration factor dictionary with the relevant offset
# factors filled in.
def get_offsets(handle, ctrl_reg, gainlist, caldict):
    offset_list = []
    gainlist = cgrlib.set_hw_gain(handle,gainlist)
    rawdata = cgrlib.get_uncal_forced_data(handle,ctrl_reg)
    for channel in range(2):
        offset_list.append(511 - average(rawdata[channel]))
    if gainlist[0] == 0: # Channel A set for 1x gain
        caldict['chA_1x_offset'] = offset_list[0]
    elif gainlist[0] == 1: # Channel A set for 10x gain
        caldict['chA_10x_offset'] = offset_list[0] 
    if gainlist[1] == 0: # Channel B set for 1x gain
        caldict['chB_1x_offset'] = offset_list[1]
    elif gainlist[1] == 1: # Channel B set for 10x gain
        caldict['chB_10x_offset'] = offset_list[1]
    return caldict


# get_slopes(handle, ctrl_reg, gainlist, caldict, calvolt)
#
# Fills in slope values for whatever gain is set. 
#
# To calibrate using the 10x gain settings, you should really be using
# a 10x scope probe.
#
# Calibrated data is calculated with:
# volts = (511 - (rawdata + offset)) * slopevalue
# ...so slopes are calculated with:
# slope = calvolt/(offset corrected data)
#
# Arguments:
#  handle -- serial object representing the CGR-101
#  ctrl_reg -- value of the control register
#  gainlist -- [cha_gain, chb_gain]
#  caldict -- Dictionary of all calibration values
#  calvolt -- The voltage used during slope calibration
def get_slopes(handle, ctrl_reg, gainlist, caldict, calvolt):
    slope_list = []
    gainlist = cgrlib.set_hw_gain(handle,gainlist)
    rawdata = cgrlib.get_uncal_forced_data(handle,ctrl_reg)
    offcal_data = get_offcal_data(caldict,gainlist,rawdata)
    for channel in range(2):
        slope_list.append(calvolt/(average(offcal_data[channel])))
    if gainlist[0] == 0: # Channel A set for 1x gain
        caldict['chA_1x_slope'] = slope_list[0]
    elif gainlist[0] == 1: # Channel A set for 10x gain
        caldict['chA_10x_slope'] = slope_list[0] 
    if gainlist[1] == 0: # Channel B set for 1x gain
        caldict['chB_1x_slope'] = slope_list[1]
    elif gainlist[1] == 1: # Channel B set for 10x gain
        caldict['chB_10x_slope'] = slope_list[1]
    return caldict
    

# plotdata()
#
# Plot data from both channels to show calibration accuracy.
def plotdata(voltdata):
    # Set debug=1 to print gnuplot commands to stdout
    gplot = Gnuplot.Gnuplot(debug=0)
    gplot('set terminal x11')
    gplot('set title "Data"')
    gplot('set style data lines')
    gplot('set key bottom left')
    gplot.xlabel('Time (s)')
    gplot.ylabel('Voltage (V)')
    gplot("set format x '%0.0s %c'")
    gplot('set pointsize 1')
    timedata = cgrlib.get_timelist(fsamp)
    gdata_cha = Gnuplot.PlotItems.Data(
        timedata,voltdata[0],title='Channel A')
    gdata_chb = Gnuplot.PlotItems.Data(
        timedata,voltdata[1],title='Channel B')
    gplot.plot(gdata_cha,gdata_chb)
    raw_input('* Press return to exit...')


def main(): 
    caldict = cgrlib.load_cal()
    cgr = cgrlib.get_cgr()
    ctrl_reg = cgrlib.set_ctrl_reg(cgr,fsamp,0,0)
    gainlist = cgrlib.set_hw_gain(cgr,[cha_gain,chb_gain])
    
    # Start the offset calibration
    raw_input('* Remove all inputs and press return...')
    caldict = get_offsets(cgr, ctrl_reg, gainlist, caldict)

    # Start the slope calibration
    raw_input('* Connect ' + '{:0.3f}'.format(calvolt) +
              'V calibration voltage and press return...')
    caldict = get_slopes(cgr, ctrl_reg, gainlist, caldict, calvolt)

    # Test calibration
    raw_input('* Ready to test calibration...')
    tracedata = cgrlib.get_uncal_forced_data(cgr,ctrl_reg)
    # Get calibrated volts
    voltdata = cgrlib.get_cal_data(caldict,gainlist,tracedata)
    plotdata(voltdata)
    # Write the calibration data
    cgrlib.write_cal(caldict)


# Execute main() from command line
if __name__ == '__main__':
    main()
