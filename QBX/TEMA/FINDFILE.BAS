'$INCLUDE: 'exlib.bi'
CLS
PRINT "CURDIR: " + CURDIR$
DEFINT A-Z
TYPE DTAinfo
	Reserved    AS STRING * 21
	Attribute   AS STRING * 1
	FileTime    AS INTEGER
	FileDate    AS INTEGER
	FileSize    AS LONG
	FileName    AS STRING * 13
END TYPE
DIM inRegs AS RegTypeX, outRegs AS RegTypeX
DIM DTA AS DTAinfo

inRegs.AX = &H2F * 256
INTERRUPTX &H21, inRegs, outRegs
DTASeg = outRegs.ES
DTAOff = outRegs.BX

fln$ = "*.*" + CHR$(0)
inRegs.AX = &H4E * 256
inRegs.CX = 0
inRegs.DS = VARSEG(fln$)
inRegs.DX = SADD(fln$)
INTERRUPTX &H21, inRegs, outRegs
IF outRegs.Flags AND 1 THEN
	errNum = outRegs.AX
	PRINT errNum
ELSE
	PRINT "good!"
END IF
END

'Let's look for all text files in the current directory....
SearchFile$ = "*.exe" + CHR$(0)
'All of the important information is stored in the
'Disk Transfer Area (DTA). We could call Interrupt 21h
'function 2Fh to find the memory segment and offset of the DTA, then
'use the PEEK statement in a loop to scan memory to retrieve
'the information. But let's get a little sneaky....
'Let's create a UDT and tell the OS to package and deliver all
'of the DTA information in a predefined data type so we won't have to mess
'with any cumbersome PEEKs. We can just get the file size (for example) by
'doing something like: PRINT "The size of the file is " ; DTA.FileSize
inRegs.AX = &H1A00
'Set the DTA to the address of the user defined type....
inRegs.DS = VARSEG(DTA)
inRegs.DX = VARPTR(DTA)
CALL INTERRUPTX(&H21, inRegs, outRegs)
'That was pretty painless.... We'll just have to remember that QB likes to
'move its variables around from time to time. If QB decides to change the
'address of the DTA, it certainly won't bother to tell DOS about the new
'location. The OS might overwite the current contents of the address that was
'set by interrupt 21h, function 1Ah and QB could crash with a
'"corrupt string space" error, or worse .
'My tests of this code didn't create a problem like this...
'but if you experience a "corrupt string space" error or enounter
'a blue screen under Win NT, you might try refreshing Interrupt 21h,
'function 1Ah periodically while looping through the files.

'Now for some action....
'Find first matching file. (Find the first match for "*.TXT")
inRegs.DS = VARSEG(SearchFile$)
inRegs.DX = SADD(SearchFile$)
inRegs.CX = &HFF
inRegs.AX = &H4E00
CALL INTERRUPTX(&H21, inRegs, outRegs)
IF outRegs.Flags AND 1 THEN
	errNum = outRegs.AX

	PRINT SearchFile$; " was not found."
	PRINT "Error = "; errNum
	'If the file doesn't exist, quit.
	'SYSTEM
END IF
Cnt = 1
'Call a subroutine to print out a bunch of information about the file
'and then print the actual contents of the file....
GOSUB PrintInfo
'Loop through all of the text files in the current directory
'using the FindNextMatchingFile function (Int21h, funct. 4Fh).
DO
	inRegs.AX = &H4F00
	CALL INTERRUPTX(&H21, inRegs, outRegs)
	IF outRegs.Flags AND 1 THEN
		'Found all of the text files, so quit
		SYSTEM
	END IF
	Cnt = Cnt + 1
	GOSUB PrintInfo
LOOP
SYSTEM

PrintInfo:
'The file name is stored in the 13 bytes of the DTA
'beginning at the 31st position. The name will be padded with
'NULL characters (ASCII 0's).
'Let's print out the file counter and the ASCII 0 padded file name,
'along with some of the other information....
PRINT Cnt; ") File Info: "; DTA.FileName
PRINT "File size: "; DTA.FileSize; " bytes"
'Extract the Year, Month and Day values from the date value stored in the DTA
Yr$ = LTRIM$(STR$(FIX(DTA.FileDate / 512) + 1980))
Mn! = (DTA.FileDate MOD 512) / 32
Mn$ = RIGHT$("00" + LTRIM$(STR$(INT(Mn!))), 2)
Dy! = (Mn! - FIX(Mn!)) * 32
Dy$ = RIGHT$("00" + LTRIM$(STR$(FIX(Dy!))), 2)
PRINT "File creation date: "; Mn$; "-"; Dy$; "-" + Yr$
'Extract the creation time from the DTA and parse it into a meaningful format.
Hours = INT(DTA.FileTime / 2048)
Hours$ = RIGHT$("00" + LTRIM$(STR$(Hours)), 2)
Mins! = ((DTA.FileTime MOD 2048) / 32)
Mins$ = RIGHT$("00" + LTRIM$(STR$(INT(Mins!))), 2)
Secs! = INT((Mins! - INT(Mins!)) * 60)
Secs$ = RIGHT$("00" + LTRIM$(STR$(Secs!)), 2)
PRINT "File creation time: "; Hours$ + ":" + Mins$ + ":" + Secs$
'The last item is the file attribute (Archive, Read Only, Hidden, System, etc.)
'Since it is only one byte long, we convert it to a number by finding its
'ASCII value....
FlAttrib = ASC(DTA.Attribute)
PRINT "File attribute"; FlAttrib
PRINT STRING$(79, "-")
'Now let's print the contents of the text file....
ff = FREEFILE
'Remove the ASCII 0 padding from the file name...
FiName$ = LEFT$(DTA.FileName, INSTR(DTA.FileName, CHR$(0)) - 1)
'Open the file...
OPEN FiName$ FOR BINARY AS #ff
'Create a string long enough to hold the file contents...
FileContent$ = STRING$(LOF(ff), 32)
'Get the file contents...
GET #ff, 1, FileContent$
'Close the file...
CLOSE #ff
'Print it out...
PRINT FileContent$
PRINT STRING$(79, "-")
RETURN

