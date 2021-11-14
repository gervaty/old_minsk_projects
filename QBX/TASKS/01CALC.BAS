CLS
LOCATE 1, 32
PRINT "ДОБРО ПОЖАЛОВАТЬ!"
INPUT "Введите тип операции: ", to$
INPUT "Введите первое число: ", n1&
INPUT "Введите второе число: ", n2&

IF to$ = "+" THEN
    otvet = n1& + n2&
ELSEIF to$ = "-" THEN
    otvet = n1& - n2&
ELSE
    PRINT "ERROR!"
    END
END IF

PRINT "Ответ: "; n1&; to$; n2&; "="; otvet


                                                      

