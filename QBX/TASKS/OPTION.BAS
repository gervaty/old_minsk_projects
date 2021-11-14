CLS
OPEN "c:\snos\lan.dat" FOR INPUT AS #1
    LINE INPUT #1, s$
    lan$ = s$
CLOSE #1


IF lan$ = "e" THEN
    PRINT "! THISIISMYSYSTEM !"
ELSEIF lan$ = "r" THEN
    PRINT "! ’ŽŒŽŸ‘ˆ‘’…Œ€ !"
ELSE
PRINT "!!! ERROR !!!"

END IF

