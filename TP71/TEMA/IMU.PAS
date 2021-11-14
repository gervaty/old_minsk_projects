program
    imu;
uses
    PasLib, Crt, Dos;
var
    yourName: String;
    K: Integer;
begin
    ClrScr;
    Write('Введите ваше имя наоборот: ');
    ReadLn(yourName);
    Write('Нет! Ваше имя ');

    for k := Length(yourName) downto 1 do
        Write(ChangeCase(yourName[k], k = Length(yourName)));

    Write('!');
    EndKey(Rus)
end.