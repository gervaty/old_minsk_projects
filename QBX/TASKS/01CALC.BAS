CLS
LOCATE 1, 32
PRINT "����� ����������!"
INPUT "������ ⨯ ����樨: ", to$
INPUT "������ ��ࢮ� �᫮: ", n1&
INPUT "������ ��஥ �᫮: ", n2&

IF to$ = "+" THEN
    otvet = n1& + n2&
ELSEIF to$ = "-" THEN
    otvet = n1& - n2&
ELSE
    PRINT "ERROR!"
    END
END IF

PRINT "�⢥�: "; n1&; to$; n2&; "="; otvet


                                                      

