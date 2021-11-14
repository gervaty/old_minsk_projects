CLS
DIM summa AS INTEGER
DIM max AS INTEGER
DIM min AS INTEGER
DIM otr AS INTEGER
DIM a(10) AS INTEGER
otr = 0
a(1) = 3
a(2) = -6
a(3) = -30
a(4) = 8
a(5) = -3
a(6) = 4
a(7) = 9
a(8) = -94
a(9) = 44
a(10) = 7

FOR k = 1 TO 10: PRINT a(k); : NEXT

min = 32767
max = -32768

FOR k = 1 TO 10
    summa = summa + a(k)
NEXT

FOR k = 1 TO 10
    IF a(k) < min THEN min = a(k)
NEXT k

FOR k = 1 TO 10
    IF a(k) > max THEN max = a(k)
NEXT k

FOR k = 1 TO 10
    IF a(k) < 0 THEN otr = otr + 1
NEXT

PRINT
PRINT "summa = "; summa
PRINT "min = "; min
PRINT "max = "; max
PRINT
PRINT "otr = "; otr





