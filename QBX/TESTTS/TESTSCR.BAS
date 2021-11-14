'$INCLUDE: 'exlib.bi'

CALL SaveScreen(1)
CALL WndDraw(1, 1, 80, 25, 1, 2, 0)
LOCATE 10, 10
INPUT "После нажатия Ентера восстановится старый экран", s$
LoadScreen (1)


