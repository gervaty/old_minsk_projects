uses
    Crt, PasLib;
var
    txtFile: Text;
begin
    ClrScr;

    Assign(txtFile, 'ff.txt');
    Append(txtFile);
        WriteLn(txtFile,'QWErTY ETO KRUTO! ABCDEFG!!');
    Close(txtFile);
    EndKey(Eng);
end.