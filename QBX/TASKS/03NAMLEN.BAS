DIM nm AS STRING
DIM nmLen AS INTEGER

CLS
LINE INPUT "��� ��� �����? "; nm
nmLen = LEN(nm)
PRINT "� ��襬 ����� "; nmLen; " ᨬ���(��)"

IF nmLen < 5 THEN
    PRINT "�����쪮�"
ELSEIF nmLen > 10 THEN
    PRINT "�������"
ELSE
    PRINT "��ଠ�쭮� � ��� ���"
END IF







