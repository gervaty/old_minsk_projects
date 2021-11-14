{$M $4000, 0, 0}
{
**************************************
*            Unit "PasLib"           *
*                 BY                 *
*           PicselSoftWare           *
*                INC                 *
**************************************
}
unit
    PasLib;

interface
uses
    Crt,WinDos, Dos;
type
    Language = (Rus, Eng);
var
    ver : Integer;
    regs: TRegisters;
    fColor, bColor: Byte;
function  HexWord( W: Word): String;
function HexByte( B: Byte): String;{ assembler;}
function GetTimeStr: String;
function GetDateStr: String;
function GetCurrentDir: String;
function ToStr(num: Longint): String;
procedure Restart;
procedure Shutdown;
procedure EndKey(lang : Language);
procedure DDInfo;
procedure ClearKeyBuf;
procedure SetColors(fore, back: Byte);
procedure SaveColors;
procedure RestoreColors;
function FindCharCount(str: String;ch:Char) : Integer;
function UpperCase(ch: Char): Char;
function LowCase(ch: Char): Char;
function ChangeCase(ch: Char; isUpper: Boolean): Char;
function ToInt(str : String) : Integer;
procedure Shell(command : String);
implementation
uses
    Strings;

var
    fOldColor, boldColor: Byte;

procedure shell(command : String);
begin
    SwapVectors;
    Exec(GetEnv('COMSPEC'), '/C ' + command);
    SwapVectors;
end;
function ToInt(str : String) : Integer;
var
    res, code : Integer;
begin
    Val(str, res, code);
    ToInt := res;
end;

function HexWord;
   begin
      HexWord:= HexByte( Hi( W))+HexByte( Lo( W));
   end;

function HexByte( B: Byte): String; assembler;
   asm
            les     di,@Result
            cld
            mov     al,2
            stosb
            mov     al,B
            mov     ah,al
            mov     cl,4
            shr     al,cl
            and     ax,0f0fh
            cmp     al,9
            jbe     @@Next
            add     al,7
@@Next:
            cmp     ah,9
            jbe     @@Done
            add     ah,7
@@Done:
            add     ax,3030h
            stosw
   end;

function LowCase(ch: Char): Char;
begin
    LowCase := ChangeCase(ch, false);
end;

function UpperCase(ch: Char): Char;
begin
    UpperCase := ChangeCase(ch, true);
end;

function ChangeCase(ch: Char; isUpper: Boolean): Char;
var
    src, dest, up, lo:String;
    k: Integer;
    find: Boolean;
begin
    find := false;
    up := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ АБВГДЕЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
    lo := 'abcdefghijklmnopqrstuvwxyz абвгдеежзийклмнопрстуфхцчшщъыьэюя';

    if isUpper then
    begin
        src := lo; dest := up;
    end else begin
        src := up; dest := lo;
    end;

    for k := 1 to Length(src) do
        if src[k] = ch then
        begin
            ChangeCase := dest[k];
            find := true;
        end;

    if not find then
        ChangeCase := ch;
end;

function FindCharCount(str: String;ch:Char) : Integer;
var
    res : Integer;
    k : Integer;
    Words :array[1..4] of String;
begin
    res := 0;
    for k:=1 to LenGth(str) do
        if str[k] = ch then res := res + 1;

    FindCharCount:=res;
end;

function AddZero(st: String; len: Integer): String;
begin
    if Length(st) = 2 then
        AddZero := st
    else
        AddZero := '0' + st;
end;

function GetDateStr: String;
var
    year, month, day, dow: Word;
begin
    GetDate(year, month, day, dow);
    GetDateStr := AddZero(Tostr(day), 2) +
        '-' + AddZero(ToStr(month), 2) + '-' + ToStr(year);
end;

function GetTimeStr: String;
var
    hour, minute, second, sec100: Word;
begin
    GetTime(hour, minute, second, sec100);
    GetTimeStr := AddZero(Tostr(hour), 2) +
        ':' + AddZero(ToStr(minute), 2) +
        ':' + AddZero(ToStr(second), 2) +
        '.' + AddZero(ToStr(sec100), 2);
end;

function GetCurrentDir: String;
var
    path: PChar;
    res: String;
    k: Integer;
begin
    res := '';
    GetMem(path, 80);
    GetCurDir(path, 0);

    for k := 0 to StrLen(path) - 1 do
        res := res + path[k];

    FreeMem(path, 80);
    GetCurrentDir := res;
end;

function ToStr(num: Longint) : String;
var
    s: String [11];
begin
    Str(num, s);
    ToStr := s;
end;

procedure SaveColors;
begin
    fOldColor := fColor;
    bOldColor := bColor;
end;

procedure RestoreColors;
begin
    SetColors(fOldColor, bOldColor);
end;

procedure SetColors(fore, back: Byte);
begin
    fColor := fore;
    bColor := back;
    TextColor(fore);
    TextBackground(back);
end;

procedure Shutdown;assembler;
asm
	mov ax, 5301h
	mov bx, 0
    int 15h
	mov ax, 530Eh
	mov bx, 0
	mov cx, 102h
    int 15h
    mov ax, 5307h
	mov bx, 1
    mov cx, 3
    int 15h
end;

procedure Restart;
begin
    WriteLn('Restarting...');
    Port[$64] := $FE
end;

Procedure EndKey(lang: Language);
begin
    ClearKeyBuf;
    if lang = Eng then
        Write(#13#10'Press any key to begin.')
    else if lang = Rus then
        Write(#13#10'Нажмите любую клавишу для продолжения.');
    ReadKey;
end;

Procedure DDInfo;
begin
    ver := DosVersion;
    WriteLn('MS-DOS Версия: ', Lo(ver),'.',  Hi(ver));
    WriteLn('Свободно памяти: ', DiskFree(0) Div 1024, ' кбайт.');
    WriteLn('Обьем диска ', DiskSize(0) Div 1024, ' кбайт.');
end;

Procedure ClearKeyBuf;
begin
    While KeyPressed Do
        ReadKey
end;

begin
    SetColors(7, 0);
end.
