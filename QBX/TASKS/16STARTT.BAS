'$INCLUDE: 'exlib.bi'

IF COMMAND$ = "" THEN
	PRINT "�訡��! ��ࠬ��� ��������� - ���� � 䠩��."
ELSEIF COMMAND$ = "/?" THEN
	PRINT "STARTT - �ணࠬ�� ����� �� ����祭��/�몫�祭��/��१���㧪�"
	PRINT "�������� 䠩� ��ୠ�� ࠡ�祣� �६���."
	PRINT "�㦥� ��ࠬ��� - ���� � 䠩��."
ELSE
	st$ = "Started: " + GetDate$ + " " + TIME$
	PRINT st$
	OPEN COMMAND$ FOR APPEND AS #1
	PRINT #1, st$
	CLOSE #1
END IF

