uses
    Crt, Dos, PasLib;
var
    strn : String;
    summa : String;
    k : Integer;
begin
    ClrScr;
    WriteLn('������ ��ப� ���.');
    ReadLn(strn);
    WriteLn('������ �㬬� 2 ��� (�� 1 �� 18).');
    ReadLn(summa);
    for k := 1 to Length(strn) do
    begin
        if ToInt(strn[k]) + ToInt(strn[k + 1]) = ToInt(summa) then
            WriteLn('��諮�� �� ����樨: ', k);
    end;
    EndKey(Rus)
end.