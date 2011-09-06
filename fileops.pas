unit fileops;

{$mode objfpc}{$LONGSTRINGS ON}

interface

uses
  Classes, SysUtils, LResources, FileUtil, Forms, Controls, Graphics, Dialogs,
  Menus, Buttons, LCLType, ExtCtrls, ActnList, shfolder;
 //type
 //  TSDiag = class(TSaveDialog)
 // end;
    function GetSpecialFolderPath(folder : integer) : string;
    procedure SaveMyFile(AStringList: TStringList);

implementation

function GetSpecialFolderPath(folder : integer) : string;
 const
   SHGFP_TYPE_CURRENT = 0;
 var
   path: array [0..MAX_PATH] of char;
   i:hresult;
 begin
   i:= SHGetFolderPath(0,folder,0,SHGFP_TYPE_CURRENT,@path[0]);
   if i = S_OK then
     Result := path
   else
     Result := GetCurrentDir;
 end;

procedure SaveMyFile(AStringList: TStringList);
var
SDiag : TSaveDialog;
begin

   SDiag := TSaveDialog.Create(NIL);
   //try
   SDiag.Title := 'Save';
   SDiag.InitialDir := (GetSpecialFolderPath(CSIDL_PERSONAL) + '\');
   SDiag.DefaultExt := 'txt';
   SDiag.FilterIndex := 1;
   Sdiag.Filter:= 'Text file|*.txt';
   //Sdiag.Options:=
     if SDiag.Execute then
     AStringList.SaveToFile(SDiag.FileName);
   //ShowMessage(AStringList.Text + 'is what would have saved...' + ' to ' +#13#13+ Sdiag.FileName);
   //finally
   FreeAndNil(SDiag);
   //end;

end;


end.

