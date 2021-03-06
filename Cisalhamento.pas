unit Cisalhamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmCisalhamento = class(TForm)
    Principal: TPanel;
    gbCisalhamento: TGroupBox;
    lblCisX: TLabel;
    lblCisY: TLabel;
    edCisX: TEdit;
    edCisY: TEdit;
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
  frmCisalhamento: TfrmCisalhamento;

implementation

uses
  Primeiro1;
{$R *.dfm}

procedure TfrmCisalhamento.btnCancelarClick(Sender: TObject);
begin
  close();
end;

procedure TfrmCisalhamento.btnOkClick(Sender: TObject);
var
  principal: TPrincipal;
begin
  principal.cisalhamento(StrToFloat(edCisX.Text), StrToFloat(edCisY.Text));
  btnCancelarClick(self);
end;

end.
