DECLARE SUB Endo (n1&, to$, n2&, otvet)
DECLARE SUB Enda ()
DECLARE SUB Fills ()
'##################################################################
CALL Fills
LOCATE 1, 32
PRINT "����� ����������!"
LOCATE 6, 30
INPUT "������ ⨯ ����樨: ", to$
LOCATE 7, 30
INPUT "������ ��ࢮ� �᫮: ", n1&
LOCATE 8, 30
INPUT "������ ��஥ �᫮: ", n2&

IF to$ = "+" THEN
    otvet = n1& + n2&
ELSEIF to$ = "-" THEN
    otvet = n1& - n2&
ELSE
    CALL Enda
END IF
CALL Endo(n1&, to$, n2&, otvet)

SUB Enda
    LOCATE 9, 38
    PRINT "ERROR!"
    END
END SUB

SUB Endo (n1&, to$, n2&, otvet)
    LOCATE 9, 30
    PRINT "�⢥�: "; n1&; to$; n2&; "="; otvet

END SUB

SUB Fills
    CLS
    COLOR 0, 15

    FOR k = 1 TO 50
        PRINT " "
    NEXT k
END SUB

