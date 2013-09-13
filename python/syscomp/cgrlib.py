# cgrlib.py
#
# Library functions for use with the CGR-101 USB oscilloscope 

import serial   # Provides serial class Serial
import time     # For making pauses
import binascii # For hex string conversion
import pickle # For writing and reading calibration data
import testlib # For colored status messages
import sys # For sys.exit()

# File used to hold the calibration constant dictionary
calfile = 'cgrcal.pkl'


# comports() returns a list of comports available in the system
from serial.tools.list_ports import comports 


cmdterm = '\r\n' # Terminates each command


# write_cal(offlist)
#
# Writes the unit's calibration constants.  The constants are
# currently just offsets, ordered as:
# [ Channel A offset with 1x gain, Channel A offset with 10x gain,
#   Channel B offset with 1x gain, Channel B offset with 10x gain ]
def write_cal(caldict):
    fout = open(calfile,'w')
    pickle.dump(caldict,fout)
    fout.close()

# load_cal()
#
# Loads and returns the calibration constants.  Loads some defaults
# into the calibration dictionary if a calibration file isn't found.
def load_cal():
    try:
        fin = open(calfile,'rb')
        caldict = pickle.load(fin)
        fin.close()
    except:
        caldict = {}
        testlib.infomessage('Failed to open calibration file...using defaults')
        caldict['chA_1x_offset'] = 0
        caldict['chA_1x_gain'] = 0.0445
        caldict['chA_10x_offset'] = 0
        caldict['chA_10x_gain'] = 0.445
        caldict['chB_1x_offset'] = 0
        caldict['chB_1x_gain'] = 0.0445
        caldict['chB_10x_offset'] = 0
        caldict['chB_10x_gain'] = 0.445
    return caldict

# get_cgr() 
#
# Returns an instrument variable for the cgr scope, or an error
# message if the connection fails.
def get_cgr():
    portlist = comports()
    for serport in portlist:
        rawstr = ''
        try:
            cgr = serial.Serial()
            cgr.baudrate = 230400
            cgr.timeout = 0.1 # Set timeout to 100ms
            cgr.port = serport[0]
            cgr.open()
            # If the port can be configured, it might be a CGR.  Check
            # to make sure.
            retnum = cgr.write("i\r\n") # Request the identity string
            rawstr = cgr.read(20) # Read a small number of bytes
            cgr.close()
            if rawstr.count('Syscomp') == 1:
                testlib.passmessage('Connecting to CGR-101 at ' +
                                    str(serport[0]))
                return cgr
            else:
                testlib.infomessage('Could not open ' + serport[0])
                if serport == portlist[-1]: # This is the last port
                    testlib.failmessage('Did not find any CGR-101 units')
                    sys.exit()
        except serial.serialutil.SerialException:
            testlib.infomessage('Could not open ' + serport[0])
            if serport == portlist[-1]: # This is the last port
                testlib.failmessage('Except Did not find any CGR-101 units')
                sys.exit()


# sendcmd(handle,command)
#    
# Send an ascii command string to the CGR scope
def sendcmd(handle,cmd):
    handle.write(cmd + cmdterm)
    testlib.infomessage(cmd)
    time.sleep(0.1) # Don't know if there's a command buffer



# get_samplebits(sample rate)
#
# Given a sample rate in Hz, returns the closest possible hardware
# sample rate setting.  This setting goes in bits 0:3 of the control
# register.
#
# The sample rate is given by (20Ms/s)/2**N, where N is the 4-bit
# value returned by this function.
def get_samplebits(srate):
    baserate = int(20e6) # Maximum sample rate
    ratelist = []
    for nval in range(2**4):
        ratelist.append( int(baserate / ( 2**nval )))
    closeval = min(ratelist, key=lambda x:abs(x - srate))
    setval = ratelist.index(closeval)
    testlib.infomessage('Requested sample rate is ' + 
                        '{:0.3f}'.format(srate/1000) +
                        ' kHz.  Actual rate is ' + 
                        '{:0.3f}'.format(closeval/1000) + ' kHz.')
    return setval

# askcgr(handle, command)
#
# Send a command to the unit and check for a response.
def askcgr(handle,cmd):
    sendcmd(handle,cmd)
    try:
        retstr = handle.readline()
        return(retstr)
    except:
        return('No reply')

# get_state(handle)
#
# Returns the state string from the unit.  The string may be:
# Returned string     Corresponding state
# ---------------------------------------
# State 1             Idle
# State 2             Initializing capture
# State 3             Wait for trigger signal to reset
# State 4             Armed, waiting for capture
# State 5             Capturing
# State 6             Done
def get_state(handle):
    handle.open()
    retstr = askcgr(handle,'S S')
    if (retstr == "No reply"):
        print('getstat: no response')
    handle.close() 
    return retstr

# get_timelist(Desired sample rate)
#
# Returns the list of sample times.  The actual sample rate is first
# calculated.
def get_timelist(fsamp):
    # Calculate the actual sample rate in Hz
    realrate = int(20e6 / ( 2**(get_samplebits(fsamp)) ))
    timelist = []
    for samplenum in range(512):
        timelist.append( samplenum * (1.0/realrate) )
    return timelist


# get_eeprom_offlist(handle)
# 
# Returns the offsets set in eeprom.  The offsets are in signed counts.
#
# [Channel A high range offset, Channel A low range offset,
#  Channel B high range offset, Channel B low range offset]
def get_eeprom_offlist(handle):
    handle.open()
    sendcmd(handle,'S O')
    retdata = handle.read(10)
    handle.close()
    hexdata = binascii.hexlify(retdata)[2:]
    print(hexdata)
    cha_hioff = int(hexdata[0:2],16)
    cha_looff = int(hexdata[2:4],16)
    chb_hioff = int(hexdata[4:6],16)
    chb_looff = int(hexdata[6:8],16)
    # Unsigned decimal list
    udeclist = [cha_hioff, cha_looff, chb_hioff, chb_looff]
    declist = []
    for unsigned in udeclist:
        if (unsigned > 127):
            signed = unsigned - 256
        else:
            signed = unsigned
        declist.append(signed)
    return declist



# set_trig_samples(handle,postpoints)
#
# Sets the number of samples to take after a trigger.  The unit always
# takes 1024 samples.  Setting the post-trigger samples to a value
# less than 1024 means that samples before the trigger will be saved
# instead.
#
# Arguments: Serial object representing CGR-101,
#            Number of points to acquire after the trigger
def set_trig_samples(handle,postpoints):
    handle.open()
    totsamp = 1024
    if (postpoints <= totsamp):
        setval_h = int((postpoints%(2**16))/(2**8))
        setval_l = int((postpoints%(2**8)))
    else:
        setval_h = int((500%(2**16))/(2**8))
        setval_l = int((500%(2**8)))
    sendcmd(handle,('S C ' + str(setval_h) + ' ' + str(setval_l)))
    handle.close()
    
# set_ctrl_reg( handle, fsamp, trigsrc, trigpol )
#
# Sets the CGR-101's control register.
#
# Arguments:
#  handle -- serial object representing the CGR-101
#  fsamp -- requested sample rate in Hz.  The actual rate will be
#           determined using those allowed for the unit.
#  trigsrc -- Which connector the trigger comes in on.
#             0: Channel A
#             1: Channel B
#             2: External trigger pin
#  trigpol -- Which transition the trigger will watch for
#             0: Rising edge
#             1: Falling edge
#
# Returns the register value
def set_ctrl_reg(handle,fsamp,trigsrc,trigpol):
    reg_value = 0
    reg_value += get_samplebits(fsamp) # Set sample rate
    # Configure the trigger source
    if trigsrc == 0: # Trigger on channel A
        reg_value += (0 << 4)
    elif trigsrc == 1: # Trigger on channel B
        reg_value += (1 << 4)
    elif trigsrc == 2: # Trigger on external input
        reg_value += (1 << 6)
    # Configure the trigger polarity
    if trigpol == 0: # Rising edge
        reg_value += (0 << 5)
    elif trigpol == 1: # Falling edge
        reg_value += (1 << 5)
    handle.open()
    sendcmd(handle,('S R ' + str(reg_value)))
    handle.close()
    return reg_value

# set_hw_gain( handle, gainlist)
#
# Sets the CGR-101's hardware gain.  I don't think there's actually a
# switched voltage divider at the inputs.  Rather, I think this switch
# just applies an extra gain factor to measurements.  This is useful
# to accomodate things like scope probes.
#
# Arguments:
#  handle -- serial object representing the CGR-101
#  gainlist -- [cha_gain, chb_gain]
#
#  ...where the gain values are:
#  cha_gain -- Set the gain for channel A
#              0: Set 1x gain
#              1: Set 10x gain (for use with a 10x probe)
#  chb_gain -- Set the gain for channel B
#              0: Set 1x gain
#              1: Set 10x gain (for use with a 10x probe)
#
# Returns the gainlist: [cha_gain, chb_gain]
def set_hw_gain(handle,gainlist):
    handle.open()
    if gainlist[0] == 0: # Set channel A gain to 1x
        sendcmd(handle,('S P A'))
    elif gainlist[0] == 1: # Set channel A gain to 10x
        sendcmd(handle,('S P a'))
    if gainlist[1] == 0: # Set channel B gain to 1x
        sendcmd(handle,('S P B'))
    elif gainlist[1] == 1: # Set channel B gain to 10x
        sendcmd(handle,('S P b'))
    handle.close()
    return gainlist

# get_trig_dict( trigsrc, triglev, trigpol, trigpts )
#
# Make a dictionary of trigger settings.
#
# Arguments:
#  trigsrc -- Trigger source
#             0: Channel A
#             1: Channel B
#             2: External
#  triglev -- Trigger voltage (floating point volts)
#  trigpol -- Trigger slope
#             0: Rising
#             1: Falling
#  trigpts -- Points to acquire after trigger (0 --> 1024)
def get_trig_dict( trigsrc, triglev, trigpol, trigpts ):
    trigdict = {}
    trigdict['trigsrc'] = trigsrc
    trigdict['triglev'] = triglev
    trigdict['trigpol'] = trigpol
    trigdict['trigpts'] = trigpts
    return trigdict



# set_trig_level( handle, caldict, gainlist, trigsrc, triglev )
#
# Sets the trigger voltage.
#
# Arguments:
#  handle -- serial object representing the CGR-101
#  caldict -- dictionary of slope and offset values
#  gainlist -- [cha_gain, chb_gain]
#  trigsrc -- Which connector the trigger comes in on.
#             0: Channel A
#             1: Channel B
#             2: External trigger pin
#  triglev -- The trigger level in volts
def set_trig_level(handle, caldict, gainlist, trigsrc, triglev):
    handle.open()
    if (gainlist[0] == 0 and trigsrc == 0): # Channel A gain is 1x
        trigcts = (511 - caldict['chA_1x_offset'] - 
                   float(triglev)/caldict['chA_1x_gain'])
    elif (gainlist[0] == 1 and trigsrc == 0): # Channel A gain is 10x
        trigcts = (511 - caldict['chA_10x_offset'] - 
                   float(triglev)/caldict['chA_10x_gain'])
    elif (gainlist[1] == 0 and trigsrc == 1): # Channel B gain is 1x
        trigcts = (511 - caldict['chB_1x_offset'] - 
                   float(triglev)/caldict['chB_1x_gain'])
    elif (gainlist[1] == 1 and trigsrc == 1): # Channel B gain is 10x
        trigcts = (511 - caldict['chB_10x_offset'] - 
                   float(triglev)/caldict['chB_10x_gain'])
    else:
        trigcts = 511 # 0V
    trigcts_l = int(trigcts%(2**8))
    trigcts_h = int((trigcts%(2**16))/(2**8))
    sendcmd(handle,('S T ' + str(trigcts_h) + ' ' + str(trigcts_l)))
    handle.close()



# get_uncal_triggered_data(handle, trigdict)
#
# Arguments:
#  handle -- serial object representing the CGR-101
#  trigdict -- dictionary of trigger settings
# 
# Returns 
#  Uncalibrated integer data and the trigger position: 
#  [ A channel data, B channel data, trigpos]
# 
# The trigger position is the position in the circular buffer where
# the trigger happened.  Each channel has 512 samples, and the trigger
# position seems to be counted from the 0th position of one channel.
def get_uncal_triggered_data(handle, trigdict):
    handle.open()
    sendcmd(handle,'S G') # Start the capture
    sys.stdout.write('Waiting for ' + '{:0.1f}'.format(trigdict['triglev']) +
                     'V trigger at ')
    if trigdict['trigsrc'] == 0:
        print('input A...')
    elif trigdict['trigsrc'] == 1:
        print('input B...')
    elif trigdict['trigsrc'] == 2:
        print('external input...')
    retstr = ' '
    # The unit will reply with 3 bytes when it's done capturing data.
    # Wait on those three bytes.
    while len(retstr) < 3:
        retstr = handle.read(10)
    hexret = binascii.hexlify(retstr)
    # trigpos is the position of the trigger sample in datapoints from
    # the beginning of the data array
    trigpos = int(hexret[2:],16) - trigdict['trigpts']
    print('Ending address is ' + hexret[2:])
    print('This is ' + str(int(hexret[2:],16)))
    sendcmd(handle,'S B') # Query the data
    retdata = handle.read(10000)
    hexdata = binascii.hexlify(retdata)[2:]
    testlib.infomessage('Got ' + str(len(hexdata)/2) + ' bytes')
    handle.close()
    bothdata = [] # Alternating data from both channels
    adecdata = [] # A channel data
    bdecdata = [] # B channel data 
    # Data returned from the unit has alternating words of channel A
    # and channel B data.  Each word is 16 bits (two hex characters)
    for samplenum in range(1024):
        sampleval = int(hexdata[(samplenum*4):(samplenum*4 + 4)],16)
        bothdata.append(sampleval)
    adecdata = bothdata[0::2]
    bdecdata = bothdata[1::2]
    return [adecdata,bdecdata,trigpos]

# reset( handle )
# Perform a hardware reset
def reset(handle):
    handle.open()
    sendcmd(handle,('S D 1' )) # Force the reset
    sendcmd(handle,('S D 0' )) # Return to normal
    handle.close()


# force_trigger( handle, ctrl_reg )
#
# Force a trigger.  Set bit 6 of the control register to configure
# triggering via the external input, then send a debug code to force
# the trigger.
#
# Arguments:
#  handle -- serial object representing the CGR-101
#  ctrl_reg -- value of the control register
def force_trigger(handle, ctrl_reg):
    old_reg = ctrl_reg
    new_reg = ctrl_reg | (1 << 6)
    handle.open()
    sendcmd(handle,'S G') # Start the capture
    sendcmd(handle,('S R ' + str(new_reg))) # Ready for forced trigger
    testlib.infomessage('Forcing trigger')
    sendcmd(handle,('S D 5' )) # Force the trigger
    sendcmd(handle,('S D 4' )) # Return to normal triggering
    # Put the control register back the way it was
    sendcmd(handle,('S R ' + str(old_reg)))
    handle.close()
    

# get_uncal_forced_data(handle, ctrl_reg)
#
# Arguments:
#  handle -- serial object representing the CGR-101
#  ctrl_reg -- value of the control register
#            
# Returns uncalibrated integer data from the unit.  Returns two lists
# of data:
# [ A channel data, B channel data]
def get_uncal_forced_data(handle,ctrl_reg):
    force_trigger(handle, ctrl_reg)
    handle.open()
    sendcmd(handle,'S B') # Query the data
    retdata = handle.read(5000)
    hexdata = binascii.hexlify(retdata)[2:]
    handle.close()
    bothdata = [] # Alternating data from both channels
    adecdata = [] # A channel data
    bdecdata = [] # B channel data 
    # Data returned from the unit has alternating words of channel A
    # and channel B data.  Each word is 16 bits (two hex characters)
    for samplenum in range(1024):
        sampleval = int(hexdata[(samplenum*4):(samplenum*4 + 4)],16)
        bothdata.append(sampleval)
    adecdata = bothdata[0::2]
    bdecdata = bothdata[1::2]
    return [adecdata,bdecdata]


# get_cal_data(caldict,gainlist,rawdata)
#
# Convert raw data points to voltages.  Return the list of voltages.
#
# The raw data list contains samples from both channels.
def get_cal_data(caldict,gainlist,rawdata):
    if gainlist[0] == 0:
        # Channel A has 1x gain
        chA_slope = caldict['chA_1x_slope']
        chA_offset = caldict['chA_1x_offset']
    elif gainlist[0] == 1:
        # Channel A has 10x gain
        chA_slope = caldict['chA_10x_slope']
        chA_offset = caldict['chA_10x_offset']
    if gainlist[1] == 0:
        # Channel B has 1x gain
        chB_slope = caldict['chB_1x_slope']
        chB_offset = caldict['chB_1x_offset']
    elif gainlist[1] == 1:
        # Channel B has 10x gain
        chB_slope = caldict['chB_10x_slope']
        chB_offset = caldict['chB_10x_offset']
    # Process channel A data
    cha_voltdata = []
    for sample in rawdata[0]:
        cha_voltdata.append((511 - (sample + chA_offset))*chA_slope)
    # Process channel B data
    chb_voltdata = []
    for sample in rawdata[1]:
        chb_voltdata.append((511 - (sample + chB_offset))*chB_slope)
    return [cha_voltdata,chb_voltdata]
