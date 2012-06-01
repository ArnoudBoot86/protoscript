# checkout.py
# Performs some basic tests on the rev G ec100
# !!! This code is only for rev G hardware !!!
import socket
import visa
import time

# Choose your ec100
# host = '172.25.128.112'
host = '172.25.128.113'
# host = '172.25.128.114' # Bob's
# host = '172.25.128.115' # Ken's
# host = '172.25.128.116'
# host = '172.25.128.34' # Igor's

port = 1680
term = '\r\n' #String terminator


# Choose your sr830 on the gpib bus
sr830ch = 30

# Set up gpib for sr830
def get830():
    try:
        sr830 = visa.instrument('GPIB::' + str(sr830ch))
        print('SR830 ready on gpib channel ' + str(sr830ch))
        return sr830
    except:
        print('SR830 not found on gpib channel ' + str(sr830ch))
    

# Set up socket for ec100
def getsocket():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        s.connect((host, port))
        print('Success connecting to ' +
                host + ' on port: ' + str(port))
        s.sendall('*CLS' + term) #Clear status registers
        s.settimeout(0.1)
        return s
    except:
        print "Cannot connect to "
        print host + " on port: " + str(port)

# Send an ascii command to the ec100
def sendec(cmdstr):
    s.sendall(cmdstr + term)
    time.sleep(0.1) # Don't know if there's a command buffer

# Send an ascii command to the ec100 and get its response
def askec(cmdstr):
    s.sendall(cmdstr + term)
    try:
        data = s.recv(128)
        return data
    except:
        print("No response")

# Send an ascii command to the sr830
def send830(cmdstr):
    sr830.write(cmdstr)

# Send an ascii command to the sr830 and get its response
def ask830(cmdstr):
    data = sr830.ask(cmdstr)
    return data

def setup830():
    send830('fmod 1') # Set reference source (1: internal)
    send830('freq 1000') # Set drive frequency (Hz)
    send830('slvl 0.5') # Set drive amplitude (Volts)
    send830('harm 1') # Set measurement harmonic
    send830('isrc 0') # Set input (0:A)

def setupec():
    sendec('$fbsrc 3') #Set local feedback
    sendec('ceenab 0') #Open AC switch
    sendec('irange 1') #Set current range (1 -- 1A)
    sendec('celimt 0') #Set CE limiting to full compliance
    sendec('$clmph ce0') #Set 30V compliance limit
    sendec('$clmpl d33') #Set -30V compliance limit
    sendec('clbwth 1') #Set control bandwidth (1 -- 1MHz)
    sendec('$eigai 7ff') #Set external input gain (7ff nom)
    sendec('$boost 7ff4') #Set current interrupt boost DAC (7fff nom)
    sendec('$eiena 1') #Enable external input
    sendec('$raweo 7ff') #Set raw E offset
    sendec('$rpegn cff') #Set rear panel E gain
    sendec('bireje 7fff') #Set front panel E bias reject (7fff nom)
    sendec('lpfile 0') #Set front panel E filter (0 -- none)
    sendec('$fpegn cff') #Set front panel E gain
    sendec('$i2vof 980') #Set raw I/V offset
    sendec('bireji 808') #Set front panel I bias reject
    sendec('lpfili 0') #Set front panel I/V filter (0 -- none)

def local():
    sendec('ecmode 3') #Set local feedback
    
    
# pstat_test()
# Perform a very basic test of the control loop using a 10k unity-gain
# load.  This just makes sure that the loop closes in potentiostat mode.
def pstat_test():
    drive = 0.1 # Vrms -- drive level for this test
    print 'Test closed-loop potentiostatic operation',
    sendec('ceenab 1') #Close AC switch
    sendec('$fbsrc 0') # Set main vm feedback for potentiostat mode
    send830('fmod 1') # Set reference source (1: internal)
    send830('slvl ' + str(drive)) # Set drive amplitude (Volts)
    send830('freq 1000') # Set drive frequency (Hz)
    send830('harm 1') # Set measurement harmonic
    send830('isrc 0') # Set input (0:A)
    count = 10
    while count != 0:
        print '.',
        time.sleep(1)
        count -= 1
    rval = float(ask830('outp? 3'))
    if (rval > drive*0.9 and rval < drive*1.1):
        print('OK')
    else:
        print('Fail')


    
# bref_test()
# Test the voltage and current references in a buddy box
def bref_test():
    local()
    sendec('ceenab 0')
    # Switch the 10V reference to the internal 10k load and connect
    # the fieldcal sink switch.
    sendec('$scalv 3') 
    
# extref_test()
# Apply the 1.25V refererence from external input to the 10k load
def extref_test():
    setupec() # Leaves instrument in local feedback
    sendec('ceenab 1') #Close AC switch
    sendec('$fbsrc 0') # Set main vm feedback for potentiostat mode
    sendec('$eivrf 1') # Set external input reference to +1.25V
    sendec('bireje 7fff') # Reset bias rejection to midscale
    adcread = askec('adcval? 0')
    adcval = int(adcread.split('\r')[0],16)
    volts = float(adcval) / float(0x40000) # 0x40000 only for 15V range
    if (volts > 0.9 * 1.25) and (volts < 1.1 * 1.25):
        print('E ADC reading is ' + '%0.2f' % volts + ' volts...OK')
    else:
        print('E ADC reading is ' + '%0.2f' % volts + ' volts...FAIL')
    



    
s = getsocket()
sr830 = get830()
def main():
    print('Testing using a 10k load')
    setup830()
    setupec()
    local()
    pstat_test()
    
