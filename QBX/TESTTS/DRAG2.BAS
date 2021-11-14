DECLARE SUB DrawBox (x!, y!, isDraw!)
'$INCLUDE: 'exlib.bi'


CLS
MouseInit
MouseShow
DIM x1, x2, y1, y2, lastX, last, shiftX
x1 = 50
shiftX = 0
y1 = 15
DrawBox x1, y1, TRUE

DO
	MousePoll y, x, lBtn, rBtn

	IF lBtn = TRUE THEN
		IF x >= x1 AND x < x1 + 4 AND y = y1 THEN
			dragging = TRUE
		END IF
	ELSEIF lBtn = FALSE AND dragging = TRUE THEN
		dragging = FALSE
		MouseHide
		DrawBox x1, y1, TRUE
		MouseShow
	END IF

	IF lastX <> x OR lastY <> y THEN
		IF dragging = TRUE THEN
			IF y1 + 3 = 26 THEN
				END
			ELSE
				DrawBox x1, y1, FALSE
				x1 = x1 + x - lastX
				y1 = y1 + y - lastY
				DrawBox x1, y1, TRUE
			END IF
		END IF
		lastX = x
		lastY = y
	END IF
LOOP WHILE INKEY$ <> CHR$(27)

SUB DrawBox (x, y, isDraw)
	IF isDraw = TRUE THEN
		's$ = "лллл"
		WndDraw x, y, x + 20, y + 8, 7, 1, 2, " Hello "
	ELSE
		's$ = "    "
		WndDraw x, y, x + 20, y + 8, 0, 0, 2, " Hello "
	END IF
																	
		'COLOR 1, 0
		'LOCATE y, x
		'PRINT s$
		'LOCATE y + 1, x
		'PRINT s$
		'COLOR 7, 0
END SUB

