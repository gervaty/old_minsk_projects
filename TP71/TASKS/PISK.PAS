uses Crt, dos;
var k : Integer;
begin
    ClrScr;
    k := 0;
    Repeat
          Write (' P  I  S  K  !! #',k,' !!!!!');
          Sound(400);
          Delay (5000);
          Sound(5000);
          Delay (5000);
          k := k + 1
    Until KeyPressed;
    NoSound;
end.
