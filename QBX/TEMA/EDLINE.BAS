DECLARE FUNCTION InputString$ (x%, y%, maxLen%)
DECLARE FUNCTION Min% (a1%, a2%)
DECLARE FUNCTION Max% (a1%, a2%)
DECLARE SUB Do2 (ch$, s$, x%, y%, maxLen%)
DECLARE SUB DoBack (s$, x%, y%, maxLen%)
DECLARE SUB DoChar (ch$, s$, maxLen%)
DECLARE SUB DoKey (ch$, s$, x%, y%, maxLen%)
DECLARE SUB RestoreStr (s$, x%, y%, maxLen%, oldPos%)
DECLARE SUB ShiftStr (s$, stPos%)
DECLARE SUB DelSym (s$, delPos%, x%, y%, maxLen%)
CLS
CONST x% = 10
CONST y% = 12
CONST maxLen% = 8
LOCATE y%, x%, 1

s$ = InputString$(x%, y%, maxLen%)

CLS
PRINT s$

SUB DelSym (s$, delPos%, x%, y%, maxLen%)
    oldPos% = delPos%
    CALL ShiftStr(s$, oldPos% - x% + 1)
    CALL RestoreStr(s$, x%, y%, maxLen%, oldPos%)
END SUB

SUB Do2 (ch$, s$, x%, y%, maxLen%)
    IF ch$ = CHR$(0) + CHR$(75) THEN    ' left
        LOCATE y%, Max(x%, POS(0) - 1)
    ELSEIF ch$ = CHR$(0) + CHR$(77) THEN ' right
        LOCATE y%, Min(x% + LEN(s$), POS(0) + 1)
    ELSEIF ch$ = CHR$(0) + CHR$(71) THEN ' home
        LOCATE y%, x%
    ELSEIF ch$ = CHR$(0) + CHR$(79) THEN ' end
        LOCATE y%, x% + LEN(s$)
    ELSEIF ch$ = CHR$(0) + CHR$(83) THEN ' del
        CALL DelSym(s$, POS(0), x%, y%, maxLen%)
    END IF
END SUB

SUB DoBack (s$, x%, y%, maxLen%)
    IF POS(0) > x% THEN
        CALL DelSym(s$, POS(0) - 1, x%, y%, maxLen%)
    END IF
END SUB

SUB DoChar (ch$, s$, maxLen%)
    IF LEN(s$) < maxLen% THEN
        PRINT ch$;
        s$ = s$ + ch$
    END IF
END SUB

SUB DoKey (ch$, s$, x%, y%, maxLen%)
    IF LEN(ch$) = 2 THEN
        CALL Do2(ch$, s$, x%, y%, maxLen%)
    END IF

    IF LEN(ch$) = 1 THEN
        IF ch$ = CHR$(8) THEN
            CALL DoBack(s$, x%, y%, maxLen%)
        ELSEIF ch$ <> CHR$(9) THEN
            CALL DoChar(ch$, s$, maxLen%)
        END IF
    END IF
END SUB

FUNCTION InputString$ (x%, y%, maxLen%)
    s$ = ""
    DO
        ch$ = INKEY$
        IF ch$ <> "" AND ch$ <> CHR$(27) THEN
            CALL DoKey(ch$, s$, x%, y%, maxLen%)
        END IF
    LOOP WHILE ch$ <> CHR$(13)

    InputString$ = s$
END FUNCTION

FUNCTION Max% (a1%, a2%)
    IF a1% > a2% THEN Max = a1% ELSE Max = a2%
END FUNCTION

FUNCTION Min% (a1%, a2%)
    IF a1% < a2% THEN Min = a1% ELSE Min = a2%
END FUNCTION

SUB RestoreStr (s$, x%, y%, maxLen%, oldPos%)
    LOCATE y%, x%
    PRINT STRING$(maxLen%, " ");
    LOCATE y%, x%
    PRINT s$;
    LOCATE y%, oldPos%
END SUB

' shift part of the string to the left starting from stPos
SUB ShiftStr (s$, stPos%)
    IF stPos% <= LEN(s$) THEN
        FOR k = stPos% TO LEN(s$) - 1
            MID$(s$, k) = MID$(s$, k + 1, 1)
        NEXT
        IF LEN(s$) > 0 THEN
            s$ = MID$(s$, 1, LEN(s$) - 1)
        END IF
    END IF
END SUB

