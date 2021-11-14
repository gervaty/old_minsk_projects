program
    BinFile;
uses
    Dos, Crt, PasLib;
type
    KeyCommand = (Quit, PgDn, PgUp);

procedure PrintAdr(byteN: Byte; yy , nn: Integer);
begin
    if byteN = 1 then
    begin
        GotoXY(1, yy);
        Write(HexWord(nn));
    end;
end;

function GetCharToPrint(bt: Byte) : Char;
begin
    if bt < 32 then
        GetCharToPrint := '.'
    else
        GetCharToPrint := Chr(bt);
end;

function GetCommand: KeyCommand;
var
    ch: Char;
begin
    while true do
    begin
        ch := ReadKey;
        if ch = #27 then
        begin
            GetCommand := Quit;
            Break;
        end else if ch = #0 then
        begin
            ch := ReadKey;
            if ch = #81 then
            begin
                GetCommand := PgDn;
                Break;
            end;

        end;
    end;
end;

var
    f: file of Byte;
    b: Byte;
    w: Word;
    c: Char;
    byteNum, y, n: Integer;
begin
    ClrScr;

    Assign(f, 'c:\cmd\gg.exe');
    Reset(f);
    byteNum := 1;
    y := 1;
    n := 0;

    while not Eof(f) do
    begin
       PrintAdr(byteNum, y, n);
       Read(F, b);
       GotoXY(5 + (byteNum - 1) * 3 + 1, y);
       Write(HexByte(b), ' ');           {Print byte}
       GotoXY(55 + byteNum, y);   {Print char}
       Write(GetCharToPrint(b));
       Inc(byteNum);
       Inc(n);
       if byteNum = 17 then
       begin
           byteNum := 1 ; Inc(y);
       end;
       if y = 24 then
       begin
           ClearKeyBuf;
           WriteLn('');
           WriteLn('Чтоб продолжить вывод, нажмите Page Down');
           case GetCommand of
               Quit: Halt;
               PgDn:
               begin
                   ClrScr;
                   y := 1;
               end;
           end;
      end;

    end;

    Close(f);

    EndKey(Eng);
end.
