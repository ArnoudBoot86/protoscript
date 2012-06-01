Attribute VB_Name = "capture_mdio"
'==========================================================================
' (c) 2007  Total Phase, Inc.
'--------------------------------------------------------------------------
' Project : Beagle Sample Code
' File    : capture_mdio.bas
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

'==========================================================================
' STATIC GLOBALS
'==========================================================================
Dim beagle As Long

Type CurrStruct
    Value As Currency
End Type


'==========================================================================
' UTILITY FUNCTIONS
'==========================================================================
' This will only work for sample rates that
' are multiples of 1MHz.  If any other rates
' are desired, this code needs to be changed.
Function timestamp_to_ns(stamp As LongLong, samplerate_khz As Long) As LongLong
    Dim Temp As CurrStruct
    Dim result As LongLong
    LSet Temp = stamp
    Temp.Value = Temp.Value * 1000000
    Temp.Value = Temp.Value / samplerate_khz
    LSet result = Temp
    timestamp_to_ns = result
End Function

Function zeropad(s As String, zeros As Long)
    If Len(s) < zeros Then
        For i = 0 To zeros - 1 - Len(s)
            s = "0" & s
        Next
    End If
    zeropad = s
End Function

Sub print_general_status(status As Long)
    Debug.Print " ";

    ' General status codes
    If status = BG_READ_OK Then
        Debug.Print "OK ";
    End If

    If (status And BG_READ_TIMEOUT) Then
        Debug.Print "TIMEOUT ";
    End If

    If (status And BG_READ_ERR_MIDDLE_OF_PACKET) Then
        Debug.Print "MIDDLE ";
    End If

    If (status And BG_READ_ERR_SHORT_BUFFER) Then
        Debug.Print "SHORT BUFFER ";
    End If

    If (status And BG_READ_ERR_PARTIAL_LAST_BYTE) Then
        Debug.Print "PARTIAL_BYTE(bit " & (status And &HFF) & ") ";
    End If
End Sub

Sub print_mdio_status(status As Long)
    ' MDIO status codes
    If status And BG_MDIO_BAD_TURNAROUND Then
        Debug.Print "MDIO_BAD_TURNAROUND ";
    End If
End Sub

Function LongLongToText(ByRef Value As LongLong) As String
    Dim Val As CurrStruct
    LSet Val = Value
    Dim Temp As String
    Dim L As Long
    Temp = Format$(Val.Value, "#.0000")
    L = Len(Temp)
    Temp = Left$(Temp, L - 5) & Right$(Temp, 4)
    Do While Len(Temp) > 1 And Left$(Temp, 1) = "0"
        Temp = Mid$(Temp, 2)
    Loop
    Do While Len(Temp) > 2 And Left$(Temp, 2) = "-0"
        Temp = "-" & Mid$(Temp, 3)
    Loop
    LongLongToText = Temp
End Function


'==========================================================================
' MDIO DUMP FUNCTION
'==========================================================================
Sub mdiodump(num_packets As Long)
    ' Get the size of the timing information for a transaction of
    ' max_bytes length
    Dim timing_size As Long
    timing_size = bg_bit_timing_size(BG_PROTOCOL_MDIO, 0)
    Dim timing() As Long
    ReDim timing(timing_size - 1)

    ' Get the current sampling rate
    Dim samplerate_khz As Long
    samplerate_khz = bg_samplerate(beagle, 0)

    ' Start the capture
    If Not (bg_enable(beagle, BG_PROTOCOL_MDIO) = BG_READ_OK) Then
        Debug.Print "error: could not enable MDIO capture; exiting..."
        Exit Sub
    End If

    Debug.Print "index,time(ns),MDIO,status,<clause:opcode>,<addr1>," & _
                "<addr2>,data"

    ' Capture and print each transaction
    Dim i As Long
    For i = 0 To num_packets - 1
        Dim packet As Long
        Dim status As Long
        Dim time_sop As LongLong
        Dim time_sop_ns As LongLong
        Dim time_duration As LongLong
        Dim time_dataoffset As Long
        Dim count As Long

        ' Read transaction with bit timing data
        count = bg_mdio_read_bit_timing(beagle, status, _
                                        time_sop, time_duration, _
                                        time_dataoffset, _
                                        packet, _
                                        timing_size, _
                                        timing)

        ' Translate timestamp to ns
        time_sop_ns = timestamp_to_ns(time_sop, samplerate_khz)

        ' Check for errors
        If count < 0 Then
            Debug.Print i & "," & LongLongToText(time_sop_ns) & _
                ",MDIO,( error=" & count;
                print_general_status (status)
                print_mdio_status (status)
                Debug.Print ")"
                
        Else
            ' Parse the MDIO frame
            Dim clause As Byte
            Dim opcode As Byte
            Dim addr1 As Byte
            Dim addr2 As Byte
            Dim data As Integer
            Dim ret As Long
            ret = bg_mdio_parse(packet, clause, opcode, addr1, addr2, data)

            Debug.Print i & "," & LongLongToText(time_sop_ns) & ",MDIO,(";
            print_general_status (status)
            If Not (status And BG_READ_TIMEOUT) Then
                print_mdio_status (status)
            End If
            Debug.Print ")";

            If count > 0 Then
                ' Print the clause and opcode
                Debug.Print ",";
                If ((status And BG_READ_ERR_MIDDLE_OF_PACKET) = 0) Then
                    If clause = BG_MDIO_CLAUSE_22 Then
                        Debug.Print "<22:";
                        Select Case opcode
                          Case BG_MDIO_OPCODE22_WRITE:
                            Debug.Print "W";
                          Case BG_MDIO_OPCODE22_READ:
                            Debug.Print "R";
                          Case BG_MDIO_OPCODE22_ERROR:
                            Debug.Print "?";
                        End Select
                    ElseIf clause = BG_MDIO_CLAUSE_45 Then
                        Debug.Print "<45:";
                        Select Case opcode
                          Case BG_MDIO_OPCODE45_ADDR:
                            Debug.Print "A";
                          Case BG_MDIO_OPCODE45_WRITE:
                            Debug.Print "W";
                          Case BG_MDIO_OPCODE45_READ_POSTINC:
                            Debug.Print "RI";
                          Case BG_MDIO_OPCODE45_READ:
                            Debug.Print "R";
                        End Select
                    Else
                        Debug.Print "<?:?";
                    End If

                    Debug.Print ">,<" & zeropad(Hex(addr1), 2) & ">,<" & _
                        zeropad(Hex(addr2), 2) & ">," & _
                        zeropad(Hex(data), 4);
                End If
            End If
            Debug.Print
        End If
    Next

    ' Stop the capture
    Call bg_disable(beagle)
End Sub


'==========================================================================
' MAIN PROGRAM
'==========================================================================
Public Sub capture_mdio_run()
    Dim port       As Long
    Dim samplerate As Long
    Dim timeout    As Long
    Dim latency    As Long
    Dim target_pow As Long
    Dim num        As Long

    port = 0                          'Open Port 0 by default
    samplerate = 10000                'in kHz
    timeout = 500                     'in milliseconds
    latency = 200                     'in milliseconds
    target_pow = BG_TARGET_POWER_OFF
    num = 8                           'number of packets to capture

    ' Open the device
    beagle = bg_open(port)
    If beagle <= 0 Then
        Debug.Print "Unable to open Beagle on port " & port
        Debug.Print "Error code = " & beagle
        Exit Sub
    End If
    
    Debug.Print "Opened Beagle device on port " & port

    ' Set the samplerate
    samplerate = bg_samplerate(beagle, samplerate)
    If samplerate < 0 Then
        Debug.Print "error: " & bg_status_string(samplerate)
        Exit Sub
    End If
    
    Debug.Print "Sampling rate set to " & samplerate & " KHz."

    ' Set the idle timeout.
    ' The Beagle read functions will return in the specified time
    ' if there is no data available on the bus.
    Call bg_timeout(beagle, timeout)
    Debug.Print "Idle timeout set to " & timeout & " ms."

    ' Set the latency.
    ' The latency parameter allows the programmer to balance the
    ' tradeoff between host side buffering and the latency to
    ' receive a packet when calling one of the Beagle read
    ' functions.
    Call bg_latency(beagle, latency)
    Debug.Print "Latency set to " & latency & " ms."

    Dim speed As String
    If bg_host_ifce_speed(beagle) Then
        speed = "high speed"
    Else
        speed = "full speed"
    End If
    Debug.Print "Host interface is " & speed & "."
    Debug.Print ""

    ' There is usually no need for target power when using the
    ' Beagle as a passive monitor.
    Call bg_target_power(beagle, target_pow)

    Call mdiodump(num)

    ' Close the device
    bg_close (beagle)
End Sub
