CLS

DIM file AS STRING

' ������ � 䠩�
INPUT "Enter file name: ", file
INPUT "Enter text to write to the file: ", s$

file = file + ".txt"

OPEN file FOR APPEND AS #1
PRINT #1, s$
CLOSE 1

' �⥭�� �� 䠩��

OPEN file FOR INPUT AS #1
DO WHILE NOT EOF(1)
    LINE INPUT #1, s$
    PRINT s$
LOOP

CLOSE #1

' elfkbnm afqk
'KILL file

