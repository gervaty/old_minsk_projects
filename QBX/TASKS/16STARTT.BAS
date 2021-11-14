'$INCLUDE: 'exlib.bi'

IF COMMAND$ = "" THEN
	PRINT "Ошибка! Параметр отсутствует - путь к файлу."
ELSEIF COMMAND$ = "/?" THEN
	PRINT "STARTT - программа которая при включении/выключении/перезагрузке"
	PRINT "заполняет файл журнала рабочего времени."
	PRINT "Нужен параметр - путь к файлу."
ELSE
	st$ = "Started: " + GetDate$ + " " + TIME$
	PRINT st$
	OPEN COMMAND$ FOR APPEND AS #1
	PRINT #1, st$
	CLOSE #1
END IF

