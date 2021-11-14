program
   Hello;
uses      {Подключение модулей}
   Crt, Dos, Paslib;
var
   ver : Integer;
   name : String;


begin          {Начало}
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
end.            {Конец}