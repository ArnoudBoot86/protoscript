' parcopy.vbs
' Copies all *.c files from a working directory to c:/parc.  Put this
' script in your current data directory.

' The location of HeadStart working directory
const parpath = "C:\parc"

' Variables to keep track of script files
dim files, folder

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

' Copy scripts
function copysrc()
	srcfile = currdir & "\*.c"
	Set folder = objfso.GetFolder(currdir)
	Set files = folder.Files
	objfso.copyfile srcfile , parpath , "true"
	statblurb = statblurb & "Copied "
	For each fileid in files
		if InStr(fileid.Name,".c") > 0 then
			statblurb = statblurb & fileid.Name & " "
		end if
	Next
	statblurb = statblurb & "to c:\parc"
end function

' Main execution section
copysrc()
wscript.echo statblurb
