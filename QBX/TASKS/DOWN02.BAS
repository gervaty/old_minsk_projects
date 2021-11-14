' /=================\
'|   OFFPC           |
'|   Version 1.0     |
'|                   |
' \=================/
DECLARE SUB HandleCommand (cmd!)
DECLARE SUB HandleKey (selItem!, ch$)
DECLARE SUB Cancel ()
DECLARE SUB HandleMouse (selItem, row!, col!, btn!)
DECLARE SUB Restart ()
DECLARE SUB ShutDown ()
DECLARE SUB drawMenu (selItem)
'$INCLUDE: 'exlib.bi'
FOR k = 1 TO 2000
	PRINT "█";
NEXT

IF COMMAND$ = "" THEN
	PRINT "Ошибка! Пораметр отсутствует - путь к файлу журнала."
ELSEIF COMMAND$ = "/?" THEN
	PRINT "''OFFPC'' - программа выключения и перезагрузки."
ELSE


	DIM selItem AS SINGLE
	DIM ch AS STRING

	selItem = 1
	CALL MouseShow
	COLOR 3, 0
	CALL Frame(30, 2, 45, 10)
	CALL drawMenu(selItem)

	DO
		MousePoll row, col, lb, rb
		CALL HandleMouse(selItem, row, col, lb)
		ch = INKEY$
		CALL HandleKey(selItem, ch)
	LOOP WHILE ch <> CHR$(27)
	CALL drawMenu(3)
	COLOR 0, 7
END IF

SUB Cancel
	CALL drawMenu(3)
	PLAY "C"
	CLS
	COLOR 7, 0
	END
END SUB

SUB drawMenu (selItem)
	CALL MouseHide
	LOCATE 4, 34
	IF selItem = 1 THEN
		COLOR 0, 7
	ELSE
		COLOR 4, 0
	END IF
	PRINT "Shutdown"

	LOCATE 6, 34
	IF selItem = 2 THEN
		COLOR 0, 7
	ELSE
		COLOR 4, 0
	END IF
	PRINT "Restart"

	LOCATE 8, 34
	IF selItem = 3 THEN
		COLOR 0, 7
	ELSE
		COLOR 4, 0
	END IF
	PRINT "Cancel"
	COLOR 4, 7
	LOCATE 15, 35
	PRINT "OFFPC"
	CALL MouseShow
END SUB

SUB HandleCommand (cmd)
	IF cmd = 1 THEN
		CALL ShutDown
	ELSEIF cmd = 2 THEN
		CALL Restart
	ELSEIF cmd = 3 THEN
		CALL Cancel
	END IF
END SUB

SUB HandleKey (selItem, ch$)
	IF ch$ = CHR$(0) + CHR$(80) AND selItem < 3 THEN
		selItem = selItem + 1
		CALL drawMenu(selItem)
	ELSEIF ch$ = CHR$(0) + CHR$(72) AND selItem > 1 THEN
		selItem = selItem - 1
		CALL drawMenu(selItem)
	ELSEIF ch$ = CHR$(13) THEN
		CALL HandleCommand(selItem)
	END IF
END SUB

SUB HandleMouse (selItem, row, col, btn)
	IF btn = true THEN
	   IF col >= 34 AND col <= 41 THEN
		   CALL HandleCommand(row / 2 - 1)
	   END IF
	END IF
END SUB

SUB Restart
	OPEN COMMAND$ FOR APPEND AS #1
	PRINT #1, "Restart: "; GetDate + " " + TIME$
	CLOSE #1
	CALL drawMenu(2)
	PLAY "D"
	SLEEP 1
	OUT &H64, &HFE
END SUB

SUB ShutDown
	DIM regs AS RegType

	OPEN COMMAND$ FOR APPEND AS #1
	PRINT #1, "ShutDown: "; GetDate$ + " " + TIME$
	CLOSE #1
	CALL drawMenu(1)
	PLAY "A"
	SLEEP 1
	regs.ax = &H5301
	regs.bx = 0
	CALL Interrupt(&H15, regs, regs)
	regs.ax = &H530E
	regs.bx = 0
	regs.cx = &H102
	CALL Interrupt(&H15, regs, regs)
	regs.ax = &H5307
	regs.bx = 1
	regs.cx = &H3
	CALL Interrupt(&H15, regs, regs)

END SUB

