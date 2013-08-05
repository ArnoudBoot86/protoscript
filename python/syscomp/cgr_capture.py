# cgr_capture.py
#
# Captures one buffer of data from the cgr-101 USB scope

import serial   # Provides serial class Serial
from serial.tools.list_ports import comports # For getting list of
                                             # serial ports
import time     # For making pauses
import os       # For basic file I/O
import binascii

#--------------------- Begin configure --------------------

triglev = 0.1 # Volts -- the trigger level
trigsrc = 0 # 0: Channel A, 1: Channel B, 2: External
trigpol = 0 # 0: Rising,    1: Falling
trigpts = 500 # The number of points to capture after trigger
fsamp = 1e4 # Hz -- the sample rate
cha_gain = 1 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )
chb_gain = 1 # 0: 1x gain ( +/-25V max ), 1: 10x gain ( +/-2.5V max )

#---------------------- End configure ---------------------

cmdterm = '\r\n' # Terminates each command


# getcgr() 
#
# Returns an instrument variable for the cgr scope, or an error
# message if the connection fails.
def getcgr():
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
def sendcgr(handle,cmd):
    handle.write(cmd + cmdterm)
    time.sleep(0.1) # Don't know if there's a command buffer

# askcgr(handle,command)
#
# Send an ascii command and return the reply
def askcgr(handle,cmd):
    sendcgr(handle,cmd)
    try:
        retstr = handle.readline()
        return(retstr)
    except:
        return('No reply')

# ctrl_reg_val()
#
# Compute the control register value.  We have to keep track of the
# control register value in between writes.
#
# Returns the control register value.
def ctrl_reg_value():
    reg_value = 0
    reg_value += samplebits(fsamp) # Set sample rate
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
    sendcgr(handle,('S R ' + str(ctrl_reg_value())))
    print('Control register set to ' + str(ctrl_reg_value()))
    handle.close()

# gain_set(handle)
#
# Set the gains for both channels.
def gain_set(handle):
    handle.open()
    if cha_gain == 0:
        # Set channel A gain to 1x
        sendcgr(handle,('S P A'))
    elif cha_gain == 1:
        # Set channel A gain to 10x
        sendcgr(handle,('S P a'))
    if chb_gain == 0:
        # Set channel B gain to 1x
        sendcgr(handle,('S P B'))
    elif chb_gain == 1:
        # Set channel B gain to 10x
        sendcgr(handle,('S P b'))
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
    sendcgr(handle,('S T ' + str(trigval_h) + ' ' + str(trigval_l)))
    handle.close()

# trig_samples_set(handle)
#
# Sets the number of samples to take after a trigger.  The unit always
# takes 1024 samples.  Setting the post-trigger samples to a value
# less than 1024 means that samples before the trigger will be saved
# instead.
def trig_samples_set(handle):
    handle.open()
    totsamp = 1024
    if (trigpts <= totsamp):
        setval_h = int((trigpts%(2**16))/(2**8))
        setval_l = int((trigpts%(2**8)))
    else:
        setval_h = int((500%(2**16))/(2**8))
        setval_l = int((500%(2**8)))
    sendcgr(handle,('S C ' + str(setval_h) + ' ' + str(setval_l)))
    handle.close()
    


# samplebits(sample rate)
#
# Given a sample rate in Hz, returns the closest possible hardware
# sample rate setting.  This setting goes in bits 0:3 of the control
# register.
#
# The sample rate is given by (20Ms/s)/2**N, where N is the 4-bit
# value returned by this function.
def samplebits(srate):
    baserate = int(20e6) # Maximum sample rate
    ratelist = []
    for nval in range(2**4):
        ratelist.append( int(baserate / ( 2**nval )))
    closeval = min(ratelist, key=lambda x:abs(x - srate))
    setval = ratelist.index(closeval)
    return setval
    
# getstat(handle)
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
def getstat(handle):
    handle.open()
    retstr = askcgr(handle,'S S')
    if (retstr == "No reply"):
        print('getstat: no response')
    handle.close() 
    return retstr

# getdata(handle)
# 
# Returns data from the unit
def getdata(handle):
    handle.open()
    sendcgr(handle,'S G') # Start the capture
    print('Waiting for capture to finish...')
    retstr = ' '
    # The unit will reply with 3 bytes when it's done capturing data.
    # Wait on those three bytes.
    while len(retstr) < 3:
        retstr = handle.read(10)
    sendcgr(handle,'S B') # Query the data
    retdata = handle.read(5000)
    print('Got data length ' + str(len(retdata)))
    hexdata = binascii.hexlify(retdata)[2:]
    print(hexdata[0:10])
    handle.close()
    decdata = []
    for samplenum in range(1024):
        highbyte = hexdata[(samplenum*4):((samplenum*4)+2)]
        lowbyte = hexdata[((samplenum*4)+2):((samplenum*4)+4)] 
        sampleval = (int(highbyte,16) << 8 ) + int(lowbyte,16)
        decdata.append(sampleval)

    
    print(decdata[0:]) 
    return decdata

# caldata(declist)
#
# Convert the list of decimal data points to voltages.  Return the
# list of voltages.
#
# The decimal data list contains samples from both channels.  Channel
# A samples are at odd indexes, and channel B samples are at even
# indexes.
def caldata(decdata):
    cha_voltdata = []
    if cha_gain == 0:
        # Channel A has 1x gain
        cha_adStepSize = 0.00592
    elif cha_gain == 1:
        # Channel A has 10x gain
        cha_adStepSize = 0.0521
    for sample in decdata[0::2]:
        cha_voltdata.append((511 - sample)*cha_adStepSize)
    return cha_voltdata

# getoffset(handle)
def getoffset(handle):
    handle.open()
    sendcgr(handle,'S O')
    offdata = handle.read(10)
    handle.close()
        




def main(): 
    cgr = getcgr()
    gain_set(cgr)
    trig_level_set(cgr)
    trig_samples_set(cgr)
    ctrl_reg_set(cgr)
    tracedata = getdata(cgr) # List of uncalibrated decimal values
    voltdata = caldata(tracedata) # List of voltages
    print(voltdata[0:])


# Execute main() from command line
if __name__ == '__main__':
    main()
