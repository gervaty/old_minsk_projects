DECLARE SUB DrawBox (x!, y!, isDraw!)
'$INCLUDE: 'exlib.bi'


CLS
CALL MouseInit
CALL MouseShow
DIM x1, x2, y1, y2, lastX, lastY
x1 = 50
y1 = 15
CALL DrawBox(x1, y1, TRUE)

DO
	CALL MousePoll(y, x, lBtn, rBtn)

	LOCATE 10, 10
	PRINT x, y
	IF lBtn = TRUE AND pressed = FALSE THEN
		LOCATE 20, 20
		PRINT "Нажата  "
		pressed = TRUE
		startX = x
		startY = y
		IF x1 = x AND y1 = y THEN
			dragging = TRUE
		END IF
	ELSEIF lBtn = FALSE AND pressed = TRUE THEN
		dragging = FALSE
		CALL MouseHide
		CALL DrawBox(x1, y1, TRUE)
		CALL MouseShow
		pressed = FALSE
		LOCATE 20, 20
		PRINT "Отпущена";
	END IF

	IF lastX <> x OR lastY <> y THEN
		lastX = x
		lastY = y
		IF dragging = TRUE THEN
			CALL DrawBox(x1, y1, FALSE)
			x1 = x
			y1 = y
			CALL DrawBox(x1, y1, TRUE)
		END IF


		IF pressed = TRUE THEN
			LOCATE 20, 30
			PRINT "Перетаскивает", lBtn
		ELSE
			LOCATE 20, 30
			PRINT "Двигается    ", lBtn
		END IF
	END IF
LOOP WHILE INKEY$ <> CHR$(27)

SUB DrawBox (x, y, isDraw)
	IF isDraw = TRUE THEN
		s$ = "████"
	ELSE
		s$ = "    "
	END IF

	COLOR 1, 0
	LOCATE y, x
	PRINT s$
	LOCATE y + 1, x
	PRINT s$
	COLOR 7, 0

END SUB

