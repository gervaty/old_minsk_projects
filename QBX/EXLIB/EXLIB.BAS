DECLARE FUNCTION GetSysLang$ ()
DECLARE SUB CenterText (x1!, x2!, y!, text$)
'$INCLUDE: 'exlib.bi'

' INTERNAL DECLARATIONS
DECLARE SUB InsertSym (s$, ch$, nPos%)
DECLARE SUB ShiftStrLeft (s$, stPos%)
DECLARE FUNCTION Min% (a1%, a2%)
DECLARE FUNCTION Max% (a1%, a2%)
DECLARE SUB Do2 (ch$, s$, x%, y%, maxLen%)
DECLARE SUB DoBack (s$, x%, y%, maxLen%)
DECLARE SUB DoChar (s$, ch$, x%, y%, maxLen%)
DECLARE SUB DoKey (s$, ch$, x%, y%, maxLen%)
DECLARE SUB RestoreStr (s$, x%, y%, maxLen%, oldPos%)
DECLARE SUB DelSym (s$, delPos%, x%, y%, maxLen%)

COMMON SHARED fColor AS INTEGER
COMMON SHARED bColor AS INTEGER

COMMON SHARED isCaretVisible AS INTEGER
COMMON SHARED xCaretPos AS INTEGER
COMMON SHARED yCaretPos AS INTEGER


'#############################   Mouse   ##############################
CLS
Init
's$ = InputStr$(10, 10, 10)
'LOCATE 11, 10
'PRINT s$
'instr
'CALL ShiftStrLeft(s$, 2)
'PRINT s$
'nPos = 2
'CALL InsertSym(s$, "E", 4)
's$ = InputStr$(10, 10, 10)
'PRINT s$

'PRINT GetSysLang$
'Init
DIM wnd AS WndType
wnd.frameType = 2
wnd.canClose = FALSE
'CALL ShowCaret

'CALL WndDraw(1, 1, 80, 25, wnd, " Hello ")

SetPos 30, 20
ShowCaret
'PrintStr 10, 10, "dd"
'SetPos 30, 20
'ShowCaret

PressAnyKey

HideCaret

PressAnyKey

SUB CenterText (x1, x2, y, text$)
	xPos = (x2 - x1) / 2 - LEN(text$) / 2
	IF xPos > 0 THEN
		LOCATE y, x1 + xPos
		PRINT text$
	END IF
END SUB

SUB Delay (ms)
	start# = TIMER
	DO
	LOOP UNTIL TIMER - start# > .001 * ms
END SUB

SUB DelSym (s$, delPos%, x%, y%, maxLen%)
	oldPos% = delPos%
	CALL ShiftStrLeft(s$, oldPos% - x% + 1)
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

SUB DoChar (s$, ch$, x%, y%, maxLen%)
	IF LEN(s$) < maxLen% THEN
		CALL InsertSym(s$, ch$, POS(0) - x% + 1)
		LOCATE y%, POS(0) + 1, 1
		CALL RestoreStr(s$, x%, y%, maxLen%, POS(0))
	END IF
END SUB

SUB DoKey (s$, ch$, x%, y%, maxLen%)
	IF LEN(ch$) = 2 THEN
		CALL Do2(ch$, s$, x%, y%, maxLen%)
	END IF

	IF LEN(ch$) = 1 THEN
		IF ch$ = CHR$(8) THEN
			CALL DoBack(s$, x%, y%, maxLen%)
		ELSEIF ch$ <> CHR$(9) THEN
			CALL DoChar(s$, ch$, x%, y%, maxLen%)
		END IF
	END IF
END SUB

FUNCTION GetBColor
	GetBColor = bColor
END FUNCTION

FUNCTION GetDate$
	d$ = DATE$

	day$ = MID$(d$, 4, 2)
	month$ = MID$(d$, 1, 2)
	year$ = MID$(d$, 7, 4)

	GetDate$ = day$ + "-" + month$ + "-" + year$

END FUNCTION

FUNCTION GetFColor
	GetFColor = fColor
END FUNCTION

FUNCTION GetKey$
	DO
		ch$ = INKEY$

	LOOP WHILE ch$ = ""
	GetKey$ = ch$

END FUNCTION

FUNCTION GetSysLang$
	GetSysLang$ = ENVIRON$("LANG")
END FUNCTION

SUB HideCaret
	SHARED isCaretVisible AS INTEGER

	isCaretVisible = 0

	SetPos xCaretPos%, yCaretPos%
END SUB

SUB Init
	SetPos 1, 1
	HideCaret
	SetColor 7, 0
END SUB

FUNCTION InputStr$ (x%, y%, maxLen%)
	SetPos x%, y%
	s$ = ""
	DO
		ch$ = INKEY$
		IF ch$ <> "" AND ch$ <> CHR$(27) AND ch$ <> CHR$(13) THEN
			CALL DoKey(s$, ch$, x%, y%, maxLen%)
		END IF
	LOOP WHILE ch$ <> CHR$(13)

	InputStr$ = s$
END FUNCTION

' inserts symbol ch$ into the string s$ at the position nPos%
SUB InsertSym (s$, ch$, nPos%)
	s$ = MID$(s$, 1, nPos% - 1) + ch$ + MID$(s$, nPos%)
END SUB

SUB LoadScreen (num%)
	IF num% > 0 AND num% < 99 THEN
		DEF SEG = &HB800
		BLOAD "screen" + ToZeroStr$(CSNG(num%), 2) + ".dat", 0
		DEF SEG
	ELSE
		ERROR 201
	END IF
END SUB

FUNCTION Max% (a1%, a2%)
	IF a1% > a2% THEN Max = a1% ELSE Max = a2%
END FUNCTION

FUNCTION Min% (a1%, a2%)
	IF a1% < a2% THEN Min = a1% ELSE Min = a2%
END FUNCTION

SUB MouseCallDriver (m0, m1, m2, m3) STATIC

	DIM regs AS RegType

	IF MouseChecked = FALSE THEN
	DEF SEG = 0

	MouseSegment& = 256& * PEEK(207) + PEEK(206)
	MouseOffset& = 256& * PEEK(205) + PEEK(204)

	DEF SEG = MouseSegment&

	IF (MouseSegment& = 0 AND MouseOffset& = 0) OR PEEK(MouseOffset&) = 207 THEN
		MousePresent = FALSE
		MouseChecked = TRUE
		DEF SEG
	END IF
	END IF

	IF MousePresent = FALSE AND MouseChecked = TRUE THEN
	'EXIT SUB
	END IF

	' =======================================================================
	' Calls interrupt 51 to invoke mouse functions in the MS Mouse Driver.
	' =======================================================================

	regs.ax = m0
	regs.bx = m1
	regs.cx = m2
	regs.dx = m3

	'Interrupt 51, regs, regs

	m0 = regs.ax
	m1 = regs.bx
	m2 = regs.cx
	m3 = regs.dx

	IF MouseChecked THEN EXIT SUB

	' =======================================================================
	' Check for successful mouse initialization
	' =======================================================================

	IF m0 AND NOT MouseChecked THEN
	MousePresent = TRUE
	DEF SEG
	END IF

	MouseChecked = TRUE

END SUB

SUB MouseHide
   MouseCallDriver 2, 0, 0, 0
END SUB

SUB MouseInit
   MouseCallDriver 0, 0, 0, 0
END SUB

SUB MousePoll (row, col, lButton, rButton) STATIC
	' =======================================================================
	' Polls mouse driver, then sets parms correctly
	' =======================================================================

	MouseCallDriver 3, button, col, row
	row = row / 8 + 1
	col = col / 8 + 1

	IF button AND 1 THEN
		lButton = TRUE
	ELSE
		lButton = FALSE
	END IF

	IF button AND 2 THEN
	rButton = TRUE
	ELSE
	rButton = FALSE
	END IF
 
END SUB

SUB MouseSetBorder (row1, col1, row2, col2) STATIC

	' =======================================================================
	' Sets max and min bounds on mouse movement both vertically, and
	' horizontally
	' =======================================================================

   MouseCallDriver 7, 0, (col1 - 1) * 8, (col2 - 1) * 8
   MouseCallDriver 8, 0, (row1 - 1) * 8, (row2 - 1) * 8
END SUB'

SUB MouseShow
   MouseCallDriver 1, 0, 0, 0
END SUB

SUB PressAnyKey
	DO
	LOOP WHILE INKEY$ = ""
END SUB

SUB PressEsc
	DO
	LOOP WHILE INKEY$ <> CHR$(27)
END SUB

SUB PrintStr (x%, y%, st$)
	SetPos x%, y%
	PRINT st$;
END SUB

SUB RestoreStr (s$, x%, y%, maxLen%, oldPos%)
	LOCATE y%, x%
	PRINT STRING$(maxLen%, " ");
	LOCATE y%, x%
	PRINT s$;
	LOCATE y%, oldPos%
END SUB

SUB SaveScreen (num%)
	IF num% > 0 AND num% < 99 THEN
		DEF SEG = &HB800
		BSAVE "screen" + ToZeroStr$(CSNG(num%), 2) + ".dat", 0, 4000
		DEF SEG
	ELSE
		ERROR 201
	END IF
END SUB

FUNCTION SearchWord (a() AS STRING, word$)
	SearchWord = -1
	FOR k = LBOUND(a) TO UBOUND(a)
		IF a(k) = word$ THEN
			SearchWord = k
			EXIT FOR
		END IF
	NEXT
END FUNCTION

SUB SetBColor (bCol)
	COLOR fColor, bCol
	bColor = bCol
END SUB

SUB SetColor (fCol, bCol)
	COLOR fCol, bCol
	fColor = fCol
	bColor = bCol
END SUB

SUB SetFColor (fCol)
	COLOR fCol, bColor
	fColor = fCol
END SUB

SUB SetPos (x%, y%)
	SHARED isCaretVisible AS INTEGER
	SHARED xCaretPos AS INTEGER
	SHARED yCaretPos AS INTEGER

	IF x% > 0 AND x% <= 80 AND y% > 0 AND y% <= 25 THEN
		LOCATE y%, x%, isCaretVisible
		xCaretPos = x%
		yCaretPos = y%
	END IF
END SUB

' shift part of the string starting from stPos
SUB ShiftStrLeft (s$, stPos%)
	IF stPos% <= LEN(s$) THEN
		FOR k = stPos% TO LEN(s$) - 1
			MID$(s$, k) = MID$(s$, k + 1, 1)
		NEXT
		IF LEN(s$) > 0 THEN
			s$ = MID$(s$, 1, LEN(s$) - 1)
		END IF
	END IF
END SUB

SUB ShowCaret
	SHARED isCaretVisible AS INTEGER

	isCaretVisible = 1
	SetPos xCaretPos%, yCaretPos%
END SUB

FUNCTION ToStr$ (num!)
	ToStr$ = LTRIM$(STR$(num!))
END FUNCTION

FUNCTION ToZeroStr$ (num!, length)
	' does not work with negative numbers!

	res$ = ToStr$(num!)

	WHILE LEN(res$) < length
		res$ = "0" + res$
	WEND

	ToZeroStr$ = res$
END FUNCTION

'########################### Windows #############################
SUB WndDraw (x1, y1, x2, y2, wnd AS WndType, title$)
	IF wnd.frameType = 0 THEN wnd.frameType = 1
	IF wnd.frameColor = 0 THEN wnd.frameColor = 7

	DIM psCode(7) AS SINGLE
	DIM ps(1 TO 3) AS STRING
	ps(1) = "┌─┐│└─┘"
	ps(2) = "╔═╗║╚═╝"
	ps(3) = "███║╚═╝"

	FOR k = 1 TO 7
		psCode(k) = ASC(MID$(ps(wnd.frameType), k, 1))
	NEXT

	COLOR wnd.frameColor, wnd.backColor
	CALL WndPutc(x1, y1, psCode(1))
	CALL WndPuthl(x1 + 1, x2 - 1, y1, psCode(2))
	CALL WndPutc(x2, y1, psCode(3))
	CALL WndPutvl(x1, y1 + 1, y2 - 1, psCode(4))
	CALL WndPutc(x1, y2, psCode(5))
	CALL WndPuthl(x1 + 1, x2 - 1, y2, psCode(2))
	CALL WndPutvl(x2, y1 + 1, y2 - 1, psCode(4))

	'right bottom corner
	CALL WndPutc(x2, y2, psCode(7))

	IF title$ <> "" THEN
		CALL CenterText(x1, x2, y1, title$)
	END IF

	IF wnd.canClose = TRUE THEN
		LOCATE y1, x1 + 2
		PRINT "[■]";
	END IF

	' fill
	COLOR wnd.backColor, wnd.backColor
	FOR k = y1 + 1 TO y2 - 1
		CALL WndPuthl(x1 + 1, x2 - 1, k, 32)
	NEXT k

	COLOR fColor, bColor
END SUB

'Нарисовать символ с кодом code в координате (y, x)
SUB WndPutc (x, y, code)
	LOCATE y, x
	PRINT CHR$(code);
END SUB

' Линия символов с кодом code на строчке y начиная с координаты x1 до x2
SUB WndPuthl (x1, x2, y, code)
	FOR k = x1 TO x2
		CALL WndPutc(k, y, code)
	NEXT k
END SUB

'рисуем вертикальную линию
SUB WndPutvl (x, y1, y2, code)
	FOR k = y1 TO y2
		CALL WndPutc(x, k, code)
	NEXT k
END SUB

