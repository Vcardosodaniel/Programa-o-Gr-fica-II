program Primeiro;

uses
  Vcl.Forms,
  Primeiro1 in 'Primeiro1.pas' {Principal},
  CoordenadasQuadrado in 'CoordenadasQuadrado.pas' {frmCoordenadasQuadrado},
  CoordenadasTriangulo in 'CoordenadasTriangulo.pas' {frmTriangulo},
  CoordenadasLinhas in 'CoordenadasLinhas.pas' {frmLinha};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipal, Principal);
  Application.CreateForm(TfrmCoordenadasQuadrado, frmCoordenadasQuadrado);
  Application.CreateForm(TfrmTriangulo, frmTriangulo);
  Application.CreateForm(TfrmLinha, frmLinha);
  Application.Run;
end.
