program
    password;
uses
    Crt, Dos, PasLib, Windows;
var
    pssWrd: String;
    login: String;
    pssWrd2: String;
    login2: String;
begin
    pssWrd2 := 'dede' ;
    login2 := 'fefe';
    ReadLn(pssWrd);
    ReadLn(login);
    if (login = login2) and (pssWrd = pssWrd2) then
        WriteLn('verno')
    else
        WriteLn('neverno')
end.