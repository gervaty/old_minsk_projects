program
    files2;
uses
    Crt, WinDos, PasLib;
Var
   fFile : PChar;
   DirInfo : TSearchRec;
begin
    ClrScr;
    FindFirst('*.*', faAnyFile, DirInfo);
     { Аналог команды DIR *.PAS }
    While DosError = 0 Do
        Begin
            Write(DirInfo.Attr:5, DirInfo.Name:15);
            FindNext(DirInfo);
        End;
    EndKey(Rus)
end.