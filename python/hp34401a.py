""" hp34401a.py
    Functions related to controlling the hp34401a multimeter """
import visa

""" gethandle(GPIB channel)
    Return a handle for gpib communications with the hp34401a """
def gethandle(gpibchan):
    try:
        dmm = visa.instrument('GPIB::' + str(gpibchan))
        print('HP34401A ready on gpib channel ' + str(gpibchan))
        return dmm
    except:
        print('HP34401A not found on gpib channel ' + str(gpibchan))
        
""" sendbus(handle)
    Send an ascii command to the hp34401a over the gpib bus """
def sendbus(handle,string):
    handle.write(string)
    return

""" flusherr(handle)
    Flush out the existing errors """
def flusherr(handle):
    err = handle.ask('system:error?')
    while err.split(',')[1] != '"No error"':
        err = handle.ask('system:error?')

# rmeasinit(handle)
# Configures the DMM to measure 2-wire resistance.  The handle argument
# is the dmm object created by getdmm()
def rmeasinit(dmm):
    sendmm(dmm,'conf:res 1e3,1')
    sendmm(dmm,'trig:sour bus')
    sendmm(dmm,'samp:coun 1')
    
""" onevmeas(handle, vrange (volts), resolution (mV))
    *  Configures the DMM to measure volts from the front panel. 
    *  The range and resolution parameters don't have to match the DMM's
    ranges -- the meter will pick the best range."""
def onevmeas(handle,vrange,resolution):
    sendbus(handle,'conf:volt:dc ' + '%0.3f'%(vrange) +
        ',' + '%0.4f'%(resolution))
    sendbus(handle,'trig:sour bus')
    sendbus(handle,'samp:coun 1')

""" getmeas(handle)
    Get the last measurement. """
def getmeas(handle):
    sendbus(handle,'init') # Set the wait for trigger state
    sendbus(handle,'*TRG') # Trigger the DMM
    reading = handle.ask('fetch?')
    return reading
    
    
    

