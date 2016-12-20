unit SettingsDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Obj, Math;

type
  TOKBottomDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    ValueEditBox1: TPanel;
    Label1: TLabel;
    VXEdit: TEdit;
    ValueEditBox2: TPanel;
    Label2: TLabel;
    VYEdit: TEdit;
    ValueEditBox3: TPanel;
    Label4: TLabel;
    ObjXEdit: TEdit;
    ValueEditBox4: TPanel;
    Label6: TLabel;
    ObjYEdit: TEdit;
    ValueEditBox5: TPanel;
    Label7: TLabel;
    ObjWeightEdit: TEdit;
    ValueEditBox6: TPanel;
    Label5: TLabel;
    ObjRadiusEdit: TEdit;
    ValueEditBox7: TPanel;
    Label8: TLabel;
    ObjNameEdit: TEdit;
    ColorBox1: TColorBox;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ObjNameEditChange(Sender: TObject);
    procedure s(Sender: TObject);
    procedure ObjXEditChange(Sender: TObject);
    procedure ObjYEditChange(Sender: TObject);
    procedure ObjWeightEditChange(Sender: TObject);
    procedure ObjRadiusEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure VYEditChange(Sender: TObject);
    procedure VXEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OKBottomDlg: TOKBottomDlg;
  TempColor: TColor;
  TempR, TempX, TempY, TempM, TempVX, TempVY: Real;
  TempName: String;
  PlaceObj1: procedure(AObj: TObj);
  Change: Boolean;

implementation

uses MainForm;

{$R *.dfm}

procedure PlaceObj(AObj: TObj);
begin
  AObj.Rad:= Round(AObj.FR/Scale);
  with AObj do
    begin
    Left:= Round((CSX + FX)/Scale) - Rad;
    Top:= Form1.Field.Height - Round((CSY + FY)/Scale) - Rad;
    end
end;

procedure TOKBottomDlg.OKBtnClick(Sender: TObject);
begin
  OKBottomDlg.Close
end;

procedure TOKBottomDlg.CancelBtnClick(Sender: TObject);
begin
with ObjSh[Index] do
  begin
  Color:= TempColor;
  Caption:= TempName;
  FX:= TempX;
  FY:= TempY;
  FM:= TempM;
  FR:= TempR;
  PlaceObj(ObjSh[Index]);
  FVX:= TempVX;
  FVY:= TempVY;
  Close
  end
end;

procedure TOKBottomDlg.s(Sender: TObject);
begin
Change:= False;
with ObjSh[Index] do
  begin
  TempColor:= Color;
  ColorBox1.Selected:= TempColor;
  TempName:= Caption;
  ObjNameEdit.Text:= TempName;
  TempX:= FX;
  ObjXEdit.Text:= FloatToStr(FX);
  TempY:= FY;
  ObjYEdit.Text:= FloatToStr(FY);
  TempM:= FM;
  ObjWeightEdit.Text:= FloatToStr(FM);
  VXEdit.Text:= FloatToStr(FVX);
  VYEdit.Text:= FloatToStr(FVY);
  TempR:= FR;
  ObjRadiusEdit.Text:= FloatToStr(FR);
  TempVX:= FVX;
  TempVY:= FVY;
  end;
Change:= True;
end;

procedure TOKBottomDlg.ColorBox1Change(Sender: TObject);
begin
if Change=True then
  ObjSh[Index].Color:= ColorBox1.Selected;
end;

procedure TOKBottomDlg.ObjNameEditChange(Sender: TObject);
begin
try
if Change=True then
  ObjSh[Index].Caption:= ObjNameEdit.Text
except
end
end;

procedure TOKBottomDlg.ObjXEditChange(Sender: TObject);
begin
try
if Change=True then
  begin
  ObjSh[Index].FX:= StrToFloat(ObjXEdit.Text);
  PlaceObj(ObjSh[Index]);
  end
except
end
end;

procedure TOKBottomDlg.ObjYEditChange(Sender: TObject);
begin
try
if Change=True then
  begin
  ObjSh[Index].FY:= StrToFloat(ObjYEdit.Text);
  PlaceObj(ObjSh[Index]);
  end
except
end
end;

procedure TOKBottomDlg.ObjWeightEditChange(Sender: TObject);
begin
try
if Change=True then
  ObjSh[Index].FM:= StrToFloat(ObjWeightEdit.Text);
except
end
end;

procedure TOKBottomDlg.ObjRadiusEditChange(Sender: TObject);
begin
try
if Change=True then
  begin
  ObjSh[Index].FR:= StrToFloat(ObjRadiusEdit.Text);
  PlaceObj(ObjSh[Index]);
  end
except
end
end;

procedure TOKBottomDlg.FormCreate(Sender: TObject);
begin
  PlaceObj1:= PlaceObj;
end;

procedure TOKBottomDlg.VYEditChange(Sender: TObject);
begin
try
if Change=True then
  begin
  ObjSh[Index].FVY:= StrToFloat(VYEdit.Text);
  PlaceObj(ObjSh[Index]);
  end
except
end
end;

procedure TOKBottomDlg.VXEditChange(Sender: TObject);
begin
try
if Change=True then
  begin
  ObjSh[Index].FVX:= StrToFloat(VXEdit.Text);
  PlaceObj(ObjSh[Index]);
  end
except
end
end;

end.

