program
    In_Sguare;
uses
    Crt, Dos, PasLib;
var
    number : Integer;
begin
    ClrScr;
    Write('Введите число для умножения в квадрате: ');
    ReadLn(number);
    WriteLn ('Ответ: ', number *  number);
    EndKey(Rus);
end.
