# cgr_sweep.py
# Plots a transfer function taken with the cgr-101 USB scope
from numpy import *
import serial   # Provides serial class Serial
from serial.tools.list_ports import comports # For getting list of
                                             # serial ports
import time     # For making pauses
import os       # For basic file I/O

# ------------------------- Begin configure ----------------------------

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
term = '\r\n' # String terminator

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


        
        

""" sendcgr(handle,command)
    Send an ascii command string to the CGR scope """
def sendcgr(handle,cmd):
    handle.write(cmd + term)
    time.sleep(0.1) # Don't know if there's a command buffer
    
""" askcgr(handle,command)
    Send an ascii command and return the reply """
def askcgr(handle,cmd):
    sendcgr(handle,cmd)
    try:
        retstr = handle.readline()
        return(retstr)
    except:
        return('No reply')
        
# setamp(handle,amplitude) 
# 
# Set the output amplitude in volts
def setamp(handle,volts):
    handle.open()
    if volts > 3:
        print('Illegal amplitude -- exceeds 3V')
        sendcgr(handle,'W A 255')
    else:
        azero = int(255 * float(volts)/3.0)
        sendcgr(handle,'W A ' + str(azero))
    handle.close()
        
# setfreq(handle,frequency)
#    
# Set the cgr output frequency in Hz
def setfreq(handle,freq):
    handle.open()
    fres = 0.09313225746
    pval = int(freq/fres)
    freqstr = basecon(pval)
    sendstr = ('W F ' + freqstr)
    sendcgr(handle,sendstr)
    handle.close()

# basecon(decimal) 
#
# Converts a decimal number to a 32-bit base-256 number for setting
# the CGR frequency.
def basecon(decimal):
    fthree = int(decimal/(2**24))
    ftwo = int((decimal%(2**24))/(2**16))
    fone = int((decimal%(2**16))/(2**8))
    fzero = int((decimal%(2**8))) 
    retstr = (str(fthree) + ' ' + str(ftwo) + ' ' + str(fone) + ' ' +
        str(fzero))
    return(retstr)  

def main(): 
    cgr = getcgr()
    setamp(cgr,drive)
    for freq in freqlist:
        setfreq(cgr,freq)
        time.sleep( 10.0/freq )


# Execute main() from command line
if __name__ == '__main__':
    main()

    
