DECLARE SUB ReadFile (file$)
DECLARE SUB KillFile (file$)
DECLARE SUB WriteFile (file$)
DIM file AS STRING
DIM otv AS INTEGER
CLS
INPUT "Введите имя файлa: "; file



INPUT "1 - редоктирывать, 2 - читать, 3 - удалять: "; otv
IF otv = 1 THEN CALL WriteFile(file)
IF otv = 2 THEN CALL ReadFile(file)
IF otv = 3 THEN CALL KillFile(file)

SUB KillFile (file$)
    KILL file$
END SUB

SUB ReadFile (file$)
    OPEN file$ FOR INPUT AS #1
    DO WHILE NOT EOF(1)
        LINE INPUT #1, s$
        PRINT s$
    LOOP
    CLOSE #1
END SUB

SUB WriteFile (file$)
    OPEN file$ FOR APPEND AS #1
    INPUT s$
    PRINT #1, s$
    CLOSE #1
END SUB

