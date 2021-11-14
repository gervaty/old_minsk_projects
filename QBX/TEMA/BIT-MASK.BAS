DECLARE FUNCTION ToBin$ (BYVAL num%)
CLS
DIM byte AS INTEGER

byte = 254
mask = NOT 120

PRINT "Byte = ", ToBin$(byte)
PRINT "Mask = ", ToBin$(mask)

res = byte AND mask

PRINT "Result = ", ToBin$(res)

FUNCTION ToBin$ (BYVAL num%)
    num% = num% AND &HFF
    'num% = d%
    DO WHILE num% <> 0
        r = num% MOD 2
        s$ = LTRIM$(STR$(r)) + s$
        num% = num% \ 2
    LOOP

    FOR k = 1 TO 8 - LEN(s$)
        s$ = "0" + s$
    NEXT
    
    ToBin$ = s$
END FUNCTION

