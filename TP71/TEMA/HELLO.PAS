program
   Hello;
uses      {������祭�� ���㫥�}
   Crt, Dos, Paslib;
var
   ver : Integer;
   name : String;


begin          {��砫�}
   ClrScr;
   ver := DosVersion;
   WriteLn('Hello! MS DOS Version is ', Lo(ver),'.',  Hi(ver));
   Write ('What is your name? ');
   ReadLn (name);
   if name='' then
   begin
       WriteLn ('Cheat?!?');
   end else
   begin
       WriteLn('Hi, ', name);
       DDInfo;
   end;

   ReadKey
end.            {�����}