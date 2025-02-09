'$INCLUDE: 'exlib.bi'
DECLARE SUB Vopros (vopr$, otvet$, otmet%, numLine%, wnd AS WndType)
DECLARE SUB LoadVoprs (vopr() AS STRING, otvet() AS STRING, fileName AS STRING)
DECLARE FUNCTION GetTemaFile$ (temas() AS STRING, names() AS STRING)
DECLARE SUB LoadCfg (temas() AS STRING, names() AS STRING)
'     **************************
'     *                        *
'     *    Super test          *
'     *    Version: 4.0        *
'     *                        *
'     **************************

ON ERROR GOTO errorbox

CLS
DIM vopr(1 TO 10) AS STRING
DIM otvet(1 TO 10)  AS STRING
DIM vopr AS STRING
DIM temas(1 TO 10) AS STRING, names(1 TO 10) AS STRING
DIM otmet AS INTEGER
DIM wnd AS WndType

wnd.frameColor = 4
wnd.backColor = 1
wnd.frameType = 2
			   
WndDraw 1, 1, 80, 24, wnd, " �롥�� ���� "


CALL LoadCfg(temas(), names())
otmet = 10
fileName$ = GetTemaFile$(temas(), names())

' ����㧪� ���.
CALL LoadVoprs(vopr(), otvet(), fileName$)

' ��砫� ���.

numLine% = 2
FOR k = LBOUND(vopr) TO UBOUND(vopr)
	 CALL Vopros(vopr(k), otvet(k), otmet, numLine%, wnd)
NEXT


IF otmet >= 7 THEN
	LOCATE 13, 29, 0
	PRINT "���� �ன���!"
	LOCATE , 29
	PRINT "��� �⬥⪠: "; otmet
	PLAY "acdefg"

ELSEIF otmet < 7 THEN
	LOCATE 13, 29, 0
	PRINT "���� �� �ன���!"
	LOCATE , 29
	PRINT "��� �⬥⪠: "; otmet
	BEEP
	SLEEP 1
	BEEP
	BEEP

END IF
END

errorbox:
COLOR 4, 1
LOCATE 14, 2
SELECT CASE ERR
	CASE 52
		PRINT "������ ����� 䠩�� ���."
		LOCATE , 2, 0
		BEEP
		SLEEP 1
		COLOR 7, 0
		CLS
		END
	CASE 53
		PRINT "���� ��� �� ������."
		LOCATE , 2, 0
		BEEP
		SLEEP 1
		CLS
		END
END SELECT
RESUME NEXT

FUNCTION GetTemaFile$ (temas() AS STRING, names() AS STRING)
	LOCATE 2, 2
	FOR k = LBOUND(temas) TO UBOUND(temas)
		COLOR 4, 1
		IF temas(k) <> "" THEN
		PRINT STR$(k) + ". " + temas(k);
		END IF
	NEXT

	LOCATE 13, 25, 1
	PRINT "������ ����� ⥬�: ";
	temas$ = InputStr$(45, 13, 3, 1)
	GetTemaFile$ = names(VAL(temas$))
END FUNCTION

SUB LoadCfg (temas() AS STRING, names() AS STRING)
	k = LBOUND(temas)
	OPEN "c:\question\temas.cfg" FOR INPUT AS #1
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
	'CLS
	fileName = fileName + ".vpr"
	LOCATE , 2, 0
	PRINT "����㧪� ���..."
	OPEN "c:\question\" + fileName FOR INPUT AS #1
	WHILE NOT EOF(1)
		LINE INPUT #1, s$
		vopr(k) = s$
		LINE INPUT #1, s$
		otvet(k) = s$
		k = k + 1
	WEND
	CLOSE #1
END SUB

SUB Vopros (vopr$, otvet$, otmet%, numLine%, wnd AS WndType)

	WndDraw 1, 1, 80, 24, wnd, " SUPER TEST  ��室 - [Ctrl + C]"

	SetColor 7, 1
	LOCATE 10, 20
	PRINT "========= ����饭��: =========="

	adeotv = 0
voprosic:
	SetColor 7, 1
	LOCATE numLine%, 2, 1
	PRINT SPACE$(70);
	LOCATE numLine%, 2, 1
	PRINT "�����: "; vopr$;
	LINE INPUT " ��� �⢥�: "; adeotv$
	IF adeotv$ <> otvet$ <> 0 THEN
		LOCATE 13, 29
		PRINT "������ �⢥�!"
		str = str + 2
		IF otmet% <> 0 THEN
			otmet% = otmet% - 1
		END IF
		BEEP
		GOTO voprosic
	ELSEIF adeotv$ = otvet$ THEN
		str = str + 1
	END IF
END SUB

