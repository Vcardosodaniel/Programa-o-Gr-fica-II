unit CoordenadasLinhas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Linha, Primeiro1;

type
  TfrmLinha = class(TForm)
    Principal: TPanel;
    GroupBox1: TGroupBox;
    btnOK: TButton;
    btnCancelar: TButton;
    lblPonto1: TLabel;
    lblPonto2: TLabel;
    lblXPonto1: TLabel;
    lblXPonto2: TLabel;
    lblYPonto1: TLabel;
    lblYPonto2: TLabel;
    edXPonto1: TEdit;
    edYPonto1: TEdit;
    edXPonto2: TEdit;
    edYPonto2: TEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLinha: TfrmLinha;

implementation

{$R *.dfm}

procedure TfrmLinha.btnCancelarClick(Sender: TObject);
begin
  close();
end;

procedure TfrmLinha.btnOKClick(Sender: TObject);
var
  linha: TLinha;
  principal: TPrincipal;
begin
  linha.setP1X(StrToFloat(edXPonto1.Text));
  linha.setP1Y(StrToFloat(edYPonto1.Text));
  linha.setP2X(StrToFloat(edXPonto2.Text));
  linha.setP2Y(StrToFloat(edYPonto2.Text));
  principal.setDesenharLinha(true);
  btnCancelarClick(self);
end;

end.
