# cgrlib.py
#
# Library functions for use with the CGR-101 USB oscilloscope 

import serial   # Provides serial class Serial
import time     # For making pauses
import binascii # For hex string conversion


# comports() returns a list of comports available in the system
from serial.tools.list_ports import comports 

#------------------- Configure logging -------------------
import logging
logger = logging.getLogger(__name__)

cmdterm = '\r\n' # Terminates each command


# get_cgr() 
#
# Returns an instrument variable for the cgr scope, or an error
# message if the connection fails.
def get_cgr():
    for serport in comports():
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
                return cgr
        except:
            print('Could not open ' + serport[0])


# sendcgr(handle,command)
#    
# Send an ascii command string to the CGR scope
def sendcmd(handle,cmd):
    handle.write(cmd + cmdterm)
    time.sleep(0.1) # Don't know if there's a command buffer


# askcgr(handle,command)
#
# Send an ascii command and return the reply
def askcgr(handle,cmd):
    sendcmd(handle,cmd)
    try:
        retstr = handle.readline()
        return(retstr)
    except:
        return('No reply')



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
    print('* Sample rate is ' + str(closeval))
    return setval

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


# get_offlist(handle)
# 
# Returns the offsets set in eeprom.  The offsets are in signed counts.
#
# [Channel A high range offset, Channel A low range offset,
#  Channel B high range offset, Channel B low range offset]
def get_offlist(handle):
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

# get_uncal_data(handle)
#
# Arguments: Serial object representing CGR-101
# 
# Returns uncalibrated integer data from the unit.  Returns two lists
# of data:
# [ A channel data, B channel data]
def get_uncal_data(handle):
    handle.open()
    sendcmd(handle,'S G') # Start the capture
    print('Waiting for capture to finish...')
    retstr = ' '
    # The unit will reply with 3 bytes when it's done capturing data.
    # Wait on those three bytes.
    while len(retstr) < 3:
        retstr = handle.read(10)
    sendcmd(handle,'S B') # Query the data
    retdata = handle.read(5000)
    print('Got data length ' + str(len(retdata)))
    hexdata = binascii.hexlify(retdata)[2:]
    print(hexdata[0:10])
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
    
