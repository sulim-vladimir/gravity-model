unit AboutProDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls, ShellApi;

type
  TOKBottomDlg1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Image1Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OKBottomDlg1: TOKBottomDlg1;

implementation

{$R *.dfm}

procedure TOKBottomDlg1.FormKeyPress(Sender: TObject; var Key: Char);
begin
OKBottomDlg1.Close
end;

procedure TOKBottomDlg1.Image1Click(Sender: TObject);
begin
OKBottomDlg1.Close
end;

procedure TOKBottomDlg1.Label8Click(Sender: TObject);
var em_subject, em_body, em_mail : string;
begin
em_subject := 'SVY Gravity Model';
em_body := 'Текст сообщения';  em_mail := 'mailto:svuorion@yandex.ru?subject=' +
em_subject + '&body=' + em_body ;
ShellExecute(Handle,'open',PChar(em_mail), nil, nil, SW_SHOWNORMAL);
end;  

end.
