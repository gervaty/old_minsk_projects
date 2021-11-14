'$INCLUDE: 'exlib.bi'

CLS

CALL MouseInit
CALL MouseShow
COLOR 0, 3
LOCATE 1, 70: PRINT "<Clear>"
COLOR 7, 0
DO
CALL MousePoll(row, col, lButton, rButton)
IF lButton = true THEN
	IF row = 1 AND col >= 70 THEN
		FOR k = 2 TO 23
			CALL Puthl(1, 80, k, 32)
		NEXT
		CALL Frame(70, 2, 80, 10)
	ELSE
		LOCATE row, col
		PRINT "q"
	END IF
END IF
LOOP WHILE INKEY$ <> CHR$(27)
CALL Frame(1, 2, 4, 4)
CALL Frame(1, 20, 4, 2)
CALL PressAnyKey

