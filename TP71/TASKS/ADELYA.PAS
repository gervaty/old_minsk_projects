program
    Adelya;
uses
    Crt, Dos, PasLib;
var
   Name : String;
begin
     ClrScr;
     Write('��� ��� �����? ');
     ReadLn(Name);
     WriteLn('�ਢ��, ', Name, '!');
     EndKey(Rus);
     Shutdown2;
end.