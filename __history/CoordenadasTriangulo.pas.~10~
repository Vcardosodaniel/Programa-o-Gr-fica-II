unit CoordenadasTriangulo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Primeiro1;

type
  TfrmTriangulo = class(TForm)
    painelPrincipal: TPanel;
    gbCoordenadas: TGroupBox;
    btnOK: TButton;
    btnCancel: TButton;
    lblPonto1: TLabel;
    lblPonto2: TLabel;
    lblPonto3: TLabel;
    edXPonto1: TEdit;
    edXPonto2: TEdit;
    edXPonto3: TEdit;
    edYPonto1: TEdit;
    edYPonto2: TEdit;
    edYPonto3: TEdit;
    lblYPonto1: TLabel;
    lblYPonto2: TLabel;
    lblYPonto3: TLabel;
    lblXPonto1: TLabel;
    lblXPonto2: TLabel;
    lblXPonto3: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTriangulo: TfrmTriangulo;

implementation

{$R *.dfm}

procedure TfrmTriangulo.btnCancelClick(Sender: TObject);
begin
  close();
end;

procedure TfrmTriangulo.btnOKClick(Sender: TObject);
var
  Principal: TPrincipal;
begin
  Principal.InicializaVariaveisTriangulo(true, StrToFloat(edXPonto1.Text), StrToFloat(edYPonto1.Text), StrToFloat(edXPonto2.Text),
                                               StrToFloat(edYPonto2.Text), StrToFloat(edXPonto3.Text), StrToFloat(edYPonto3.Text));
  btnCancelClick(self);
end;

end.
