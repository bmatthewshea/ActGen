program ActGen;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, aboutfrm, outputfrm, fileops, calcs, act_source;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm1, MainForm1);
  Application.CreateForm(TFormSerialOutput, FormSerialOutput);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.

