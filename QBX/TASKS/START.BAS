start:
PRINT "Что запустить - 1. QBX, 2. Norton Comander 3. Turbo Pascal."; otvet$
INPUT " "; otv%
IF otv% = 1 THEN
    SHELL "qb"
ELSEIF otv% = 2 THEN
    SHELL "sc"
ELSEIF otv% = 3 THEN
    SHELL "tp"
ELSEIF otv% = 0 THEN
    END
ELSE
    GOTO start
END IF


