# sr830.py
# Functions related to controlling the SR830 lock-in
import visa

# get830(channel)
# Set up gpib for sr830
def get830(channel):
    try:
        sr830 = visa.instrument('GPIB::' + str(channel))
        print('SR830 ready on gpib channel ' + str(channel))
        return sr830
    except:
        print('SR830 not found on gpib channel ' + str(channel))
        
# send830
# Send an ascii command to the sr830.  sr830 is the handle output by 
# get830()       
def send830(sr830,cmdstr):
    sr830.write(cmdstr)

# check_init(sr830)
# Initializes the sr830 for the basic checkout test described in ectest.
# sr830 is the handle output by get830().
def check_init(sr830):
    send830('fmod 1') # Set reference source (1: internal)
    send830('freq 1000') # Set drive frequency (Hz)
    send830('slvl 0.5') # Set drive amplitude (Volts)
    send830('harm 1') # Set measurement harmonic
    send830('isrc 0') # Set input (0:A)


    
    

