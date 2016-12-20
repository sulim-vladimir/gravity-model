unit Obj;

interface

uses
  SysUtils, Classes, Graphics, Controls;

type
  TObj = class(TGraphicControl)
  private
    FCaption: String;
    FColor: TColor;
    FRad: Integer;
    procedure SetCaption(Value: String);
    procedure SetRad(Value: Integer);
    procedure SetColor(Value: TColor);
  protected
    procedure Paint; override;
  public
    FR, FX, FY, FM, FVX, FVY: Real;
    FK, FQ: array [1..4] of Real;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Caption: String read FCaption write SetCaption;
    property Rad: Integer read FRad write SetRad;
    property Color: TColor read FColor write SetColor;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseDown;
end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Win32', [TObj]);
end;

constructor TObj.Create;
begin
  inherited Create(AOwner);
  Width:= 50;
  Height:= 50;
  FColor:= clGray
end;

procedure TObj.Paint;
var ScrSize: Integer;
begin
  if Rad<10 then Rad:= 10;
  ScrSize:= 2*Rad;
  Canvas.Brush.Color:= FColor;
  Width:= ScrSize + Canvas.TextWidth(FCaption);
  Height:= ScrSize;
  Canvas.Brush.Color:= FColor;
  Canvas.FillRect(Rect(ScrSize,0,Width,14));
  Canvas.Ellipse(0,0,ScrSize,ScrSize);
  Canvas.Brush.Color:= clWhite;
  Canvas.TextOut(ScrSize,0,FCaption);
end;

procedure TObj.SetCaption;
begin
  FCaption:= Value;
  Paint
end;

procedure TObj.SetRad;
begin
  FRad:= Value;
  Paint
end;

procedure TObj.SetColor;
begin
  FColor:= Value;
  Paint
end;

destructor TObj.Destroy;
begin
  inherited Destroy
end;

end.
