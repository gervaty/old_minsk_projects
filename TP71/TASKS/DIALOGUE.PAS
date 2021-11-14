program
    Dialogue;
uses
    Crt, Dos, PasLib;
var
   name : String;
   old : String;
   you : String;
begin
     ClrScr;

     WriteLn('This is Dialogue with Jonh.');
     WriteLn('Hi, my name is John!');
     WriteLn ('What is your name?');
     Write ('My name is ');
     ReadLn (name);
     Write ('Hi, ');
     WriteLn (name);
     WriteLn ('How old are you?');
     Write ('I am ');
     ReadLn(old);
     WriteLn ('How are you?');
     Write ('I am ');
     ReadLn (you);
     WriteLn('THIS IS END OF Dialogue.');
     EndKey
end.