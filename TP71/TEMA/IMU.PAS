program
    imu;
uses
    PasLib, Crt, Dos;
var
    yourName: String;
    K: Integer;
begin
    ClrScr;
    Write('������ ��� ��� �������: ');
    ReadLn(yourName);
    Write('���! ��� ��� ');

    for k := Length(yourName) downto 1 do
        Write(ChangeCase(yourName[k], k = Length(yourName)));

    Write('!');
    EndKey(Rus)
end.