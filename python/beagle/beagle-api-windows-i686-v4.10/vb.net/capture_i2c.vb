'==========================================================================    
' (c) 2007-2009  Total Phase, Inc.
'--------------------------------------------------------------------------
' Project : Beagle Sample Code
' File    : capture_i2c.vb
'--------------------------------------------------------------------------
' I2C capture example program
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

Module capture_i2c


    '======================================================================
    ' STATIC GLOBALS
    '======================================================================
    Dim handle As Integer


    '======================================================================
    ' UTILITY FUNCTIONS
    '======================================================================
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

    Sub print_i2c_status(ByRef status As Integer)
        'I2C status codes
        If (status And BeagleApi.BG_READ_I2C_NO_STOP) Then
            Console.Write("I2C_NO_STOP ")
        End If
    End Sub


    '======================================================================
    ' I2C DUMP FUNCTION
    '======================================================================
    Sub i2cdump(ByRef max_bytes As Integer, ByRef num_packets As Integer)
        ' Get the size of the timing information for a transaction of
        ' max_bytes length
        Dim timing_size As Integer
        timing_size = _
            BeagleApi.bg_bit_timing_size( _
                BeagleProtocol.BG_PROTOCOL_I2C, max_bytes)

        Dim timing() As UInteger
        Dim data_in() As UShort

        ReDim timing(timing_size - 1)
        ReDim data_in(max_bytes - 1)

        ' Get the current sampling rate
        Dim samplerate_khz As Integer
        samplerate_khz = BeagleApi.bg_samplerate(handle, 0)

        ' Start the capture
        If Not (BeagleApi.bg_enable(handle, BeagleProtocol.BG_PROTOCOL_I2C) = _
            BeagleApi.BG_READ_OK) Then
            Console.WriteLine("error: could not enable I2C capture; " & _
                              "exiting...")
            Exit Sub
        End If

        Console.WriteLine("index,time(ns),I2C,status,<addr:r/w>(*)," & _
            "data0 ... dataN(*)")

        Dim status As Integer
        Dim time_sop As Long
        Dim time_sop_ns As Long
        Dim time_duration As Long
        Dim time_dataoffset As Integer
        Dim count As Integer
        Dim offset As Integer
        Dim n As Integer
        Dim nack As Integer

        ' Capture and print each transaction
        Dim i As Integer
        For i = 0 To num_packets - 1
            ' Read transaction with bit timing data
            count = BeagleApi.bg_i2c_read_bit_timing(handle, status, _
                time_sop, time_duration, time_dataoffset, max_bytes, data_in, _
                timing_size, timing)

            ' Translate timestamp to ns
            time_sop_ns = timestamp_to_ns(time_sop, samplerate_khz)

            Console.Write(i & "," & time_sop_ns & ",I2C,(")

            ' Check for errors
            If count < 0 Then
                Console.Write("error=" & count & ",")
            End If

            print_general_status((status))
            print_i2c_status((status))
            Console.Write(")")

            If count < 0 Then
                Exit For

            ' Print the address and read/write
            ElseIf count > 0 Then
                Console.Write(",")
                offset = 0
                ' Display the start condition
                If (status And BeagleApi.BG_READ_ERR_MIDDLE_OF_PACKET) = 0 Then
                    Console.Write("[S] ")

                    If (count >= 1) Then
                        ' Determine if byte was NACKed
                        nack = (data_in(0) And BeagleApi.BG_I2C_MONITOR_NACK)

                        ' Determine if this is a 10-bit address
                        If (count = 1 Or (data_in(0) And &HF9S) <> _
                                     (&HF0S Or nack)) Then
                            ' Display 7-bit address
                            Console.Write( _
                                "<" & _
                                zeropad(Hex(CByte(data_in(0) And &HFFS) >> 1), 2) & _
                                ":" & IIf(data_in(0) And &H1S, "r>", "w>") & _
                                IIf(nack, "* ", " "))
                            offset = 1
                        Else
                            ' Display 10-bit address
                            Console.Write( _
                                VB6.Format(Hex(((data_in(0) << 8) And &H300S) Or _
                                               (data_in(1) And &HFFS)), "000") & _
                                IIf(data_in(0) And &H1S, "r", "w") & _
                                IIf(nack, "* ", " "))
                            offset = 2
                        End If
                    End If
                End If

                ' Display rest of transaction
                count = count - offset
                For n = 0 To count - 1
                    ' Determine if byte was NACKed
                    nack = data_in(offset) And BeagleApi.BG_I2C_MONITOR_NACK

                    Console.Write(zeropad(Hex(data_in(offset) And &HFFS), 2) & _
                                  IIf(nack, "* ", " "))
                    offset = offset + 1
                Next n

                ' Display the stop condition
                If ((status And BeagleApi.BG_READ_I2C_NO_STOP) = 0) Then
                    Console.Write("[P]")
                End If
            End If

            Console.WriteLine("")
        Next i

        ' Stop the capture
        Call BeagleApi.bg_disable(handle)
    End Sub


    '======================================================================
    ' MAIN PROGRAM
    '======================================================================
    Public Sub capture_i2c_run()
        Dim pullups As Integer
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

        ' There is usually no need for target power when using the
        ' Beagle as a passive monitor.
        Call BeagleApi.bg_i2c_pullup(handle, pullups)
        Call BeagleApi.bg_target_power(handle, target_pow)

        Call i2cdump(packet_len, num)

        ' Close the device
        BeagleApi.bg_close(handle)
    End Sub
End Module
