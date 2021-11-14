' $INCLUDE: 'girlanda.bi'

CLS

' константы - долгая и короткая задержка (в миллисекундах,1000 - это 1 секунда)
CONST t1 = 300, t2 = 50
CONST radius = 25, border = 12, fill = 4, x = 75, y = 240, distance = 55
DIM prog AS INTEGER
DIM lamps AS INTEGER

prog = 0

CALL Init                   ' выполняем инициализацию и подготовку

ON KEY(1) GOSUB Prog1
KEY(1) ON

ON KEY(2) GOSUB Prog2
KEY(2) ON

ON KEY(3) GOSUB Prog3
KEY(3) ON

ON KEY(4) GOSUB Prog4
KEY(4) ON

ON KEY(5) GOSUB Prog5
KEY(5) ON

ON KEY(6) GOSUB Prog6
KEY(6) ON

DO
    SELECT CASE prog
        CASE 1
            CALL GoSlow                 ' пробежаться медленно
        CASE 2
            CALL GoFast                 ' пробежаться побыстрее
        CASE 3
            CALL Gir
        CASE 4
            CALL GoRandom
        CASE 5
            CALL GoSuper
        CASE 6
            CALL GoRace
    END SELECT
LOOP WHILE INKEY$ <> CHR$(27)
PLAY "A"
END

Prog1:
    BEEP
    prog = 1
    RETURN

Prog2:
    BEEP
    prog = 2
    RETURN

Prog3:
    BEEP
    prog = 3
    RETURN

Prog4:
    BEEP
    prog = 4
    RETURN

Prog5:
    BEEP
    prog = 5
    RETURN

Prog6:
    BEEP
    prog = 6
    RETURN

SUB DoLoop
    DO
        ch$ = INKEY$
    LOOP WHILE ch$ <> CHR$(27)
END SUB

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

SUB Gir
    FOR k = 1 TO 8
        CALL SetOn(k)
        CALL WaitTime(250)
    NEXT k
    FOR k = 8 TO 1 STEP -1
        CALL SetOff(k)
        CALL WaitTime(250)
    NEXT k
    FOR k = 8 TO 1 STEP -1
        CALL SetOn(k)
        CALL WaitTime(250)
    NEXT k
    FOR k = 1 TO 8
        CALL SetOff(k)
        CALL WaitTime(250)
    NEXT k
    FOR k = 1 TO 7 STEP 2
        CALL SetOn(k)
        CALL SetOn(k + 1)
        CALL WaitTime(250)
    NEXT k
END SUB

SUB GoBalls
    CALL WaitTime(400)
    CALL SetOn(4)
    CALL SetOn(5)
    CALL WaitTime(400)
    CALL SetOn(3)
    CALL SetOn(6)
    CALL WaitTime(400)
    CALL SetOn(7)
    CALL SetOn(2)
    CALL WaitTime(400)
    CALL SetOn(1)
    CALL SetOn(8)

    CALL WaitTime(200)

    CALL SetOff(4)
    CALL SetOff(5)
    CALL WaitTime(400)
    CALL SetOff(3)
    CALL SetOff(6)
    CALL WaitTime(400)
    CALL SetOff(7)
    CALL SetOff(2)
    CALL WaitTime(400)
    CALL SetOff(1)
    CALL SetOff(8)
END SUB

SUB GoFast                  ' быстрое зажигание и гашение ламп
    FOR k = 1 TO 8
        CALL SetOn(k)
        CALL WaitTime(t2)   ' ждем недолго
    NEXT k

    FOR k = 8 TO 1 STEP -1
        CALL SetOff(k)
        CALL WaitTime(t2)
    NEXT k
    CALL WaitTime(100)
END SUB

SUB GoRace
    FOR n = 100 TO 1 STEP -10
        FOR k = 1 TO 8
            SetOn (k)
            WaitTime (n)
            SetOff (k)
        NEXT
    NEXT

END SUB

SUB GoRandom
    CALL SetOn(INT(RND * 8) + 1)
    CALL WaitTime(20)
    CALL SetOff(INT(RND * 8) + 1)
END SUB

SUB GoSlow                  ' медленное зажигание и гашение всех ламп
    FOR k = 1 TO 8
        CALL SetOn(k)
        CALL WaitTime(t1)   ' ждем подольше
    NEXT k

    FOR k = 8 TO 1 STEP -1
        CALL SetOff(k)
        CALL WaitTime(t1)
    NEXT k
END SUB

SUB GoSuper
    FOR k = 1 TO 8
        SetOn (k)
        WaitTime (300)
        SetOff (k)
    NEXT
    'WaitTime (300)
    FOR k = 1 TO 7
        SetOn (k)
        SetOn (k + 1)
        WaitTime (300)
        SetOff (k)
        SetOff (k + 1)
    NEXT
    FOR k = 1 TO 6
        SetOn (k)
        SetOn (k + 1)
        SetOn (k + 2)
        WaitTime (300)
        SetOff (k)
        SetOff (k + 1)
        SetOff (k + 2)
    NEXT
    FOR k = 1 TO 5
        SetOn (k)
        SetOn (k + 1)
        SetOn (k + 2)
        SetOn (k + 3)
        WaitTime (300)
        SetOff (k)
        SetOff (k + 1)
        SetOff (k + 2)
        SetOff (k + 3)
    NEXT

END SUB

SUB Init
    'SCREEN 12           ' переходим в графический режим

   ' SLEEP 2             ' чтобы код не начал выполняться до графического режима
    RANDOMIZE TIMER

    'FOR k = 1 TO 8      ' рисуем восемь кругов
    '    CIRCLE (x + distance * k, y), radius, border, , , 1.3
    'NEXT k
END SUB

SUB SetOff (num)
    'PAINT (x + distance * num, y), 0, 0
    'CIRCLE (x + distance * num, y), radius, border, , , 1.3
    SHARED lamps AS INTEGER

    lamps = lamps AND NOT GetMask(num)
    OUT &H378, lamps
END SUB

SUB SetOn (num)
    'PAINT (x + distance * num, y), fill, border

     SHARED lamps AS INTEGER

     lamps = lamps OR GetMask(num)
     OUT &H378, lamps
END SUB

SUB WaitTime (t)
    start# = TIMER
    DO
    LOOP UNTIL TIMER - start# > .001 * t
END SUB

