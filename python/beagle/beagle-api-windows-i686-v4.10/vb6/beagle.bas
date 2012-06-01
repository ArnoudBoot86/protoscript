Attribute VB_Name = "BEAGLE"
'==========================================================================
' Beagle Interface Library
'--------------------------------------------------------------------------
' Copyright (c) 2004-2011 Total Phase, Inc.
' All rights reserved.
' www.totalphase.com
'
' Redistribution and use in source and binary forms, with or without
' modification, are permitted provided that the following conditions
' are met:
'
' - Redistributions of source code must retain the above copyright
'   notice, this list of conditions and the following disclaimer.
'
' - Redistributions in binary form must reproduce the above copyright
'   notice, this list of conditions and the following disclaimer in the
'   documentation and/or other materials provided with the distribution.
'
' - Neither the name of Total Phase, Inc. nor the names of its
'   contributors may be used to endorse or promote products derived from
'   this software without specific prior written permission.
'
' THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
' "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
' LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
' FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
' COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
' INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
' BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
' LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
' CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
' LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
' ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
' POSSIBILITY OF SUCH DAMAGE.
'--------------------------------------------------------------------------
' To access Total Phase Beagle devices through the API:
'
' 1) Use one of the following shared objects:
'      beagle.so        --  Linux shared object
'          or
'      beagle.dll       --  Windows dynamic link library
'
' 2) Along with one of the following language modules:
'      beagle.c/h       --  C/C++ API header file and interface module
'      beagle_py.py     --  Python API
'      beagle.bas       --  Visual Basic 6 API
'      beagle.cs        --  C# .NET source
'      beagle_net.dll   --  Compiled .NET binding
'==========================================================================

' Data types:
'    Handles are Long
'
'    Fixed bit-width types
'      8-bit => Byte
'     16-bit => Integer
'     32-bit => Long
'     64-bit => LongLong

Public Type LongLong
    LoValue As Long
    HiValue As Long
End Type

Public Enum BeagleStatus
    ' General codes (0 to -99)
    BG_OK                                    =    0
    BG_UNABLE_TO_LOAD_LIBRARY                =   -1
    BG_UNABLE_TO_LOAD_DRIVER                 =   -2
    BG_UNABLE_TO_LOAD_FUNCTION               =   -3
    BG_INCOMPATIBLE_LIBRARY                  =   -4
    BG_INCOMPATIBLE_DEVICE                   =   -5
    BG_INCOMPATIBLE_DRIVER                   =   -6
    BG_COMMUNICATION_ERROR                   =   -7
    BG_UNABLE_TO_OPEN                        =   -8
    BG_UNABLE_TO_CLOSE                       =   -9
    BG_INVALID_HANDLE                        =  -10
    BG_CONFIG_ERROR                          =  -11
    BG_UNKNOWN_PROTOCOL                      =  -12
    BG_STILL_ACTIVE                          =  -13
    BG_FUNCTION_NOT_AVAILABLE                =  -14
    BG_CAPTURE_NOT_TRIGGERED                 =  -15
    BG_INVALID_LICENSE                       =  -16

    ' COMMTEST codes (-100 to -199)
    BG_COMMTEST_NOT_AVAILABLE                = -100
    BG_COMMTEST_NOT_ENABLED                  = -101

    ' I2C codes (-200 to -299)
    BG_I2C_NOT_AVAILABLE                     = -200
    BG_I2C_NOT_ENABLED                       = -201

    ' SPI codes (-300 to -399)
    BG_SPI_NOT_AVAILABLE                     = -300
    BG_SPI_NOT_ENABLED                       = -301

    ' USB codes (-400 to -499)
    BG_USB_NOT_AVAILABLE                     = -400
    BG_USB_NOT_ENABLED                       = -401
    BG_USB2_NOT_ENABLED                      = -402
    BG_USB3_NOT_ENABLED                      = -403

    ' Complex Triggering Config codes
    BG_COMPLEX_CONFIG_ERROR_NO_STATES        = -450
    BG_COMPLEX_CONFIG_ERROR_DATA_PACKET_TYPE = -451
    BG_COMPLEX_CONFIG_ERROR_DATA_FIELD       = -452
    BG_COMPLEX_CONFIG_ERROR_ERR_MATCH_FIELD  = -453
    BG_COMPLEX_CONFIG_ERROR_DATA_RESOURCES   = -454
    BG_COMPLEX_CONFIG_ERROR_DP_MATCH_TYPE    = -455
    BG_COMPLEX_CONFIG_ERROR_DP_MATCH_VAL     = -456
    BG_COMPLEX_CONFIG_ERROR_DP_REQUIRED      = -457
    BG_COMPLEX_CONFIG_ERROR_DP_RESOURCES     = -458
    BG_COMPLEX_CONFIG_ERROR_TIMER_UNIT       = -459
    BG_COMPLEX_CONFIG_ERROR_TIMER_BOUNDS     = -460
    BG_COMPLEX_CONFIG_ERROR_ASYNC_EVENT      = -461
    BG_COMPLEX_CONFIG_ERROR_ASYNC_EDGE       = -462
    BG_COMPLEX_CONFIG_ERROR_ACTION_FILTER    = -463
    BG_COMPLEX_CONFIG_ERROR_ACTION_GOTO_SEL  = -464
    BG_COMPLEX_CONFIG_ERROR_ACTION_GOTO_DEST = -465

    ' MDIO codes (-500 to -599)
    BG_MDIO_NOT_AVAILABLE                    = -500
    BG_MDIO_NOT_ENABLED                      = -501
    BG_MDIO_BAD_TURNAROUND                   = -502
End Enum

Public Type BeagleVersion
    ' Software, firmware, and hardware versions.
    software          as Integer
    firmware          as Integer
    hardware          as Integer

    ' Hardware revisions that are compatible with this software version.
    ' The top 16 bits gives the maximum accepted hw revision.
    ' The lower 16 bits gives the minimum accepted hw revision.
    hw_revs_for_sw    as Long

    ' Firmware revisions that are compatible with this software version.
    ' The top 16 bits gives the maximum accepted fw revision.
    ' The lower 16 bits gives the minimum accepted fw revision.
    fw_revs_for_sw    as Long

    ' Driver revisions that are compatible with this software version.
    ' The top 16 bits gives the maximum accepted driver revision.
    ' The lower 16 bits gives the minimum accepted driver revision.
    ' This version checking is currently only pertinent for WIN32
    ' platforms.
    drv_revs_for_sw   as Long

    ' Software requires that the API interface must be >= this version.
    api_req_by_sw     as Integer
End Type

Public Const BG_PORT_NOT_FREE = &H8000

Public Type BeagleExt
    ' Version matrix
    version    as BeagleVersion

    ' Features of this device.
    features   as Long
End Type

Public Const BG_FEATURE_NONE = &H00000000
Public Const BG_FEATURE_I2C = &H00000001
Public Const BG_FEATURE_SPI = &H00000002
Public Const BG_FEATURE_USB = &H00000004
Public Const BG_FEATURE_MDIO = &H00000008
Public Const BG_FEATURE_USB_HS = &H00000010
Public Const BG_FEATURE_USB_SS = &H00000020

Public Const BG_TARGET_POWER_OFF = &H00
Public Const BG_TARGET_POWER_ON = &H01
Public Const BG_TARGET_POWER_QUERY = &H80

Public Const BG_HOST_IFCE_FULL_SPEED = &H00
Public Const BG_HOST_IFCE_HIGH_SPEED = &H01

Public Enum BeagleProtocol
    BG_PROTOCOL_NONE     = 0
    BG_PROTOCOL_COMMTEST = 1
    BG_PROTOCOL_USB      = 2
    BG_PROTOCOL_I2C      = 3
    BG_PROTOCOL_SPI      = 4
    BG_PROTOCOL_MDIO     = 5
End Enum

Public Const BG_READ_OK = &H00000000
Public Const BG_READ_TIMEOUT = &H00000100
Public Const BG_READ_ERR_MIDDLE_OF_PACKET = &H00000200
Public Const BG_READ_ERR_SHORT_BUFFER = &H00000400
Public Const BG_READ_ERR_PARTIAL_LAST_BYTE = &H00000800
Public Const BG_READ_ERR_PARTIAL_LAST_BYTE_MASK = &H0000000f
Public Const BG_READ_ERR_UNEXPECTED = &H00001000

Public Const BG_I2C_PULLUP_OFF = &H00
Public Const BG_I2C_PULLUP_ON = &H01
Public Const BG_I2C_PULLUP_QUERY = &H80

Public Const BG_I2C_MONITOR_DATA = &H00ff
Public Const BG_I2C_MONITOR_NACK = &H0100
Public Const BG_READ_I2C_NO_STOP = &H00010000

Public Enum BeagleSpiSSPolarity
    BG_SPI_SS_ACTIVE_LOW  = 0
    BG_SPI_SS_ACTIVE_HIGH = 1
End Enum

Public Enum BeagleSpiSckSamplingEdge
    BG_SPI_SCK_SAMPLING_EDGE_RISING  = 0
    BG_SPI_SCK_SAMPLING_EDGE_FALLING = 1
End Enum

Public Enum BeagleSpiBitorder
    BG_SPI_BITORDER_MSB = 0
    BG_SPI_BITORDER_LSB = 1
End Enum

Public Const BG_USB_PID_OUT = &He1
Public Const BG_USB_PID_IN = &H69
Public Const BG_USB_PID_SOF = &Ha5
Public Const BG_USB_PID_SETUP = &H2d
Public Const BG_USB_PID_DATA0 = &Hc3
Public Const BG_USB_PID_DATA1 = &H4b
Public Const BG_USB_PID_DATA2 = &H87
Public Const BG_USB_PID_MDATA = &H0f
Public Const BG_USB_PID_ACK = &Hd2
Public Const BG_USB_PID_NAK = &H5a
Public Const BG_USB_PID_STALL = &H1e
Public Const BG_USB_PID_NYET = &H96
Public Const BG_USB_PID_PRE = &H3c
Public Const BG_USB_PID_ERR = &H3c
Public Const BG_USB_PID_SPLIT = &H78
Public Const BG_USB_PID_PING = &Hb4
Public Const BG_USB_PID_EXT = &Hf0
Public Const BG_USB_PID_CORRUPTED = &Hff

Public Const BG_READ_USB_ERR_BAD_SIGNALS = &H00010000
Public Const BG_READ_USB_ERR_BAD_PID = &H00200000
Public Const BG_READ_USB_ERR_BAD_CRC = &H00400000

Public Const BG_READ_USB_ERR_BAD_SYNC = &H00020000
Public Const BG_READ_USB_ERR_BIT_STUFF = &H00040000
Public Const BG_READ_USB_ERR_FALSE_EOP = &H00080000
Public Const BG_READ_USB_ERR_LONG_EOP = &H00100000

Public Const BG_READ_USB_TRUNCATION_LEN_MASK = &H000000ff
Public Const BG_READ_USB_TRUNCATION_MODE = &H20000000
Public Const BG_READ_USB_END_OF_CAPTURE = &H40000000

Public Const BG_READ_USB_ERR_BAD_SLC_CRC_1 = &H00008000
Public Const BG_READ_USB_ERR_BAD_SLC_CRC_2 = &H00010000
Public Const BG_READ_USB_ERR_BAD_SHP_CRC_16 = &H00008000
Public Const BG_READ_USB_ERR_BAD_SHP_CRC_5 = &H00010000
Public Const BG_READ_USB_ERR_BAD_SDP_CRC = &H00008000
Public Const BG_READ_USB_EDB_FRAMING = &H00020000
Public Const BG_READ_USB_ERR_UNK_END_OF_FRAME = &H00040000
Public Const BG_READ_USB_ERR_DATA_LEN_INVALID = &H00080000
Public Const BG_READ_USB_PKT_TYPE_LINK = &H00100000
Public Const BG_READ_USB_PKT_TYPE_HDR = &H00200000
Public Const BG_READ_USB_PKT_TYPE_DP = &H00400000
Public Const BG_READ_USB_PKT_TYPE_TSEQ = &H00800000
Public Const BG_READ_USB_PKT_TYPE_TS1 = &H01000000
Public Const BG_READ_USB_PKT_TYPE_TS2 = &H02000000
Public Const BG_READ_USB_ERR_BAD_TS = &H04000000
Public Const BG_READ_USB_ERR_FRAMING = &H08000000

Public Const BG_EVENT_USB_HOST_DISCONNECT = &H00000100
Public Const BG_EVENT_USB_TARGET_DISCONNECT = &H00000200
Public Const BG_EVENT_USB_HOST_CONNECT = &H00000400
Public Const BG_EVENT_USB_TARGET_CONNECT = &H00000800
Public Const BG_EVENT_USB_RESET = &H00001000

Public Const BG_EVENT_USB_CHIRP_J = &H00002000
Public Const BG_EVENT_USB_CHIRP_K = &H00004000
Public Const BG_EVENT_USB_SPEED_UNKNOWN = &H00008000
Public Const BG_EVENT_USB_LOW_SPEED = &H00010000
Public Const BG_EVENT_USB_FULL_SPEED = &H00020000
Public Const BG_EVENT_USB_HIGH_SPEED = &H00040000
Public Const BG_EVENT_USB_LOW_OVER_FULL_SPEED = &H00080000
Public Const BG_EVENT_USB_SUSPEND = &H00100000
Public Const BG_EVENT_USB_RESUME = &H00200000
Public Const BG_EVENT_USB_KEEP_ALIVE = &H00400000
Public Const BG_EVENT_USB_DIGITAL_INPUT = &H00800000
Public Const BG_EVENT_USB_OTG_HNP = &H01000000
Public Const BG_EVENT_USB_OTG_SRP_DATA_PULSE = &H02000000
Public Const BG_EVENT_USB_OTG_SRP_VBUS_PULSE = &H04000000
Public Const BG_EVENT_USB_DIGITAL_INPUT_MASK = &H0000000f

Public Const BG_EVENT_USB_LFPS = &H00001000
Public Const BG_EVENT_USB_LTSSM = &H00002000
Public Const BG_EVENT_USB_VBUS_PRESENT = &H00010000
Public Const BG_EVENT_USB_VBUS_ABSENT = &H00020000
Public Const BG_EVENT_USB_SCRAMBLING_ENABLED = &H00040000
Public Const BG_EVENT_USB_SCRAMBLING_DISABLED = &H00080000
Public Const BG_EVENT_USB_POLARITY_NORMAL = &H00100000
Public Const BG_EVENT_USB_POLARITY_REVERSED = &H00200000
Public Const BG_EVENT_USB_PHY_ERROR = &H00400000
Public Const BG_EVENT_USB_LTSSM_MASK = &H000000ff
Public Const BG_EVENT_USB_LTSSM_STATE_UNKNOWN = &H00000000
Public Const BG_EVENT_USB_LTSSM_STATE_SS_DISABLED = &H00000001
Public Const BG_EVENT_USB_LTSSM_STATE_SS_INACTIVE = &H00000002
Public Const BG_EVENT_USB_LTSSM_STATE_RX_DETECT_RESET = &H00000003
Public Const BG_EVENT_USB_LTSSM_STATE_RX_DETECT_ACTIVE = &H00000004
Public Const BG_EVENT_USB_LTSSM_STATE_POLLING_LFPS = &H00000005
Public Const BG_EVENT_USB_LTSSM_STATE_POLLING_RXEQ = &H00000006
Public Const BG_EVENT_USB_LTSSM_STATE_POLLING_ACTIVE = &H00000007
Public Const BG_EVENT_USB_LTSSM_STATE_POLLING_CONFIG = &H00000008
Public Const BG_EVENT_USB_LTSSM_STATE_POLLING_IDLE = &H00000009
Public Const BG_EVENT_USB_LTSSM_STATE_U0 = &H0000000a
Public Const BG_EVENT_USB_LTSSM_STATE_U1 = &H0000000b
Public Const BG_EVENT_USB_LTSSM_STATE_U2 = &H0000000c
Public Const BG_EVENT_USB_LTSSM_STATE_U3 = &H0000000d
Public Const BG_EVENT_USB_LTSSM_STATE_RECOVERY_ACTIVE = &H0000000e
Public Const BG_EVENT_USB_LTSSM_STATE_RECOVERY_CONFIG = &H0000000f
Public Const BG_EVENT_USB_LTSSM_STATE_RECOVERY_IDLE = &H00000010
Public Const BG_EVENT_USB_LTSSM_STATE_HOT_RESET_ACTIVE = &H00000011
Public Const BG_EVENT_USB_LTSSM_STATE_HOT_RESET_EXIT = &H00000012
Public Const BG_EVENT_USB_LTSSM_STATE_LOOPBACK_ACTIVE = &H00000013
Public Const BG_EVENT_USB_LTSSM_STATE_LOOPBACK_EXIT = &H00000014
Public Const BG_EVENT_USB_LTSSM_STATE_COMPLIANCE = &H00000015
Public Const BG_EVENT_USB_TRIGGER = &H80000000
Public Const BG_EVENT_USB_COMPLEX_TRIGGER = &H00800000
Public Const BG_EVENT_USB_TRIGGER_TIMER = &H01000000
Public Const BG_EVENT_USB_TRIGGER_5GBIT_START = &H02000000
Public Const BG_EVENT_USB_TRIGGER_5GBIT_STOP = &H04000000
Public Const BG_EVENT_USB_TRIGGER_STATE_MASK = &H00000007
Public Const BG_EVENT_USB_TRIGGER_STATE_0 = &H00000000
Public Const BG_EVENT_USB_TRIGGER_STATE_1 = &H00000001
Public Const BG_EVENT_USB_TRIGGER_STATE_2 = &H00000002
Public Const BG_EVENT_USB_TRIGGER_STATE_3 = &H00000003
Public Const BG_EVENT_USB_TRIGGER_STATE_4 = &H00000004
Public Const BG_EVENT_USB_TRIGGER_STATE_5 = &H00000005
Public Const BG_EVENT_USB_TRIGGER_STATE_6 = &H00000006
Public Const BG_EVENT_USB_TRIGGER_STATE_7 = &H00000007
Public Const BG_EVENT_USB_EXT_TRIG_ASSERTED = &H08000000
Public Const BG_EVENT_USB_EXT_TRIG_DEASSERTED = &H10000000

Public Const BG_USB480_TRUNCATION_LENGTH = 4

Public Enum BeagleUsb480CaptureMode
    BG_USB480_CAPTURE_REALTIME                 = 0
    BG_USB480_CAPTURE_REALTIME_WITH_PROTECTION = 1
    BG_USB480_CAPTURE_DELAYED_DOWNLOAD         = 2
End Enum

Public Enum BeagleUsb2TargetSpeed
    BG_USB2_AUTO_SPEED_DETECT = 0
    BG_USB2_LOW_SPEED         = 1
    BG_USB2_FULL_SPEED        = 2
    BG_USB2_HIGH_SPEED        = 3
End Enum

Public Const BG_USB2_DIGITAL_OUT_ENABLE_PIN1 = &H01
Public Const BG_USB2_DIGITAL_OUT_PIN1_ACTIVE_HIGH = &H01
Public Const BG_USB2_DIGITAL_OUT_PIN1_ACTIVE_LOW = &H00
Public Const BG_USB2_DIGITAL_OUT_ENABLE_PIN2 = &H02
Public Const BG_USB2_DIGITAL_OUT_PIN2_ACTIVE_HIGH = &H02
Public Const BG_USB2_DIGITAL_OUT_PIN2_ACTIVE_LOW = &H00
Public Const BG_USB2_DIGITAL_OUT_ENABLE_PIN3 = &H04
Public Const BG_USB2_DIGITAL_OUT_PIN3_ACTIVE_HIGH = &H04
Public Const BG_USB2_DIGITAL_OUT_PIN3_ACTIVE_LOW = &H00
Public Const BG_USB2_DIGITAL_OUT_ENABLE_PIN4 = &H08
Public Const BG_USB2_DIGITAL_OUT_PIN4_ACTIVE_HIGH = &H08
Public Const BG_USB2_DIGITAL_OUT_PIN4_ACTIVE_LOW = &H00

Public Enum BeagleUsb2DigitalOutMatchPins
    BG_USB2_DIGITAL_OUT_MATCH_PIN3 = 3
    BG_USB2_DIGITAL_OUT_MATCH_PIN4 = 4
End Enum

Public Enum BeagleUsb2MatchType
    BG_USB2_MATCH_TYPE_DISABLED  = 0
    BG_USB2_MATCH_TYPE_EQUAL     = 1
    BG_USB2_MATCH_TYPE_NOT_EQUAL = 2
End Enum

Public Type BeagleUsb2PacketMatch
    pid_match_type   as Long
    pid_match_val    as Byte
    dev_match_type   as Long
    dev_match_val    as Byte
    ep_match_type    as Long
    ep_match_val     as Byte
End Type

Public Const BG_USB2_DATA_MATCH_DATA0 = &H01
Public Const BG_USB2_DATA_MATCH_DATA1 = &H02
Public Const BG_USB2_DATA_MATCH_DATA2 = &H04
Public Const BG_USB2_DATA_MATCH_MDATA = &H08

Public Type BeagleUsb2DataMatch
    data_match_type     as Long
    data_match_pid      as Byte
    data()              as Byte
    data_valid()        as Byte
End Type

Public Const BG_USB2_DIGITAL_IN_ENABLE_PIN1 = &H01
Public Const BG_USB2_DIGITAL_IN_ENABLE_PIN2 = &H02
Public Const BG_USB2_DIGITAL_IN_ENABLE_PIN3 = &H04
Public Const BG_USB2_DIGITAL_IN_ENABLE_PIN4 = &H08

Public Const BG_USB2_HW_FILTER_PID_SOF = &H01
Public Const BG_USB2_HW_FILTER_PID_IN = &H02
Public Const BG_USB2_HW_FILTER_PID_PING = &H04
Public Const BG_USB2_HW_FILTER_PID_PRE = &H08
Public Const BG_USB2_HW_FILTER_PID_SPLIT = &H10
Public Const BG_USB2_HW_FILTER_SELF = &H20

Public Const BG_USB5000_CAPTURE_SIZE_INFINITE = 0
Public Const BG_USB5000_CAPTURE_SIZE_SCALE = &Hffffffff
Public Const BG_USB5000_USB2_BUFFER_SIZE_128MB = 128
Public Const BG_USB5000_USB3_BUFFER_SIZE_2GB = 2
Public Const BG_USB5000_USB3_BUFFER_SIZE_4GB = 4

Public Const BG_USB5000_LICENSE_LENGTH = 60

Public Const BG_USB5000_FEATURE_NONE = &H00000000
Public Const BG_USB5000_FEATURE_USB2_MON = &H00000001
Public Const BG_USB5000_FEATURE_USB3_MON = &H00000002
Public Const BG_USB5000_FEATURE_SIMUL_23 = &H00000004
Public Const BG_USB5000_FEATURE_CMP_TRIG = &H00000008
Public Const BG_USB5000_FEATURE_4G_MEM = &H00000020

Public Const BG_USB5000_CAPTURE_USB3 = &H01
Public Const BG_USB5000_CAPTURE_USB2 = &H02

Public Enum BeagleUsb5000TriggerMode
    BG_USB5000_TRIGGER_MODE_EVENT     = 0
    BG_USB5000_TRIGGER_MODE_IMMEDIATE = 1
End Enum

Public Enum BeagleUsbTargetPower
    BG_USB5000_TARGET_POWER_HOST_SUPPLIED = 0
    BG_USB5000_TARGET_POWER_OFF           = 1
End Enum

Public Enum BeagleMemoryTestResult
    BG_USB5000_MEMORY_TEST_PASS = 0
    BG_USB5000_MEMORY_TEST_FAIL = 1
End Enum

Public Const BG_USB5000_USB3_PHY_CONFIG_POLARITY_NON_INVERT = &H00
Public Const BG_USB5000_USB3_PHY_CONFIG_POLARITY_INVERT = &H01
Public Const BG_USB5000_USB3_PHY_CONFIG_POLARITY_AUTO = &H02
Public Const BG_USB5000_USB3_PHY_CONFIG_POLARITY_MASK = &H03
Public Const BG_USB5000_USB3_PHY_CONFIG_DESCRAMBLER_ON = &H00
Public Const BG_USB5000_USB3_PHY_CONFIG_DESCRAMBLER_OFF = &H04
Public Const BG_USB5000_USB3_PHY_CONFIG_DESCRAMBLER_AUTO = &H08
Public Const BG_USB5000_USB3_PHY_CONFIG_DESCRAMBLER_MASK = &H0c
Public Const BG_USB5000_USB3_PHY_CONFIG_RXTERM_ON = &H00
Public Const BG_USB5000_USB3_PHY_CONFIG_RXTERM_OFF = &H10
Public Const BG_USB5000_USB3_PHY_CONFIG_RXTERM_AUTO = &H20
Public Const BG_USB5000_USB3_PHY_CONFIG_RXTERM_MASK = &H30

Public Enum BeagleUsb3MemoryTestType
    BG_USB5000_USB3_MEMORY_TEST_FAST =  0
    BG_USB5000_USB3_MEMORY_TEST_FULL =  1
    BG_USB5000_USB3_MEMORY_TEST_SKIP = -1
End Enum

Public Enum BeagleUsb5000CaptureStatus
    BG_USB5000_CAPTURE_STATUS_INACTIVE         = 0
    BG_USB5000_CAPTURE_STATUS_PRE_TRIGGER      = 1
    BG_USB5000_CAPTURE_STATUS_PRE_TRIGGER_SYNC = 2
    BG_USB5000_CAPTURE_STATUS_POST_TRIGGER     = 3
    BG_USB5000_CAPTURE_STATUS_TRANSFER         = 4
    BG_USB5000_CAPTURE_STATUS_COMPLETE         = 5
End Enum

Public Const BG_USB5000_USB3_TRUNCATION_OFF = &H00
Public Const BG_USB5000_USB3_TRUNCATION_20 = &H01
Public Const BG_USB5000_USB3_TRUNCATION_36 = &H02
Public Const BG_USB5000_USB3_TRUNCATION_68 = &H03

Public Const BG_USB5000_SIMPLE_MATCH_NONE = &H00000000
Public Const BG_USB5000_SIMPLE_MATCH_SSTX_IPS = &H00000001
Public Const BG_USB5000_SIMPLE_MATCH_SSTX_SLC = &H00000002
Public Const BG_USB5000_SIMPLE_MATCH_SSTX_SHP = &H00000004
Public Const BG_USB5000_SIMPLE_MATCH_SSTX_SDP = &H00000008
Public Const BG_USB5000_SIMPLE_MATCH_SSRX_IPS = &H00000010
Public Const BG_USB5000_SIMPLE_MATCH_SSRX_SLC = &H00000020
Public Const BG_USB5000_SIMPLE_MATCH_SSRX_SHP = &H00000040
Public Const BG_USB5000_SIMPLE_MATCH_SSRX_SDP = &H00000080
Public Const BG_USB5000_SIMPLE_MATCH_SSTX_SLC_CRC_5A_CRC_5B = &H00000100
Public Const BG_USB5000_SIMPLE_MATCH_SSTX_SHP_CRC_5 = &H00000200
Public Const BG_USB5000_SIMPLE_MATCH_SSTX_SHP_CRC_16 = &H00000400
Public Const BG_USB5000_SIMPLE_MATCH_SSTX_SDP_CRC = &H00000800
Public Const BG_USB5000_SIMPLE_MATCH_SSRX_SLC_CRC_5A_CRC_5B = &H00001000
Public Const BG_USB5000_SIMPLE_MATCH_SSRX_SHP_CRC_5 = &H00002000
Public Const BG_USB5000_SIMPLE_MATCH_SSRX_SHP_CRC_16 = &H00004000
Public Const BG_USB5000_SIMPLE_MATCH_SSRX_SDP_CRC = &H00008000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_SSTX_LFPS = &H00010000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_SSTX_POLARITY = &H00020000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_SSTX_DETECTED = &H00400000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_SSTX_SCRAMBL = &H00080000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_SSRX_LFPS = &H00100000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_SSRX_POLARITY = &H00200000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_SSRX_DETECTED = &H00040000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_SSRX_SCRAMBL = &H00800000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_VBUS_PRESENT = &H08000000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_SSTX_PHYERR = &H10000000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_SSRX_PHYERR = &H20000000
Public Const BG_USB5000_SIMPLE_MATCH_EVENT_EXTTRIG = &H40000000
Public Const BG_USB5000_EDGE_RISING = &H01
Public Const BG_USB5000_EDGE_PULSE = &H01
Public Const BG_USB5000_EDGE_FALLING = &H02

Public Enum BeagleUsb5000ExtoutMode
    BG_USB5000_EXTOUT_DISABLED     = 0
    BG_USB5000_EXTOUT_TRIGGER_MODE = 1
    BG_USB5000_EXTOUT_EVENTS_MODE  = 2
End Enum

Public Enum BeagleUsb5000IPSType
    BG_USB5000_IPS_TYPE_DISABLED = 0
    BG_USB5000_IPS_TYPE_TS1      = 1
    BG_USB5000_IPS_TYPE_TS2      = 2
    BG_USB5000_IPS_TYPE_TSEQ     = 3
    BG_USB5000_IPS_TYPE_TSx      = 4
    BG_USB5000_IPS_TYPE_TS_ANY   = 5
End Enum

Public Enum BeagleUsb5000MatchType
    BG_USB5000_MATCH_TYPE_DISABLED      = 0
    BG_USB5000_MATCH_TYPE_EQUAL         = 1
    BG_USB5000_MATCH_TYPE_LESS_EQUAL    = 2
    BG_USB5000_MATCH_TYPE_GREATER_EQUAL = 3
End Enum

Public Enum BeagleUsb5000Source
    BG_USB5000_SOURCE_ASYNC = 0
    BG_USB5000_SOURCE_RX    = 1
    BG_USB5000_SOURCE_TX    = 2
    BG_USB5000_SOURCE_USB2  = 3
End Enum

Public Type BeagleUsb5000DataProperties
    source_match_type      as Long
    source_match_val       as Long
    ep_match_type          as Long
    ep_match_val           as Byte
    dev_match_type         as Long
    dev_match_val          as Byte
    stream_id_match_type   as Long
    stream_id_match_val    as Integer
    data_len_match_type    as Long
    data_len_match_val     as Integer
End Type

Public Enum BeagleUsb5000PacketType
    BG_USB5000_MATCH_PACKET_SLC         = 0
    BG_USB5000_MATCH_PACKET_SHP         = 1
    BG_USB5000_MATCH_PACKET_SDP         = 2
    BG_USB5000_MATCH_PACKET_SHP_SDP     = 3
    BG_USB5000_MATCH_PACKET_TSx         = 4
    BG_USB5000_MATCH_PACKET_TSEQ        = 5
    BG_USB5000_MATCH_PACKET_ERROR       = 6
    BG_USB5000_MATCH_PACKET_5GBIT_START = 7
    BG_USB5000_MATCH_PACKET_5GBIT_STOP  = 8
End Enum

Public Enum BeagleUsb5000ErrorType
    BG_USB5000_MATCH_CRC_DONT_CARE    =    0
    BG_USB5000_MATCH_CRC_1_VALID      =    1
    BG_USB5000_MATCH_CRC_2_VALID      =    2
    BG_USB5000_MATCH_CRC_BOTH_VALID   =    3
    BG_USB5000_MATCH_CRC_EITHER_FAIL  =    4
    BG_USB5000_MATCH_CRC_1_FAIL       =    5
    BG_USB5000_MATCH_CRC_2_FAIL       =    6
    BG_USB5000_MATCH_CRC_BOTH_FAIL    =    7
    BG_USB5000_MATCH_ERR_MASK_CRC     = &H10
    BG_USB5000_MATCH_ERR_MASK_FRAMING = &H20
    BG_USB5000_MATCH_ERR_MASK_UNKNOWN = &H40
End Enum

Public Const BG_USB5000_COMPLEX_MATCH_ACTION_EXTOUT = &H01
Public Const BG_USB5000_COMPLEX_MATCH_ACTION_TRIGGER = &H02
Public Const BG_USB5000_COMPLEX_MATCH_ACTION_FILTER = &H04
Public Const BG_USB5000_COMPLEX_MATCH_ACTION_GOTO = &H08

Public Type BeagleUsb5000DataMatchUnit
    packet_type             as Long
    match_other_packets     as Byte
    data()                  as Byte
    data_not                as Byte
    data_valid()            as Byte
    err_match               as Long
    data_properties_valid   as Byte
    data_properties         as BeagleUsb5000DataProperties
    repeat_count            as Integer
    sticky_action           as Byte
    action_mask             as Byte
    goto_selector           as Byte
End Type

Public Enum BeagleUsb5000TimerUnit
    BG_USB5000_TIMER_UNIT_DISABLED = 0
    BG_USB5000_TIMER_UNIT_NS       = 1
    BG_USB5000_TIMER_UNIT_US       = 2
    BG_USB5000_TIMER_UNIT_MS       = 3
    BG_USB5000_TIMER_UNIT_SEC      = 4
End Enum

Public Type BeagleUsb5000TimerMatchUnit
    timer_unit      as Long
    timer_val       as Long
    action_mask     as Byte
    goto_selector   as Byte
End Type

Public Enum BeagleUsb5000AsyncEventType
    BG_USB5000_COMPLEX_MATCH_EVENT_SSTX_LFPS     =  0
    BG_USB5000_COMPLEX_MATCH_EVENT_SSTX_POLARITY =  1
    BG_USB5000_COMPLEX_MATCH_EVENT_SSTX_DETECTED =  2
    BG_USB5000_COMPLEX_MATCH_EVENT_SSTX_SCRAMBL  =  3
    BG_USB5000_COMPLEX_MATCH_EVENT_SSRX_LFPS     =  4
    BG_USB5000_COMPLEX_MATCH_EVENT_SSRX_POLARITY =  5
    BG_USB5000_COMPLEX_MATCH_EVENT_SSRX_DETECTED =  6
    BG_USB5000_COMPLEX_MATCH_EVENT_SSRX_SCRAMBL  =  7

    BG_USB5000_COMPLEX_MATCH_EVENT_VBUS_PRESENT  = 11
    BG_USB5000_COMPLEX_MATCH_EVENT_SSTX_PHYERR   = 12
    BG_USB5000_COMPLEX_MATCH_EVENT_SSRX_PHYERR   = 13
    BG_USB5000_COMPLEX_MATCH_EVENT_EXTTRIG       = 14
End Enum

Public Type BeagleUsb5000AsyncEventMatchUnit
    event_type      as Long
    edge_mask       as Byte
    repeat_count    as Integer
    sticky_action   as Byte
    action_mask     as Byte
    goto_selector   as Byte
End Type

Public Type BeagleUsb5000ComplexMatchState
    tx_data_0_valid   as Byte
    tx_data_0         as BeagleUsb5000DataMatchUnit
    tx_data_1_valid   as Byte
    tx_data_1         as BeagleUsb5000DataMatchUnit
    tx_data_2_valid   as Byte
    tx_data_2         as BeagleUsb5000DataMatchUnit
    rx_data_0_valid   as Byte
    rx_data_0         as BeagleUsb5000DataMatchUnit
    rx_data_1_valid   as Byte
    rx_data_1         as BeagleUsb5000DataMatchUnit
    rx_data_2_valid   as Byte
    rx_data_2         as BeagleUsb5000DataMatchUnit
    timer_valid       as Byte
    timer             as BeagleUsb5000TimerMatchUnit
    async_valid       as Byte
    async             as BeagleUsb5000AsyncEventMatchUnit
    goto_0            as Byte
    goto_1            as Byte
    goto_2            as Byte
End Type

Public Enum BeagleUsb5000ExtoutType
    BG_USB5000_EXTOUT_LOW       = 0
    BG_USB5000_EXTOUT_HIGH      = 1
    BG_USB5000_EXTOUT_POS_PULSE = 2
    BG_USB5000_EXTOUT_NEG_PULSE = 3
    BG_USB5000_EXTOUT_TOGGLE_0  = 4
    BG_USB5000_EXTOUT_TOGGLE_1  = 5
End Enum

Public Const BG_USB5000_EQUALIZATION_OFF = 0
Public Const BG_USB5000_EQUALIZATION_MIN = 1
Public Const BG_USB5000_EQUALIZATION_MOD = 2
Public Const BG_USB5000_EQUALIZATION_MAX = 3

Public Type BeagleUsb5000Channel
    input_equalization_short    as Byte
    input_equalization_medium   as Byte
    input_equalization_long     as Byte
    pre_emphasis_short_level    as Byte
    pre_emphasis_short_decay    as Byte
    pre_emphasis_long_level     as Byte
    pre_emphasis_long_decay     as Byte
    output_level                as Byte
End Type

Public Enum BeagleMdioClause
    BG_MDIO_CLAUSE_22    = 0
    BG_MDIO_CLAUSE_45    = 1
    BG_MDIO_CLAUSE_ERROR = 2
End Enum

Public Const BG_MDIO_OPCODE22_WRITE = &H01
Public Const BG_MDIO_OPCODE22_READ = &H02
Public Const BG_MDIO_OPCODE22_ERROR = &Hff
Public Const BG_MDIO_OPCODE45_ADDR = &H00
Public Const BG_MDIO_OPCODE45_WRITE = &H01
Public Const BG_MDIO_OPCODE45_READ_POSTINC = &H02
Public Const BG_MDIO_OPCODE45_READ = &H03

Private Declare Function vb6_bg_find_devices Lib "beagle.dll" (ByVal num_devices As Long, ByRef devices As Integer) as Long
Private Declare Function vb6_bg_find_devices_ext Lib "beagle.dll" (ByVal num_devices As Long, ByRef devices As Integer, ByVal num_ids As Long, ByRef unique_ids As Long) as Long
Private Declare Function vb6_bg_open Lib "beagle.dll" (ByVal port_number As Long) as Long
Private Declare Function vb6_bg_open_ext Lib "beagle.dll" (ByVal port_number As Long, ByRef bg_ext As BeagleExt) as Long
Private Declare Function vb6_bg_close Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_port Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_features Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_unique_id_to_features Lib "beagle.dll" (ByVal unique_id As Long) as Long
Private Declare Function vb6_bg_unique_id Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_status_string Lib "beagle.dll" (ByVal status As Long) as String
Private Declare Function vb6_bg_version Lib "beagle.dll" (ByVal beagle As Long, ByRef version As BeagleVersion) as Long
Private Declare Function vb6_bg_latency Lib "beagle.dll" (ByVal beagle As Long, ByVal milliseconds As Long) as Long
Private Declare Function vb6_bg_timeout Lib "beagle.dll" (ByVal beagle As Long, ByVal milliseconds As Long) as Long
Private Declare Function vb6_bg_sleep_ms Lib "beagle.dll" (ByVal milliseconds As Long) as Long
Private Declare Function vb6_bg_target_power Lib "beagle.dll" (ByVal beagle As Long, ByVal power_flag As Byte) as Long
Private Declare Function vb6_bg_host_ifce_speed Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_dev_addr Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_host_buffer_size Lib "beagle.dll" (ByVal beagle As Long, ByVal num_bytes As Long) as Long
Private Declare Function vb6_bg_host_buffer_free Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_host_buffer_used Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_commtest Lib "beagle.dll" (ByVal beagle As Long, ByVal num_samples As Long, ByVal delay_count As Long) as Long
Private Declare Function vb6_bg_enable Lib "beagle.dll" (ByVal beagle As Long, ByVal protocol As Long) as Long
Private Declare Function vb6_bg_disable Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_samplerate Lib "beagle.dll" (ByVal beagle As Long, ByVal samplerate_khz As Long) as Long
Private Declare Function vb6_bg_bit_timing_size Lib "beagle.dll" (ByVal protocol As Long, ByVal num_data_bytes As Long) as Long
Private Declare Function vb6_bg_i2c_pullup Lib "beagle.dll" (ByVal beagle As Long, ByVal pullup_flag As Byte) as Long
Private Declare Function vb6_bg_i2c_read Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef data_in As Integer) as Long
Private Declare Function vb6_bg_i2c_read_data_timing Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef data_in As Integer, ByVal max_timing As Long, ByRef data_timing As Long) as Long
Private Declare Function vb6_bg_i2c_read_bit_timing Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef data_in As Integer, ByVal max_timing As Long, ByRef bit_timing As Long) as Long
Private Declare Function vb6_bg_spi_configure Lib "beagle.dll" (ByVal beagle As Long, ByVal ss_polarity As Long, ByVal sck_sampling_edge As Long, ByVal bitorder As Long) as Long
Private Declare Function vb6_bg_spi_read Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal mosi_max_bytes As Long, ByRef data_mosi As Byte, ByVal miso_max_bytes As Long, ByRef data_miso As Byte) as Long
Private Declare Function vb6_bg_spi_read_data_timing Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal mosi_max_bytes As Long, ByRef data_mosi As Byte, ByVal miso_max_bytes As Long, ByRef data_miso As Byte, ByVal max_timing As Long, ByRef data_timing As Long) as Long
Private Declare Function vb6_bg_spi_read_bit_timing Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal mosi_max_bytes As Long, ByRef data_mosi As Byte, ByVal miso_max_bytes As Long, ByRef data_miso As Byte, ByVal max_timing As Long, ByRef bit_timing As Long) as Long
Private Declare Function vb6_bg_usb12_read Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef events As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef packet As Byte) as Long
Private Declare Function vb6_bg_usb12_read_data_timing Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef events As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef packet As Byte, ByVal max_timing As Long, ByRef data_timing As Long) as Long
Private Declare Function vb6_bg_usb12_read_bit_timing Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef events As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef packet As Byte, ByVal max_timing As Long, ByRef bit_timing As Long) as Long
Private Declare Function vb6_bg_usb480_capture_configure Lib "beagle.dll" (ByVal beagle As Long, ByVal capture_mode As Long, ByVal target_speed As Long) as Long
Private Declare Function vb6_bg_usb480_digital_out_config Lib "beagle.dll" (ByVal beagle As Long, ByVal out_enable_mask As Byte, ByVal out_polarity_mask As Byte) as Long
Private Declare Function vb6_bg_usb480_digital_out_match Lib "beagle.dll" (ByVal beagle As Long, ByVal pin_num As Long, ByRef packet_match As BeagleUsb2PacketMatch, ByRef data_match As BeagleUsb2DataMatch) as Long
Private Declare Function vb6_bg_usb480_digital_in_config Lib "beagle.dll" (ByVal beagle As Long, ByVal in_enable_mask As Byte) as Long
Private Declare Function vb6_bg_usb480_hw_filter_config Lib "beagle.dll" (ByVal beagle As Long, ByVal filter_enable_mask As Byte) as Long
Private Declare Function vb6_bg_usb480_hw_buffer_stats Lib "beagle.dll" (ByVal beagle As Long, ByRef buffer_size As Long, ByRef buffer_usage As Long, ByRef buffer_full As Byte) as Long
Private Declare Function vb6_bg_usb480_read Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef events As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef packet As Byte) as Long
Private Declare Function vb6_bg_usb480_reconstruct_timing Lib "beagle.dll" (ByVal speed As Long, ByVal num_bytes As Long, ByRef packet As Byte, ByVal max_timing As Long, ByRef bit_timing As Long) as Long
Private Declare Function vb6_bg_usb5000_license_read Lib "beagle.dll" (ByVal beagle As Long, ByVal length As Long, ByRef license_key As Byte) as Long
Private Declare Function vb6_bg_usb5000_license_write Lib "beagle.dll" (ByVal beagle As Long, ByVal length As Long, ByRef license_key As Byte) as Long
Private Declare Function vb6_bg_usb5000_features Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_usb5000_configure Lib "beagle.dll" (ByVal beagle As Long, ByVal cap_mask As Byte, ByVal trigger_mode As Long) as Long
Private Declare Function vb6_bg_usb5000_target_power Lib "beagle.dll" (ByVal beagle As Long, ByVal power_flag As Long) as Long
Private Declare Function vb6_bg_usb5000_usb2_hw_filter_config Lib "beagle.dll" (ByVal beagle As Long, ByVal filter_enable_mask As Byte) as Long
Private Declare Function vb6_bg_usb5000_usb2_digital_in_config Lib "beagle.dll" (ByVal beagle As Long, ByVal in_enable_mask As Byte) as Long
Private Declare Function vb6_bg_usb5000_usb2_digital_out_config Lib "beagle.dll" (ByVal beagle As Long, ByVal out_enable_mask As Byte, ByVal out_polarity_mask As Byte) as Long
Private Declare Function vb6_bg_usb5000_usb2_digital_out_match Lib "beagle.dll" (ByVal beagle As Long, ByVal pin_num As Long, ByRef packet_match As BeagleUsb2PacketMatch, ByRef data_match As BeagleUsb2DataMatch) as Long
Private Declare Function vb6_bg_usb5000_usb2_target_configure Lib "beagle.dll" (ByVal beagle As Long, ByVal target_speed As Long) as Long
Private Declare Function vb6_bg_usb5000_usb2_simple_match_config Lib "beagle.dll" (ByVal beagle As Long, ByVal dig_in_pin_pos_edge_mask As Byte, ByVal dig_in_pin_neg_edge_mask As Byte, ByVal dig_out_match_pin_mask As Byte) as Long
Private Declare Function vb6_bg_usb5000_usb2_memory_test Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_usb5000_usb2_capture_config Lib "beagle.dll" (ByVal beagle As Long, ByVal pretrig_kb As Long, ByVal capture_kb As Long) as Long
Private Declare Function vb6_bg_usb5000_usb2_capture_config_query Lib "beagle.dll" (ByVal beagle As Long, ByRef pretrig_kb As Long, ByRef capture_kb As Long) as Long
Private Declare Function vb6_bg_usb5000_usb3_phy_config Lib "beagle.dll" (ByVal beagle As Long, ByVal tx As Byte, ByVal rx As Byte) as Long
Private Declare Function vb6_bg_usb5000_usb3_memory_test Lib "beagle.dll" (ByVal beagle As Long, ByVal test As Long) as Long
Private Declare Function vb6_bg_usb5000_usb3_capture_config Lib "beagle.dll" (ByVal beagle As Long, ByVal pretrig_kb As Long, ByVal capture_kb As Long) as Long
Private Declare Function vb6_bg_usb5000_usb3_capture_config_query Lib "beagle.dll" (ByVal beagle As Long, ByRef pretrig_kb As Long, ByRef capture_kb As Long) as Long
Private Declare Function vb6_bg_usb5000_usb3_capture_status Lib "beagle.dll" (ByVal beagle As Long, ByVal timeout_ms As Long, ByRef status As Long, ByRef pretrig_remaining_kb As Long, ByRef pretrig_total_kb As Long, ByRef capture_remaining_kb As Long, ByRef capture_total_kb As Long) as Long
Private Declare Function vb6_bg_usb5000_usb2_capture_status Lib "beagle.dll" (ByVal beagle As Long, ByVal timeout_ms As Long, ByRef status As Long, ByRef pretrig_remaining_kb As Long, ByRef pretrig_total_kb As Long, ByRef capture_remaining_kb As Long, ByRef capture_total_kb As Long) as Long
Private Declare Function vb6_bg_usb5000_capture_abort Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_usb5000_capture_trigger Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_usb5000_usb3_truncation_mode Lib "beagle.dll" (ByVal beagle As Long, ByVal tx_truncation_mode As Byte, ByVal rx_truncation_mode As Byte) as Long
Private Declare Function vb6_bg_usb5000_usb3_simple_match_config Lib "beagle.dll" (ByVal beagle As Long, ByVal trigger_mask As Long, ByVal extout_mask As Long, ByVal extout_mode As Long, ByVal extin_edge_mask As Byte, ByVal tx_ips_type As Long, ByVal rx_ips_type As Long) as Long
Private Declare Function vb6_bg_usb5000_usb3_complex_match_enable Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_usb5000_usb3_complex_match_disable Lib "beagle.dll" (ByVal beagle As Long) as Long
Private Declare Function vb6_bg_usb5000_usb3_complex_match_config Lib "beagle.dll" (ByVal beagle As Long, ByVal validate As Byte, ByVal extout As Byte, ByRef state_0 As BeagleUsb5000ComplexMatchState, ByRef state_1 As BeagleUsb5000ComplexMatchState, ByRef state_2 As BeagleUsb5000ComplexMatchState, ByRef state_3 As BeagleUsb5000ComplexMatchState, ByRef state_4 As BeagleUsb5000ComplexMatchState, ByRef state_5 As BeagleUsb5000ComplexMatchState, ByRef state_6 As BeagleUsb5000ComplexMatchState, ByRef state_7 As BeagleUsb5000ComplexMatchState) as Long
Private Declare Function vb6_bg_usb5000_usb3_complex_match_config_single Lib "beagle.dll" (ByVal beagle As Long, ByVal validate As Byte, ByVal extout As Byte, ByRef state As BeagleUsb5000ComplexMatchState) as Long
Private Declare Function vb6_bg_usb5000_usb3_ext_io_config Lib "beagle.dll" (ByVal beagle As Long, ByVal extin_enable As Byte, ByVal extout_modulation As Long) as Long
Private Declare Function vb6_bg_usb5000_usb3_link_config Lib "beagle.dll" (ByVal beagle As Long, ByRef tx As BeagleUsb5000Channel, ByRef rx As BeagleUsb5000Channel) as Long
Private Declare Function vb6_bg_usb5000_read Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef events As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByRef source As Long, ByVal max_bytes As Long, ByRef packet As Byte, ByVal max_k_bytes As Long, ByRef k_data As Byte) as Long
Private Declare Function vb6_bg_mdio_read Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByRef data_in As Long) as Long
Private Declare Function vb6_bg_mdio_read_bit_timing Lib "beagle.dll" (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByRef data_in As Long, ByVal max_timing As Long, ByRef bit_timing As Long) as Long
Private Declare Function vb6_bg_mdio_parse Lib "beagle.dll" (ByVal packet As Long, ByRef clause As Byte, ByRef opcode As Byte, ByRef addr1 As Byte, ByRef addr2 As Byte, ByRef data As Integer) as Long


'==========================================================================
' VERSION
'==========================================================================
Public Const BG_API_VERSION    = &H040a   ' v4.10
Public Const BG_REQ_SW_VERSION = &H040a   ' v4.10

Private Declare Function bg_std_version Lib "beagle.dll" () as Long
Dim BG_VERSION_OK as Boolean

Private Function check_version () as Boolean
    If BG_VERSION_OK Then
        check_version = True
    Else
        Dim sw_version As Long
        Dim req_api_version As Long
        sw_version = bg_std_version() And &Hffff
        req_api_version = (bg_std_version() / 65536) And &Hffff
        BG_VERSION_OK = ((sw_version >= BG_REQ_SW_VERSION) And (BG_API_VERSION >= req_api_version))
        check_version = BG_VERSION_OK
    End If
End Function

'==========================================================================
' HELPER FUNCTIONS
'==========================================================================
Public Function tp_min (ByVal x As Variant, ByVal y As Variant) as Variant
    If x > y Then
        tp_min = y
    Else
        tp_min = x
    End If
End Function


'==========================================================================
' STATUS CODES
'==========================================================================
' All API functions return an integer which is the result of the
' transaction, or a status code if negative.  The status codes are
' defined as follows:

'==========================================================================
' GENERAL TYPE DEFINITIONS
'==========================================================================
' Beagle handle type definition
' typedef Beagle => Long

' Beagle version matrix.
'
' This matrix describes the various version dependencies
' of Beagle components.  It can be used to determine
' which component caused an incompatibility error.
'
' All version numbers are of the format:
'   (major << 8) | minor
'
' ex. v1.20 would be encoded as:  0x0114

'==========================================================================
' GENERAL API
'==========================================================================
' Get a list of ports to which Beagle devices are attached.
'
' num_devices = maximum number of elements to return
' devices     = array into which the port numbers are returned
'
' Each element of the array is written with the port number.
' Devices that are in-use are ORed with BG_PORT_NOT_FREE
' (0x8000).
'
' ex.  devices are attached to ports 0, 1, 2
'      ports 0 and 2 are available, and port 1 is in-use.
'      array => 0x0000, 0x8001, 0x0002
'
' If the array is NULL, it is not filled with any values.
' If there are more devices than the array size, only the
' first nmemb port numbers will be written into the array.
'
' Returns the number of devices found, regardless of the
' array size.

Public Function bg_find_devices (ByVal num_devices As Long, ByRef devices() As Integer) as Long
    If check_version() Then
        Dim devices_num_devices As Long
        devices_num_devices = tp_min(num_devices, UBound(devices) - LBound(devices) + 1)
        bg_find_devices = vb6_bg_find_devices(devices_num_devices, devices(0))
    Else
        bg_find_devices = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Get a list of ports to which Beagle devices are attached
'
' This function is the same as bg_find_devices() except that
' it returns the unique IDs of each Beagle device.  The IDs
' are guaranteed to be non-zero if valid.
'
' The IDs are the unsigned integer representation of the 10-digit
' serial numbers.

Public Function bg_find_devices_ext (ByVal num_devices As Long, ByRef devices() As Integer, ByVal num_ids As Long, ByRef unique_ids() As Long) as Long
    If check_version() Then
        Dim devices_num_devices As Long
        devices_num_devices = tp_min(num_devices, UBound(devices) - LBound(devices) + 1)
        Dim unique_ids_num_ids As Long
        unique_ids_num_ids = tp_min(num_ids, UBound(unique_ids) - LBound(unique_ids) + 1)
        bg_find_devices_ext = vb6_bg_find_devices_ext(devices_num_devices, devices(0), unique_ids_num_ids, unique_ids(0))
    Else
        bg_find_devices_ext = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Open the Beagle port.
'
' The port number is a zero-indexed integer.
'
' The port number is the same as that obtained from the
' bg_find_devices() function above.
'
' Returns an Beagle handle, which is guaranteed to be
' greater than zero if it is valid.
'
' This function is recommended for use in simple applications
' where extended information is not required.  For more complex
' applications, the use of bg_open_ext() is recommended.

Public Function bg_open (ByVal port_number As Long) as Long
    If check_version() Then
        bg_open = vb6_bg_open(port_number)
    Else
        bg_open = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Open the Beagle port, returning extended information
' in the supplied structure.  Behavior is otherwise identical
' to bg_open() above.  If 0 is passed as the pointer to the
' structure, this function is exactly equivalent to bg_open().
'
' The structure is zeroed before the open is attempted.
' It is filled with whatever information is available.
'
' For example, if the hardware version is not filled, then
' the device could not be queried for its version number.
'
' This function is recommended for use in complex applications
' where extended information is required.  For more simple
' applications, the use of bg_open() is recommended.

Public Function bg_open_ext (ByVal port_number As Long, ByRef bg_ext As BeagleExt) as Long
    If check_version() Then
        bg_open_ext = vb6_bg_open_ext(port_number, bg_ext)
    Else
        bg_open_ext = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Close the Beagle port.

Public Function bg_close (ByVal beagle As Long) as Long
    If check_version() Then
        bg_close = vb6_bg_close(beagle)
    Else
        bg_close = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Return the port for this Beagle handle.
'
' The port number is a zero-indexed integer.

Public Function bg_port (ByVal beagle As Long) as Long
    If check_version() Then
        bg_port = vb6_bg_port(beagle)
    Else
        bg_port = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Return the device features as a bit-mask of values, or
' an error code if the handle is not valid.

Public Function bg_features (ByVal beagle As Long) as Long
    If check_version() Then
        bg_features = vb6_bg_features(beagle)
    Else
        bg_features = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_unique_id_to_features (ByVal unique_id As Long) as Long
    If check_version() Then
        bg_unique_id_to_features = vb6_bg_unique_id_to_features(unique_id)
    Else
        bg_unique_id_to_features = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Return the unique ID for this Beagle adapter.
' IDs are guaranteed to be non-zero if valid.
' The ID is the unsigned integer representation of the
' 10-digit serial number.

Public Function bg_unique_id (ByVal beagle As Long) as Long
    If check_version() Then
        bg_unique_id = vb6_bg_unique_id(beagle)
    Else
        bg_unique_id = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Return the status string for the given status code.
' If the code is not valid or the library function cannot
' be loaded, return a NULL string.

Public Function bg_status_string (ByVal status As Long) as String
    If check_version() Then
        bg_status_string = vb6_bg_status_string(status)
    Else
        bg_status_string = vbNullString
    End If
End Function


' Return the version matrix for the device attached to the
' given handle.  If the handle is 0 or invalid, only the
' software and required api versions are set.

Public Function bg_version (ByVal beagle As Long, ByRef version As BeagleVersion) as Long
    If check_version() Then
        bg_version = vb6_bg_version(beagle, version)
    Else
        bg_version = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Set the capture latency to the specified number of milliseconds.
' This number determines the minimum time that a read call will
' block if there is no available data.  Lower times result in
' faster turnaround at the expense of reduced buffering.  Setting
' this parameter too low can cause packets to be dropped.

Public Function bg_latency (ByVal beagle As Long, ByVal milliseconds As Long) as Long
    If check_version() Then
        bg_latency = vb6_bg_latency(beagle, milliseconds)
    Else
        bg_latency = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Set the capture timeout to the specified number of milliseconds.
' If any read call has a longer idle than this value, that call
' will return with a count of 0 bytes.

Public Function bg_timeout (ByVal beagle As Long, ByVal milliseconds As Long) as Long
    If check_version() Then
        bg_timeout = vb6_bg_timeout(beagle, milliseconds)
    Else
        bg_timeout = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Sleep for the specified number of milliseconds
' Accuracy depends on the operating system scheduler
' Returns the number of milliseconds slept

Public Function bg_sleep_ms (ByVal milliseconds As Long) as Long
    If check_version() Then
        bg_sleep_ms = vb6_bg_sleep_ms(milliseconds)
    Else
        bg_sleep_ms = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Configure the target power pin.

Public Function bg_target_power (ByVal beagle As Long, ByVal power_flag As Byte) as Long
    If check_version() Then
        bg_target_power = vb6_bg_target_power(beagle, power_flag)
    Else
        bg_target_power = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_host_ifce_speed (ByVal beagle As Long) as Long
    If check_version() Then
        bg_host_ifce_speed = vb6_bg_host_ifce_speed(beagle)
    Else
        bg_host_ifce_speed = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Returns the device address that the beagle is attached to.

Public Function bg_dev_addr (ByVal beagle As Long) as Long
    If check_version() Then
        bg_dev_addr = vb6_bg_dev_addr(beagle)
    Else
        bg_dev_addr = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



'==========================================================================
' BUFFERING API
'==========================================================================
' Set the amount of buffering that is to be allocated on the PC.
' Pass zero to num_bytes to query the existing buffer size.

Public Function bg_host_buffer_size (ByVal beagle As Long, ByVal num_bytes As Long) as Long
    If check_version() Then
        bg_host_buffer_size = vb6_bg_host_buffer_size(beagle, num_bytes)
    Else
        bg_host_buffer_size = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Query the amount of buffering that is unused and free for buffering.

Public Function bg_host_buffer_free (ByVal beagle As Long) as Long
    If check_version() Then
        bg_host_buffer_free = vb6_bg_host_buffer_free(beagle)
    Else
        bg_host_buffer_free = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Query the amount of buffering that is used and no longer available.

Public Function bg_host_buffer_used (ByVal beagle As Long) as Long
    If check_version() Then
        bg_host_buffer_used = vb6_bg_host_buffer_used(beagle)
    Else
        bg_host_buffer_used = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Benchmark the speed of the host to Beagle interface

Public Function bg_commtest (ByVal beagle As Long, ByVal num_samples As Long, ByVal delay_count As Long) as Long
    If check_version() Then
        bg_commtest = vb6_bg_commtest(beagle, num_samples, delay_count)
    Else
        bg_commtest = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



'==========================================================================
' MONITORING API
'==========================================================================
' Protocol codes
' Common Beagle read status codes
' PARTIAL_LAST_BYTE Unused by USB 480 and 5000
' Enable the Beagle monitor

Public Function bg_enable (ByVal beagle As Long, ByVal protocol As Long) as Long
    If check_version() Then
        bg_enable = vb6_bg_enable(beagle, protocol)
    Else
        bg_enable = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Disable the Beagle monitor

Public Function bg_disable (ByVal beagle As Long) as Long
    If check_version() Then
        bg_disable = vb6_bg_disable(beagle)
    Else
        bg_disable = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Set the sample rate in kilohertz.

Public Function bg_samplerate (ByVal beagle As Long, ByVal samplerate_khz As Long) as Long
    If check_version() Then
        bg_samplerate = vb6_bg_samplerate(beagle, samplerate_khz)
    Else
        bg_samplerate = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Get the number of bits for the given number of bytes in the
' given protocol.
' Use this to determine how large a bit_timing array to allocate
' for bg_*_read_bit_timing functions.

Public Function bg_bit_timing_size (ByVal protocol As Long, ByVal num_data_bytes As Long) as Long
    If check_version() Then
        bg_bit_timing_size = vb6_bg_bit_timing_size(protocol, num_data_bytes)
    Else
        bg_bit_timing_size = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



'==========================================================================
' I2C API
'==========================================================================
' Configure the I2C pullup resistors.

Public Function bg_i2c_pullup (ByVal beagle As Long, ByVal pullup_flag As Byte) as Long
    If check_version() Then
        bg_i2c_pullup = vb6_bg_i2c_pullup(beagle, pullup_flag)
    Else
        bg_i2c_pullup = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_i2c_read (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef data_in() As Integer) as Long
    If check_version() Then
        Dim data_in_max_bytes As Long
        data_in_max_bytes = tp_min(max_bytes, UBound(data_in) - LBound(data_in) + 1)
        bg_i2c_read = vb6_bg_i2c_read(beagle, status, time_sop, time_duration, time_dataoffset, data_in_max_bytes, data_in(0))
    Else
        bg_i2c_read = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_i2c_read_data_timing (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef data_in() As Integer, ByVal max_timing As Long, ByRef data_timing() As Long) as Long
    If check_version() Then
        Dim data_in_max_bytes As Long
        data_in_max_bytes = tp_min(max_bytes, UBound(data_in) - LBound(data_in) + 1)
        Dim data_timing_max_timing As Long
        data_timing_max_timing = tp_min(max_timing, UBound(data_timing) - LBound(data_timing) + 1)
        bg_i2c_read_data_timing = vb6_bg_i2c_read_data_timing(beagle, status, time_sop, time_duration, time_dataoffset, data_in_max_bytes, data_in(0), data_timing_max_timing, data_timing(0))
    Else
        bg_i2c_read_data_timing = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_i2c_read_bit_timing (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef data_in() As Integer, ByVal max_timing As Long, ByRef bit_timing() As Long) as Long
    If check_version() Then
        Dim data_in_max_bytes As Long
        data_in_max_bytes = tp_min(max_bytes, UBound(data_in) - LBound(data_in) + 1)
        Dim bit_timing_max_timing As Long
        bit_timing_max_timing = tp_min(max_timing, UBound(bit_timing) - LBound(bit_timing) + 1)
        bg_i2c_read_bit_timing = vb6_bg_i2c_read_bit_timing(beagle, status, time_sop, time_duration, time_dataoffset, data_in_max_bytes, data_in(0), bit_timing_max_timing, bit_timing(0))
    Else
        bg_i2c_read_bit_timing = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



'==========================================================================
' SPI API
'==========================================================================

Public Function bg_spi_configure (ByVal beagle As Long, ByVal ss_polarity As Long, ByVal sck_sampling_edge As Long, ByVal bitorder As Long) as Long
    If check_version() Then
        bg_spi_configure = vb6_bg_spi_configure(beagle, ss_polarity, sck_sampling_edge, bitorder)
    Else
        bg_spi_configure = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_spi_read (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal mosi_max_bytes As Long, ByRef data_mosi() As Byte, ByVal miso_max_bytes As Long, ByRef data_miso() As Byte) as Long
    If check_version() Then
        Dim data_mosi_mosi_max_bytes As Long
        data_mosi_mosi_max_bytes = tp_min(mosi_max_bytes, UBound(data_mosi) - LBound(data_mosi) + 1)
        Dim data_miso_miso_max_bytes As Long
        data_miso_miso_max_bytes = tp_min(miso_max_bytes, UBound(data_miso) - LBound(data_miso) + 1)
        bg_spi_read = vb6_bg_spi_read(beagle, status, time_sop, time_duration, time_dataoffset, data_mosi_mosi_max_bytes, data_mosi(0), data_miso_miso_max_bytes, data_miso(0))
    Else
        bg_spi_read = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_spi_read_data_timing (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal mosi_max_bytes As Long, ByRef data_mosi() As Byte, ByVal miso_max_bytes As Long, ByRef data_miso() As Byte, ByVal max_timing As Long, ByRef data_timing() As Long) as Long
    If check_version() Then
        Dim data_mosi_mosi_max_bytes As Long
        data_mosi_mosi_max_bytes = tp_min(mosi_max_bytes, UBound(data_mosi) - LBound(data_mosi) + 1)
        Dim data_miso_miso_max_bytes As Long
        data_miso_miso_max_bytes = tp_min(miso_max_bytes, UBound(data_miso) - LBound(data_miso) + 1)
        Dim data_timing_max_timing As Long
        data_timing_max_timing = tp_min(max_timing, UBound(data_timing) - LBound(data_timing) + 1)
        bg_spi_read_data_timing = vb6_bg_spi_read_data_timing(beagle, status, time_sop, time_duration, time_dataoffset, data_mosi_mosi_max_bytes, data_mosi(0), data_miso_miso_max_bytes, data_miso(0), data_timing_max_timing, data_timing(0))
    Else
        bg_spi_read_data_timing = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_spi_read_bit_timing (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal mosi_max_bytes As Long, ByRef data_mosi() As Byte, ByVal miso_max_bytes As Long, ByRef data_miso() As Byte, ByVal max_timing As Long, ByRef bit_timing() As Long) as Long
    If check_version() Then
        Dim data_mosi_mosi_max_bytes As Long
        data_mosi_mosi_max_bytes = tp_min(mosi_max_bytes, UBound(data_mosi) - LBound(data_mosi) + 1)
        Dim data_miso_miso_max_bytes As Long
        data_miso_miso_max_bytes = tp_min(miso_max_bytes, UBound(data_miso) - LBound(data_miso) + 1)
        Dim bit_timing_max_timing As Long
        bit_timing_max_timing = tp_min(max_timing, UBound(bit_timing) - LBound(bit_timing) + 1)
        bg_spi_read_bit_timing = vb6_bg_spi_read_bit_timing(beagle, status, time_sop, time_duration, time_dataoffset, data_mosi_mosi_max_bytes, data_mosi(0), data_miso_miso_max_bytes, data_miso(0), bit_timing_max_timing, bit_timing(0))
    Else
        bg_spi_read_bit_timing = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



'==========================================================================
' USB API
'==========================================================================
' USB packet PID definitions
' The following codes are returned for USB 12, 480, and 5000 captures
' The following codes are only returned for USB 12 captures
' The following codes are only returned for USB 480 and 5000  captures
' The following codes are only returned for USB 5000 captures
' The following events are returned for USB 12, 480, and 5000 captures
' USB 480 specific event codes
' USB 5000 specific event codes for US, DS, and ASYNC streams

'==========================================================================
' USB 12 API
'==========================================================================

Public Function bg_usb12_read (ByVal beagle As Long, ByRef status As Long, ByRef events As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef packet() As Byte) as Long
    If check_version() Then
        Dim packet_max_bytes As Long
        packet_max_bytes = tp_min(max_bytes, UBound(packet) - LBound(packet) + 1)
        bg_usb12_read = vb6_bg_usb12_read(beagle, status, events, time_sop, time_duration, time_dataoffset, packet_max_bytes, packet(0))
    Else
        bg_usb12_read = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb12_read_data_timing (ByVal beagle As Long, ByRef status As Long, ByRef events As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef packet() As Byte, ByVal max_timing As Long, ByRef data_timing() As Long) as Long
    If check_version() Then
        Dim packet_max_bytes As Long
        packet_max_bytes = tp_min(max_bytes, UBound(packet) - LBound(packet) + 1)
        Dim data_timing_max_timing As Long
        data_timing_max_timing = tp_min(max_timing, UBound(data_timing) - LBound(data_timing) + 1)
        bg_usb12_read_data_timing = vb6_bg_usb12_read_data_timing(beagle, status, events, time_sop, time_duration, time_dataoffset, packet_max_bytes, packet(0), data_timing_max_timing, data_timing(0))
    Else
        bg_usb12_read_data_timing = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb12_read_bit_timing (ByVal beagle As Long, ByRef status As Long, ByRef events As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef packet() As Byte, ByVal max_timing As Long, ByRef bit_timing() As Long) as Long
    If check_version() Then
        Dim packet_max_bytes As Long
        packet_max_bytes = tp_min(max_bytes, UBound(packet) - LBound(packet) + 1)
        Dim bit_timing_max_timing As Long
        bit_timing_max_timing = tp_min(max_timing, UBound(bit_timing) - LBound(bit_timing) + 1)
        bg_usb12_read_bit_timing = vb6_bg_usb12_read_bit_timing(beagle, status, events, time_sop, time_duration, time_dataoffset, packet_max_bytes, packet(0), bit_timing_max_timing, bit_timing(0))
    Else
        bg_usb12_read_bit_timing = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



'==========================================================================
' USB 480 API
'==========================================================================
' General constants
' Capture modes
' Target speeds

Public Function bg_usb480_capture_configure (ByVal beagle As Long, ByVal capture_mode As Long, ByVal target_speed As Long) as Long
    If check_version() Then
        bg_usb480_capture_configure = vb6_bg_usb480_capture_configure(beagle, capture_mode, target_speed)
    Else
        bg_usb480_capture_configure = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Digital output configuration

Public Function bg_usb480_digital_out_config (ByVal beagle As Long, ByVal out_enable_mask As Byte, ByVal out_polarity_mask As Byte) as Long
    If check_version() Then
        bg_usb480_digital_out_config = vb6_bg_usb480_digital_out_config(beagle, out_enable_mask, out_polarity_mask)
    Else
        bg_usb480_digital_out_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Digital output match pin configuration
' Packet matching modes
' Digital ouput matching configuration
' Data match PID mask

Public Function bg_usb480_digital_out_match (ByVal beagle As Long, ByVal pin_num As Long, ByRef packet_match As BeagleUsb2PacketMatch, ByRef data_match As BeagleUsb2DataMatch) as Long
    If check_version() Then
        bg_usb480_digital_out_match = vb6_bg_usb480_digital_out_match(beagle, pin_num, packet_match, data_match)
    Else
        bg_usb480_digital_out_match = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Digital input pin configuration

Public Function bg_usb480_digital_in_config (ByVal beagle As Long, ByVal in_enable_mask As Byte) as Long
    If check_version() Then
        bg_usb480_digital_in_config = vb6_bg_usb480_digital_in_config(beagle, in_enable_mask)
    Else
        bg_usb480_digital_in_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Hardware filtering configuration

Public Function bg_usb480_hw_filter_config (ByVal beagle As Long, ByVal filter_enable_mask As Byte) as Long
    If check_version() Then
        bg_usb480_hw_filter_config = vb6_bg_usb480_hw_filter_config(beagle, filter_enable_mask)
    Else
        bg_usb480_hw_filter_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb480_hw_buffer_stats (ByVal beagle As Long, ByRef buffer_size As Long, ByRef buffer_usage As Long, ByRef buffer_full As Byte) as Long
    If check_version() Then
        bg_usb480_hw_buffer_stats = vb6_bg_usb480_hw_buffer_stats(beagle, buffer_size, buffer_usage, buffer_full)
    Else
        bg_usb480_hw_buffer_stats = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb480_read (ByVal beagle As Long, ByRef status As Long, ByRef events As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByVal max_bytes As Long, ByRef packet() As Byte) as Long
    If check_version() Then
        Dim packet_max_bytes As Long
        packet_max_bytes = tp_min(max_bytes, UBound(packet) - LBound(packet) + 1)
        bg_usb480_read = vb6_bg_usb480_read(beagle, status, events, time_sop, time_duration, time_dataoffset, packet_max_bytes, packet(0))
    Else
        bg_usb480_read = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb480_reconstruct_timing (ByVal speed As Long, ByVal num_bytes As Long, ByRef packet() As Byte, ByVal max_timing As Long, ByRef bit_timing() As Long) as Long
    If check_version() Then
        Dim packet_num_bytes As Long
        packet_num_bytes = tp_min(num_bytes, UBound(packet) - LBound(packet) + 1)
        Dim bit_timing_max_timing As Long
        bit_timing_max_timing = tp_min(max_timing, UBound(bit_timing) - LBound(bit_timing) + 1)
        bg_usb480_reconstruct_timing = vb6_bg_usb480_reconstruct_timing(speed, packet_num_bytes, packet(0), bit_timing_max_timing, bit_timing(0))
    Else
        bg_usb480_reconstruct_timing = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



'==========================================================================
' USB 5000 API
'==========================================================================
' General constants
' License constants
' Read the license key string and return the features
' Length must be set to BG_USB5000_LICENSE_LENGTH in order
' for license_key to be populated.

Public Function bg_usb5000_license_read (ByVal beagle As Long, ByVal length As Long, ByRef license_key() As Byte) as Long
    If check_version() Then
        Dim license_key_length As Long
        license_key_length = tp_min(length, UBound(license_key) - LBound(license_key) + 1)
        bg_usb5000_license_read = vb6_bg_usb5000_license_read(beagle, license_key_length, license_key(0))
    Else
        bg_usb5000_license_read = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Write the license key string and return the features
' Length must be set to BG_USB5000_LICENSE_LENGTH.  If
' the license is not valid or the length is not set to
' BG_USB5000_LICENSE_LENGTH, an invalid license error is
' returned.

Public Function bg_usb5000_license_write (ByVal beagle As Long, ByVal length As Long, ByRef license_key() As Byte) as Long
    If check_version() Then
        Dim license_key_length As Long
        license_key_length = tp_min(length, UBound(license_key) - LBound(license_key) + 1)
        bg_usb5000_license_write = vb6_bg_usb5000_license_write(beagle, license_key_length, license_key(0))
    Else
        bg_usb5000_license_write = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Beagle USB 5000 feature bits

Public Function bg_usb5000_features (ByVal beagle As Long) as Long
    If check_version() Then
        bg_usb5000_features = vb6_bg_usb5000_features(beagle)
    Else
        bg_usb5000_features = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Capture modes
' Trigger modes

Public Function bg_usb5000_configure (ByVal beagle As Long, ByVal cap_mask As Byte, ByVal trigger_mode As Long) as Long
    If check_version() Then
        bg_usb5000_configure = vb6_bg_usb5000_configure(beagle, cap_mask, trigger_mode)
    Else
        bg_usb5000_configure = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' USB Target Power

Public Function bg_usb5000_target_power (ByVal beagle As Long, ByVal power_flag As Long) as Long
    If check_version() Then
        bg_usb5000_target_power = vb6_bg_usb5000_target_power(beagle, power_flag)
    Else
        bg_usb5000_target_power = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' USB 2 Configuration

Public Function bg_usb5000_usb2_hw_filter_config (ByVal beagle As Long, ByVal filter_enable_mask As Byte) as Long
    If check_version() Then
        bg_usb5000_usb2_hw_filter_config = vb6_bg_usb5000_usb2_hw_filter_config(beagle, filter_enable_mask)
    Else
        bg_usb5000_usb2_hw_filter_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb2_digital_in_config (ByVal beagle As Long, ByVal in_enable_mask As Byte) as Long
    If check_version() Then
        bg_usb5000_usb2_digital_in_config = vb6_bg_usb5000_usb2_digital_in_config(beagle, in_enable_mask)
    Else
        bg_usb5000_usb2_digital_in_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb2_digital_out_config (ByVal beagle As Long, ByVal out_enable_mask As Byte, ByVal out_polarity_mask As Byte) as Long
    If check_version() Then
        bg_usb5000_usb2_digital_out_config = vb6_bg_usb5000_usb2_digital_out_config(beagle, out_enable_mask, out_polarity_mask)
    Else
        bg_usb5000_usb2_digital_out_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb2_digital_out_match (ByVal beagle As Long, ByVal pin_num As Long, ByRef packet_match As BeagleUsb2PacketMatch, ByRef data_match As BeagleUsb2DataMatch) as Long
    If check_version() Then
        bg_usb5000_usb2_digital_out_match = vb6_bg_usb5000_usb2_digital_out_match(beagle, pin_num, packet_match, data_match)
    Else
        bg_usb5000_usb2_digital_out_match = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb2_target_configure (ByVal beagle As Long, ByVal target_speed As Long) as Long
    If check_version() Then
        bg_usb5000_usb2_target_configure = vb6_bg_usb5000_usb2_target_configure(beagle, target_speed)
    Else
        bg_usb5000_usb2_target_configure = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb2_simple_match_config (ByVal beagle As Long, ByVal dig_in_pin_pos_edge_mask As Byte, ByVal dig_in_pin_neg_edge_mask As Byte, ByVal dig_out_match_pin_mask As Byte) as Long
    If check_version() Then
        bg_usb5000_usb2_simple_match_config = vb6_bg_usb5000_usb2_simple_match_config(beagle, dig_in_pin_pos_edge_mask, dig_in_pin_neg_edge_mask, dig_out_match_pin_mask)
    Else
        bg_usb5000_usb2_simple_match_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb2_memory_test (ByVal beagle As Long) as Long
    If check_version() Then
        bg_usb5000_usb2_memory_test = vb6_bg_usb5000_usb2_memory_test(beagle)
    Else
        bg_usb5000_usb2_memory_test = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' USB 2 Capture modes

Public Function bg_usb5000_usb2_capture_config (ByVal beagle As Long, ByVal pretrig_kb As Long, ByVal capture_kb As Long) as Long
    If check_version() Then
        bg_usb5000_usb2_capture_config = vb6_bg_usb5000_usb2_capture_config(beagle, pretrig_kb, capture_kb)
    Else
        bg_usb5000_usb2_capture_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb2_capture_config_query (ByVal beagle As Long, ByRef pretrig_kb As Long, ByRef capture_kb As Long) as Long
    If check_version() Then
        bg_usb5000_usb2_capture_config_query = vb6_bg_usb5000_usb2_capture_config_query(beagle, pretrig_kb, capture_kb)
    Else
        bg_usb5000_usb2_capture_config_query = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' USB 3 Configuration

Public Function bg_usb5000_usb3_phy_config (ByVal beagle As Long, ByVal tx As Byte, ByVal rx As Byte) as Long
    If check_version() Then
        bg_usb5000_usb3_phy_config = vb6_bg_usb5000_usb3_phy_config(beagle, tx, rx)
    Else
        bg_usb5000_usb3_phy_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb3_memory_test (ByVal beagle As Long, ByVal test As Long) as Long
    If check_version() Then
        bg_usb5000_usb3_memory_test = vb6_bg_usb5000_usb3_memory_test(beagle, test)
    Else
        bg_usb5000_usb3_memory_test = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' USB 3 Capture modes

Public Function bg_usb5000_usb3_capture_config (ByVal beagle As Long, ByVal pretrig_kb As Long, ByVal capture_kb As Long) as Long
    If check_version() Then
        bg_usb5000_usb3_capture_config = vb6_bg_usb5000_usb3_capture_config(beagle, pretrig_kb, capture_kb)
    Else
        bg_usb5000_usb3_capture_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb3_capture_config_query (ByVal beagle As Long, ByRef pretrig_kb As Long, ByRef capture_kb As Long) as Long
    If check_version() Then
        bg_usb5000_usb3_capture_config_query = vb6_bg_usb5000_usb3_capture_config_query(beagle, pretrig_kb, capture_kb)
    Else
        bg_usb5000_usb3_capture_config_query = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb3_capture_status (ByVal beagle As Long, ByVal timeout_ms As Long, ByRef status As Long, ByRef pretrig_remaining_kb As Long, ByRef pretrig_total_kb As Long, ByRef capture_remaining_kb As Long, ByRef capture_total_kb As Long) as Long
    If check_version() Then
        bg_usb5000_usb3_capture_status = vb6_bg_usb5000_usb3_capture_status(beagle, timeout_ms, status, pretrig_remaining_kb, pretrig_total_kb, capture_remaining_kb, capture_total_kb)
    Else
        bg_usb5000_usb3_capture_status = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb2_capture_status (ByVal beagle As Long, ByVal timeout_ms As Long, ByRef status As Long, ByRef pretrig_remaining_kb As Long, ByRef pretrig_total_kb As Long, ByRef capture_remaining_kb As Long, ByRef capture_total_kb As Long) as Long
    If check_version() Then
        bg_usb5000_usb2_capture_status = vb6_bg_usb5000_usb2_capture_status(beagle, timeout_ms, status, pretrig_remaining_kb, pretrig_total_kb, capture_remaining_kb, capture_total_kb)
    Else
        bg_usb5000_usb2_capture_status = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_capture_abort (ByVal beagle As Long) as Long
    If check_version() Then
        bg_usb5000_capture_abort = vb6_bg_usb5000_capture_abort(beagle)
    Else
        bg_usb5000_capture_abort = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_capture_trigger (ByVal beagle As Long) as Long
    If check_version() Then
        bg_usb5000_capture_trigger = vb6_bg_usb5000_capture_trigger(beagle)
    Else
        bg_usb5000_capture_trigger = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' USB 3 Configuration

Public Function bg_usb5000_usb3_truncation_mode (ByVal beagle As Long, ByVal tx_truncation_mode As Byte, ByVal rx_truncation_mode As Byte) as Long
    If check_version() Then
        bg_usb5000_usb3_truncation_mode = vb6_bg_usb5000_usb3_truncation_mode(beagle, tx_truncation_mode, rx_truncation_mode)
    Else
        bg_usb5000_usb3_truncation_mode = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Simple match configuration

Public Function bg_usb5000_usb3_simple_match_config (ByVal beagle As Long, ByVal trigger_mask As Long, ByVal extout_mask As Long, ByVal extout_mode As Long, ByVal extin_edge_mask As Byte, ByVal tx_ips_type As Long, ByVal rx_ips_type As Long) as Long
    If check_version() Then
        bg_usb5000_usb3_simple_match_config = vb6_bg_usb5000_usb3_simple_match_config(beagle, trigger_mask, extout_mask, extout_mode, extin_edge_mask, tx_ips_type, rx_ips_type)
    Else
        bg_usb5000_usb3_simple_match_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Complex matching enable/disable

Public Function bg_usb5000_usb3_complex_match_enable (ByVal beagle As Long) as Long
    If check_version() Then
        bg_usb5000_usb3_complex_match_enable = vb6_bg_usb5000_usb3_complex_match_enable(beagle)
    Else
        bg_usb5000_usb3_complex_match_enable = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_usb3_complex_match_disable (ByVal beagle As Long) as Long
    If check_version() Then
        bg_usb5000_usb3_complex_match_disable = vb6_bg_usb5000_usb3_complex_match_disable(beagle)
    Else
        bg_usb5000_usb3_complex_match_disable = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Complex matching configuration

Public Function bg_usb5000_usb3_complex_match_config (ByVal beagle As Long, ByVal validate As Byte, ByVal extout As Byte, ByRef state_0 As BeagleUsb5000ComplexMatchState, ByRef state_1 As BeagleUsb5000ComplexMatchState, ByRef state_2 As BeagleUsb5000ComplexMatchState, ByRef state_3 As BeagleUsb5000ComplexMatchState, ByRef state_4 As BeagleUsb5000ComplexMatchState, ByRef state_5 As BeagleUsb5000ComplexMatchState, ByRef state_6 As BeagleUsb5000ComplexMatchState, ByRef state_7 As BeagleUsb5000ComplexMatchState) as Long
    If check_version() Then
        bg_usb5000_usb3_complex_match_config = vb6_bg_usb5000_usb3_complex_match_config(beagle, validate, extout, state_0, state_1, state_2, state_3, state_4, state_5, state_6, state_7)
    Else
        bg_usb5000_usb3_complex_match_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Complex matching configuration for a single state

Public Function bg_usb5000_usb3_complex_match_config_single (ByVal beagle As Long, ByVal validate As Byte, ByVal extout As Byte, ByRef state As BeagleUsb5000ComplexMatchState) as Long
    If check_version() Then
        bg_usb5000_usb3_complex_match_config_single = vb6_bg_usb5000_usb3_complex_match_config_single(beagle, validate, extout, state)
    Else
        bg_usb5000_usb3_complex_match_config_single = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Extout configuration

Public Function bg_usb5000_usb3_ext_io_config (ByVal beagle As Long, ByVal extin_enable As Byte, ByVal extout_modulation As Long) as Long
    If check_version() Then
        bg_usb5000_usb3_ext_io_config = vb6_bg_usb5000_usb3_ext_io_config(beagle, extin_enable, extout_modulation)
    Else
        bg_usb5000_usb3_ext_io_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Channel Configuration

Public Function bg_usb5000_usb3_link_config (ByVal beagle As Long, ByRef tx As BeagleUsb5000Channel, ByRef rx As BeagleUsb5000Channel) as Long
    If check_version() Then
        bg_usb5000_usb3_link_config = vb6_bg_usb5000_usb3_link_config(beagle, tx, rx)
    Else
        bg_usb5000_usb3_link_config = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_usb5000_read (ByVal beagle As Long, ByRef status As Long, ByRef events As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByRef source As Long, ByVal max_bytes As Long, ByRef packet() As Byte, ByVal max_k_bytes As Long, ByRef k_data() As Byte) as Long
    If check_version() Then
        Dim packet_max_bytes As Long
        packet_max_bytes = tp_min(max_bytes, UBound(packet) - LBound(packet) + 1)
        Dim k_data_max_k_bytes As Long
        k_data_max_k_bytes = tp_min(max_k_bytes, UBound(k_data) - LBound(k_data) + 1)
        bg_usb5000_read = vb6_bg_usb5000_read(beagle, status, events, time_sop, time_duration, time_dataoffset, source, packet_max_bytes, packet(0), k_data_max_k_bytes, k_data(0))
    Else
        bg_usb5000_read = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' | return / 8

'==========================================================================
' MDIO API
'==========================================================================
' Read the next MDIO frame.

Public Function bg_mdio_read (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByRef data_in As Long) as Long
    If check_version() Then
        bg_mdio_read = vb6_bg_mdio_read(beagle, status, time_sop, time_duration, time_dataoffset, data_in)
    Else
        bg_mdio_read = BG_INCOMPATIBLE_LIBRARY
    End If
End Function



Public Function bg_mdio_read_bit_timing (ByVal beagle As Long, ByRef status As Long, ByRef time_sop As LongLong, ByRef time_duration As LongLong, ByRef time_dataoffset As Long, ByRef data_in As Long, ByVal max_timing As Long, ByRef bit_timing() As Long) as Long
    If check_version() Then
        Dim bit_timing_max_timing As Long
        bit_timing_max_timing = tp_min(max_timing, UBound(bit_timing) - LBound(bit_timing) + 1)
        bg_mdio_read_bit_timing = vb6_bg_mdio_read_bit_timing(beagle, status, time_sop, time_duration, time_dataoffset, data_in, bit_timing_max_timing, bit_timing(0))
    Else
        bg_mdio_read_bit_timing = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


' Parse the raw MDIO data into the standard format.
' This function will fill the supplied fields as per
' the constants defined above.  If the raw data contains
' a malformed turnaround field, the caller will be
' notified of the error through the return value of
' this function (BG_MDIO_BAD_TURNAROUND).

Public Function bg_mdio_parse (ByVal packet As Long, ByRef clause As Byte, ByRef opcode As Byte, ByRef addr1 As Byte, ByRef addr2 As Byte, ByRef data As Integer) as Long
    If check_version() Then
        bg_mdio_parse = vb6_bg_mdio_parse(packet, clause, opcode, addr1, addr2, data)
    Else
        bg_mdio_parse = BG_INCOMPATIBLE_LIBRARY
    End If
End Function


