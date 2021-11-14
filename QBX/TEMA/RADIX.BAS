CLS
INPUT "Введите целое десятичное число: ", n&
a$ = ""
k% = 0
DO
    INPUT "Укажите основание другой системы счисления: ", k%
    IF k% < 2 OR k% > 36 THEN
        PRINT "Допустимые значения - от 2 до 36"
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
PRINT "Число в системе с основанием"; k%; ": "; a$




