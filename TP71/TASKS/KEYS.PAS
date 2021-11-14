uses
    Crt, Dos, PasLib;
var
    ch1 : Char;
    ch2 : Char;
begin
    ClrScr;
    ClearKeyBuf;
    WriteLn('Press Esc to exit.');
    repeat
        if KeyPressed then
        begin
            ch1 := ReadKey;
            if ch1 <> Chr(0) then
                WriteLn('1 Byte code: ', Ord(ch1))
            else begin
                ch2 := ReadKey;
                WriteLn('2 Byte code: ', Ord(ch2));
            end;
        end;
    until ch1 = Chr(27);
end.