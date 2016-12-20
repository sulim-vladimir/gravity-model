unit Unit1;

interface

uses
  Classes, SysUtils;

type
  TCompObj = class(TThread)
  private
    procedure Update;
  protected
    procedure Execute; override;
  end;
var Aux,MPBChecked: Boolean;

implementation

uses MainForm,GenSettDlg;

procedure TCOmpObj.Update;
begin
  ComputeObjSit1(Aux,True,False,True);
  if Time<>0 then
  Form1.ProgressBar.Position:= Round(Time*100/TimeTo);
  Time:= Time+TimeInt;                                                    
  ShowTime1;
end;

procedure TCompObj.Execute;
begin
RemSet1;
MPBChecked:= Form4.MakePointsbox.Checked;
while Time<=TimeTo do
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
  Synchronize(Update);
  Sleep(1);
  if terminated then exit
  end;
end;

end.
 