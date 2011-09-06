unit aboutfrm;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,  lclintf;

type

  { TAboutForm }

  TAboutForm = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OKAboutButton: TButton;
    WrittenBy: TLabel;
    Contact: TLabel;
    Email: TLabel;
    Web: Tlabel;
    WebSite: Tlabel;

    procedure Button1Click(Sender: TObject);
    procedure OKAboutButtonClick(Sender: TObject);
    procedure URLLabelMouseDown(Sender: TObject); // Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure URLLabelMouseEnter(Sender: TObject);
    procedure URLLabelMouseLeave(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  AboutForm: TAboutForm;

implementation

{$R *.lfm}


procedure TAboutForm.URLLabelMouseDown(Sender: TObject);//  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  OpenURL(TLabel(Sender).Caption);
end;

procedure TAboutForm.OKAboutButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TAboutForm.Button1Click(Sender: TObject);
begin
  OpenURL('https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=MD9LTWS5DAXBG&lc=US&item_name=Shea%20Computers%20%26%20Networking&item_number=actgen&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted');
end;



procedure TAboutForm.URLLabelMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
  TLabel(Sender).Font.Color := clBlue;
  TLabel(Sender).Cursor := crDefault;
end;

procedure TAboutForm.URLLabelMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsUnderLine];
  TLabel(Sender).Font.Color := clRed;
  TLabel(Sender).Cursor := crHandPoint;
end;
end.

