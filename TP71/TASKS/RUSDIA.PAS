program
    Dialogue;
uses
    Crt, Dos, PasLib;
var
   name : String;
   old : String;
   you : String;
begin
     ClrScr;

     WriteLn('�� ������ � ������.');
     WriteLn('�ਢ��, ���� ����� ����!');
     WriteLn ('��� ⥡� �����?');
     Write ('���� ����� ');
     ReadLn (name);
     Write ('�ਢ��, ');
     WriteLn (name);
     WriteLn ('������ ⥡� ���?');
     Write ('��� ');
     ReadLn(old);
     WriteLn ('��� �� ᥡ� ������ ?');
     Write ('� ᥡ� ������ ');
     ReadLn (you);
     WriteLn('�� ����� �������.');
     EndKey('rus')
end.