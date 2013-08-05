# cgr_pulse.py
#
# Creates a custom waveform for the CircuitGear scope with the first N
# bits at maximum amplitude, and the rest zero.  Saves the generated
# waveform in this directory with the filename cgpulse_<N>high.dat.
#
# This custom waveform should be sent to the CircuitGear scope with
# the software they provide.

import sys
import optparse

def process_command_line(argv):
    """
    Return a 2-tuple: (settings object, args list).
    `argv` is a list of arguments, or `None` for ``sys.argv[1:]``.
    """
    if argv is None:
        argv = sys.argv[1:]

    # initialize the parser object:
    parser = optparse.OptionParser(
        formatter=optparse.TitledHelpFormatter(width=78),
        add_help_option=None)

    # define options here:
    parser.add_option(
        '-n', type='int', dest = 'highnum', action = 'store',
        help='Number of high samples (the rest are 0)')
    parser.add_option(      # customized description; put --help last
        '-h', '--help', action='help',
        help='Show this help message and exit.')

    (options, args) = parser.parse_args(argv)

    # check number of arguments, verify values, etc.:
    if args:
        parser.error('program takes no command-line arguments; '
                     '"%s" ignored.' % (args,))

    # further process settings & args if necessary

    return (options, args)

def main(argv=None):
    # The highnum option is now options.highnum
    (options, args) = process_command_line(argv)
    filename = ('cgrpulse_' + str(options.highnum) + 'high.dat')
    outfile = open(filename,'w')
    for samplenum in range(256):
        if (samplenum < options.highnum):
            outfile.write('0\n')
        else:
            outfile.write('128\n')
    print('Waveform written to ' + filename)
    outfile.close()
    
    
    return 0        # success

if __name__ == '__main__':
    status = main()
    sys.exit(status)
