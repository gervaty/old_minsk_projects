'********************
'*                  *
'* Bath reader 1.0  *
'*                  *
'********************
DIM batf AS STRING

IF COMMAND$ <> "" THEN
    SHELL COMMAND$
ELSE
    LINE INPUT "������ �������� Bath - 䠩��: ", batf$
    batf = batf + ".bat"
    SHELL batf$
END IF




