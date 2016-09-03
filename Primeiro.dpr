program Primeiro;

uses
  Vcl.Forms,
  Primeiro1 in 'Primeiro1.pas' {Principal},
  CoordenadasQuadrado in 'CoordenadasQuadrado.pas' {frmCoordenadasQuadrado},
  CoordenadasTriangulo in 'CoordenadasTriangulo.pas' {frmTriangulo},
  CoordenadasLinhas in 'CoordenadasLinhas.pas' {frmLinha},
  CoordenadasPonto in 'CoordenadasPonto.pas' {frmPonto},
  Linha in 'Linha.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipal, Principal);
  Application.Run;
end.
