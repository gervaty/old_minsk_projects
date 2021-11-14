program
    Powers;
uses
    Dos, Crt, PasLib, Windows, Mouse;

const
    colFrame = 4;
    colBackUnsel = 2;
    colUnsel = 4;
    colBackSel = 7;

var
    selItem, curX, curY: Integer;
    logFilePath: String;
type
    TConfig=record
        names: array[1..8] of String;
        values: array[1..8] of String;
    end;

procedure ReadConfig(path: String; var cfg: TConfig);
var
    cfgFile: Text;
    st: String;
    k, n: Byte;
begin
    k := 1;
    Assign(cfgFile, path + 'cfg');
    Reset(cfgFile);
    while not Eof(cfgFile) do
    begin
        ReadLn(cfgFile, st);
        if (st <> '') and (st[1] <> ';') then
        begin
             n := Pos('=', st);
             if n > 0 then
             begin
                 cfg.names[k] := Copy(st, 1, n - 1);
                 cfg.values[k] := Copy(st, n + 1, Length(st) - n);
                 k := k + 1;
             end
        end;
    end;

    Close(cfgFile);
end;

procedure SetMenuItemColors(selItem, num: Integer);
begin
    if selItem = num then
        SetColors(colFrame, colBackSel)
    else
	    SetColors(colUnsel, colBackUnsel);
end;

procedure DrawMenu(selItem: Integer);
begin
    MouseShow;
    GotoXY (34, 4);
    SetMenuItemColors(selItem, 1);
    Write (' Shutdown ');
    GotoXY (34, 6);

    SetMenuItemColors(selItem, 2);
    Write(' Restart ');

    GotoXY (34, 8);
    SetMenuItemColors(selItem, 3);
    WriteLn(' Cancel ');
    SetColors(7, 4);
    MouseShow;
    GotoXY(35, 13);
    Write('Powers');
    SetColors(0, 7);
end;

procedure Cancel;
begin
    DrawMenu(3);
    {PLAY "C"}
    {CALL LoadScreen(77)}
    GotoXY(curX, curY);
    Halt;
end;

procedure Reboot;
var
    log : Text;
begin
    Assign(log, logFilePath);
    Append(log);
    WriteLn(log,'Restart:  ' + GetDateStr + ' ' + GetTimeStr);
    Flush(log);
    Close(log);

    DrawMenu(2);
    Sound(440);
    Delay(65535);
    NoSound;

    Restart;
end;

procedure TurnOff;
var
    log: Text;
begin
    Assign(log, logFilePath);
    Append(log);
    WriteLn(log,'Shutdown: ' + GetDateStr + ' ' + GetTimeStr);
    Flush(log);
    Close(log);

    DrawMenu(1);
    Sound(440);
    Delay(65535);
    NoSound;

    Shutdown;
end;

procedure HandleCommand (cmd : Integer);
begin
    if cmd = 1 then
	TurnOff
    else if cmd = 2 THEN
	Reboot
    else if cmd = 3 THEN
	Cancel
end;

procedure HandleMouse (row, col: Integer; btn: Boolean);
begin
    if btn then
        if (col >= 34) and (col <= 41) then
            HandleCommand(row div 2 - 1);
end;

procedure HandleKey(var selItem: Integer;ch: Char);
begin
    if (ch = Chr(80)) and (selItem < 3) then
    begin
	    selItem := selItem + 1;
	    DrawMenu(selItem);
    end else if (ch = Chr(72)) and (selItem > 1) then
    begin
	    selItem := selItem - 1;
	    DrawMenu(selItem);
    end	else if ch = Chr(13) then
	    HandleCommand(selItem)
end;

procedure s(s: array of string);
begin
    WriteLn(s);
end;

function GetLogFilePath: String;
var
    exeFilePath: String;
    n: Byte;
    cfg: TConfig;
begin
    exeFilePath := ParamStr(0);
    Delete(exeFilePath, Length(exeFilePath) - 2, 3);
    ReadConfig(exeFilePath + 'cfg', cfg);

end;

procedure Init;
var
    wnd: TWnd;
    k: Integer;
begin
    ClrScr;
    WriteLn('Current Dir: ' + GetCurrentDir);
    WriteLn('Path to Exe File: ' + ParamStr(0));
    curY := WhereY;
    curX := WhereX;
    logFilePath := GetLogFilePath;

    GotoXY(1, 1);
    for k := 1 to 2000 do
	    Write(Chr(219));

    selItem := 1;
    MouseShow;
    wnd.frameType := 2;
    wnd.canClose := False;
    wnd.frameColor := 7;
    wnd.backColor := 2;
    WindowDraw(31, 2, 46, 10, wnd, '');
    DrawMenu(selItem);
end;

var
    ch: Char;
    mi: TMouseInfo;

begin                  {!!!!!!!!!!!  <<-- Starting!!!!!!!}
    if ParamStr(1) = '/?' then
        WriteLn('Powers - программа выключения и перезагрузки.')
    else begin
        Init;
	    repeat
            GetMouseInfo(mi);
	        HandleMouse(mi.yPos, mi.xPos, mi.left);
            if KeyPressed then
            begin
	            ch := ReadKey;
                if ch = Chr(0) then
                    ch := ReadKey;
	            HandleKey(selItem, ch)
            end;
	    until ch = Chr(27);

	    Cancel;
    end;
end.