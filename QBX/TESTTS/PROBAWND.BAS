DECLARE SUB LoadResources (res() AS STRING)
' $INCLUDE: 'exlib.bi'
CLS

DIM wnd AS WndType
DIM res(1 TO 2) AS STRING
LoadResources res()
Init

WndDraw 1, 10, 60, 20, wnd, res(1)

SUB LoadResources (res() AS STRING)
	lang$ = ENVIRON$("LANG")
	OPEN "c:\dev\basic\qbx\testts\" + lang$ + ".res" FOR INPUT AS #1
	LINE INPUT #1, res(1)
	CLOSE #1
END SUB

