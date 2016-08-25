unit CoordenadasPonto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Primeiro1;

type
  TfrmPonto = class(TForm)
    Principal: TPanel;
    GroupBox1: TGroupBox;
    lblXPonto: TLabel;
    lblYPonto: TLabel;
    edXPonto: TEdit;
    edYPonto: TEdit;
    btnOK: TButton;
    btnCancelar: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPonto: TfrmPonto;

implementation

{$R *.dfm}

procedure TfrmPonto.btnCancelarClick(Sender: TObject);
begin
  close();
end;

procedure TfrmPonto.btnOKClick(Sender: TObject);
var
  Principal: TPrincipal;
begin
  Principal.InicializaVariaveisPonto(true, StrToFloat(edXPonto.Text), StrToFloat(edYPonto.Text));
  btnCancelarClick(self);
end;

end.
