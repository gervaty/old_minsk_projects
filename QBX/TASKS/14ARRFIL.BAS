CLS
DIM a(1 TO 10)
OPEN "c:\numbers.dat" FOR INPUT AS #1

FOR k = 1 TO 10
    LINE INPUT #1, s$
    a(k) = VAL(s$)
NEXT

CLOSE #1

FOR k = 1 TO 10
    PRINT a(k)
NEXT


