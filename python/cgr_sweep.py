# cgr_sweep.py
# Plots a transfer function taken with the cgr-101 USB scope
from numpy import *
import Gnuplot, Gnuplot.funcutils
import socket   # For TCP/IP sockets
# import visa     # For GPIB or RS-232
import serial   # From pyserial package
import time     # For making pauses
import os       # For basic file I/O

# ------------------------- Begin configure ----------------------------

baud = 230400   # Baud rate
devpath = '/dev/ttyUSB1'
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

""" getcgr() 
    Returns an instrument variable for the cgr scope, or an error message
    if the connection fails. """
def getcgr():
    try:
        cgr = serial.Serial(devpath)
        cgr.timeout = 1 # Timeout in seconds
        cgr.baudrate = baud
        return cgr
    except:
        print('Cannot connect to cgr-101 at ' + devpath)

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
        
""" setamp(handle,amplitude)
    Set the output amplitude in volts """
def setamp(handle,volts):
    if volts > 3:
        print('Illegal amplitude -- exceeds 3V')
        sendcgr(handle,'W A 255')
    else:
        azero = int(255 * float(volts)/3.0)
        sendcgr(handle,'W A ' + str(azero))
        
""" setfreq(handle,frequency)
    Set the cgr output frequency in Hz """
def setfreq(handle,freq):
    fres = 0.09313225746
    pval = int(freq/fres)
    freqstr = basecon(pval)
    sendstr = ('W F ' + freqstr)
    sendcgr(handle,sendstr)

""" Converts a decimal number to a 32-bit base-256 number for setting the 
    CGR frequency. """
def basecon(decimal):
    fthree = int(decimal/(2**24))
    ftwo = int((decimal%(2**24))/(2**16))
    fone = int((decimal%(2**16))/(2**8))
    fzero = int((decimal%(2**8))) 
    retstr = (str(fthree) + ' ' + str(ftwo) + ' ' + str(fone) + ' ' +
        str(fzero))
    return(retstr)   

    
