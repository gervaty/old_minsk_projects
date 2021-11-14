'$INCLUDE: 'exlib.bi'

CLS
COLOR 15, 2

RANDOMIZE TIMER

FOR k = 1 TO 100
	x1 = INT(RND * 10) + 1
	y1 = INT(RND * 10) + 1
	x2 = INT(RND * 80) + 1
	y2 = INT(RND * 10) + 15
	fore = INT(RND * 15) + 1
	back = INT(RND * 15) + 1
	IF x2 > x1 + 3 THEN
		CALL WndDraw(x1, y1, x2, y2, fore, back, 2, " Заголовок ")
	END IF
	IF INKEY$ = CHR$(27) THEN EXIT FOR
NEXT k

