uses
    Crt, Dos, PasLib;

function CompareChars(ch1, ch2 : Char; isCaseSens: Boolean): Boolean;
begin
    if isCaseSens then
        CompareChars := ch1 = ch2
    else
        CompareChars := UpperCase(ch1) = UpperCase(ch2);
end;

function FindSubStr(mainSt: String; idx: Integer; subSt: String;
    isCaseSens: Boolean): Boolean;
var
    k: Integer;
begin
    FindSubStr := False;
    for k := 1 to Length(subSt) do
        if not CompareChars(mainSt[idx + k], subSt[k], isCaseSens) then
            Exit;
    FindSubStr := True;
end;

var
    stMain, stSub : String;
    k : Integer;
    reg : Char;

begin
    ClrScr;
    WriteLn('Введите строку:');
    ReadLn(stMain);
    WriteLn('Введите подстроку:');
    ReadLn(stSub);
    WriteLn('Учитывать регистр букв (y, n) ?');
    reg := ReadKey;
    WriteLn(reg);

    for k := 1 to Length(stMain) do
    begin
        if FindSubStr(stMain, k, stSub, reg = 'y') then
        begin
            WriteLn('Нашли в позиции ' + IntToStr(k));
        end
    end;

    EndKey(Rus)
end.