uses
    Crt, Dos, PasLib;

function IsVowel(ch : Char) : Boolean;
var
    i  : Integer;
    vowels : String;
begin
    IsVowel := False;
    vowels :='EeYyUuIiOoAa';
    for i := 1 to Length(vowels) do
        if ch = vowels[i] then
        begin
            IsVowel := True;
            Break;
        end;
end;

function CalcVowels(str: string) : Integer;
var
   cVowels: Integer;
   k: Integer;
begin
    cVowels:= 0;

    for k := 1 to Length(str) do
        if IsVowel(str[k]) then
            cVowels := cVowels + 1;

    CalcVowels := cVowels
end;

var
    name : String;
begin
     ClrScr;
     Write('Введите свое имя: ');
     ReadLn(name);
     WriteLn('В вашем имени ', CalcVowels(name), ' гласных.');
     EndKey(Rus)
end.
