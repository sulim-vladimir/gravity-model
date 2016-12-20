unit Thread;

interface

uses
  Classes;

type
  TCompute = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

uses Mainform;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TCompute.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TCompute }


procedure TCompute.Execute;
var Aux,MPBChecked: Boolean;
begin
CanRender:= True;
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
RenderButton.Enabled:= True;
end;

end.
 