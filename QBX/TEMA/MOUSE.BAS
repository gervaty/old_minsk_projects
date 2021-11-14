'$INCLUDE: 'exlib.bi'

CLS

MouseInit
MouseShow
MouseBorder 2, 2, 25, 80

DO
	MousePoll row, col, lb, rb

	LOCATE 1, 1
	PRINT row, col, lb, rb
	IF lb = true THEN
		LOCATE row, col
		PRINT CHR$(178)
	ELSEIF rb = true THEN
		LOCATE row, col
		PRINT CHR$(15)
	END IF


LOOP WHILE INKEY$ <> CHR$(27)

