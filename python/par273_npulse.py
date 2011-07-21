""" par273_npulse.py
    Sets up the PAR273 to make measurements with the normal pulse
    technique. """
import visa     # For GPIB or RS-232
import time     # For making pauses
import os       # For basic file I/O
import math     # For functions like floor
import types
from decimal import * # For math with people in mind
getcontext().prec = 3 # Set numeric precision

""" The following two lines are for the Gnuplot module """
from numpy import * # For gnuplot.py
import Gnuplot, Gnuplot.funcutils # For gnuplot.py

# ----------------Begin instrument configuration -----------------------
gpibchan = 6    # PAR273 GPIB channel
gpibwait = 10e-3 # Seconds to wait between GPIB writes
tbase = 10e-3   # Timebase in seconds
ivrange = -4    # I/V converter range in log10(amps)
""" Choose the egain value:
    egain           Voltage range
    -----------------------------
    1               >2V
    5               1...2V
"""
egain = 1
"""     The maxpoints, pcurve, scurve, and dcurve settings are all related.
    The maximum value for maxpoints (6144) is only available if all the
    curve values are set to zero.  In this case, current measurement data
    will overwrite the stimulus, and you'll have to download your waveform
    every time you want to scan.  Each of the PAR's 6 curves contain 1024
    memory locations, and you can combine them for longer stimuli.  The
    least confusion happens when you keep your curves shorter than 1024
    points -- then you have all 6 curves available.
        The PC can only talk to the processing curve.  This curve's data
    has to be copied to the source curve before it can be applied to the
    cell.  Likewise, destination curve data must be copied to the 
    processing curve before it can be downloaded.  Setting the destination
    and processing curve locations to be the same makes this automatic,
    and allows real-time updates of collected data to the PC. """
maxpoints = 1024    # Maximum points in the driving waveform
pcurve = 3          # Processing curve
scurve = 0          # Source curve
dcurve = 3          # Destination curve
# ----------------End instrument configuration -------------------------



# --------------- Begin measurement configuration ----------------------

""" Scans run from reste and decrease toward ende.  I have to enforce
    this in order to know where to set the bias DAC """ 
reste = 0.2    # Resting potential in volts
starte = 0.2  # Starting pulse potential in volts
ende = -0.1      # Ending pulse potential in volts
restime = 0.5    # Resting time between pulses in seconds
""" Keep in mind that our minimum timebase (tbase) is 10ms if we're to
    have reasonable scan length.  The pulse sample is taken on the last
    point in the pulse, so the pulse must be longer than 10ms. """
plstime = .5   # Pulsing time in seconds
datadir = '../../2011-jul-20'
basename = 'partest'

# --------------- End measurement configuration ------------------------

""" Set the bias DAC potential to be 100mV below the ending
    potential """
biaspot = ende - 0.1

""" get273()
    Set up gpib for the PAR273.  If successful, return the instrument
    variable.  If not, return an error message. """
def get273():
    try:
        instr = visa.instrument('GPIB::' + str(gpibchan))
        instr.timeout = 1 # Set timeout to 1s
        return instr
    except:
        print "get273: Failed to create instrument variable"
        
""" send273(instrument variable, command string)
    Send an ascii command to the PAR273.  Ignore any replies. """
def send273(instr, cmdstr):
    instr.write(cmdstr)
    time.sleep(gpibwait)
    error = chkerror()
    if not error == 'ok':
        print error
    time.sleep(gpibwait)
    
""" ask273(instrument variable, command string)
    Send and ascii command to the PAR273. Return whatever it replies,
    unless we time out. """
def ask273(instr, cmdstr):
    try:
        data = instr.ask(cmdstr)
        time.sleep(2*gpibwait)
        return data
    except:
        print "ask273: no reply"
    
""" chkerror()
    Report an error. """
def chkerror():
    instr = get273()
    errcode = ask273(instr, 'ERR')
    if errcode == '0':
        return 'ok'
    else:
        if errcode == '2':
            errstr = 'Invalid command sent.'
        if errcode == '3':
            errstr = 'Invalid parameter sent.'
        if errcode == '4':
            errstr = 'Command buffer overrun.'
        if errcode == '5':
            errstr = 'Nothing to say.'
        if errcode == '6':
            errstr = 'Numeric format error'
        if errcode == '11':
            errstr = 'Mode error'
        if errcode == '12':
            errstr = 'Acquisition error'
        return errstr

""" test273()
    Tests writing to the PAR273 by increasing the current range from 100nA
    to 1A every second. """
def test273():
    instr = get273()
    ranges = [-7,-6,-5,-4,-3,-2,-1,0]
    for rangenum in ranges:
        send273(instr, 'I/E ' + str(rangenum))
        time.sleep(1)
    errstr = chkerror()
    if not errstr == 'ok':
        print(errstr)
    
""" defaults()
    Return the 273 to factory default state. """
def defaults():
    instr = get273()
    instr.write('DCL')
    time.sleep(gpibwait)

""" initialize()
    Sets some defaults for the experiment. """
def initialize():
    instr = get273()
    defaults() # Set factory defaults
    send273(instr, 'CLEAR') # Clear all curve data
    send273(instr, 'MODE 2') # Set instrument mode
    send273(instr, 'AR 0') # Disable autoranging
    send273(instr, 'I/E ' + str(ivrange)) # Set current range
    send273(instr, 'EGAIN ' + str(egain)) # Set e measurement range
    send273(instr, 'BW 1') # Set bandwidth stop
    send273(instr, 'BIAS ' + str(int(biaspot * 1000)))
    send273(instr, 'MR 2') # 8000 counts = 2V on modulation DAC
    send273(instr, 'MM 2') # Set arbitrary wave mode
    send273(instr, 'INTRP 0') # No interpolation
    """ Some SIE values:
        n       I       E       AUX     deltaE
        --------------------------------------
        1       on      off     off     off
        3       on      on      off     off
    """
    send273(instr, 'SIE 3')
    send273(instr, 'TMB ' + str(int(tbase * 1e6))) # Set timebase
    send273(instr, 'S/P 1') # One sample per point
    errstr = chkerror() # Check the previous commands for errors
    if not errstr == 'ok':
        print(errstr)
    
""" makedrive()
    Create the drive waveform """
def makedrive():
    dvals = []
    restnum = int(math.floor(restime/tbase))
    pulsnum = int(math.floor(plstime/tbase))
    incpoints = restnum + pulsnum
    numsteps = int(math.floor((maxpoints-1)/incpoints)) # Last point is reserved
    pulsevals = linspace(starte,ende,numsteps)
    for val in pulsevals:
        dvals.extend([reste]*restnum) # Resting points
        dvals.extend([val]*pulsnum) # Pulsing points
    dvals.append(reste) # Come back to rest at the end
    return dvals
    
""" makesamp()
    Create the array of sample/baseline pairs.  Returns array of:
    [rest sample number, pulse sample number] """
def makesamp():
    pairs = []
    wform = makedrive()
    restnum = int(math.floor(restime/tbase))
    pulsnum = int(math.floor(plstime/tbase))
    incpoints = restnum + pulsnum
    tpoints = multiply(tbase,range(len(wform))).tolist()
    numsteps = int(math.floor((maxpoints-1)/incpoints)) # Last point is reserved
    for step in range(numsteps):
        rsample = (restnum-1) + step * incpoints # Resting sample
        psample = (restnum-1) + (pulsnum) + step * incpoints # Pulsing sample
        pairs.append([rsample,psample])
    return pairs
        
""" showdrive()
    Show the driving waveform with sample points. """
def showdrive():
    gplot = Gnuplot.Gnuplot(debug=0)
    wform = makedrive()
    rsamples = []
    psamples = []
    ramps = [] # Amplitudes at resting samples
    trest = [] # Times at resting samples
    pamps = [] # Amplutudes at pulsing samples
    tpuls = [] # Times at pulsing samples
    tpoints = multiply(tbase,range(len(wform))).tolist()
    spoints = makesamp() # Rest/sample pairs
    for pair in spoints:
        rsamples.append(pair[0]) # Resting sample numbers
        psamples.append(pair[1]) # Pulsing sample numbers
    for rnum in rsamples:
        ramps.append(wform[rnum])
        trest.append(tpoints[rnum])
    for pnum in psamples:
        pamps.append(wform[pnum])
        tpuls.append(tpoints[pnum])
    gplot('set terminal wxt')
    gplot('set title "Preview of driving waveform"')
    gplot('set style data linespoints')
    gplot('set key bottom left')
    gplot('set pointsize 1')
    gplot('set style points 3')
    gplot("set format x '%0.0s %c'")
    gplot.xlabel('Time (s)')
    gplot.ylabel('Amplitude (WE voltage vs reference)')
    gwdata = Gnuplot.Data(tpoints,wform,title='Drive waveform')
    gplot.plot(gwdata)
    gplot('set style data points')
    grdata = Gnuplot.Data(trest,ramps,title='Resting sample points')
    gpdata = Gnuplot.Data(tpuls,pamps,title='Pulsing sample points')
    gplot.replot(grdata)
    gplot.replot(gpdata)
    raw_input('* Press return to continue...')
    return
    
""" upload()
    Upload driving waveform to the 273 """
def upload():
    instr = get273()
    wform = makedrive()
    send273(instr,'FP 0') # First point location
    send273(instr,'LP ' + str(len(wform)-1)) # Last point location
    send273(instr,'PCV ' + str(pcurve)) # Processing curve location
    send273(instr,'SCV ' + str(scurve)) # Source curve location
    send273(instr,'DCV ' + str(dcurve)) # Destination curve location
    send273(instr,'CLR') # Clear points in PCV
    instr.write('LC 0 ' + str(len(wform))) # Preamble to sending data
    time.sleep(gpibwait)
    print 'Sending waveform',
    count = 0
    for point in wform:
        counts = int((point-biaspot) * (8000/2))
        instr.write(str(counts))
        time.sleep(gpibwait)
        if math.floor(count/100) == 1: # Don't make a dot for every point
            print '.',
            count = 0
        count += 1
    print 'Done!'
    """ The 273 will use points in the source curve as the stimulus, but
        it can only talk to the PC with the processing curve.  Copy the
        processing curve to the source curve """
    send273(instr,'COPY ' + str(pcurve) + ',' + str(scurve))
    send273(instr,'CLR') # Clear the processing curve
    return

    
""" takedata() 
    Runs the programmed waveform and tries to plot current data on the
    fly.  Doesn't do very well. """
def takedata():
    instr = get273()
    wform = makedrive() # Driving waveform
    plotcur = []    # Measured current array that grows as data is taken
    plottim = []    # Timing array that grows as data is taken
    diffcurr = []   # Array of difference currents
    difftime = []   # Timestamps for the pulse samples
    datadict = {} # Dictionary to hold measurement results
    spoints = makesamp() # Rest/sample pairs
    tpoints = multiply(tbase,range(len(wform))).tolist()
    send273(instr,'NC') # Clear the destination curve
    send273(instr,'CELL 1') # Turn cell on
    send273(instr,'TC') # Take curve
    gplot = Gnuplot.Gnuplot(debug=0)
    gplot('set terminal wxt')
    gplot('set title "Delayed data"')
    gplot('set style data linespoints')
    gplot('set key bottom left')
    gplot.xlabel('Time (s)')
    gplot.ylabel('Current (A)')
    gplot("set format y '%0.0s %c'")
    gplot('set pointsize 1')
    gplot('set style points 2')
    diffnum = 0
    plotcount = 0
    for point in range(len(wform)-1):
        retstr = ask273(instr,'DP ' + str(point))
        retcur = 2 * (10**ivrange) * int(retstr)/2047
        tpoint = tbase * point
        plotcur.append(retcur)
        plottim.append(tpoint)
        if point == spoints[diffnum][1]: # We've taken up to the first pulse point
            pval = plotcur[spoints[diffnum][1]] # Pulse value
            rval = plotcur[spoints[diffnum][0]] # Rest value
            diffcurr.append(pval-rval)
            difftime.append(plottim[spoints[diffnum][1]])
            diffnum += 1
        gcdata = Gnuplot.PlotItems.Data(plottim,plotcur,title='Raw points')
        if diffnum > 0:
            gddata = Gnuplot.PlotItems.Data(difftime,diffcurr,
                title='Pulse - rest')
        """ Now to display the data """
        if math.floor(plotcount/10) == 1: # Don't plot every time
            gplot.plot(gcdata)
            if diffnum > 0:
                gplot.replot(gddata)
            plotcount = 0
        plotcount += 1
    """ Plot one last time at the end """
    gplot.plot(gcdata)
    gplot.replot(gddata)
    raw_input('* Press return to exit...')
    datadict['rawi'] = plotcur
    datadict['rawt'] = plottim
    datadict['diffi'] = diffcurr
    datadict['difft'] = difftime
    return(datadict)

    
""" download()
    Download data from the PAR.  This function will grab only two curves:
    the destination curve (dcurve) and the next higher curve. 
    Data will be returned in a dictionary of:
    ['rawi'] = Raw, time-based current data
    ['rawe'] = Raw, time-based voltage data """
def download():
    wform = makedrive()
    instr = get273()
    pardata = {} # Dictionary of all downloaded data
    curdata = [] # Array of current data
    voldata = [] # Array of voltage data
    icurve = dcurve # Curve number for current data (should be dcurve)
    ecurve = dcurve+1 # Curve number for voltage data (should be dcurve+1)
    """ Start with the destination curve, which is the current data """
    send273(instr,'COPY ' + str(icurve) + ',' + str(pcurve))
    print 'Downloading current data from curve ' + str(icurve),
    count = 0
    for point in range(len(wform)-1):
        retstr = ask273(instr,'DP ' + str(point))
        """ See page V-42 of the PAR manual for converting current return
            strings to current values. """
        retcur = Decimal(10**ivrange) * Decimal(retstr)/Decimal(1000)
        curdata.append(retcur)
        if math.floor(count/100) == 1: # Don't make a dot for every point
            print '.',
            count = 0
        count += 1
    print 'Done!'
    """ Next grab the next curve, which is the voltage data """
    send273(instr,'COPY ' + str(ecurve) + ',' + str(pcurve))
    print 'Downloading voltage data from curve ' + str(ecurve),
    count = 0
    for point in range(len(wform)-1):
        retstr = ask273(instr,'DP ' + str(point))
        retvol = Decimal(retstr)/Decimal(1000)
        voldata.append(retvol)   
        if math.floor(count/100) == 1: # Don't make a dot for every point
            print '.',
            count = 0
        count += 1
    print 'Done!'
    pardata['rawi'] = curdata
    pardata['rawe'] = voldata
    return(pardata)
    
""" makediffs(dictionary with rawi and rawe time-based data)
    Takes the raw current and voltage time-based data and calculates
    differences for normal pulse. Returns the dictionary with the difference
    keys tacked on as ['difi'] and ['dife'] """
def makediffs(pardata):
    wform = makedrive() # Driving waveform
    spoints = makesamp() # Rest/sample pairs
    diffcurr = [] # Difference current values
    diffvolt = [] # E values at the pulse points
    diffnum = 0
    for point in range(len(wform)-1):
        if point == spoints[diffnum][1]: # We're up to the pulse point
            pvali = pardata['rawi'][spoints[diffnum][1]] # Pulse i value
            pvale = pardata['rawe'][spoints[diffnum][1]] # Pulse e value
            rvali = pardata['rawi'][spoints[diffnum][0]] # Rest i value
            diffcurr.append(pvali-rvali)
            diffvolt.append(pvale)
            diffnum += 1
    pardata['difi'] = diffcurr
    pardata['dife'] = diffvolt
    return(pardata)
        
        

""" savedata(Data dictionary)
    Saves data in two files -- raw and diff.  Creates <basename>_i.raw,
    <basename>_e.raw, 
and <basename>.dif files """
def savedata(pardata):
    wform = makedrive()
    pairs = makesamp()
    tpoints = multiply(tbase,range(len(wform)-1)).tolist() # Time points
    pardata['rawt'] = tpoints
    """ Write the raw current file -- all the data with no differences """
    fot = open(datadir + '/' + basename + '_i.raw','w')
    keys = ['rawt','rawi']
    datapoints = range(len(tpoints))
    for point in datapoints: 
        for key in keys:
            fot.write('{:0.3e}'.format(pardata[key][point]))
            if key == keys[-1]: # We're at the last key
                fot.write('\n')
            else:
                fot.write('\t')
    fot.close()
    print('Raw current data written to ' + datadir + '/' + basename + '_i.raw')
    """ Write the raw voltage file """
    fot = open(datadir + '/' + basename + '_e.raw','w')
    keys = ['rawt','rawe']
    datapoints = range(len(tpoints))
    for point in datapoints: 
        for key in keys:
            fot.write('{:0.3e}'.format(pardata[key][point]))
            if key == keys[-1]: # We're at the last key
                fot.write('\n')
            else:
                fot.write('\t')
    fot.close()
    print('Raw voltage data written to ' + datadir + '/' + basename + '_e.raw')
    """ Write the difference file -- just the differences """
    fot = open(datadir + '/' + basename + '.dif','w')
    keys = ['dife','difi']
    datapoints = range(len(pardata['dife']))
    for point in datapoints: 
        for key in keys:
            fot.write('{:0.3e}'.format(pardata[key][point]))
            if key == keys[-1]: # We're at the last key
                fot.write('\n')
            else:
                fot.write('\t')
    print('Diference data written to ' + datadir + '/' + basename + '.dif')
    fot.close()


    

def main():
    initialize()
    showdrive()
    upload()
    datadict = takedata()
    pardata = download() # Download curve data from instrument
    pardata = makediffs(pardata) # Add the difference keys
    savedata(pardata)
    
if __name__ == '__main__':
     main()
