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

     WriteLn('Это диалог с Джоном.');
     WriteLn('Привет, меня зовут Джон!');
     WriteLn ('Как тебя зовут?');
     Write ('Меня зовут ');
     ReadLn (name);
     Write ('Привет, ');
     WriteLn (name);
     WriteLn ('Сколко тебе лет?');
     Write ('Мне ');
     ReadLn(old);
     WriteLn ('Как ты себя чувствуеш ?');
     Write ('Я себя чувствую ');
     ReadLn (you);
     WriteLn('Это конец диалога.');
     EndKey('rus')
end.