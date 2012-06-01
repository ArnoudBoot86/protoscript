'==========================================================================
' (c) 2007-2009  Total Phase, Inc.
'--------------------------------------------------------------------------
' Project : Beagle Sample Code
' File    : capture_spi.vb
'--------------------------------------------------------------------------
' SPI capture example program
'--------------------------------------------------------------------------
' Redistribution and use of this file in source and binary forms, with
' or without modification, are permitted.
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
'==========================================================================
Option Strict Off
Option Explicit On 
Imports TotalPhase

Module capture_spi	


    '======================================================================
    ' STATIC GLOBALS
    '======================================================================
    Dim handle As Integer

    Structure CurrStruct
        Dim Value As Decimal
    End Structure


    '=======================================================================
    ' UTILITY FUNCTIONS
    '=======================================================================
    ' This will only work for sample rates that
    ' are multiples of 1MHz.  If any other rates
    ' are desired, this code needs to be changed.
    Function timestamp_to_ns(ByRef stamp As Long, _
            ByRef samplerate_khz As Integer) As Long
        stamp = stamp * 1000000
        stamp = stamp / samplerate_khz
        timestamp_to_ns = stamp
    End Function

    Function zeropad(ByRef s As String, ByRef zeros As Integer) As String
        Dim i As Integer
        If Len(s) < zeros Then
            For i = 0 To zeros - 1 - Len(s)
                s = "0" & s
            Next
        End If
        zeropad = s
    End Function

    Sub print_general_status(ByRef status As Integer)
        Console.Write(" ")

        ' General status codes
        If status = BeagleApi.BG_READ_OK Then
            Console.Write("OK ")
        End If

        If (status And BeagleApi.BG_READ_TIMEOUT) Then
            Console.Write("TIMEOUT ")
        End If

        If (status And BeagleApi.BG_READ_ERR_MIDDLE_OF_PACKET) Then
            Console.Write("MIDDLE ")
        End If

        If (status And BeagleApi.BG_READ_ERR_SHORT_BUFFER) Then
            Console.Write("SHORT BUFFER ")
        End If

        If (status And BeagleApi.BG_READ_ERR_PARTIAL_LAST_BYTE) Then
            Console.Write("PARTIAL_BYTE(bit " & (status And &HFFS) & ") ")
        End If
    End Sub

    Sub print_spi_status(ByRef status As Integer)
        ' No specific SPI status codes
    End Sub


    '=======================================================================
    ' SPI DUMP FUNCTION
    '=======================================================================
    Sub spidump(ByRef max_bytes As Integer, ByRef num_packets As Integer)
        ' Get the size of timing information for each transaction of size
        ' max_bytes
        Dim timing_size As Integer
        timing_size = _
            BeagleApi.bg_bit_timing_size(BeagleProtocol.BG_PROTOCOL_SPI, _
                max_bytes)

        Dim timing() As UInteger

        Dim data_mosi() As Byte
        Dim data_miso() As Byte

        ReDim timing(timing_size - 1)

        ReDim data_mosi(max_bytes - 1)
        ReDim data_miso(max_bytes - 1)

        ' Get the current sampling rate
        Dim samplerate_khz As Integer
        samplerate_khz = BeagleApi.bg_samplerate(handle, 0)

        ' Start the capture
        If Not (BeagleApi.bg_enable(handle, BeagleProtocol.BG_PROTOCOL_SPI) = _
                BeagleApi.BG_READ_OK) Then
            Console.WriteLine("error: could not enable SPI capture; " & _
                              "exiting...")
            Exit Sub
        End If

        Console.WriteLine("index,time(ns),SPI,status,mosi0/miso0 ... " & _
            "mosiN/misoN")

        Dim status As Integer
        Dim time_sop As Long
        Dim time_sop_ns As Long
        Dim time_duration As Long
        Dim time_dataoffset As Integer
        Dim count As Integer
        Dim n As Integer

        ' Capture and print information for each transaction
        Dim i As Integer
        For i = 0 To num_packets - 1

            ' Read transaction with bit timing data
            count = BeagleApi.bg_spi_read_bit_timing(handle, status, _
                                                     time_sop, time_duration, _
                                                     time_dataoffset, _
                                                     max_bytes, data_mosi, _
                                                     max_bytes, data_miso, _
                                                     timing_size, timing)

            ' Translate timestamp to ns
            time_sop_ns = timestamp_to_ns(time_sop, samplerate_khz)

            Console.Write(i & "," & time_sop_ns & ",SPI,(")

            If count < 0 Then
                Console.WriteLine("error=" & count & ",")
            End If

            print_general_status((status))
            print_spi_status((status))
            Console.Write(")")

            ' Check for errors
            If count < 0 Then
                Exit For
            
            ' Display the data
            ElseIf count > 0 Then
                For n = 0 To count - 1
                    If (Not n = 0) Then
                        Console.Write(", ")
                    End If
                    If (n And &HF) = 0 Then
                        Console.WriteLine()
                        Console.Write("    ")
                    End If
                    Console.Write(zeropad(Hex(data_mosi(n)), 2) & "/" & _
                                  zeropad(Hex(data_miso(n)), 2))
                Next n
            End If

            Console.WriteLine()
        Next i

        ' Stop the capture
        Call BeagleApi.bg_disable(handle)
    End Sub


    '=======================================================================
    ' MAIN PROGRAM
    '=======================================================================
    Public Sub capture_spi_run()
        Dim port As Integer
        Dim samplerate As Integer
        Dim timeout As Integer
        Dim latency As Integer
        Dim target_pow As Integer
        Dim num As Integer
        Dim packet_len As Integer

        port       = 0      'Open Port 0 by default
        samplerate = 10000  'in kHz
        timeout    = 500    'in milliseconds
        latency    = 200    'in milliseconds
        target_pow = BeagleApi.BG_TARGET_POWER_OFF
        num        = 8      'number of packets to capture
        packet_len = 256    'max packet length in bytes

        ' Open the device
        handle = BeagleApi.bg_open(port)
        If handle <= 0 Then
            Console.WriteLine("Unable to open Beagle on port " & port)
            Console.WriteLine("Error code = " & handle)
            Exit Sub
        End If

        Console.WriteLine("Opened Beagle device on port " & port)

        ' Set the samplerate
        samplerate = BeagleApi.bg_samplerate(handle, samplerate)
        If samplerate < 0 Then
            Console.WriteLine("error: " & _
                              BeagleApi.bg_status_string(samplerate))
            Exit Sub
        End If

        Console.WriteLine("Sampling rate set to " & samplerate & " kHz.")

        ' Set the idle timeout.
        ' The Beagle read functions will return in the specified time
        ' if there is no data available on the bus.
        Call BeagleApi.bg_timeout(handle, timeout)

        Console.WriteLine("Idle timeout set to " & timeout & " ms.")

        ' Set the latency.
        ' The latency parameter allows the programmer to balance the
        ' tradeoff between host side buffering and the latency to
        ' receive a packet when calling one of the Beagle read
        ' functions.
        Call BeagleApi.bg_latency(handle, latency)
        Console.WriteLine("Latency set to " & latency & " ms.")

        Dim speed As String
        If BeagleApi.bg_host_ifce_speed(handle) Then
            speed = "high speed"
        Else
            speed = "full speed"
        End If
        Console.WriteLine("Host interface is " & speed & ".")
        Console.WriteLine()

        ' Configure the device for SPI
        Call BeagleApi.bg_spi_configure( _
            handle, _
            BeagleSpiSSPolarity.BG_SPI_SS_ACTIVE_LOW, _
            BeagleSpiSckSamplingEdge.BG_SPI_SCK_SAMPLING_EDGE_RISING, _
            BeagleSpiBitorder.BG_SPI_BITORDER_MSB)

        ' There is usually no need for target power when using the
        ' Beagle as a passive monitor.
        Call BeagleApi.bg_target_power(handle, target_pow)

        Call spidump(packet_len, num)

        ' Close the device
        BeagleApi.bg_close(handle)
    End Sub
End Module
