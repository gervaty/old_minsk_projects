DECLARE FUNCTION GetPos! (a() AS STRING, word$)
CLS
DIM a(1 TO 10) AS STRING

'a(0) = "mama"
a(1) = "papa"
a(2) = "dom"
a(3) = "w"
a(4) = "w2314"
a(5) = "kuku"
a(6) = "fefe"
a(7) = "Z"
a(8) = "w"
a(9) = "NET"
a(10) = "DUD"

FOR k = 1 TO 10
'    INPUT "Enter the next string: ", a(k)
    PRINT a(k)
NEXT

DO
    LINE INPUT "Enter value to search: ", word$
    PRINT GetPos(a(), word$)

LOOP WHILE word$ <> ""


FUNCTION GetPos (a() AS STRING, word$)
    GetPos = -1
    FOR k = LBOUND(a) TO UBOUND(a)
        IF a(k) = word$ THEN
            GetPos = k
            EXIT FOR
        END IF
    NEXT
END FUNCTION

