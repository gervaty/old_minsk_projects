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

' ����㧪� ���.
CALL LoadVoprs(vopr(), otvet(), fileName$)

' ��砫� ���.
FOR k = LBOUND(vopr) TO UBOUND(vopr)
	CALL Vopros(vopr(k), otvet(k))
NEXT


PRINT "�����!"
PLAY "acdefg"
END

errorbox:

SELECT CASE ERR
	CASE 52
		PRINT "������ ����� 䠩�� ���."
		END
	CASE 53
		PRINT "���� ��� �� ������."
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
	LINE INPUT "������ ����� ⥬�: "; temas$
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
	PRINT "���� ����������! (��室 - Ctrl + c)"
END SUB

SUB Vopros (vopr$, otvet$)
	adeotv = 0
voprosic:
	PRINT "�����: "; vopr$;
	LINE INPUT " ��� �⢥�: "; adeotv$
	IF adeotv$ <> otvet$ THEN
		PRINT "������ �⢥�!"
		BEEP
		GOTO voprosic
	END IF
END SUB

