DIM nm AS STRING
DIM nmLen AS INTEGER

CLS
LINE INPUT "Как вас зовут? "; nm
nmLen = LEN(nm)
PRINT "В Вашем имени "; nmLen; " символ(ов)"

IF nmLen < 5 THEN
    PRINT "Маленькое"
ELSEIF nmLen > 10 THEN
    PRINT "Длинное"
ELSE
    PRINT "Нармальное у Вас имя"
END IF







