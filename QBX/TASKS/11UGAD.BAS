DIM otv AS STRING
n1 = 1
n2 = 100
c = 50
CLS
PRINT "Задумайте число от 1 до 100"
DO
    PRINT "Больше меньше или равно" + STR$(c);
    INPUT otv
    IF otv = "=" THEN
        END
    ELSEIF otv = "<" THEN
        n2 = c
        c = (c + n1) \ 2
    ELSEIF otv = ">" THEN
        n1 = c
        c = (c + n2) \ 2
    END IF
LOOP WHILE INKEY$ <> CHR$(27)



