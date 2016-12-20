unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, StdCtrls, ComCtrls, Obj, Math, Spin, AppEvnts,
  ToolWin, Buttons, ImgList, TeeProcs, TeEngine, Chart, ShellApi, Unit1;

type
  TForm1 = class(TForm)
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    HelpMenu: TMenuItem;
    OpenSetFile: TMenuItem;
    SaveSetFile: TMenuItem;
    AboutPro: TMenuItem;
    SaveImFile: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveSetDialog: TSaveDialog;
    SaveImDialog: TSaveDialog;
    FieldPanel: TPanel;
    Field: TImage;
    ApplicationEvents: TApplicationEvents;
    NewSystem: TMenuItem;
    StatusBar: TStatusBar;
    Return: TMenuItem;
    EditMenu: TMenuItem;
    CopyObject: TMenuItem;
    CreateObject: TMenuItem;
    Control: TMenuItem;
    Render: TMenuItem;
    Zoom: TMenuItem;
    Unzoom: TMenuItem;
    Clear: TMenuItem;
    FTime: TMenuItem;
    DeleteObject: TMenuItem;
    Measure: TMenuItem;
    ToolBar: TToolBar;
    CreateButton: TToolButton;
    CopyButton: TToolButton;
    DeleteButton: TToolButton;
    ClearButton: TToolButton;
    MeasureButton: TToolButton;
    ImageList: TImageList;
    ReturnButton: TToolButton;
    ZoomButton: TToolButton;
    UnzoomButton: TToolButton;
    Separator3: TToolButton;
    RenderButton: TToolButton;
    Separator5: TToolButton;
    TimePanel: TPanel;
    FTimeButton: TToolButton;
    Settings: TMenuItem;
    ProgressBar: TProgressBar;
    Separator2: TToolButton;
    Separator1: TToolButton;
    Separator4: TToolButton;
    N1: TMenuItem;
    ToolButton1: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure OpenSetFileClick(Sender: TObject);
    procedure SaveSetFileClick(Sender: TObject);
    procedure SaveImFileClick(Sender: TObject);
    procedure SaveImDialogCanClose(Sender: TObject; var CanClose: Boolean);
    procedure ObjMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SaveSetDialogCanClose(Sender: TObject;
      var CanClose: Boolean);
    procedure MakePointsBoxClick(Sender: TObject);
    procedure ObjMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ObjMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ClearBtnClick(Sender: TObject);
    procedure FieldMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CreateBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure ZoomBtnClick(Sender: TObject);
    procedure UnzoomBtnClick(Sender: TObject);
    procedure FieldMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FieldMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TimeToEditChange(Sender: TObject);
    procedure MUnitBoxChange(Sender: TObject);
    procedure IntEditChange(Sender: TObject);
    procedure OpenDialogCanClose(Sender: TObject; var CanClose: Boolean);
    procedure MeasureBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure AboutProClick(Sender: TObject);
    procedure RenderBtnClick(Sender: TObject);
    procedure FTimeBtnClick(Sender: TObject);
    procedure ApplicationEventsShortCut(var Msg: TWMKey;
      var Handled: Boolean);
    procedure NewSystemClick(Sender: TObject);
    procedure ReturnBtnClick(Sender: TObject);
    procedure CopyObjectClick(Sender: TObject);
    procedure SettingsClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure StopClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type TObjData = record
      X,Y,VX,VY: double;
      end;

const N=20;
      GConst=6.67e-11;
var
  Form1: TForm1;
  MoveField, Move, CanRender, MoveSetBox, L1, L2: Boolean;
  X0,X01,Y0,Y01, PCounter, SleepTime: Integer;
  ObjSh: array [1..N] of TObj;
  ObjData: array [1..N] of TObjData;
  Index: Byte;
  Scale, CSX, CSY, Time, TimeInt, TimeTo, RemTime,M,GX,GY: double;
  DrawCoord1, ComputeTime1, RemSet1, ShowTime1: procedure;
  PlaceObjs1: procedure(Sc2,Sc1: double);
  ComputeObjSit1: procedure(MakePoint, DrawPoint, SaveRes, PO: Boolean);
  ResFile: TextFile;
  L: array [1..2] of TObjData;
  CompObj: TCompObj;

implementation
                       
uses SettingsDlg, GenSettDlg, AboutProDlg, DeviationDlg, Presents;

{$R *.dfm}

function Convert(x: Real): string;
begin
  if Abs(x)<1000 then Convert:=FormatFloat('0.00',x)+' м'
  else if Abs(x)<1496000 then Convert:= FormatFloat('0.00',x/1000)+' км'
       else Convert:= FormatFloat('0.00',x/1496000)+' а.е.'
end;

procedure DrawCoord;
var W,H,S,ST: Integer;
begin
with Form1.Field.Canvas do
  begin
  Pen.Color:= clSilver;
  FillRect(ClipRect);
  W:= Form1.Field.Width;
  H:= Form1.Field.Height;
  MoveTo(20,H-21);
  LineTo(W-20,H-21);
  MoveTo(20,20);
  LineTo(20,H-20);
  MoveTo(W-21,20);
  LineTo(W-21,H-21);
  MoveTo(20,20);
  LineTo(W-21,20);
  S:= Round(Frac(CSX/(Scale*45))*45);
  ST:= Round(Frac(CSX/(Scale*180))*180);
  while S<=W do
    begin
    MoveTo(S,20);
    if (S>=20)and(S<=W-21) then
    LineTo(S,H-21);
    S:= S + 45;
    if ST<=W then
    begin
    TextOut(ST-1,H-18,'|'+Convert(ST*Scale - CSX));
    ST:= ST + 180;
    end
    end;
  S:= Round(Frac(-CSY/(Scale*45))*45);
  ST:= Round(Frac(-CSY/(Scale*180))*180);
  while S<=H do
    begin
    MoveTo(20,S);
    if (S<=H-20)and(S>=20) then
    LineTo(W-20,S);
    S:= S + 45;
    if ST<=H-20 then
    begin
    TextOut(0,ST+2,Convert((H - ST)*Scale - CSY));
    ST:= ST + 180;
    end
    end;
  end;
end;

procedure ComputeTime;
var Mult: Integer;
    i: Byte;
begin
i:= Form4.MUnitBox.ItemIndex;
case i of
  0: Mult:= 1;
  1: Mult:= 60;
  2: Mult:= 3600;
  3: Mult:= 86400;
  4: Mult:= 2592000;
  5: Mult:= 946080000
end;
TimeTo:= StrToFloat(Form4.TimeToEdit.Text)*Mult
end;

procedure PlaceObjs(Sc2,Sc1: double);
var i: Byte;
begin
CSX:= Form1.Field.Width*(Sc2 - Sc1)/2 + CSX;
CSY:= Form1.Field.Height*(Sc2 - Sc1)/2 + CSY;
for i:= 1 to N do
  if ObjSh[i]<>nil then
    PlaceObj1(ObjSh[i])
end;

procedure TForm1.OpenSetFileClick(Sender: TObject);
begin
OpenDialog.Execute;
end;

procedure TForm1.SaveSetFileClick(Sender: TObject);
begin
SaveSetDialog.Execute
end;

procedure TForm1.SaveImFileClick(Sender: TObject);
begin
SaveImDialog.Execute
end;

procedure TForm1.SaveImDialogCanClose(Sender: TObject;
  var CanClose: Boolean);
var i: byte;
begin
for i:= 1 to N do
  if ObjSh[i]<>nil then
    with ObjSh[i] do
      begin
      Field.Canvas.Pen.Color:= clBlack;
      Field.Canvas.TextOut(Left+2*Rad,Top,Caption);
      Field.Canvas.Brush.Color:= Color;
      Field.Canvas.Ellipse(Left,Top,Left+2*Rad,Top+2*Rad);
      Field.Canvas.Brush.Color:= clWhite;
      end;
Field.Canvas.Pen.Color:= clSilver;
Field.Picture.SaveToFile(SaveImDialog.Files[0]);
end;

procedure TForm1.SaveSetDialogCanClose(Sender: TObject;
  var CanClose: Boolean);
var SetFile: TextFile;
    i: Byte;
    Points: Integer;
begin
AssignFile(SetFile, SaveSetDialog.Files[0]);
Rewrite(SetFile);
Write(SetFile,Scale);
Write(SetFile,' ',CSX);
Write(SetFile,' ',CSY);
Write(SetFile,' ',TimeTo);
Write(SetFile,' ',TimeInt);
Write(SetFile,' ',SleepTime);
Write(SetFile,' ',Time);
if Form4.MakePointsBox.Checked then Points:= Form4.PointsEdit.Value
else Points:= 0;
Write(SetFile,' ',Points);
WriteLn(SetFile);
for i:= 1 to N do
if ObjSh[i]<>nil then
  with ObjSh[i] do
    begin
    Write(SetFile,FX);
    Write(Setfile,' ',FY);
    Write(Setfile,' ',FM);
    Write(Setfile,' ',FVX);
    Write(Setfile,' ',FVY);
    Write(Setfile,' ',FR);
    Write(SetFile,' ',Color);
    Write(SetFile,' ',Caption);
    Writeln(SetFile);
    end;
Form1.Caption:= 'SVYGravityModel v2.0 :) - '+ExtractFileName(SaveSetDialog.Files[0]);
CloseFile(SetFile);
end;

procedure TForm1.MakePointsBoxClick(Sender: TObject);
var MakePoints: Boolean;
begin
MakePoints:= Form4.MakePointsBox.Checked;
Form4.PointsEdit.Enabled:= MakePoints;
Form4.Label2.Enabled:= MakePoints
end;

procedure TForm1.ClearBtnClick(Sender: TObject);
begin
DrawCoord;
end;

procedure TForm1.ObjMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var a, R: double;
  begin
Index:= (Sender as TObj).Tag;
case Button of
  mbLeft:
    begin
    Move:= True;
    X0:= X;
    Y0:= Y;
    if L2=True then begin
      L[2].X:= (Sender as TObj).FX;
      L[2].Y:= (Sender as TObj).FY;
      L2:= False;
      if L[2].Y-L[1].Y=0 then
        if L[1].X-L[2].X>=0 then a:= pi/2
        else a:= -pi/2
      else a:= arctan((L[1].X-L[2].X)/(L[2].Y-L[1].Y));
      R:= sqrt(sqr(L[1].X-L[2].X)+sqr(L[1].Y-L[2].Y));
      (Sender as TObj).FVX:= sqrt(GConst*M/R)*Cos(a)+L[1].VX;
      (Sender as TObj).FVY:= sqrt(GConst*M/R)*Sin(a)+L[1].VY;
      N1.Enabled:= True
      end;
    if L1=True then begin
      L[1].X:= (Sender as TObj).FX;
      L[1].Y:= (Sender as TObj).FY;
      L[1].VX:= (Sender as TObj).FVX;
      L[1].VY:= (Sender as TObj).FVY;
      L1:= False;
      L2:= True;
      M:= (Sender as TObj).FM
      end;
    end;
  mbRight:
    begin
    OKBottomDlg.Close;
    OKBottomDlg.Show
    end
  end;
end;

procedure TForm1.ObjMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
MoveField:= False;
with (Sender as TObj) do
  if (Move = True) and (Cursor = crSizeAll) then
    begin
      Left:= Left + X - X0;
      Top:= Top + Y - Y0
    end;
end;

procedure TForm1.ObjMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Move:= False;
if (Button = mbLeft) then
with (Sender as TObj) do
  begin
  Cursor:= crSizeAll;
  FX:= (Left + Rad)*Scale - CSX;
  FY:= (Field.Height - Top - Rad)*Scale - CSY;
  PlaceObj1(Sender as TObj); 
  end;
end;

procedure TForm1.FieldMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
if Button=mbRight then
  MoveField:= True;
X0:= X;
Y0:= Y;
end;

procedure CountObjs;
var Counter, i: Byte;
begin
Counter:= 0;
for i:= 1 to N do
  if ObjSh[i]<>nil then Inc(Counter);
Form1.StatusBar.Panels[2].Text:= 'Создано объектов: '+IntToStr(Counter);
end;

procedure TForm1.CreateBtnClick(Sender: TObject);
var i,j: byte;
begin
i:= 1;
while ObjSh[i]<>nil do
  Inc(i);
if i<=N then
  begin
  ObjSh[i]:= TObj.Create(FieldPanel);
  ObjSh[i].Parent:= FieldPanel;
  with ObjSh[i] do
    begin
    FM:= 1;
    FR:= 20;
    FVX:= 0;
    FVY:= 0;
    for j:= 1 to 4 do FQ[j]:= 0;
    PlaceObj1(ObjSh[i]);
    OnMouseDown:= ObjMouseDown;
    OnMouseMove:= ObjMouseMove;
    OnMouseUp:= ObjMouseUp;
    Cursor:= crHandPoint;
    Tag:= i
    end
    end
else ShowMessage('Максимальное количество создаваемых объектов ограничено и равно '+IntToStr(N));
CountObjs
end;

procedure TForm1.DeleteBtnClick(Sender: TObject);
begin
if Index<>0 then
  begin
  ObjSh[Index].Destroy;
  ObjSh[Index]:= nil;
  Index:= 0
  end;
CountObjs
end;

procedure TForm1.ZoomBtnClick(Sender: TObject);
begin
Form4.ScaleEdit.Text:= FloatToStr(StrToFloat(Form4.ScaleEdit.Text)*0.8);
end;

procedure TForm1.UnzoomBtnClick(Sender: TObject);
begin
Form4.ScaleEdit.Text:= FloatToStr(StrToFloat(Form4.ScaleEdit.Text)*1.25);
end;

procedure TForm1.FieldMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var i: Byte;
begin
StatusBar.Panels[0].Text:= 'X: '+Convert(X*Scale - CSX);
StatusBar.Panels[1].Text:= 'Y: '+Convert((Field.Height - Y)*Scale - CSY);
for i:= 1 to N do
if ObjSh[i]<>nil then
  ObjSh[i].Cursor:= crHandPoint;
if MoveField then
  begin
  CSX:= CSX + (X - X0)*Scale;
  CSY:= CSY + (Y0 - Y)*Scale;
  for i:= 1 to N do
  if ObjSh[i]<>nil then
    begin
    ObjSh[i].Left:= ObjSh[i].Left+X-X0;
    ObjSh[i].Top:= ObjSh[i].Top+Y-Y0;
    end;
  DrawCoord;
  X0:= X;
  Y0:= Y
  end
end;

procedure TForm1.FieldMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var R: double;
    i: Byte;
begin
if (Button=mbLeft) and (Field.Cursor=crCross) then
begin
R:= sqrt(sqr((X - X01)*Scale)+sqr((Y - Y01)*Scale));
ShowMessage(Convert(R));
Field.Cursor:= crDefault;
for i:= 1 to N do
  if ObjSh[i]<>nil then ObjSh[i].Enabled:= True;
MeasureButton.Down:= False
end;
if Button=mbRight then  PlaceObjs(Scale,Scale);
MoveField:= False
end;

procedure ComputeG(var GX,GY: double; i: integer);
var j: Byte;
    RBtwnObj: double;
begin
    GX:= 0;
    GY:= 0;
    for j:= 1 to N do
      if (ObjSh[j]<>nil) and (i<>j) then
        begin
        RBtwnObj:= sqrt(sqr(ObjSh[j].FX-ObjSh[i].FX)+sqr(ObjSh[j].FY-ObjSh[i].FY));
        if RBTwnObj<>0 then
          begin
          GX:= GX + GConst*ObjSh[j].FM*(ObjSh[j].FX-ObjSh[i].FX)/(RBtwnObj*RBtwnObj*RBtwnObj);
          GY:= GY + GConst*ObjSh[j].FM*(ObjSh[j].FY-ObjSh[i].FY)/(RBtwnObj*RBtwnObj*RBtwnObj)
          end;
        end;
end;

procedure ComputeK(i: Integer);
begin
with ObjSh[i] do
    begin
    FK[1]:= TimeInt*FVX;
    FK[2]:= TimeInt*FVY;
    FK[3]:= TimeInt*GX;
    FK[4]:= TimeInt*GY
    end
end;

procedure ComputeObjSit(MakePoint, DrawPoint, SaveRes, PO: Boolean);
var ResX,ResY: double;
    i,j: Byte;
    XTo,YTo: Integer;
    XFrom,YFrom: array [1..N] of integer;
begin
for i:= 1 to N do
  if ObjSh[i]<>nil then
    with ObjSh[i] do
    begin
    ComputeG(GX,GY,i);
    XFrom[i]:= Round((CSX + FX)/Scale);
    YFrom[i]:= Form1.Field.Height - Round((CSY + FY)/Scale);
    ComputeK(i);
    FX:= FX+0.5*(FK[1]-2*FQ[1]);
    FY:= FY+0.5*(FK[2]-2*FQ[2]);
    FVX:= FVX+0.5*(FK[3]-2*FQ[3]);
    FVY:= FVY+0.5*(FK[4]-2*FQ[4]);
    for j:= 1 to 4 do
      FQ[j]:= FQ[j]+1.5*(FK[j]-2*FQ[j])-0.5*FK[j];
    end;
for i:= 1 to N do
  if ObjSh[i]<>nil then
    with ObjSh[i] do
    begin
    ComputeG(GX,GY,i);
    ComputeK(i);
    FX:= FX+(1-sqrt(0.5))*(FK[1]-FQ[1]);
    FY:= FY+(1-sqrt(0.5))*(FK[2]-FQ[2]);
    FVX:= FVX+(1-sqrt(0.5))*(FK[3]-FQ[3]);
    FVY:= FVY+(1-sqrt(0.5))*(FK[4]-FQ[4]);
    for j:= 1 to 4 do
      FQ[j]:= FQ[j]+3*(1-sqrt(0.5))*(FK[j]-FQ[j])-(1-sqrt(0.5))*FK[j];
    end;
for i:= 1 to N do
  if ObjSh[i]<>nil then
    with ObjSh[i] do
    begin
    ComputeG(GX,GY,i);
    ComputeK(i);
    FX:= FX+(1+sqrt(0.5))*(FK[1]-FQ[1]);
    FY:= FY+(1+sqrt(0.5))*(FK[2]-FQ[2]);
    FVX:= FVX+(1+sqrt(0.5))*(FK[3]-FQ[3]);
    FVY:= FVY+(1+sqrt(0.5))*(FK[4]-FQ[4]);
    for j:= 1 to 4 do
      FQ[j]:= FQ[j]+3*(1+sqrt(0.5))*(FK[j]-FQ[j])-(1+sqrt(0.5))*FK[j];
    end;
for i:= 1 to N do
  if ObjSh[i]<>nil then
    with ObjSh[i] do
    begin
    ComputeG(GX,GY,i);
    ComputeK(i);
    FX:= FX+(FK[1]-2*FQ[1])/6;
    FY:= FY+(FK[2]-2*FQ[2])/6;
    FVX:= FVX+(FK[3]-2*FQ[3])/6;
    FVY:= FVY+(FK[4]-2*FQ[4])/6;
    for j:= 1 to 4 do
      FQ[j]:= FQ[j]+0.5*(FK[j]-2*FQ[j])-0.5*FK[j];
    end;
for i:= 1 to N do
  if ObjSh[i]<>nil then
    begin
    Form1.Field.Canvas.MoveTo(XFrom[i],YFrom[i]);
    XTo:= Round((CSX + ObjSh[i].FX)/Scale);
    YTo:= Form1.Field.Height - Round((CSY + ObjSh[i].FY)/Scale);
    Form1.Field.Canvas.Pen.Color:= ObjSh[i].Color;
    Form1.Field.Canvas.LineTo(XTo,YTo);
    if MakePoint=True then
      begin
      if DrawPoint then Form1.Field.Canvas.Rectangle(XTo-2,YTo-2,XTo+2,YTo+2);
      if SaveRes and (Index=i) and (Time<>0) then
        begin
        ResX:= ObjSh[Index].FX;
        ResY:= ObjSh[Index].FY;
        WriteLn(ResFile,ResX,' ',ResY)
        end
      end
    end;
if PO then PlaceObjs(Scale,Scale);
end;

procedure RemSet;
var i:Byte;
begin
RemTime:= Time;
for i:= 1 to N do
  if ObjSh[i]<>nil then
    with ObjSh[i] do
      begin
      ObjData[i].X:= FX;
      ObjData[i].Y:= FY;
      ObjData[i].VX:= FVX;
      ObjData[i].VY:= FVY
      end
end;

procedure ShowTime;
var TT: double;
    Y,M,D,H,Min,S: String;
begin
  TT:= Time/60;
  S:= FloatToStr(Round(Frac(TT)*60));
  if StrToFLoat(S)<10 then S:='0'+S;
  TT:= Trunc(TT)/60;
  Min:= FloatToStr(Round(Frac(TT)*60));
  if StrToFLoat(Min)<10 then Min:='0'+Min;
  TT:= Trunc(TT)/24;
  H:= FloatToStr(Round(Frac(TT)*24));
  if StrToFLoat(H)<10 then H:='0'+H;
  TT:= Trunc(TT)/30;
  D:= FloatToStr(Round(Frac(TT)*30));
  if StrToFLoat(D)<10 then D:='0'+D;
  TT:= Trunc(TT)/12;
  M:= FloatToStr(Round(Frac(TT)*12));
  if StrToFLoat(M)<10 then M:='0'+M;
  Y:= FloatToStr(Trunc(TT));
  Form1.TimePanel.Caption:= Y+'/'+M+'/'+D+' '+H+':'+Min+':'+S
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
CSX:= Round(Field.Width/2);
CSY:= Round(Field.Height/2);
Scale:= 1;
CanRender:= True;
TimeInt:= 0.1;
TimeTo:= 100;
FieldPanel.DoubleBuffered:= True;
DrawCoord1:= DrawCoord;
ComputeTime1:= ComputeTime;
PlaceObjs1:= PlaceObjs;
ComputeObjSit1:= ComputeObjSit;
RemSet1:= RemSet;
ShowTime1:= ShowTime;
DrawCoord
end;

procedure TForm1.TimeToEditChange(Sender: TObject);
begin
  ComputeTime
end;

procedure TForm1.MUnitBoxChange(Sender: TObject);
begin
  ComputeTime
end;

procedure TForm1.IntEditChange(Sender: TObject);
begin
try
  TimeInt:= StrToFloat(Form4.IntEdit.Text)
except
end
end;

procedure TForm1.OpenDialogCanClose(Sender: TObject;
  var CanClose: Boolean);
var SetFile: TextFile;
    i: Byte;
    Points: Integer;
    ObjClr: TColor;
    ObjCptn: String;
begin
CanRender:= False;
for i:= 1 to N do
  if ObjSh[i]<>nil then
    begin
    ObjSh[i].Destroy;
    ObjSh[i]:= nil
    end;
AssignFile(SetFile,OpenDialog.Files[0]);
Reset(SetFile);
Read(SetFile,Scale);
Form4.ScaleEdit.Text:= FloatToStr(Scale);
Read(SetFile,CSX);
Read(SetFile,CSY);
Read(SetFile,TimeTo);
Read(SetFile,TimeInt);
Read(SetFile,SleepTime);
Form4.TimeToEdit.Text:= FloatToStr(TimeTo);
Form4.IntEdit.Text:= FloatToStr(TimeInt);
Read(SetFile,Time);
Read(SetFile,Points);
Form4.MUnitBox.ItemIndex:= 0;
if Points=0 then Form4.MakePointsBox.Checked:= False
else
  begin
  Form4.MakePointsBox.Checked:= True;
  Form4.PointsEdit.Value:= Points
  end;
ReadLn(SetFile);
i:= 1;
while (not Eof(SetFile)) and (i<=N) do
begin
  ObjSh[i]:= TObj.Create(Form1);
  with ObjSh[i] do
    begin
    Parent:= FieldPanel;
    Read(SetFile,FX);
    Read(Setfile,FY);
    Read(Setfile,FM);
    Read(Setfile,FVX);
    Read(Setfile,FVY);
    Read(Setfile,FR);
    Read(SetFile,ObjClr);
    Color:= ObjClr;
    Read(SetFile,ObjCptn);
    Delete(ObjCptn,1,1);
    Caption:= ObjCptn;
    ReadLn(SetFile);
    Tag:= i;
    OnMouseDown:= ObjMouseDown;
    OnMouseMove:= ObjMouseMove;
    OnMouseUp:= ObjMouseUp;
    Cursor:= crHandPoint;
    Inc(i)
    end
end;
DrawCoord;
PlaceObjs(Scale,Scale);
CloseFile(SetFile);
ShowTime;
CountObjs;
Form1.Caption:= 'SVYGravityModel v2.0 :) - '+ExtractFileName(OpenDialog.Files[0])
end;

procedure TForm1.MeasureBtnClick(Sender: TObject);
var i: Byte;
begin
Field.Cursor:= crCross;
MeasureButton.Down:= True;
for i:= 1 to N do
  if ObjSh[i]<>nil then ObjSh[i].Enabled:= False;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
Field.Picture.Bitmap.Height:= Field.Height;
Field.Picture.Bitmap.Width:= Field.Width;
DrawCoord;
PlaceObjs(Scale,Scale)
end;

procedure TForm1.AboutProClick(Sender: TObject);
begin
OKBottomDlg1.Show
end;

procedure TForm1.RenderBtnClick(Sender: TObject);
//var Aux,MPBChecked: Boolean;
begin
{CanRender:= True;
RemSet;
RenderButton.Enabled:= False;
MPBChecked:= Form4.MakePointsbox.Checked;
while (Time<=TimeTo)and(CanRender) do
  begin
  if (PCounter>=Form4.PointsEdit.Value) then
      begin
      if MPBChecked=True then Aux:= True
      else Aux:= False;
      PCounter:= 1
      end
    else
      begin
      Aux:= False;
      Inc(PCounter);
      end;
  ComputeObjSit(Aux,True,False,True);
  Application.ProcessMessages;
  if Time<>0 then
  Form1.ProgressBar.Position:= Round(Time*100/TimeTo);
  Time:= Time+TimeInt;
  ShowTime;
  Sleep(SleepTime);
  end;
ProgressBar.Position:= 0;
RenderButton.Enabled:= True; }
if RenderButton.ImageIndex=3 then
  begin
  CompObj:= TCompObj.Create(true);
  CompObj.Resume;
  CompObj.Priority:= tpLower;
  RenderButton.ImageIndex:= 4
  end
else
  begin
  CompObj.Terminate;
  CompObj.Free;
  ProgressBar.Position:= 0;
  RenderButton.ImageIndex:= 3
  end
end;

procedure TForm1.FTimeBtnClick(Sender: TObject);
begin
Time:= 0;
ShowTime;
end;

procedure TForm1.ApplicationEventsShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
case Msg.CharCode of
  VK_ESCAPE: Form1.RenderBtnClick(Form1);
  end
end;

procedure TForm1.NewSystemClick(Sender: TObject);
var i: byte;
begin
CanRender:= False;
for i:= 1 to N do
  if ObjSh[i]<>nil then
    begin
    ObjSh[i].Destroy;
    ObjSh[i]:= nil
    end;
Form1.OnCreate(Form1);
Form1.Caption:= 'SVYGravityModel v2.0 :)'
end;

procedure TForm1.ReturnBtnClick(Sender: TObject);
var i: Byte;
begin
Time:= RemTime;
for i:= 1 to N do
  if ObjSh[i]<>nil then
    with ObjSh[i] do
      begin
      FX:= ObjData[i].X;
      FY:= ObjData[i].Y;
      FVX:= ObjData[i].VX;
      FVY:= ObjData[i].VY
      end;
PlaceObjs(Scale,Scale);
ShowTime;
end;

procedure TForm1.CopyObjectClick(Sender: TObject);
var i: byte;
begin
if Index<>0 then
begin
i:= 1;
while ObjSh[i]<>nil do
  Inc(i);
if i<=N then
  begin
  ObjSh[i]:= TObj.Create(Form1);
  ObjSh[i].Parent:= FieldPanel;
  with ObjSh[i] do
    begin
    FM:= ObjSh[Index].FM;
    FX:= ObjSh[Index].FX;
    FY:= ObjSh[Index].FY;
    FR:= ObjSh[Index].FR;
    FVX:= ObjSh[Index].FVX;
    FVY:= ObjSh[Index].FVY;
    PlaceObj1(ObjSh[i]);
    OnMouseDown:= ObjMouseDown;
    OnMouseMove:= ObjMouseMove;
    OnMouseUp:= ObjMouseUp;
    Cursor:= crHandPoint;
    Tag:= i
    end
    end
else ShowMessage('Максимальное количество создаваемых объектов ограничено и равно '+IntToStr(N));
CountObjs;
end
end;

procedure TForm1.SettingsClick(Sender: TObject);
var Ch: Boolean;
begin
Ch:= not Settings.Checked;
Settings.Checked:= Ch;
if Ch then Form4.Show
else Form4.Close
end;

procedure TForm1.HelpClick(Sender: TObject);
begin
ShellExecute(Handle, 'open','Help.chm',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.N1Click(Sender: TObject);
begin
ShowMessage('Выберите объект, затем его спутник');
N1.Enabled:= False;
L1:= True
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
var i: Integer;
    maxX,minX,maxY,minY,Sc1,Sc2,Sc3: double;
    c: boolean;
begin
  c:= true;
  for i:= 1 to N do
  if ObjSh[i]<>nil then
    with ObjSh[i] do
    begin
    if c then
      begin
      minX:= FX-FR;
      maxX:= FX+FR;
      minY:= FY-FR;
      maxY:= FY+FR;
      c:= false
      end
    else
    begin
      if FX-FR<=minX then minX:= FX-FR;
      if FX+FR>=maxX then maxX:= FX+FR;
      if FY-FR<=minY then minY:= FY-FR;
      if FY+FR>=maxY then maxY:= FY+FR
    end
    end;
  Sc1:= Scale;
  Sc2:=(maxY-minY)/(Field.Height-100);
  Sc3:=(maxX-minX)/(Field.Width-100);
  if Sc2>=Sc3 then Scale:= Sc2
  else Scale:= Sc3;
  Form4.ScaleEdit.Text:= FloatToStr(Scale);
  placeobjs(Scale,Sc1);
  CSY:= 50*Scale-minY;
  CSX:= 50*Scale-minX;
  placeobjs(Scale,Scale);
  drawcoord;
end;

procedure TForm1.StopClick(Sender: TObject);
begin
RenderButton.OnClick(nil)
end;

end.
