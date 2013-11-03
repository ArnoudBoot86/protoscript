# pipetest.py
#
# Test the use of gnuplot-py to pipe commands to gnuplot


#------------------------- Configure logging --------------------------
import logging
from colorlog import ColoredFormatter

# create logger
logger = logging.getLogger('root')
logger.setLevel(logging.DEBUG)

# create console handler (ch) and set level to debug
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)

# create file handler and set level to debug
fh = logging.FileHandler('pipetest.log',mode='a',encoding=None,delay=False)
fh.setLevel(logging.DEBUG)

color_formatter = ColoredFormatter(
    '[ %(log_color)s%(levelname)-8s%(reset)s] %(message)s',
    datefmt=None,
    reset=True,
    log_colors={
        'DEBUG':    'cyan',
        'INFO':     'green',
        'WARNING':  'yellow',
        'ERROR':    'red',
        'CRITICAL': 'red',
    }
)

plain_formatter = logging.Formatter(
    '%(asctime)s - %(name)s - [ %(levelname)s ] - %(message)s',
    '%Y-%m-%d %H:%M:%S'
)

# Colored output goes to the console
ch.setFormatter(color_formatter)
logger.addHandler(ch)

# Plain output goes to the file
fh.setFormatter(plain_formatter)
logger.addHandler(fh)



#------------------ Configure plotting with gnuplot -------------------

# For the Gnuplot module
from numpy import * # For gnuplot.py
import Gnuplot, Gnuplot.funcutils # For gnuplot.py

# Use this option to turn off fifo if you get warnings like:
# line 0: warning: Skipping unreadable file "/tmp/tmpakexra.gnuplot/fifo"
Gnuplot.GnuplotOpts.prefer_fifo_data = 0


# plotdata()
#
# 
def plotdata(rawdata):
    # Set debug=1 to see gnuplot commands
    gplot = Gnuplot.Gnuplot(debug=0)
    gplot('set terminal x11')
    gplot('set style data lines')
    gplot('set key bottom left')
    gplot.xlabel('X axis title')
    gplot.ylabel('Y axis title')
    gplot("set yrange [*:*]")
    gplot("set format x '%0.0s %c'")
    gplot('set pointsize 1')
    gdata = Gnuplot.PlotItems.Data(rawdata,title='rawdata')
    gplot.plot(gdata) # Plot the data
    gplot('set terminal postscript eps color')
    gplot("set output '" + 'pipetest.eps' + "'")
    gplot('replot')
    gplot('set terminal x11')
    raw_input('* Press return to dismiss plot and exit...')


def main():
    rawdata = range(5)
    plotdata(rawdata)
    


# Execute main() from command line
if __name__ == '__main__':
    main()
