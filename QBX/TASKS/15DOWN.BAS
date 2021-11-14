DECLARE SUB HandleCommand (cmd!)
DECLARE SUB HandleKey (selItem!, ch$)
DECLARE SUB Cancel ()
DECLARE SUB HandleMouse (selItem, row!, col!, btn!)
DECLARE SUB Restart ()
DECLARE SUB ShutDown ()
DECLARE SUB DrawMenu (selItem)
'$INCLUDE: 'exlib.bi'
curY = CSRLIN
curX = POS(0)
CONST colFrame = 4, colBackUnsel = 2, colUnsel = 4, colBackSel = 7

CALL SaveScreen(77)


IF COMMAND$ = "" THEN
	PRINT "Ошибка! Пораметр отсутствует - путь к файлу."
ELSEIF COMMAND$ = "/?" THEN
	PRINT "OFFPC - программа выключения и перезагрузки."
ELSE
	FOR k = 1 TO 25
		CALL WndPuthl(1, 80, k, 219)
	NEXT

	DIM selItem AS SINGLE
	DIM ch AS STRING

	selItem = 1
	CALL MouseShow
	CALL WndDraw(30, 2, 45, 10, colFrame, colBackUnsel, 1, "")
	CALL DrawMenu(selItem)

	DO
		MousePoll row, col, lb, rb
		CALL HandleMouse(selItem, row, col, lb)
		ch = INKEY$
		CALL HandleKey(selItem, ch)
	LOOP WHILE ch <> CHR$(27)

	CALL Cancel
END IF

SUB Cancel
	SHARED curX, curY
	CALL DrawMenu(3)
	PLAY "C"
	CALL LoadScreen(77)
	LOCATE curY, curX
	END
END SUB

SUB DrawMenu (selItem)
	CALL MouseHide
	LOCATE 4, 34
	IF selItem = 1 THEN
		COLOR colFrame, colBackSel
	ELSE
		COLOR colUnsel, colBackUnsel
	END IF
	PRINT "Shutdown"

	LOCATE 6, 34
	IF selItem = 2 THEN
		COLOR colFrame, colBackSel
	ELSE
		COLOR colUnsel, colBackUnsel
	END IF
	PRINT "Restart"

	LOCATE 8, 34
	IF selItem = 3 THEN
		COLOR colFrame, colBackSel
	ELSE
		COLOR colUnsel, colBackUnsel
	END IF
	PRINT "Cancel"
	COLOR 4, 7
	CALL MouseShow
	LOCATE 13, 35
	PRINT "OFFPC"
	COLOR 7, 0
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
		CALL DrawMenu(selItem)
	ELSEIF ch$ = CHR$(0) + CHR$(72) AND selItem > 1 THEN
		selItem = selItem - 1
		CALL DrawMenu(selItem)
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
	CALL DrawMenu(2)
	PLAY "D"
	SLEEP 12
	OUT &H64, &HFE
END SUB

SUB ShutDown
	DIM regs AS RegType

	OPEN COMMAND$ FOR APPEND AS #1
	PRINT #1, "ShutDown: "; GetDate$ + " " + TIME$
	CLOSE #1
	CALL DrawMenu(1)
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

