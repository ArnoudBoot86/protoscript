# hp4192a.py
# Functions related to the hp4192a impedance analyzer, also called
# a frequency response analyzer (fra)
import visa

# getfra(channel)
# Takes a GPIB channel, returns the handle to the fra
def getfra(channel):
    try:
        fra = visa.instrument('GPIB::' + str(channel))
        print('FRA ready on gpib channel ' + str(channel))
        return fra
    except:
        print('FRA not found on gpib channel ' + str(channel))
        
# sendfra
# Send an ascii command to the dmm.  dmm is the handle output by 
# getdmm()       
def sendfra(handle,cmdstr):
    handle.write(cmdstr)

# flusherr(handle)
# Clears the error queue
def flusherr(fra):
    
    
