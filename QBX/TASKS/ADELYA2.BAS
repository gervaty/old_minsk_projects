'     **************************
'     *                        *
'     *  Super test            *
'     *  Version: 3.0          *
'     **************************
DECLARE SUB ReadVoprs (vopr() AS STRING, otvet() AS STRING)
DECLARE SUB Vopros (vopr$, otvet$)
CLS
PRINT "���� ����������! (��室 - Ctrl + c)"
DIM vopr(1 TO 10) AS STRING
DIM otvet(1 TO 10)  AS STRING
DIM vopr AS STRING
'======== START ===========
CALL ReadVoprs(vopr(), otvet())

FOR k = 1 TO 10
	CALL Vopros(vopr(k), otvet(k))
NEXT


PRINT "�����!"
PLAY "acdefg"

SUB ReadVoprs (vopr() AS STRING, otvet() AS STRING)
	k = 1
	LINE INPUT "����㦠�� ��� � 䠩��: "; test$
	test$ = test$ + ".vpr"
	OPEN "c:\dev\qbx\tasks\question\" + test$ FOR INPUT AS #1
	WHILE NOT EOF(1)
		LINE INPUT #1, s$
		vopr(k) = s$
		LINE INPUT #1, s$
		otvet(k) = s$
		k = k + 1
	WEND
	CLOSE #1
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

