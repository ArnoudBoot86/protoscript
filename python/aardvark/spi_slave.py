""" spi_slave.py
    Reads data written to SPI devices. """

from aardvark_py import *
import array as ay # Data is sent and read as python's array type
import decimal as dc
import sys # For writing data to stdout
import time # For adding time delays

#------------------------ Begin configure ------------------------------
port = 0 # Use detect() to set this
bitrate = 135 # The initialization bitrate in kHz
#------------------------- End configure -------------------------------

""" detect()
    Return port numbers for connected TotalPhase devices.  Use this
    function to see if the Aardvark interface is working, and to set
    the port number above. """
def detect():
    print "Detecting Aardvark adapters..."
    # Find all the attached devices
    (num, ports, unique_ids) = aa_find_devices_ext(16, 16)
    
    if num > 0:
        print "%d device(s) found:" % num
    
        # Print the information on each device
        for i in range(num):
            port      = ports[i]
            unique_id = unique_ids[i]
    
            # Determine if the device is in-use
            inuse = "(avail)"
            if (port & AA_PORT_NOT_FREE):
                inuse = "(in-use)"
                port  = port & ~AA_PORT_NOT_FREE
    
            # Display device port number, in-use status, and serial number
            print "    port = %d   %s  (%04d-%06d)" % \
                (port, inuse, unique_id / 1000000, unique_id % 1000000)
    else:
        print "No devices found."
        
""" gethandle
    Return a handle to the Aardvark """
def gethandle():
    handle = aa_open(port)
    if (handle <= 0):
        print "Unable to open Aardvark device on port %d" % port
        print "Error code = %d" % handle
        sys.exit()
    else:
        print 'Connected to Aardvark device on port %d' % port
        return(handle)
        
""" initialize()
    Set up SPI communication with the Aardvark as a slave """
def initialize(handle):
    # Ensure that the SPI subsystem is enabled
    aa_configure(handle,  AA_CONFIG_SPI_I2C)
    # Clock idles low: AA_SPI_POL_RISING_FALLING
    # Sample data on clock's leading (rising) edge: AA_SPI_PHASE_SAMPLE_SETUP
    # MSB first: AA_SPI_BITORDER_MSB
    aa_spi_configure(handle,AA_SPI_POL_RISING_FALLING, 
                     AA_SPI_PHASE_SAMPLE_SETUP, AA_SPI_BITORDER_MSB)
    # Set the bitrate (returns the actual bitrate)
    actrate = aa_spi_bitrate(handle, bitrate)
    print "Bitrate set to %d kHz" % actrate
    # Set the SS polarity
    statval = aa_spi_master_ss_polarity(handle,AA_SPI_SS_ACTIVE_HIGH)
    ewen(handle) # Write-enable the device
