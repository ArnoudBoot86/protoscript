#------------------------ fitstep.gp ------------------------------
# fitstep.gp
#
# Plot a step response acquired with the CircuitGear scope (and the
# Syscomp software).  Fit the response to that of a damped harmonic
# oscillator to extract resonant frequency and damping factor
# parameters.
#
# Usage: call 'fitstep.gp' 'datafile.csv'
#
# Author: John Peck
# Date: August 1, 2013
#------------------------------------------------------------------
reset
set terminal x11

# Set axis labels
set title 'fitstep.gp'
set xlabel 'Time (s)'
set ylabel 'Microphone voltage (V)'

set format x '%0.0s %c'
filename = '$0'

# Datafiles saved with the Syscomp software have a header line
# starting with "Time." Fields are comma-delimited
set datafile commentschars 'Time'
set datafile separator ','

# The damped harmonic oscillator initial parameters
tzero = .0069 # Time delay before pulse starts (seconds)
amp = 1 # Amplitude scaling factor
dcoff = 0.0233 # DC offset (Volts)
dfact = 0.1 # Damping factor. This script assumes an underdamped
	    # system, so 0 < dfact < 1
fn = 250 # The natural frequency
wn = 250 * 6.28 # The natural frequency


# This defines both the plotting range and the range over which
# fitting will happen
set xrange [0:0.035]

# Piecewise defined function -- output is just the DC offset for times
# less than zero
damped(x,amp,dfact,fn,dcoff,tzero) = x < tzero ? dcoff \
    : amp * exp(-dfact * 2*pi*fn * sqrt(1-dfact**2) * (x-tzero)) * \
      sin( 2*pi*fn * sqrt(1-dfact**2) * (x-tzero) ) + dcoff

set samples 1000

# Don't include DC offset as an adjustable factor...there's something
# strange going on with offset.  Just set the offset to the value
# before the step.
fit damped(x,amp,dfact,fn,dcoff,tzero) filename using 1:3 \
  via amp,dfact,fn,tzero

plot filename using 1:3 with lines title \
     filename
replot damped(x,amp,dfact,fn,dcoff,tzero) title \
  'Fit to damped SHO: f = '.gprintf('%3.0s%c',fn).'Hz,\
  damping = '.gprintf('%0.3f',dfact)

# Print the fit results to the terminal
print '--------------------------------------------------------'
print 'plotstep.gp: The fit natural frequency is '.gprintf('%3.0s%c',fn).'Hz'
print '             The fit damping factor is '.gprintf('%0.3f',dfact)
print '             The fit amplitude is '.gprintf('%0.3f',amp)
print '--------------------------------------------------------'

set output 'print.eps'
set terminal postscript eps
replot

set terminal x11
replot