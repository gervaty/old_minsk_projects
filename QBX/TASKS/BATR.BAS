'********************
'*                  *
'* Bath reader 1.0  *
'*                  *
'********************
DIM batf AS STRING

IF COMMAND$ <> "" THEN
    SHELL COMMAND$
ELSE
    LINE INPUT "Введите название Bath - файла: ", batf$
    batf = batf + ".bat"
    SHELL batf$
END IF




