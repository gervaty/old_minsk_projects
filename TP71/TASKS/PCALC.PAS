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
    Write('Введите первое число: ');
    ReadLn(num1);
    Write('Введите логическое действие: ');
    ReadLn(op);
    Write('Введите второе число: ');
    ReadLn(num2);
    If op = '*' then
       WriteLn('Ответ: ',num1 * num2)
    else if op = '+' then
       WriteLn('Ответ: ',num1 + num2)
    else if op = '-' then
       WriteLn('Ответ: ',num1 - num2)
    else if op = '/' then
    begin
        WriteLn('Ответ (точный): ',num1 / num2);
        WriteLn('Ответ (округленно): ',num1 div num2);
        WriteLn('Ответ (остаток): ',num1 mod num2);
    end;
    EndKey('rus')
end.