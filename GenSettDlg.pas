unit GenSettDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls;

type
  TForm4 = class(TForm)
    SetPanel: TPanel;
    Bevel4: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label9: TLabel;
    IntEdit: TLabeledEdit;
    TimeToEdit: TEdit;
    MUnitBox: TComboBox;
    PointsEdit: TSpinEdit;
    ScaleEdit: TLabeledEdit;
    MakePointsBox: TCheckBox;
    Label2: TLabel;
    procedure IntEditChange(Sender: TObject);
    procedure MUnitBoxChange(Sender: TObject);
    procedure TimeToEditChange(Sender: TObject);
    procedure PointsEditChange(Sender: TObject);
    procedure MakePointsBoxClick(Sender: TObject);
    procedure ScaleEditChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses MainForm;

{$R *.dfm}

procedure TForm4.IntEditChange(Sender: TObject);
begin
try
  TimeInt:= StrToFloat(Form4.IntEdit.Text)
except
end
end;

procedure TForm4.MUnitBoxChange(Sender: TObject);
begin
  ComputeTime1
end;

procedure TForm4.TimeToEditChange(Sender: TObject);
begin
  ComputeTime1
end;

procedure TForm4.PointsEditChange(Sender: TObject);
begin
PCounter:= 1
end;

procedure TForm4.MakePointsBoxClick(Sender: TObject);
var MakePoints: Boolean;
begin
MakePoints:= Form4.MakePointsBox.Checked;
Form4.PointsEdit.Enabled:= MakePoints;
Form4.Label2.Enabled:= MakePoints
end;

procedure TForm4.ScaleEditChange(Sender: TObject);
var Temp: Real;
begin
  Temp:= Scale;
try
  Scale:= StrToFloat(Form4.ScaleEdit.Text);
  if Scale<0.00007 then begin
    ShowMessage('Достигнуто минимальное значение масштаба');
    Scale:= 0.00008;
    Form4.ScaleEdit.Text:= FloatToStr(Scale)
    end;
  Form4.ScaleEdit.Hint:= Form4.ScaleEdit.Text;
  PlaceObjs1(Scale,Temp);
  DrawCoord1;
except
end;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Settings.Checked:= False
end;

end.
