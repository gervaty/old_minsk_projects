'$INCLUDE: 'c:\dev\basic\qbx\src\qbx.bi'

CONST FALSE = 0
CONST TRUE = -1
CONST MINROW = 2
CONST MAXROW = 25
CONST MINCOL = 1
CONST MAXCOL = 80
CONST MAXMENU = 10
CONST MAXITEM = 20
CONST MAXWINDOW = 10
CONST MAXBUTTON = 50
CONST MAXEDITFIELD = 20
CONST MAXHOTSPOT = 20

' #########################   Mouse     #########################

DECLARE SUB MousePoll (row, col, lButton, rButton)
DECLARE SUB MouseBorder (row1, col1, row2, col2)
DECLARE SUB MouseShow ()
DECLARE SUB MouseHide ()
DECLARE SUB MouseInit ()
DECLARE SUB MouseCallDriver (m0!, m1!, m2!, m3!)
COMMON SHARED /uitools/ MousePresent AS INTEGER

'##########################   Keyboard   ########################

DECLARE FUNCTION GetKey$ ()
DECLARE SUB PressAnyKey ()
DECLARE SUB PressEsc ()

' #########################   Windows     ########################
TYPE WndType
	frameColor AS INTEGER
	backColor AS INTEGER
	frameType AS INTEGER
	canClose AS INTEGER
END TYPE

DECLARE SUB WndDraw (x1, y1, x2, y2, wnd AS WndType, title$)
DECLARE SUB WndPutc (x, y, code)
DECLARE SUB WndPuthl (x1, x2, y, code)
DECLARE SUB WndPutvl (x, y1, y2, code)

' #########################   Misc    ###########################
DECLARE SUB Init ()
DECLARE SUB Delay (ms)
DECLARE FUNCTION GetDate$ ()
DECLARE FUNCTION SearchWord! (a() AS STRING, word$)
DECLARE SUB SaveScreen (num%)
DECLARE SUB LoadScreen (num%)
DECLARE FUNCTION ToStr$ (num!)
DECLARE FUNCTION ToZeroStr$ (num!, length)
DECLARE FUNCTION InputStr$ (x%, y%, maxLen%)
DECLARE SUB ShowCaret ()
DECLARE SUB HideCaret ()
DECLARE SUB PrintStr (x%, y%, st$)
DECLARE SUB SetFColor (fCol)
DECLARE SUB SetBColor (bCol)
DECLARE SUB SetColor (fCol, bCol)
DECLARE FUNCTION GetFColor ()
DECLARE FUNCTION GetBColor ()
DECLARE SUB SetPos (x%, y%)
DECLARE FUNCTION GetSysLang$ ()

