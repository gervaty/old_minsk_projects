program
       fortodo;
uses
    Crt, Dos, PasLib;
var
   k : Longint;
begin
    for k := 2147483647 downto -2147483647 do
        if k mod 10000000 = 0 then
           WriteLn('There''s HAKED!!! Number is   ', k);
    Sound(440);
    Delay(255);
    NoSound;
    EndKey(Eng)
end.