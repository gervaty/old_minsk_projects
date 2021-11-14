ren exlib.lib exliblib.old
ren exlib.qlb exlibqlb.old

del exlib.lib
del exlib.qlb
del exlib.obj

BC /X/FS exlib.bas exlib.obj exlib.lst /A > bc.log
LIB exlib.lib + exlib + c:\dev\basic\qbx\lib\uiasm + c:\dev\basic\qbx\lib\qbx.lib; > lib.log
LINK /Q exlib.lib, exlib.qlb,,qbxqlb.lib; > link.log

copy exlib.qlb c:\dev\basic\qbx\lib\exlib.qlb
copy exlib.lib c:\dev\basic\qbx\lib\exlib.lib
