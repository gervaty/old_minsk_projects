program
    PocetCalc;
uses
    Crt, Dos, PasLib;
var
   num1 : Integer;
   num2 : Integer;
   op : String;
begin
    ClrScr;
    Write('������ ��ࢮ� �᫮: ');
    ReadLn(num1);
    Write('������ �����᪮� ����⢨�: ');
    ReadLn(op);
    Write('������ ��஥ �᫮: ');
    ReadLn(num2);
    If op = '*' then
       WriteLn('�⢥�: ',num1 * num2)
    else if op = '+' then
       WriteLn('�⢥�: ',num1 + num2)
    else if op = '-' then
       WriteLn('�⢥�: ',num1 - num2)
    else if op = '/' then
    begin
        WriteLn('�⢥� (���): ',num1 / num2);
        WriteLn('�⢥� (���㣫����): ',num1 div num2);
        WriteLn('�⢥� (���⮪): ',num1 mod num2);
    end;
    EndKey('rus')
end.