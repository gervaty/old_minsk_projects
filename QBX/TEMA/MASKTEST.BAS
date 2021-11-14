DECLARE SUB SetOff (num)
DECLARE FUNCTION GetMask! (num!)
DECLARE SUB SetOn (num!)

CLS
OUT &H378, 0

DIM lamps AS INTEGER

FOR k = 1 TO 8
    CALL SetOn(k)
    SLEEP 1
NEXT k

FOR k = 1 TO 8
    CALL SetOff(k)
    SLEEP 1
NEXT k

FUNCTION GetMask (num)
    IF num = 1 THEN mask = 1
    IF num = 2 THEN mask = 2
    IF num = 3 THEN mask = 4
    IF num = 4 THEN mask = 8
    IF num = 5 THEN mask = 16
    IF num = 6 THEN mask = 32
    IF num = 7 THEN mask = 64
    IF num = 8 THEN mask = 128

    GetMask = mask
END FUNCTION

SUB SetOff (num)
    SHARED lamps AS INTEGER

    lamps = lamps AND NOT GetMask(num)
    OUT &H378, lamps
END SUB

SUB SetOn (num)
    SHARED lamps AS INTEGER

    lamps = lamps OR GetMask(num)
    OUT &H378, lamps
END SUB

