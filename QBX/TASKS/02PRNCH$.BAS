CLS

DO
    ch$ = INKEY$
    IF ch$ <> "" THEN
        PRINT ch$
    END IF
LOOP WHILE ch$ <> CHR$(27)







