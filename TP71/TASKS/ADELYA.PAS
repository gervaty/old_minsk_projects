program
    Adelya;
uses
    Crt, Dos, PasLib;
var
   Name : String;
begin
     ClrScr;
     Write('Как вас зовут? ');
     ReadLn(Name);
     WriteLn('Привет, ', Name, '!');
     EndKey(Rus);
     Shutdown2;
end.