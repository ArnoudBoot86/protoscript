from numpy import *
import Gnuplot, Gnuplot.funcutils


def main():
    # Set debug=1 to echo gnuplot commands to stdout
    g = Gnuplot.Gnuplot(debug=0)
    g.title('A simple example') # Set an optional plot parameter
    g('set data style linespoints')
    x = arange(10, dtype='float_') # Generate a range of data
    y1 = x**2
    d = Gnuplot.Data(x, y1) # Format into a plotitem
    g.plot(d)
    # The plot will disappear when the funtion exits.  Use this
    # input statement to keep that from happening.
    raw_input('Please press return to continue...\n')
