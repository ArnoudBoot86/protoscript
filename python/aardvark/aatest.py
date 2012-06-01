""" aatest.py
    Collection of functions needed to work with the Aardvark from
    TotalPhase 
    
    See aardvark_py.py for more information. """

from aardvark_py import *
import array as ay # Data is sent and read as python's array type
import decimal as dc
import sys # For writing data to stdout
import time # For adding time delays for eeprom writes

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
    Set up SPI communication """
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
    
""" aaclose() """
def close(handle):
    aa_close(handle)
    
""" read(handle,address)
    The address can run from 0 to 64 for our 93AA46B eeprom """
def read(handle,address):
    # The initial value is the start bit, followed by the read opcode,
    # followed by six bits of 0 for the address
    # 1 start bit (0b1)
    # 2 bits of opcode (0b10)
    # 6 bits of address (0b000000)
    # 17 bits of data (1 dummy 0 plus 16 bits)
    # 6 bits of the next address (to be discarded)
    # --------------------------------------------
    # 32 bits or 4 bytes
    data_out = ay.array('B',[0 for i in range(4)])
    data_in = ay.array('B',[0 for i in range(4)])
    data_out[0] = 0xc0 | (address >> 1)
    data_out[1] = (address & 1) << 7
    (numread,data_in) = aa_spi_write(handle,data_out,data_in)
    rawdata = (((data_in[1] & 0x3f) << 10) + (data_in[2] << 2) +
              (data_in[3] >> 6))
    return(rawdata)
    
""" ewen(handle)
    Write enable the device """
def ewen(handle):
    data_out = ay.array('B',[0 for i in range(4)])
    data_in = ay.array('B',[0 for i in range(4)])
    data_out[0] = 0x98
    (numread,data_in) = aa_spi_write(handle,data_out,data_in)
    
    
""" write(handle,address,data)
    The address can run from 0 to 64 for our 93AA46B eeprom.
    Be sure to write-enable the device first with ewen() """
def write(handle,address,writedata):
    # The initial value is the start bit, followed by the write opcode,
    # followed by six bits of 0 for the address, then 16 bits of data.
    # 1 start bit (0b1)
    # 2 bits of opcode (0b01)
    # 6 bits of address (0b000000)
    # 16 bits of data
    # 7 bits of padding
    # --------------------------------------------
    # 32 bits or 4 bytes
    data_out = ay.array('B',[0 for i in range(4)])
    data_in = ay.array('B',[0 for i in range(4)])
    data_out[0] = 0xa0 | (address >> 1)
    data_out[1] = (((address & 1) << 7) | (writedata >> 9))
    data_out[2] = (writedata >> 1) & 0xff
    data_out[3] = (writedata & 0x1) << 7
    (numread,data_in) = aa_spi_write(handle,data_out,data_in)
    
""" writecheck(handle,address,data,numwrites)
    Write to the specified address, then read it to make sure the correct
    value was written. """
def writecheck(handle,address,writedata,numwrites):
    ewen(handle) # Make sure the device is write-enabled
    twc = 10 # ms -- the write cycle time
    tcsl = 1 # ms -- the chip select low time
    goodwrites = 0
    print 'Writing and reading',
    for readnum in range(numwrites):
        write(handle,address,writedata)
        time.sleep(dc.Decimal(twc)/1000)
        readback = read(handle,address)
        if readback == writedata:
            goodwrites += 1
        print '.',
        time.sleep(dc.Decimal(tcsl)/1000)
    print 'done!'
    goodpoints = 100 * dc.Decimal(goodwrites)/dc.Decimal(numwrites)
    print '%d percent success.' % goodpoints
    
""" Speedtest
    Write using a range of bitrates to find failure.  Note that I see
    about 20ms of slop when it comes to setting these delay times.  The
    delay time may be as small as twc, or it might be 100ms.  It all 
    depends on what the operating system chooses to work on. 
    
    The Microchip 93AA46B part has a 6ms write-cycle delay (twc)
    specified.  EC100 is having problems with the part even with a 7ms
    wait time after writing. """
def speedtest(handle):
    ewen(handle) # Make sure the device is write-enabled
    twc = 1 # ms -- the write cycle time
    tcsl = 1 # ms -- the chip select low time
    numwrites = 20 # Number of writes/reads at each bitrate
    bitrates = [125, 250, 500, 1000, 2000, 4000, 8000] # kHz
    address = 0 # Address to write and read from
    testwrite = 0xbeef # Value to write and read
    for rate in bitrates:
        actrate = aa_spi_bitrate(handle, rate)
        sys.stdout.write('Writing and reading at %d kHz' % actrate)
        goodwrites = 0
        for readnum in range(numwrites):
            write(handle,address,testwrite)
            time.sleep(dc.Decimal(twc)/1000)
            readback = read(handle,address)
            if readback == testwrite:
                goodwrites += 1
            print '.',
            time.sleep(dc.Decimal(tcsl)/1000)
        goodpoints = 100 * dc.Decimal(goodwrites)/dc.Decimal(numwrites)
        print '%d percent success.' % goodpoints
        
    
            
    
    
    
        

