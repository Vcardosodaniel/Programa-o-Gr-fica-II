unit Reflexao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmReflexao = class(TForm)
    Principal: TPanel;
    gpReflexao: TGroupBox;
    rbReflexaoX: TRadioButton;
    rbReflexaoY: TRadioButton;
    rbReflexaoOrigem: TRadioButton;
    btnOk: TButton;
    btnCancelar: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReflexao: TfrmReflexao;

implementation

uses
  Primeiro1;

{$R *.dfm}

procedure TfrmReflexao.btnCancelarClick(Sender: TObject);
begin
  close();
end;

procedure TfrmReflexao.btnOkClick(Sender: TObject);
var
  principal: TPrincipal;
begin
  if(rbReflexaoX.Checked = true) then
  begin
    principal.reflexao('x');
  end;

  if(rbReflexaoY.Checked = true) then
  begin
    principal.reflexao('y');
  end;

  if(rbReflexaoOrigem.Checked = true) then
  begin
    principal.reflexao('origem');
  end;

  btnCancelarClick(self);

end;

end.
