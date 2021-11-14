unit
    Mouse;

interface
type
    TMouseInfo = record
        left: Boolean;
        right: Boolean;
        xPos: integer;
        yPos: integer;
    end;

procedure MouseShow;
procedure MouseHide;
procedure GetMouseInfo(var info: TMouseInfo);

implementation

uses
    Dos;

procedure MouseShow;
var
    reg: Registers;
begin
    reg.ax:=$0;
    intr($33,reg);
    reg.ax:=$1;
    intr($33,reg);
end;

procedure MouseHide;
var
    reg: Registers;
begin
    reg.ax:=$2;
    intr($33,reg);
end;

procedure GetMouseInfo(var info: TMouseInfo);
var
    reg: Registers;
begin
    reg.ax:=$3;
    intr($33,reg);

    info.left := reg.bx and 00000001 > 0;
    {p2:=reg.bx and 00000100;}
    info.right := reg.bx and 00000010 > 0;
    info.xPos := (reg.cx + 8) div 8;
    info.yPos := (reg.dx + 8) div 8;
end;

end.
