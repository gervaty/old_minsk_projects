CLS
DIM ch AS STRING
DIM locy, locx AS INTEGER
locy = 13
locx = 40

DO
    ch = INKEY$

    IF ch = CHR$(0) + CHR$(72) AND locy > 1 THEN
        locy = locy - 1
    ELSEIF ch = CHR$(0) + CHR$(75) AND locx > 1 THEN
        locx = locx - 1
    ELSEIF ch = CHR$(0) + CHR$(80) AND locy < 25 THEN
        locy = locy + 1
    ELSEIF ch = CHR$(0) + CHR$(77) AND locx < 80 THEN
        locx = locx + 1
    END IF

    LOCATE locy, locx, 1

LOOP WHILE ch <> CHR$(27)

