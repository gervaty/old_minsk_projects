'$INCLUDE: 'exlib.bi'
CLS
'PRINT INT(6.034) 'пример округления до шестерки
'PRINT INT(RND * 10) + 1      'случайное число от одного до 10
'PRINT CHR$(INT(RND * 26) + 65)   ' генерация случайной латинской буквы

RANDOMIZE TIMER    ' не спрашивает, а берет из времени
'cod$ = CHR$(INT(RND * 26) + 65)
FOR k = 1 TO 4
	FOR i = 1 TO 5
		cod$ = cod$ + CHR$(INT(RND * 26) + 65)
	NEXT
	cod$ = cod$ + "-"
NEXT
cod$ = MID$(cod$, 1, LEN(cod$) - 1)
OPEN "c:\logs\codos.log" FOR APPEND AS #1
PRINT #1, cod$ + "    "; GetDate + "  "; TIME$
CLOSE #1
PRINT cod$

