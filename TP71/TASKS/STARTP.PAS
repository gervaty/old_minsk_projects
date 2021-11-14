{$M $4000, 0, 0 }   { 16Kб стек, нет кучи }
program
    StartProgram;
uses
    Crt, dos, PasLib;
var
   progToStart : String;
begin
    Write('Program to start is: 1.MS-DOS Edit  2.TP  3.NC: ');
    ReadLn(progToStart);
    SwapVectors;
    if progToStart='1' then
        {Exec(GetEnv('COMSPEC'), '/C edit')}
        Shell('edit')
    else if progToStart='2' then
    begin
        {Exec(GetEnv('COMSPEC'),'/C cd c:\dev\tp\71\bin');
        Exec(GetEnv('COMSPEC'),'/C turbo')}
        Shell('c:\dev\tp\71\bin\turbo.exe')
    end else if progToStart='3' then
        {Exec(GetEnv('COMSPEC'), '/C nc');}
        Shell('nc');
    SwapVectors;


end.