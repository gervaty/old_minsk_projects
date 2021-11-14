{***********************************}
{        Turbo Windows              }
{       ~~~~~~~~~~~~~~~             }
{                                   }
{                                   }
{                                   }
{***********************************}
unit
    Windows;
interface
uses
    Crt, dos;
type
    TWnd = record
        frameType: Integer;
        frameColor: Byte;
        backColor: Byte;
        canClose: Boolean;
    end;
                     { <-- Левее могут быть слова Const, Type, и Var.}
procedure WindowDraw(x1, y1, x2, y2: integer; wnd: TWnd; title: string);

implementation

uses
    PasLib;

procedure CenterText (x1, x2, y: Integer; text : String);
var
    xPos : Integer;
begin
	xPos := (x2 - x1) div 2 - Length(text) div 2;
	if xPos > 0 then
    begin
		GotoXY (x1 + xPos, y);
		WriteLn (text)
	end;
end;

{Нарисовать символ с кодом code в координате (y, x)}
procedure WndPutc (x, y : Integer; code: Byte);
begin
	GoToXY(x, y);
	Write(Chr(code));
end;

{Линия символов с кодом code на строчке y начиная с координаты x1 до x2}
procedure WndPuthl (x1, x2, y :Integer; code: Byte);
var
    k: Integer;
begin
	for k := x1 to x2 do
		WndPutc(k, y, code);
end;

{рисуем вертикальную линию}
procedure WndPutvl (x, y1, y2: Integer; code: Byte);
var
    k: Integer;
begin
	for k := y1 to y2 do
		WndPutc(x, k, code);
end;

procedure WindowDraw(x1, y1, x2, y2: integer; wnd: TWnd; title: string);
var
    k: Integer;
    psCode: array [1..7] of Integer;
    ps: array [1..3] of string;
begin
    SaveColors;

    if wnd.frameType = 0 then wnd.frameType := 1;
	if wnd.frameColor = 0 then wnd.frameColor := 7;

	ps[1] := '┌─┐│└─┘';
	ps[2] := '╔═╗║╚═╝';
	ps[3] := '███║╚═╝';

	for k := 1 to 7 do
		psCode[k] := Ord(ps[wnd.frameType][k]);

	SetColors(wnd.frameColor, wnd.backColor);

	WndPutc(x1, y1, psCode[1]);
	WndPuthl(x1 + 1, x2 - 1, y1, psCode[2]);
	WndPutc(x2, y1, psCode[3]);
	WndPutvl(x1, y1 + 1, y2 - 1, psCode[4]);
	WndPutc(x1, y2, psCode[5]);
	WndPuthl(x1 + 1, x2 - 1, y2, psCode[2]);
	WndPutvl(x2, y1 + 1, y2 - 1, psCode[4]);

	{right bottom corner}
	WndPutc(x2, y2, psCode[7]);

	if title <> '' then
		CenterText(x1, x2, y1, title);

	if wnd.canClose then
    begin
		GotoXY(x1 + 2, y1);
		Write('[■]');
	end;

	{fill }
	SetColors(wnd.backColor, wnd.backColor);

	for k := y1 + 1 to y2 - 1 do
		WndPuthl(x1 + 1, x2 - 1, k, 32);

	RestoreColors;
end;


begin

end.



