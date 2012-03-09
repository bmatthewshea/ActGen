unit act_source; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, FileUtil, Forms, Controls, Graphics, Dialogs,
  Menus, Buttons, StdCtrls, LCLType, ExtCtrls, ActnList,
  aboutfrm, outputfrm, fileops, calcs, shfolder, inifiles;

type

  { TMainForm1 }

  TMainForm1 = class(TForm)
    ButtonConsole: TButton;
    CheckBoxLowerUpperCase: TCheckBox;
    CheckBoxAvoidChars: TCheckBox;
    CheckBoxUseCustomChars: TCheckBox;
    ComboBoxAmountDashes: TComboBox;
    CustomChars: TEdit;
    ExitAppButton: TButton;
    EditMenu: TMenuItem;
    HelpMenu: TMenuItem;
    LabelDefaultAmount: TLabel;
    LabelDefaultChars: TLabel;
    LabelAmountBetween: TLabel;
    MenuItem16: TMenuItem;
    MenuItem20: TMenuItem;
    ButtonLoadDefaults: TButton;
    CalculateButton: TButton;
    CheckBoxDashes: TCheckBox;
    EditCharAmount: TEdit;
    LabelAmountStatic: TLabel;
    LabelUniqueChars: TLabel;
    LabelDashes: TLabel;
    MainMenu1: TMainMenu;
    FileMenu: TMenuItem;
    SaveAs: TMenuItem;
    FileClose: TMenuItem;
    FileExitApp: TMenuItem;
    EditUndo: TMenuItem;
    EditRedo: TMenuItem;
    EditCut: TMenuItem;
    EditCopy: TMenuItem;
    EditPaste: TMenuItem;
    EditFind: TMenuItem;
    EditFindNext: TMenuItem;
    HelpFile1: TMenuItem;
    CreateNewList: TMenuItem;
    ClearCurrentList: TMenuItem;
    AboutBox: TMenuItem;
    NewFile: TMenuItem;
    OpenFile: TMenuItem;
    OpenRecent: TMenuItem;
    Save: TMenuItem;
    EditSerialAmount: TEdit;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Shape1: TShape;
    Shape2: TShape;
    STAvoidCharacters: TStaticText;
    STRemoveCustomChars: TStaticText;
    StaticText3: TStaticText;
    STUpperLowerCase: TStaticText;
    ToolsMenu: TMenuItem;
//
    procedure ButtonConsoleClick(Sender: TObject);
    procedure CheckBoxAvoidCharsChange(Sender: TObject);
    procedure CheckBoxUseCustomCharsChange(Sender: TObject);
    procedure ComboBoxAmountBetweenChange(Sender: TObject);
    procedure EditCharAmountChange(Sender: TObject);
    procedure EditCharAmountKeyPress(Sender: TObject; var Key: char);
    procedure EditSerialAmountKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
//    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CreateNewListClick(Sender: TObject);
    procedure ButtonShowSerialConsoleClick(Sender: TObject);
    procedure ClearCurrentListClick(Sender: TObject);
    procedure EditUndoClick(Sender: TObject);
    procedure EditRedoClick(Sender: TObject);
    procedure EditCutClick(Sender: TObject);
    procedure EditCopyClick(Sender: TObject);
    procedure EditPasteClick(Sender: TObject);
    procedure EditFindClick(Sender: TObject);
    procedure EditFindNextClick(Sender: TObject);
    procedure FileCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure ButtonLoadDefaultsClick(Sender: TObject);
    procedure CheckBoxDashesChange(Sender: TObject);
    procedure EditSerialAmountChange(Sender: TObject);
    procedure SaveAsClick(Sender: TObject);
    procedure FileExitAppClick(Sender: TObject);
    procedure FileMenuClick(Sender: TObject);
    procedure HelpFile1Click(Sender: TObject);
    procedure AboutBoxClick(Sender: TObject);
    procedure NewFileClick(Sender: TObject);
    procedure OpenFileClick(Sender: TObject);
    procedure OpenRecentClick(Sender: TObject);
    procedure ButtonLoadDefaultsExit(Sender: TObject);
  private
    { private declarations }

  public
    { public declarations }
  end; 

var
  MainForm1: TMainForm1;
  SerialAmount: Integer;
  CharAmount: Integer;
  DashesOn: Boolean;
  NoCharsCommon: Boolean;
  UseAdditionalCustomChars: Boolean;



implementation

{$R *.lfm}
{ TMainForm1 }

procedure TMainForm1.FileMenuClick(Sender: TObject);
begin

end;

procedure TMainForm1.HelpFile1Click(Sender: TObject);
begin
  {Help File}
end;

procedure TMainForm1.AboutBoxClick(Sender: TObject);
{Display 'About' box}
begin
  AboutForm.ShowModal;
end;

procedure TMainForm1.NewFileClick(Sender: TObject);
begin
  { New File }
end;

procedure TMainForm1.OpenFileClick(Sender: TObject);
var filename : string;
begin
  {OPEN FILE}
   OpenDialog1.InitialDir := (GetSpecialFolderPath(CSIDL_PERSONAL) + '\');
   OpenDialog1.DefaultExt := 'txt';
   OpenDialog1.FilterIndex := 1;
   OpenDialog1.Filter:= 'Text file|*.txt';
       if OpenDialog1.Execute then
   begin
     filename := OpenDialog1.Filename;
     ShowMessage(filename);
   end;

end;

procedure TMainForm1.OpenRecentClick(Sender: TObject);
begin
  {OPEN RECENT}
end;

procedure TMainForm1.ButtonLoadDefaultsExit(Sender: TObject);
begin

end;

procedure TMainForm1.SaveAsClick(Sender: TObject);
begin
  {SAVE AS}
end;


procedure TMainForm1.EditSerialAmountChange(Sender: TObject);
var
  Amount: String;

begin
     Amount:=EditSerialAmount.Text;
     If (StrToIntDef(Amount, 1000) > 1000000) or
     (Length(EditSerialAmount.Text) > 7) or
     (Length(EditSerialAmount.Text) < 1) then
       begin
       Amount:='1000';
       EditSerialAmount.Text:=Amount;
       end;
     SerialAmount:=StrToInt(Amount);
end;

procedure TMainForm1.CheckBoxDashesChange(Sender: TObject);
begin
     DashesOn:=True;
     if (CheckBoxDashes.State = cbUnchecked) then
       begin
       ComboBoxAmountDashes.Enabled:=False;
       DashesOn:=False
       end
     else
       ComboBoxAmountDashes.Enabled:=True;
end;

procedure TMainForm1.ButtonLoadDefaultsClick(Sender: TObject);
begin
EditSerialAmount.Text:='1000';
EditCharAmount.Text:='20';
CheckBoxDashes.Checked:=True;
ComboBoxAmountDashes.Text:='4';
CheckBoxLowerUpperCase.Checked:=False;
CheckBoxAvoidChars.Checked:=True;
CheckBoxUseCustomChars.Checked:=False;
CustomChars.Text:='';
end;

procedure TMainForm1.EditSerialAmountKeyPress(Sender: TObject; var Key: char);
begin
   if not (Key in ['0'..'9', #8, #9]) then Key := #0;
end;

procedure TMainForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
   appINI : TIniFile;
   sAmount: String;
   sCharAmount: String;
   sDashes: String;
   sCustomChars: String;
   bUpperLowerCase: Boolean;
   bDashstate: Boolean;
   bAvoidchars: Boolean;
   bCustomchars: Boolean;
   filePath: String;
 begin
   filePath:='';
   filePath:=GetSpecialFolderPath(CSIDL_APPDATA)+'\'+ApplicationName+'\';
   if not DirectoryExists(filePath) then CreateDir(filePath);
   filePath:=filePath + ApplicationName + '.ini';
appINI := TIniFile.Create(filePath);
 try
      sAmount:=EditSerialAmount.Text;
      sCharAmount:=EditCharAmount.Text;
      sDashes:=ComboBoxAmountDashes.Text;
      sCustomChars:=CustomChars.Text;
      bUpperLowerCase:=CheckBoxLowerUpperCase.Checked;
      bDashstate:=CheckBoxDashes.Checked;
      bAvoidchars:=CheckBoxAvoidChars.Checked;
      bCustomchars:=CheckBoxUseCustomChars.Checked;
      appINI.WriteString('Options','sAmount',        EditSerialAmount.Text);
      appINI.WriteString('Options','sCharAmount',    EditCharAmount.Text);
      appINI.WriteString('Options','sDashes',        ComboBoxAmountDashes.Text);
      appINI.WriteString('Options','sCustomChars',   CustomChars.Text);
      appINI.WriteBool('Options','bUpperLowerCase',  CheckBoxLowerUpperCase.Checked);
      appINI.WriteBool('Options','bDashstate',       CheckBoxDashes.Checked);
      appINI.WriteBool('Options','bAvoidchars',      CheckBoxAvoidChars.Checked);
      appINI.WriteBool('Options','bCustomchars',     CheckBoxUseCustomChars.Checked);
      with appINI, MainForm1 do
      begin
       WriteInteger('Placement','Top', Top) ;
       WriteInteger('Placement','Left', Left) ;
       WriteInteger('Placement','Width', Width) ;
       WriteInteger('Placement','Height', Height) ;
     end;
   finally
     appIni.Free;
   end;
 end;

procedure TMainForm1.FormCreate(Sender: TObject);

 var
   filePath: String;
   appINI : TIniFile;
   sAmount: String;
   sCharAmount: String;
   sDashes: String;
   sCustomChars: String;
   bUpperLowerCase: Boolean;
   bDashstate: Boolean;
   bAvoidchars: Boolean;
   bCustomchars: Boolean;
 begin
   filePath:='';
   filePath:=GetSpecialFolderPath(CSIDL_APPDATA)+'\'+ApplicationName+'\';
   if not DirectoryExists(filePath) then CreateDir(filePath);
   filePath:=filePath + ApplicationName + '.ini';
   appINI := TIniFile.Create(filePath);
   try
      EditSerialAmount.Text:=          appINI.ReadString('Options','sAmount', '1000');
      EditCharAmount.Text:=            appINI.ReadString('Options','sCharAmount', '20');
      ComboBoxAmountDashes.Text:=      appINI.ReadString('Options','sDashes', '4');
      CustomChars.Text:=               appINI.ReadString('Options','sCustomChars','');
      CheckBoxLowerUpperCase.Checked:=   appINI.ReadBool('Options','bUpperLowerCase', False);
      CheckBoxDashes.Checked:=           appINI.ReadBool('Options','bDashstate',True);
      CheckBoxAvoidChars.Checked:=       appINI.ReadBool('Options','bAvoidchars',True);
      CheckBoxUseCustomChars.Checked:=   appINI.ReadBool('Options','bCustomchars',False);
     Top := appINI.ReadInteger('Placement','Top', Top) ;
     Left := appINI.ReadInteger('Placement','Left', Left);
     Width := appINI.ReadInteger('Placement','Width', Width);
     Height := appINI.ReadInteger('Placement','Height', Height);
   finally
     appINI.Free;
   end;

  //DockMaster.MakeDockable(MainForm1);
  //DockMaster.MakeDockSite(Self,[akBottom],admrpChild);
  //DockMaster.MakeDockSite(Self,[akBottom],admrpChild);

end;

procedure TMainForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ActiveControl is TEdit) and (Key = VK_RETURN) then begin
  Key := 0;
  Self.SelectNext(ActiveControl, True, True);
  end;
end;

procedure TMainForm1.CreateNewListClick(Sender: TObject);
var
  amount: Integer;
  sAmount, sCharAmount, sDashes, sCustomChars, sChangeCaption: String;
  bUpperLowerCase, bDashstate, bAvoidchars, bCustomchars :Boolean;

  begin
  {Create New Codes List}
  {Display 'FormSerialOutput' Form}
  sAmount:=EditSerialAmount.Text;
  sCharAmount:=EditCharAmount.Text;
  sDashes:=ComboBoxAmountDashes.Text;
  sCustomChars:=CustomChars.Text;
  bUpperLowerCase:=CheckBoxLowerUpperCase.Checked;
  bDashstate:=CheckBoxDashes.Checked;
  bAvoidchars:=CheckBoxAvoidChars.Checked;
  bCustomchars:=CheckBoxUseCustomChars.Checked;
  // Setup Console
  FormSerialOutput.MemoOutputSerials.Clear; {CLEAR SLATE}
  FormSerialOutput.MemoOutputSerials.ReadOnly:=True; {NO EDITING}
  sChangeCaption:=FormSerialOutput.Caption; {SAVE CURRENT CAPTION}
  FormSerialOutput.Caption:=FormSerialOutput.Caption + ' - Working..  Please Wait';
  FormSerialOutput.Show;
  try
   FormSerialOutput.MemoOutputSerials.Lines:=CreateRandomCodes(sAmount,
                                 sCharAmount,
                                 sDashes,
                                 sCustomChars,
                                 bUpperLowerCase,
                                 bDashstate,
                                 bAvoidchars,
                                 bCustomchars);
 Finally
   // Update to default caption & make 'Console' Button 'Un-greyed'/Enabled again :
   FormSerialOutput.Caption:=sChangeCaption;
   FormSerialOutput.ButtonOutputSave.Enabled:=True;
   FormSerialOutput.ButtonCopySerialForm.Enabled:=True;
   FormSerialOutput.ButtonClearSerialForm.Enabled:=True;
 end;
end;

procedure TMainForm1.ClearCurrentListClick(Sender: TObject);
begin
 {CLEAR CODES}
  FormSerialOutput.ButtonClearSerialFormClick(sender);
end;

procedure TMainForm1.EditUndoClick(Sender: TObject);
begin
  {EDIT/UNDO}
end;

procedure TMainForm1.EditRedoClick(Sender: TObject);
begin
  {EDIT/REDO}
end;

procedure TMainForm1.EditCutClick(Sender: TObject);
begin
  {EDIT/CUT}
end;

procedure TMainForm1.EditCopyClick(Sender: TObject);
begin
  {EDIT/COPY}
end;

procedure TMainForm1.EditPasteClick(Sender: TObject);
begin
  {EDIT/PASTE}
end;

procedure TMainForm1.EditFindClick(Sender: TObject);
begin
  {EDIT/FIND}
end;

procedure TMainForm1.EditFindNextClick(Sender: TObject);
begin
  {EDIT/FIND Next}
end;

procedure TMainForm1.FileCloseClick(Sender: TObject);
begin
  {FileClose}
end;

procedure TMainForm1.FormShow(Sender: TObject);
begin
  //FormSerialOutput.Show;
end;

procedure TMainForm1.SaveClick(Sender: TObject);
var
  SL : TStringList;
begin
  {SAVE}
    begin
     SL:=TStringList.Create;
     SL:=FormSerialOutput.ReturnSerialList;
     SaveMyFile(Sl);
   end;
end;

procedure TMainForm1.EditCharAmountChange(Sender: TObject);
var
  Amount: String;

begin
     Amount:=EditCharAmount.Text;
     If (StrToIntDef(Amount, 20) > 64) or
     (Length(EditCharAmount.Text) > 2) or
     (Length(EditCharAmount.Text) < 1) then
       begin
       Amount:='20';
       EditCharAmount.Text:=Amount;
       end;
     SerialAmount:=StrToInt(Amount);
end;

procedure TMainForm1.ComboBoxAmountBetweenChange(Sender: TObject);
begin

end;

procedure TMainForm1.ButtonConsoleClick(Sender: TObject);
begin

 if FormSerialOutput.Visible  then FormSerialOutput.Close
else
  FormSerialOutput.Show;
 if FormSerialOutput.MemoOutputSerials.Text = '' then FormSerialOutput.GreyFormButtons(Sender);
end;

procedure TMainForm1.CheckBoxAvoidCharsChange(Sender: TObject);
begin

end;

procedure TMainForm1.CheckBoxUseCustomCharsChange(Sender: TObject);
begin
       UseAdditionalCustomChars:=True;
     if (CheckBoxUseCustomChars.State = cbUnchecked) then
       begin
       CustomChars.Enabled:=False;
       UseAdditionalCustomChars:=False
       end
     else
       CustomChars.Enabled:=True;
end;

procedure TMainForm1.ButtonShowSerialConsoleClick(Sender: TObject);
begin
      FormSerialOutput.Show;
end;

procedure TMainForm1.EditCharAmountKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8, #9]) then Key := #0;
end;



procedure TMainForm1.FileExitAppClick(Sender: TObject);
begin
  {FILE EXIT}
  Close;
end;


//initialization
//   Application.Title := 'ActGen v1.00';
//  //{$I act_source.lrs}
  //Application.Initialize;
  //Application.CreateForm(TFormSerialOutput,outputfrm.FormSerialOutput);
  //Application.CreateForm(TMainform1,act_source.MainForm1);
  //
  //Application.Run;


end.

