CLS
INPUT "count = ", c

DIM a(1 TO c)


a(1) = 90

FOR k = LBOUND(a) TO UBOUND(a)
    PRINT a(k);
NEXT
PRINT
INPUT "count2 = ", c2
REDIM a(1 TO c2)

FOR k = LBOUND(a) TO UBOUND(a)
    PRINT a(k);
NEXT

