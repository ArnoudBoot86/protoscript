""" hp34401a.py
    Functions related to controlling the hp34401a multimeter """
import visa
import decimal as D

#--------------------- Instrument-specific variables -------------------
gpibchan = 24
timeout = 1 # Seconds (set to at least 1)
#-----------------------------------------------------------------------


""" gethandle(GPIB channel)
    Return a handle for gpib communications with the hp34401a """
def gethandle(gpibchan):
    try:
        dmm = visa.instrument('GPIB::' + str(gpibchan))
        print('HP34401A ready on gpib channel ' + str(gpibchan))
        dmm.timeout = timeout
        return dmm
    except:
        print('HP34401A not found on gpib channel ' + str(gpibchan))
        
""" sendbus(handle)
    Send an ascii command to the hp34401a over the gpib bus """
def sendbus(handle,string):
    handle.write(string)
    return

""" flusherr(handle)
    Flush out existing errors and the send/recieve queue """
def flusherr(handle):
    # Clear out the receive queue
    while True:
        try:
            dummy = handle.ask('\r')
        except:
            # Nothing to read -- the queue is empty
            break
    err = handle.ask('system:error?')
    # Clear out the error queue
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
        ',' + '%0.4f'%(D.Decimal(resolution)/1000))
    sendbus(handle,'sens:volt:dc:nplc 10') # Integrate for 10 line cycles
    sendbus(handle,'trig:sour bus')
    sendbus(handle,'samp:coun 1')

""" getmeas(handle)
    Get the last measurement. """
def getmeas(handle):
    sendbus(handle,'samp:coun 1')
    sendbus(handle,'init') # Set the wait for trigger state
    sendbus(handle,'*TRG') # Trigger the DMM
    reading = handle.ask('fetch?')
    return reading
    
""" dumread(handle,readnum)
    Reads the DMM a few times to remove previous data. """
def dumread(handle,readnum):
    for read in range(readnum):
        value = getmeas(handle)
    return
    

    
    
    
    

