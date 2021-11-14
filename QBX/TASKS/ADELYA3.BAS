DECLARE SUB LoadVoprs (vopr() AS STRING, otvet() AS STRING, fileName AS STRING)
DECLARE FUNCTION GetTemaFile$ (temas() AS STRING, names() AS STRING)
DECLARE SUB LoadCfg (temas() AS STRING, names() AS STRING)
DECLARE SUB Vopros (vopr$, otvet$)
'     **************************
'     *                        *
'     *    Super test          *
'     *    Version: 4.0        *
'     *                        *
'     **************************
'$INCLUDE: 'exlib.bi'
ON ERROR GOTO errorbox

CLS

DIM vopr(1 TO 10) AS STRING
DIM otvet(1 TO 10)  AS STRING
DIM vopr AS STRING
DIM temas(1 TO 10) AS STRING, names(1 TO 10) AS STRING

CALL LoadCfg(temas(), names())

fileName$ = GetTemaFile$(temas(), names())

' Загрузка теста.
CALL LoadVoprs(vopr(), otvet(), fileName$)

' Начало теста.
FOR k = LBOUND(vopr) TO UBOUND(vopr)
	CALL Vopros(vopr(k), otvet(k))
NEXT


PRINT "КОНЕЦ!"
PLAY "acdefg"
END

errorbox:

SELECT CASE ERR
	CASE 52
		PRINT "Неверный номер файла теста."
		END
	CASE 53
		PRINT "Файл теста не найден."
		END
END SELECT
RESUME NEXT

FUNCTION GetTemaFile$ (temas() AS STRING, names() AS STRING)
	FOR k = LBOUND(temas) TO UBOUND(temas)
		IF temas(k) <> "" THEN
		PRINT STR$(k) + ". " + temas(k);
		END IF
	NEXT

	LOCATE 13, 25
	LINE INPUT "Введите номер темы: "; temas$
	GetTemaFile$ = names(VAL(temas$))
END FUNCTION

SUB LoadCfg (temas() AS STRING, names() AS STRING)
	k = LBOUND(temas)
	OPEN "c:\dev\qbx\tasks\question\temas.cfg" FOR INPUT AS #1
	WHILE NOT EOF(1)
		LINE INPUT #1, s$
		temas(k) = s$
		LINE INPUT #1, s$
		names(k) = s$
		k = k + 1
	WEND
	CLOSE #1
END SUB

SUB LoadVoprs (vopr() AS STRING, otvet() AS STRING, fileName AS STRING)
	k = 1
	CLS
	fileName = fileName + ".vpr"
	OPEN "c:\dev\qbx\tasks\question\" + fileName FOR INPUT AS #1
	WHILE NOT EOF(1)
		LINE INPUT #1, s$
		vopr(k) = s$
		LINE INPUT #1, s$
		otvet(k) = s$
		k = k + 1
	WEND
	CLOSE #1
	PRINT "Добро пожаловать! (Выход - Ctrl + c)"
END SUB

SUB Vopros (vopr$, otvet$)
	adeotv = 0
voprosic:
	PRINT "Вопрос: "; vopr$;
	LINE INPUT " Ваш ответ: "; adeotv$
	IF adeotv$ <> otvet$ THEN
		PRINT "Неверный ответ!"
		BEEP
		GOTO voprosic
	END IF
END SUB

