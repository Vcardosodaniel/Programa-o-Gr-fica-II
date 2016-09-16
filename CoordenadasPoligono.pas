unit CoordenadasPoligono;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Primeiro1, Poligono;

type
  TfrmPoligono = class(TForm)
    Principal: TPanel;
    gpPoligono: TGroupBox;
    lblPonto1: TLabel;
    lblPonto2: TLabel;
    lblPonto3: TLabel;
    lblPonto4: TLabel;
    lblPonto5: TLabel;
    lblPonto6: TLabel;
    lblPonto7: TLabel;
    lblPonto8: TLabel;
    lblPonto9: TLabel;
    lblPonto10: TLabel;
    lblXPonto1: TLabel;
    lblXPonto2: TLabel;
    lblXPonto3: TLabel;
    lblXPonto4: TLabel;
    lblXPonto5: TLabel;
    lblXPonto6: TLabel;
    lblXPonto7: TLabel;
    lblXPonto8: TLabel;
    lblXPonto9: TLabel;
    lblXPonto10: TLabel;
    edXPonto1: TEdit;
    edXPonto3: TEdit;
    edXPonto4: TEdit;
    edXPonto5: TEdit;
    esXPonto6: TEdit;
    edXPonto7: TEdit;
    edXPonto8: TEdit;
    edXPonto9: TEdit;
    edXPonto10: TEdit;
    edXPonto2: TEdit;
    edYPonto1: TEdit;
    edYPonto2: TEdit;
    edYPonto3: TEdit;
    edYPonto4: TEdit;
    edYPonto5: TEdit;
    edYPonto6: TEdit;
    edYPonto7: TEdit;
    edYPonto8: TEdit;
    edYPonto9: TEdit;
    edYPonto10: TEdit;
    btnOk: TButton;
    btnCancelar: TButton;
    lblYPonto1: TLabel;
    lblYPonto2: TLabel;
    lblYPonto3: TLabel;
    lblYPonto4: TLabel;
    lblYPonto5: TLabel;
    lblYPonto6: TLabel;
    lblYPonto7: TLabel;
    lblYPonto8: TLabel;
    lblYPonto9: TLabel;
    lblYPonto10: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPoligono: TfrmPoligono;

implementation

{$R *.dfm}

procedure TfrmPoligono.btnOkClick(Sender: TObject);
var
  Poligono: TPoligono;
  principal: TPrincipal;
begin
  Poligono.setP1X(StrToFloat(edXPonto1.Text));
  Poligono.setP1Y(StrToFloat(edYPonto1.Text));
  Poligono.setP2X(StrToFloat(edXPonto2.Text));
  Poligono.setP2Y(StrToFloat(edYPonto2.Text));
  Poligono.setP3X(StrToFloat(edXPonto3.Text));
  Poligono.setP3Y(StrToFloat(edYPonto3.Text));
  Poligono.setP4X(StrToFloat(edXPonto4.Text));
  Poligono.setP4Y(StrToFloat(edYPonto4.Text));
  Poligono.setP5X(StrToFloat(edXPonto5.Text));
  Poligono.setP5Y(StrToFloat(edYPonto5.Text));
  Poligono.setP6X(StrToFloat(esXPonto6.Text));
  Poligono.setP6Y(StrToFloat(edYPonto6.Text));
  Poligono.setP7X(StrToFloat(edXPonto7.Text));
  Poligono.setP7Y(StrToFloat(edYPonto7.Text));
  Poligono.setP8X(StrToFloat(edXPonto8.Text));
  Poligono.setP8Y(StrToFloat(edYPonto8.Text));
  Poligono.setP9X(StrToFloat(edXPonto9.Text));
  Poligono.setP9Y(StrToFloat(edYPonto9.Text));
  Poligono.setP10X(StrToFloat(edXPonto10.Text));
  Poligono.setP10Y(StrToFloat(edYPonto10.Text));
  principal.setDesenharPoligono(true);
  btnCancelarClick(self);
end;


procedure TfrmPoligono.btnCancelarClick(Sender: TObject);
begin
  Close();
end;

end.
