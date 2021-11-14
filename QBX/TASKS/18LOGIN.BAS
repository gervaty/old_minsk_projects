DECLARE SUB LoadUsers (users() AS ANY)
'$INCLUDE: 'exlib.bi'
CLS

TYPE User
	login AS STRING * 16
	password AS STRING * 12
END TYPE
DIM users(10) AS User

CALL LoadUsers(users())
start:           
CALL WndDraw(28, 11, 53, 16, 7, )
LOCATE 13, 30
PRINT "Login:"
LOCATE 14, 30
PRINT "Password:"
LOCATE 13, 40
s$ = InputString$(40, 13, 8)
LOCATE 14, 40
s2$ = InputString$(40, 14, 8)

FOR k = LBOUND(logins) TO UBOUND(logins)
	IF logins(k) = login$ THEN
		IF password$ = passwords(k) THEN
			CLS
			PLAY "acdfga"
			END 0
		ELSE
			GOTO start
		END IF
	ELSE
		GOTO start
	END IF
NEXT

END 1

SUB LoadUsers (users() AS User)
	'fileNum = FREEFILE
	DIM uindex AS INTEGER
	OPEN "c:\snos\users.dat" FOR INPUT AS #1
	k = 0
	WHILE NOT EOF(1)
		LINE INPUT #1, s$
		logins(k) = s$
		LINE INPUT #1, s$
		passwords(k) = s$
		k = k + 1
	WEND
	CLOSE #1
END SUB

