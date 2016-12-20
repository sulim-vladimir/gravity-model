program SVYGravityModel;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  SettingsDlg in 'SettingsDlg.pas' {OKBottomDlg},
  AboutProDlg in 'AboutProDlg.pas' {OKBottomDlg1},
  GenSettDlg in 'GenSettDlg.pas' {Form4},
  Obj in 'Obj.pas',
  Presents in 'Presents.pas' {Form2},
  Unit1 in 'Unit1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SVY Gravity Model';
  Application.HelpFile := 'D:\Вовина папка\Учебная папка\Gravity Model\Екософт\Help.chm';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TOKBottomDlg, OKBottomDlg);
  Application.CreateForm(TOKBottomDlg1, OKBottomDlg1);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
