program
    DataTypes;
uses
    Crt, PasLib;
var
    ch: Char;
    st: String;
    b: Boolean;
    bt: Byte;
begin
    ClrScr;
    st := '123123123';
    WriteLn(st);

    b := 10 <> 4;

    if b then
        WriteLn('PRAVDA')
    else
        WriteLn('NE PRAVDA');

    ch := st[4];

    WriteLn(Ord(ch));
    EndKey('rus');
end.