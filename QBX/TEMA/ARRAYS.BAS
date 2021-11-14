CLS
DIM a(10) AS INTEGER
DIM summa AS INTEGER
DIM min AS INTEGER
min = 32767

FOR k = 1 TO 10
    INPUT "дай мне элемент"; a(k)
NEXT

FOR k = 1 TO 10
    PRINT a(k);
NEXT

FOR k = 1 TO 10
    summa = summa + a(k)
NEXT

PRINT
PRINT summa

FOR k = 1 TO 10
    IF a(k) < min THEN
        min = a(k)
    END IF
NEXT

PRINT "MIN = "; min


