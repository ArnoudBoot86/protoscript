# hp34401.py
# Functions related to controlling the hp34401 multimeter
import visa

# getdmm(channel)
# Takes a GPIB channel, returns the handle to the GPIB instrument
def getdmm(channel):
    try:
        dmm = visa.instrument('GPIB::' + str(channel))
        print('DMM ready on gpib channel ' + str(channel))
        return dmm
    except:
        print('DMM not found on gpib channel ' + str(channel))
        
# sendmm
# Send an ascii command to the dmm.  dmm is the handle output by 
# getdmm()       
def sendmm(dmm,cmdstr):
    dmm.write(cmdstr)

# Flush out the existing errors
def flusherr(dmm):
    err = dmm.ask('system:error?')
    while err.split(',')[1] != '"No error"':
        err = dmm.ask('system:error?')

# rmeasinit(handle)
# Configures the DMM to measure 2-wire resistance.  The handle argument
# is the dmm object created by getdmm()
def rmeasinit(dmm):
    sendmm(dmm,'conf:res 1e3,1')
    sendmm(dmm,'trig:sour bus')
    sendmm(dmm,'samp:coun 1')
    
# vmeasinit(handle)
# Configures the DMM to measure volts from the front panel.  The handle
# argument is the dmm object created by getdmm()
def vmeasinit(dmm):
    sendmm(dmm,'conf:volt:dc 0.1,1e-4')
    sendmm(dmm,'trig:sour bus')
    sendmm(dmm,'samp:coun 1')

# getmeas(handle)
# Get the measurement set up with rmeasinit()
def getmeas(dmm):
    sendmm(dmm,'init') # Set the wait for trigger state
    sendmm(dmm,'*TRG') # Trigger the DMM
    reading = dmm.ask('fetch?')
    return reading
    
    
    

