unit Rotacionar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmRotacionar = class(TForm)
    Principal: TPanel;
    gpRotacao: TGroupBox;
    lblGraus: TLabel;
    edGraus: TEdit;
    rbOrigem: TRadioButton;
    rbCentro: TRadioButton;
    rbPonto: TRadioButton;
    btnOk: TButton;
    btnCancelar: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRotacionar: TfrmRotacionar;

implementation
uses
  Primeiro1;

{$R *.dfm}

procedure TfrmRotacionar.btnCancelarClick(Sender: TObject);
begin
  self.Close();
end;

procedure TfrmRotacionar.btnOkClick(Sender: TObject);
var
  principal: TPrincipal;
begin
  if (rbOrigem.Checked = true) then
  begin
    principal.rotacionar(StrToFloat(edGraus.Text));
  end;
  if(rbCentro.Checked = true) then
  begin
    principal.rotacionarPeloCentro(StrToFloat(edGraus.Text));
  end;
  if(rbPonto.Checked = true) then
  begin
    principal.rotacionarPorPonto(StrToFloat(edGraus.Text));
  end;
  btnCancelarClick(self);
end;

end.
