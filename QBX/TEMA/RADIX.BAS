CLS
INPUT "������ 楫�� �����筮� �᫮: ", n&
a$ = ""
k% = 0
DO
    INPUT "������ �᭮����� ��㣮� ��⥬� ��᫥���: ", k%
    IF k% < 2 OR k% > 36 THEN
        PRINT "�����⨬� ���祭�� - �� 2 �� 36"
    END IF
LOOP UNTIL k% > 1 AND k% < 37

DO
    r% = n& MOD k%
    n& = n& \ k%
    IF r% < 10 THEN
        b$ = LTRIM$(STR$(r%))
    ELSE
        b$ = CHR$(ASC("A") - 10 + r%)
    END IF
    a$ = b$ + a$
LOOP WHILE n& > 0
PRINT "��᫮ � ��⥬� � �᭮������"; k%; ": "; a$




