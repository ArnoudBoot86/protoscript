' archive.vbs
' Copies the current capture dsn file and the layout max file to the archive
' directory

' The location of the archive
const arpath = "U:\Projects\ec\EC100\control"

' Name of the schematic design
' Example: INT_I2V_REVC.DSN
const dsnfile = "ANAL_CTRL_REVH.DSN"



' Name of the layout file
' Example: "int_i2v_revc.max"
const maxfile = "ANAL_CTRL_REVH.MAX"



' The revision letter
const revlett = "h"

' Create a file system object
dim objfso
set objfso = wscript.createobject("scripting.filesystemobject")

' Create a wsh object
Dim objshl
Set objshl = wscript.createobject("wscript.shell")

' Find where we are
dim currdir
currdir = objshl.currentdirectory

' A status text holder
dim statblurb
statblurb = ""





' Create directory structure if it doesn't exist
function makedirs()
	if not (objfso.folderexists(arpath & "\rev" & revlett)) then
		objfso.createfolder(arpath & "\rev" & revlett)
		objfso.createfolder(arpath & "\rev" & revlett & "\schematics")
		objfso.createfolder(arpath & "\rev" & revlett & "\layout")
		objfso.createfolder(arpath & "\rev" & revlett & "\changes")
		statblurb = statblurb & "Created archive directories in " _
			& arpath & "\rev" & revlett & vbCr & vbLf
	else
		statblurb = statblurb & "Archive directory is " _
			& arpath & "\rev" & revlett & vbCr & vbLf
	end if
end function

' Copy schematic and layout files
function copysrc()
	srcfile = currdir & "\schematics\" & dsnfile
	revpath = arpath & "\rev" & revlett
	if not objfso.fileexists(srcfile) then
		statblurb = statblurb & "Did not find " & srcfile & vbCr & vbLf
	else
		objfso.copyfile srcfile , revpath & "\schematics\" & dsnfile , "true" 
		statblurb = statblurb & "Copied " & dsnfile & vbCr & vbLf
	end if
	
	srcfile = currdir & "\layout\" & maxfile
	if not objfso.fileexists(srcfile) then
		statblurb = statblurb & "Did not find " & srcfile & vbCr & vbLf
	else
		objfso.copyfile srcfile , revpath & "\layout\" & maxfile , "true" 
		statblurb = statblurb & "Copied " & maxfile & vbCr & vbLf
	end if
end function


' Main execution section
makedirs()
copysrc()
wscript.echo statblurb