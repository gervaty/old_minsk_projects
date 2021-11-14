uses
    Crt, Dos, PasLib;
var
    strn : String;
    summa : String;
    k : Integer;
begin
    ClrScr;
    WriteLn('Введите строку цифр.');
    ReadLn(strn);
    WriteLn('Введите сумму 2 цифр (от 1 до 18).');
    ReadLn(summa);
    for k := 1 to Length(strn) do
    begin
        if ToInt(strn[k]) + ToInt(strn[k + 1]) = ToInt(summa) then
            WriteLn('Нашлось на позиции: ', k);
    end;
    EndKey(Rus)
end.