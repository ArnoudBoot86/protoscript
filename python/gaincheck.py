#gainrange
#Checks the gain adjustment range
import socket
import visa


# Choose your ec100
# host = '172.25.128.112'
# host = '172.25.128.113'
# host = '172.25.128.114' # Bob's
# host = '172.25.128.115' # Ken's
# host = '172.25.128.116'
host = '172.25.128.34' # Igor's

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

def askec(cmdstr):
    s.sendall(cmdstr + term)
    try:
        data = s.recv(128)
        return data
    except:
        print("No response")

def send830(cmdstr):
    sr830.write(cmdstr)

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
    sendec('irange 1') #Set current range (1:1A)
    sendec('$celim 0') #Set CE limiting
    sendec('$clmph ce0') #Set 30V compliance limit
    sendec('$clmpl d33') #Set -30V compliance limit
    sendec('clbwth 1') #Set control bandwidth (1:1MHz)
    sendec('ceenab 1') #Close AC switch
    sendec('ecmode 0') #Set potentiostat mode
    sendec('$eigai 7ff') #Set external input gain (7ff nom)
    sendec('$boost 7ff4') #Set current interrupt boost DAC (7fff nom)
    sendec('$eioff 710') #Set external input offset (7ff nom)
    sendec('$eiena 1') #Enable external input
    sendec('$raweo 7ff') #Set raw E offset
    sendec('$rpegn cff') #Set rear panel E gain
    sendec('bireje 7fff') #Set front panel E bias reject (7fff nom)
    sendec('lpfile 0') #Set front panel E filter (0:none)
    sendec('$fpegn cff') #Set front panel E gain
    sendec('$i2vof 980') #Set raw I/V offset
    sendec('bireji 808') #Set front panel I bias reject
    sendec('lpfili 0') #Set front panel I/V filter (0:none)

def local():
    sendec('ecmode 3') #Set local feedback
    
    
    
    




    
s = getsocket()
sr830 = get830()
def main():
    print('Testing using a 10k load')
    setup830()
    
