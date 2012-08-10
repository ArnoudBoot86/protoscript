""" ds345.py
    A collection of functions useful for testing with the ds345 """
import visa
import math
import decimal as D

#--------------------- Instrument-specific variables -------------------
gpibchan = 19
#-----------------------------------------------------------------------


""" gethandle(GPIB channel)
    Return a handle for gpib communications with the ds345 """
def gethandle(gpibchan):
    try:
        ds345 = visa.instrument('GPIB::' + str(gpibchan))
        print('DS345 ready on gpib channel ' + str(gpibchan))
        return ds345
    except:
        print('DS345 not found on gpib channel ' + str(gpibchan))

""" sendbus(handle)
    Send an ascii command to the ds345 over the gpib bus """
def sendbus(handle,string):
    handle.write(string)
    return

""" onesquare(handle, frequency (Hz), Vpp (volts))
    *   Get the ds345 ready to send one period of a square wave with specified
        frequency and peak-to-peak voltage (into high-z)
    *   Send a bus trigger to actually start the output.  This is just a
        setup function. """
def onesquare(handle,freq,vpp):
    sendbus(handle,'freq ' + '%0.3f'%(freq))
    sendbus(handle,'ampl ' + '%0.3f'%(vpp) + 'VP')
    sendbus(handle,'func 1') # Set square wave output
    sendbus(handle,'offs 0') # No offset
    sendbus(handle,'pclr') # Waveform output starts with phase zero
    sendbus(handle,'mena 1') # Enable modulation
    sendbus(handle,'mtyp 5') # Set burst modulation
    sendbus(handle,'bcnt 1') # One burst
    sendbus(handle,'tsrc 0') # Single trigger -- *TRG triggers the burst
    print('Send *TRG to trigger the burst.')
    
""" squareout(handle, frequency (Hz), Vpp (volts))
    *   Set up the ds345 to output a square wave """
def squareout(handle,freq,vpp):
    sendbus(handle,'freq ' + '%0.3f'%(freq))
    sendbus(handle,'ampl ' + '%0.3f'%(vpp) + 'VP')
    sendbus(handle,'func 1') # Set square wave output
    sendbus(handle,'offs 0') # No offset
    sendbus(handle,'pclr') # Waveform output starts with phase zero
    
""" dcvolt(handle, DC voltage (volts))
    *   Uses the DS345 as a DC voltage source, with -10V to 10V available.
        The voltage takes about 1/2 second to set up, so this isn't for
        making square waves. 
    *   Remember that these are voltages into high impedance, with a 50ohm
        output resistor inside the DS345. """
def dcvolt(handle, voltage):
    voltage = D.Decimal(voltage)
    if voltage < 0:
        isneg = True
    else:
        isneg = False
    absvolt = math.fabs(voltage)
    sendbus(handle,'freq 1')
    sendbus(handle,'ampl ' + '%0.3f'%(absvolt) + 'VP')
    sendbus(handle,'func 1') # Set square wave output
    sendbus(handle,'tsrc 0') # Set single trigger
    sendbus(handle,'offs 0') # No offset
    sendbus(handle,'mena 1') # Enable modulation
    sendbus(handle,'mtyp 5') # Set burst modulation
    if isneg:
        sendbus(handle,'phse 180')
    else:
        sendbus(handle,'phse 0')
