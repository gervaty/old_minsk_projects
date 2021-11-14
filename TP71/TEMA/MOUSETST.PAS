program
    MouseTest;
uses
    Crt, Mouse, PasLib;
var
    info: TMouseInfo;
begin
    ClrScr;
    MouseShow;

    repeat
        GetMouseInfo(info);
        if info.left then
        begin
            GotoXY(10, 10);
            Write('LEFT');
            MouseShow;
        end else begin
            GotoXY(10, 10);
            Write('    ');
        end;

        if info.right then
        begin
            GotoXY(10, 11);
            Write('RIGHT');
            MouseHide;
        end else begin
            GotoXY(10, 11);
            Write('     ');
        end;

        GotoXY(20, 20);
        Write(info.xPos:4, info.yPOs:4);
    until KeyPressed;

    EndKey(Eng);
end.