Attribute VB_Name = "detect"
'==========================================================================
' (c) 2007-2009  Total Phase, Inc.
'--------------------------------------------------------------------------
' Project : Beagle Sample Code
' File    : detect.bas
'--------------------------------------------------------------------------
' Auto-detection test routine
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
' MAIN PROGRAM
'==========================================================================
Public Sub detect_run()
    Debug.Print ("Detecting Beagle adapters...")
    Dim num As Long
    Dim devices(15) As Integer
    Dim unique_ids(15) As Long
    
    ' Find all the attached devices
    num = bg_find_devices_ext(16, devices, 16, unique_ids)

    If num > 0 Then
        Debug.Print ("Found " & num & " device(s)")

        Dim port As Integer
        Dim inuse As String
        Dim i As Long

        ' Print the information on each device
        For i = 0 To num - 1
            port = devices(i)

            ' Determine if the device is in-use
            inuse = "   (avail)  "
            If port And BG_PORT_NOT_FREE Then
                inuse = "   (in-use)  "
                port = port And Not BG_PORT_NOT_FREE
            End If

            ' Display device port number, in-use status, and serial number
            Debug.Print ("    port = " & port & inuse & _
                Format$(unique_ids(i) \ 1000000, "0000") & "-" & _
                Format$(unique_ids(i) Mod 1000000, "000000"))
        Next
    Else
        Debug.Print ("No devices found.")
    End If
End Sub
