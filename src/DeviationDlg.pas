unit DeviationDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, Menus, Series, StdCtrls;

type
  TForm5 = class(TForm)
    Chart: TChart;
    MainMenu1: TMainMenu;
    FileMenu: TMenuItem;
    Series: TLineSeries;
    SaveChart: TMenuItem;
    WithIntEdit: TEdit;
    Label1: TLabel;
    Start: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure StartClick(Sender: TObject);
    procedure SaveChartClick(Sender: TObject);
    procedure SaveDialog1CanClose(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses MainForm;

{$R *.dfm}

procedure TForm5.StartClick(Sender: TObject);
var Aux: Boolean;
    DY, DX, Interval, PreInt: Real;
begin
Start.Enabled:= False;
if Index<>0 then
begin
Chart.Series[0].Clear;
RemSet1;
Time:= 0;
CanRender:= True;
AssignFile(ResFile,'Results.txt');
Rewrite(ResFile);
while (Time<=500000) do
  begin
  ComputeObjSit1(True,False,True,False);
  Application.ProcessMessages;
  Time:= Time+TimeInt;
  end;
CloseFile(ResFile);
Form1.ReturnBtnClick(nil);
RemSet1;
Time:= 0;
Reset(ResFile);
PCounter:= 0;
PreInt:= TimeInt;
try
TimeInt:= StrToFloat(WithIntEdit.Text);
except
ShowMessage(WithIntEdit.Text+' - неверное значение интервала');
WithIntEdit.Text:= '100';
TimeInt:= 100
end;
Interval:= PreInt/TimeInt;
while Time<=500000 do
  begin
  if (PCounter>=Interval) then
      begin
      Aux:= True;
      PCounter:= 1
      end
    else
      begin
      Aux:= False;
      Inc(PCounter);
      end;
  ComputeObjSit1(Aux,False,False,False);
  if Aux then
  begin
  Read(ResFile,DX);
  ReadLn(ResFile,DY);
  DX:= DX - ObjSh[Index].FX;
  DY:= DY - ObjSh[Index].FY;
  DY:= sqrt(sqr(DX)+sqr(DY));
  Chart.Series[0].AddXY(Time,DY);
  end;
  Time:= Time+TimeInt;
  end;
CloseFile(ResFile);
TimeInt:= PreInt
end;
Start.Enabled:= True
end;

procedure TForm5.SaveChartClick(Sender: TObject);
begin
SaveDialog1.Execute
end;

procedure TForm5.SaveDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
Chart.SaveToMetafile(SaveDialog1.Files[0]);
end;

end.
