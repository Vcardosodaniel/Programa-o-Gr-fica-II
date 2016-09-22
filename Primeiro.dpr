program Primeiro;

uses
  Vcl.Forms,
  Primeiro1 in 'Primeiro1.pas' {Principal},
  CoordenadasQuadrado in 'CoordenadasQuadrado.pas' {frmCoordenadasQuadrado},
  CoordenadasTriangulo in 'CoordenadasTriangulo.pas' {frmTriangulo},
  CoordenadasLinhas in 'CoordenadasLinhas.pas' {frmLinha},
  CoordenadasPonto in 'CoordenadasPonto.pas' {frmPonto},
  Linha in 'Linha.pas',
  Ponto in 'Ponto.pas',
  Quadrado in 'Quadrado.pas',
  Triangulo in 'Triangulo.pas',
  Vetor in 'Vetor.pas',
  Rotacionar in 'Rotacionar.pas' {frmRotacionar},
  Escalonamento in 'Escalonamento.pas' {frmEscalonamento},
  Translacao in 'Translacao.pas' {frmTranslacao},
  Poligono in 'Poligono.pas',
  CoordenadasPoligono in 'CoordenadasPoligono.pas' {frmPoligono},
  Reflexao in 'Reflexao.pas' {frmReflexao},
  Cisalhamento in 'Cisalhamento.pas' {frmCisalhamento};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipal, Principal);
  Application.CreateForm(TfrmCisalhamento, frmCisalhamento);
  Application.Run;
end.
