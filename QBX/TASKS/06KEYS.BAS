DIM ch AS STRING

DO
    ch = INKEY$

    IF ch <> "" THEN
        IF LEN(ch) = 1 THEN
            PRINT "1 BYTE CODE:"; ASC(ch)
        ELSE
            PRINT "2 BYTE CODE:"; ASC(MID$(ch, 2, 1))
        END IF
    END IF
LOOP WHILE ch <> CHR$(27)

