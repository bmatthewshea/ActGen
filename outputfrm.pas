unit outputfrm;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls, ExtCtrls, fileops;

type

  { TFormSerialOutput }

  TFormSerialOutput = class(TForm)
    ButtonCopySerialForm: TButton;
    ButtonClearSerialForm: TButton;
    ButtonOutputSave: TButton;
    ButtonOutputOkClose: TButton;
    MemoOutputSerials: TMemo;
    procedure ButtonClearSerialFormClick(Sender: TObject);
    procedure ButtonCopySerialFormClick(Sender: TObject);
    procedure ButtonOutputOkCloseClick(Sender: TObject);
    procedure ButtonOutputSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GreyFormButtons(Sender: TObject);
    procedure UnGreyFormButtons(Sender: TObject);
    function ReturnSerialList:TStringList;
  private
    { private declarations }
  public
    { public declarations }

  end; 

var
  FormSerialOutput: TFormSerialOutput;

implementation

{$R *.lfm}

function TFormSerialOutput.ReturnSerialList:TStringList;
begin
  result := TStringList.Create;
  result.add(MemoOutputSerials.Text);
  //result.add('');
end;


{ TFormSerialOutput }

procedure TFormSerialOutput.ButtonOutputOkCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSerialOutput.ButtonClearSerialFormClick(Sender: TObject);
begin
   MemoOutputSerials.Clear;
   //FormSerialOutput.ButtonOutputSave.Enabled:=False;
   //FormSerialOutput.ButtonCopySerialForm.Enabled:=False;
   //FormSerialOutput.ButtonClearSerialForm.Enabled:=False;
   GreyFormButtons(Sender);
end;

procedure TFormSerialOutput.ButtonCopySerialFormClick(Sender: TObject);
begin
  MemoOutputSerials.SelectAll;
  MemoOutputSerials.SetFocus;
  MemoOutputSerials.CopyToClipboard;
end;

procedure TFormSerialOutput.ButtonOutputSaveClick(Sender: TObject);
begin
  //ShowMessage(FormSerialOutput.ReturnSerialList.Text);
  SaveMyFile(FormSerialOutput.ReturnSerialList);
end;

procedure TFormSerialOutput.FormCreate(Sender: TObject);
begin
  //DockMaster.MakeDockable(FormSerialOutput);
  //DockMaster.MakeDockSite(Self,[akTop],admrpChild);
end;

procedure TFormSerialOutput.GreyFormButtons(Sender: TObject);
begin
   FormSerialOutput.ButtonOutputSave.Enabled:=False;
   FormSerialOutput.ButtonCopySerialForm.Enabled:=False;
   FormSerialOutput.ButtonClearSerialForm.Enabled:=False;
end;

procedure TFormSerialOutput.UnGreyFormButtons(Sender: TObject);
begin
   FormSerialOutput.ButtonOutputSave.Enabled:=True;
   FormSerialOutput.ButtonCopySerialForm.Enabled:=True;
   FormSerialOutput.ButtonClearSerialForm.Enabled:=True;
end;

end.

