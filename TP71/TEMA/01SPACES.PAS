program
    Spacecnt;
uses
    Crt, Dos, PasLib;

function Trim(st: String): String;
var
    k: Integer;
begin
    Trim := st;
    k := 1;
    while k < Length(st) do
    begin
        if st[k] <> ' ' then Break;
        Trim := Copy(st, k + 1, Length(st) - k + 1);
    end;
end;

var
    st: String;
    str: String;
    charsCount: Integer;
    last, k : Integer;
    words: array[1..100] of String;
begin
    ClrScr;
    last := 0;
    Write('Введите строку: ');
    ReadLn(str);
    charsCount := FindCharCount(str, ' ');
    WriteLn('В вашей строке ' + IntToStr(charsCount) + ' пробелов.');

    for k := 1 to Length(str) do
        if str[k] = ' ' then
        begin
            st := Trim(Copy(str, last + 1, k - last - 1));
            if st <> '' then
            begin
                WriteLn(st);
                last := k;
            end;
        end;

    if last < Length(str) then
        WriteLn(Trim(Copy(str, last + 1, Length(str) - last)));
    EndKey(Rus);
end.