'==========================================================================
' (c) 2007-2009  Total Phase, Inc.
'--------------------------------------------------------------------------
' Project : Beagle Sample Code
' File    : capture_mdio.vb
'--------------------------------------------------------------------------
' MDIO capture example program
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

Module capture_mdio


    '=======================================================================
    ' STATIC GLOBALS
    '=======================================================================
    Dim handle As Integer


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

        If (status And BeagleApi.BG_READ_ERR_PARTIAL_LAST_BYTE) Then
            Console.Write("PARTIAL_BYTE(bit " & (status And &HFFS) & ") ")
        End If
    End Sub

    Sub print_mdio_status(ByRef status As Integer)
        ' MDIO status codes
        If status And BeagleStatus.BG_MDIO_BAD_TURNAROUND Then
            Console.Write("MDIO_BAD_TURNAROUND ")
        End If
    End Sub


    '=======================================================================
    ' MDIO DUMP FUNCTION
    '=======================================================================
    Sub mdiodump(ByRef num_packets As Integer)
        ' Get the size of the timing information for a transaction of
        ' max_bytes length
        Dim bit_timing As Integer
        bit_timing = BeagleApi.bg_bit_timing_size( _
            BeagleProtocol.BG_PROTOCOL_MDIO, 0)
        Dim timing(bit_timing) As UInteger

        ' Get the current sampling rate
        Dim samplerate_khz As Integer
        samplerate_khz = BeagleApi.bg_samplerate(handle, 0)

        ' Start the capture
        If Not (BeagleApi.bg_enable(handle, BeagleProtocol.BG_PROTOCOL_MDIO) _
                = BeagleApi.BG_READ_OK) Then
            Console.WriteLine("error: could not enable MDIO capture; " & _
                              "exiting...")
            Exit Sub
        End If

        Console.WriteLine("index,time(ns),MDIO,status,<clause:opcode>," & _
                          "<addr1>,<addr2>,data")

        Dim packet As Integer
        Dim status As Integer
        Dim time_sop As Long
        Dim time_sop_ns As Long
        Dim time_duration As Long
        Dim time_dataoffset As Integer
        Dim count As Integer
        Dim clause As Byte
        Dim opcode As Byte
        Dim addr1 As Byte
        Dim addr2 As Byte
        Dim data As Short
        Dim ret As Integer

        ' Capture and print each transaction
        Dim i As Integer
        For i = 0 To num_packets - 1
            ' Read transaction with bit timing data
            count = BeagleApi.bg_mdio_read_bit_timing(handle, status, _
                time_sop, time_duration, time_dataoffset, packet, _
                bit_timing, timing)

            ' Translate timestamp to ns
            time_sop_ns = timestamp_to_ns(time_sop, samplerate_khz)

            ' Check for errors
            If count < 0 Then
                Console.Write(i & "," & time_sop_ns & ",MDIO,( error=" & _
                              count)
                print_general_status((status))
                print_mdio_status((status))
                Console.WriteLine(")")

            Else
                ' Parse the MDIO frame
                ret = BeagleApi.bg_mdio_parse(packet, clause, opcode, addr1, _
                    addr2, data)

                Console.Write(i & "," & time_sop_ns & ",MDIO,(")
                print_general_status((status))
                If Not (status And BeagleApi.BG_READ_TIMEOUT) Then
                    print_mdio_status((status))
                End If
                Console.Write(")")

                If count > 0 Then
                    ' Print the clause and opcode
                    Console.Write(",")
                    If ((status And BeagleApi.BG_READ_ERR_MIDDLE_OF_PACKET) _
                         = 0) Then
                        If clause = BeagleMdioClause.BG_MDIO_CLAUSE_22 Then
                            Console.Write("<22:")
                            Select Case opcode
                                Case BeagleApi.BG_MDIO_OPCODE22_WRITE
                                    Console.Write("W")
                                Case BeagleApi.BG_MDIO_OPCODE22_READ
                                    Console.Write("R")
                                Case BeagleApi.BG_MDIO_OPCODE22_ERROR
                                    Console.Write("?")
                            End Select
                        ElseIf clause = BeagleMdioClause.BG_MDIO_CLAUSE_45 Then
                            Console.Write("<45:")
                            Select Case opcode
                                Case BeagleApi.BG_MDIO_OPCODE45_ADDR
                                    Console.Write("A")
                                Case BeagleApi.BG_MDIO_OPCODE45_WRITE
                                    Console.Write("W")
                                Case BeagleApi.BG_MDIO_OPCODE45_READ_POSTINC
                                    Console.Write("RI")
                                Case BeagleApi.BG_MDIO_OPCODE45_READ
                                    Console.Write("R")
                            End Select
                        Else
                            Console.Write("<?:?")
                        End If

                        Console.Write(">,<" & zeropad(Hex(addr1), 2) & _
                            ">,<" & zeropad(Hex(addr2), 2) & ">," & _
                            zeropad(Hex(data), 4))
                    End If
                End If
                Console.WriteLine("")
            End If
        Next

        ' Stop the capture
        Call BeagleApi.bg_disable(handle)
    End Sub


    '=======================================================================
    ' MAIN PROGRAM
    '=======================================================================
    Public Sub capture_mdio_run()
        Dim port As Integer
        Dim samplerate As Integer
        Dim timeout As Integer
        Dim latency As Integer
        Dim target_pow As Integer
        Dim num As Integer

        port       = 0      'Open Port 0 by default
        samplerate = 10000  'in kHz
        timeout    = 500    'in milliseconds
        latency    = 200    'in milliseconds
        target_pow = BeagleApi.BG_TARGET_POWER_OFF
        num        = 8      'number of packets to capture

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

        Console.WriteLine("Sampling rate set to " & samplerate & " KHz.")

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
        Call BeagleApi.bg_target_power(handle, target_pow)

        Call mdiodump(num)

        ' Close the device
        BeagleApi.bg_close(handle)
    End Sub
End Module
