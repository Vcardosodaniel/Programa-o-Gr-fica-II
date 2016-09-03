unit frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Primeiro1, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFramePrincipal = class(TForm)
    btnTriangulo: TButton;
    btnQuadrado: TButton;
    btnLinha: TButton;
    btnPonto: TButton;
    btnCima: TButton;
    btnBaixo: TButton;
    btnDireita: TButton;
    btnEsquerda: TButton;
    btnZoomIn: TButton;
    btnZoomOut: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnBaixoClick(Sender: TObject);
    procedure btnCimaClick(Sender: TObject);
    procedure btnDireitaClick(Sender: TObject);
    procedure btnEsquerdaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FramePrincipal: TFramePrincipal;

implementation

{$R *.dfm}

procedure TFramePrincipal.btnBaixoClick(Sender: TObject);
var
  Viewport: TPrincipal;
begin
  Viewport.moverParaBaixo();
end;

procedure TFramePrincipal.btnCimaClick(Sender: TObject);
var
  Viewport: TPrincipal;
begin
  Viewport.moverParaCima();
end;

procedure TFramePrincipal.btnDireitaClick(Sender: TObject);
var
  Viewport: TPrincipal;
begin
  Viewport.moverParaDireita();
end;

procedure TFramePrincipal.btnEsquerdaClick(Sender: TObject);
var
  Viewport: TPrincipal;
begin
  Viewport.moverParaEsquerda();
end;

procedure TFramePrincipal.FormShow(Sender: TObject);
var
  Principal: TPrincipal;
begin
    Principal := TPrincipal.Create(self);
end;

end.

