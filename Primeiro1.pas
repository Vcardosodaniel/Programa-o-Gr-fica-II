unit Primeiro1;

interface

uses
  OpenGL, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Math, Linha, Ponto, Quadrado, Triangulo, Vetor,
  Rotacionar, Escalonamento, Translacao, Poligono;

type
  TMatriz = array[0..2,0..2] of double;
  TPrincipal = class(TForm)
    btnTriangulo: TButton;
    btnQuadrado: TButton;
    btnLinha: TButton;
    btnCima: TButton;
    btnBaixo: TButton;
    btnEsquerda: TButton;
    btnDireita: TButton;
    btnPonto: TButton;
    btnZoomIn: TButton;
    btnZoomOut: TButton;
    btnRotacionar: TButton;
    btnEscalonamento: TButton;
    btnTranslacao: TButton;
    ListBox: TListBox;
    btnPoligono: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnTrianguloClick(Sender: TObject);
    procedure btnQuadradoClick(Sender: TObject);
    procedure btnLinhaClick(Sender: TObject);
    procedure btnCimaClick(Sender: TObject);
    procedure btnBaixoClick(Sender: TObject);
    procedure btnEsquerdaClick(Sender: TObject);
    procedure btnDireitaClick(Sender: TObject);
    procedure btnPontoClick(Sender: TObject);
    procedure btnZoomInClick(Sender: TObject);
    procedure btnZoomOutClick(Sender: TObject);
    procedure btnRotacionarClick(Sender: TObject);
    procedure btnEscalonamentoClick(Sender: TObject);
    procedure btnTranslacaoClick(Sender: TObject);
    procedure btnPoligonoClick(Sender: TObject);
  private
    procedure Draw; //Draws an OpenGL scene on request
    procedure DesenhaLinha();
    procedure DesenhaTriangulo();
    procedure DesenhaQuadrado();
    procedure DesenhaPoligono();
    procedure DesenhaPonto();
    procedure DesenhaLinhasDivisorias();
    function multiplicarVetorPorMatriz(ponto: TVetor; matriz: TMatriz):TVetor;
    function calculaCentro(somaX, somaY, numPontos: double):TVetor;

  public
    procedure rotacionar(graus: double);
    procedure rotacionarPeloCentro(graus: double);
    procedure rotacionarPorPonto(graus: double);
    procedure escalonar(escX, escY: double);
    procedure escalonamentoNatural(escX, escY: double);
    procedure translacao(tX, tY: double);
    procedure setDesenharLinha(desenhar: boolean);
    procedure setDesenharPonto(desenhar: boolean);
    procedure setDesenharQuadrado(desenhar: boolean);
    procedure setDesenharPoligono(desenhar: boolean);
    procedure setDesenharTriangulo(desenhar: boolean);

  end;

var
  Principal: TPrincipal;
  xViewPort, yViewPort, widthViewPort, heigthViewport: integer;

implementation

uses
  CoordenadasQuadrado, CoordenadasTriangulo, CoordenadasLinhas, CoordenadasPonto,
  CoordenadasPoligono;

var
  linha: TLinha;
  ponto: TPonto;
  quadrado: TQuadrado;
  triangulo: TTriangulo;
  poligono: TPoligono;

{$R *.DFM}

procedure setupPixelFormat(DC:HDC);
const
  pfd:TPIXELFORMATDESCRIPTOR = (
    nSize :           sizeof(TPIXELFORMATDESCRIPTOR);	                              // size
    nVersion :        1;                                                            // version
    dwFlags :         PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or PFD_DOUBLEBUFFER;	// support double-buffering
    iPixelType :      PFD_TYPE_RGBA;	                                              // color type
    cColorBits :      24;                                                           // preferred color depth
    cRedBits :        0; cRedShift:0;                                            	  // color bits (ignored)
    cGreenBits :      0; cGreenShift:0;
    cBlueBits :       0; cBlueShift:0;
    cAlphaBits :      0; cAlphaShift:0;                                             // no alpha buffer
    cAccumBits :      0;
    cAccumRedBits :   0;                                                            // no accumulation buffer,
    cAccumGreenBits : 0;                                                           	// accum bits (ignored)
    cAccumBlueBits :  0;
    cAccumAlphaBits : 0;
    cDepthBits :      16; 	                                                        // depth buffer
    cStencilBits :    0;	                                                          // no stencil buffer
    cAuxBuffers :     0; 	                                                          // no auxiliary buffers
    iLayerType :      PFD_MAIN_PLANE;                                               // main layer
    bReserved :       0;
    dwLayerMask :     0;
    dwVisibleMask :   0;
    dwDamageMask :    0;                                                            // no layer, visible, damage masks
  );
var pixelFormat:integer;
begin
   pixelFormat := ChoosePixelFormat(DC, @pfd);
   if (pixelFormat = 0) then
        exit;
   if (SetPixelFormat(DC, pixelFormat, @pfd) <> TRUE) then
        exit;
end;

procedure GLInit;
begin
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluOrtho2D(-50, 50, -50, 50);
  glMatrixMode(GL_MODELVIEW);
end;

procedure TPrincipal.FormCreate(Sender: TObject);
var
  DC:HDC;
  RC:HGLRC;
begin
  DC := GetDC(Handle);        //Actually, you can use any windowed control here
  SetupPixelFormat(DC);
  RC := wglCreateContext(DC); //makes OpenGL window out of DC
  wglMakeCurrent(DC, RC);   //makes OpenGL window active
  GLInit;                   //initialize OpenGL
  linha := TLinha.Create(self);
  ponto := TPonto.Create(self);
  quadrado := TQuadrado.Create(self);
  triangulo := TTriangulo.Create(self);
  xViewPort := 0;
  yViewPort := 0;
  widthViewPort := 600;
  heigthViewport := 600;
end;

procedure TPrincipal.Draw;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  glClearColor(1.0, 1.0, 1.0, 1.0);
  glLoadIdentity();
  glViewPort(xViewPort, yViewPort, widthViewPort, heigthViewport);
  DesenhaLinhasDivisorias();
  DesenhaLinha();
  DesenhaTriangulo();
  DesenhaQuadrado();
  DesenhaPonto();
  DesenhaPoligono();
  SwapBuffers(wglGetCurrentDC);
  glFlush();
end;

procedure TPrincipal.FormPaint(Sender: TObject);
begin
   Draw;
end;

function TPrincipal.multiplicarVetorPorMatriz(ponto: TVetor; matriz: TMatriz): TVetor;
var
  resultado: TVetor;
begin
  resultado[0] := (ponto[0]*matriz[0][0] + ponto[1]*matriz[1][0] + ponto[2]*matriz[2][0]);
  resultado[1] := (ponto[0]*matriz[0][1] + ponto[1]*matriz[1][1] + ponto[2]*matriz[2][1]);
  resultado[2] := 1;
  Result := resultado;
end;

procedure TPrincipal.rotacionar(graus: double);
var
  matrizRotacao: TMatriz;
  desenho: string;

  procedure rotacionarLinha();
  var
    pontoRotacionado: TVetor;
  begin
    pontoRotacionado := multiplicarVetorPorMatriz(linha.getP1, matrizRotacao);
    linha.setP1X(pontoRotacionado[0]);
    linha.setP1Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(linha.getP2, matrizRotacao);
    linha.setP2X(pontoRotacionado[0]);
    linha.setP2Y(pontoRotacionado[1]);
  end;

  procedure rotacionarPonto();
  var
    pontoRotacionado: TVetor;
  begin
    pontoRotacionado := multiplicarVetorPorMatriz(ponto.getP1, matrizRotacao);
    ponto.setP1X(pontoRotacionado[0]);
    ponto.setP1Y(pontoRotacionado[1]);
  end;

  procedure rotacionarTriangulo();
  var
    pontoRotacionado: TVetor;
  begin
    pontoRotacionado := multiplicarVetorPorMatriz(triangulo.getP1, matrizRotacao);
    triangulo.setP1X(pontoRotacionado[0]);
    triangulo.setP1Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(triangulo.getP2, matrizRotacao);
    triangulo.setP2X(pontoRotacionado[0]);
    triangulo.setP2Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(triangulo.getP3, matrizRotacao);
    triangulo.setP3X(pontoRotacionado[0]);
    triangulo.setP3Y(pontoRotacionado[1]);
  end;

  procedure rotacionarQuadrado();
  var
    pontoRotacionado: TVetor;
  begin
    pontoRotacionado := multiplicarVetorPorMatriz(quadrado.getP1, matrizRotacao);
    quadrado.setP1X(pontoRotacionado[0]);
    quadrado.setP1Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(quadrado.getP2, matrizRotacao);
    quadrado.setP2X(pontoRotacionado[0]);
    quadrado.setP2Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(quadrado.getP3, matrizRotacao);
    quadrado.setP3X(pontoRotacionado[0]);
    quadrado.setP3Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(quadrado.getP4, matrizRotacao);
    quadrado.setP4X(pontoRotacionado[0]);
    quadrado.setP4Y(pontoRotacionado[1]);
  end;

  procedure rotacionarPoligono();
  var
    pontoRotacionado: TVetor;
  begin
    pontoRotacionado := multiplicarVetorPorMatriz(poligono.getP1, matrizRotacao);
    poligono.setP1X(pontoRotacionado[0]);
    poligono.setP1Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(poligono.getP2, matrizRotacao);
    poligono.setP2X(pontoRotacionado[0]);
    poligono.setP2Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(poligono.getP3, matrizRotacao);
    poligono.setP3X(pontoRotacionado[0]);
    poligono.setP3Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(poligono.getP4, matrizRotacao);
    poligono.setP4X(pontoRotacionado[0]);
    poligono.setP4Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(poligono.getP5, matrizRotacao);
    poligono.setP5X(pontoRotacionado[0]);
    poligono.setP5Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(poligono.getP6, matrizRotacao);
    poligono.setP6X(pontoRotacionado[0]);
    poligono.setP6Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(poligono.getP7, matrizRotacao);
    poligono.setP7X(pontoRotacionado[0]);
    poligono.setP7Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(poligono.getP8, matrizRotacao);
    poligono.setP8X(pontoRotacionado[0]);
    poligono.setP8Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(poligono.getP9, matrizRotacao);
    poligono.setP9X(pontoRotacionado[0]);
    poligono.setP9Y(pontoRotacionado[1]);
    pontoRotacionado := multiplicarVetorPorMatriz(poligono.getP10, matrizRotacao);
    poligono.setP10X(pontoRotacionado[0]);
    poligono.setP10Y(pontoRotacionado[1]);
  end;

  procedure zeraMatriz();
  begin
    matrizRotacao[0][0] := cos(DegToRad(graus));
    matrizRotacao[0][1] := sin(DegToRad(graus));
    matrizRotacao[0][2] := 0;
    matrizRotacao[1][0] := -sin(DegToRad(graus));
    matrizRotacao[1][1] := cos(DegToRad(graus));
    matrizRotacao[1][2] := 0;
    matrizRotacao[2][0] := 0;
    matrizRotacao[2][1] := 0;
    matrizRotacao[2][2] := 1;
  end;

begin
  zeraMatriz();
  desenho := Principal.ListBox.Items.Strings[Principal.ListBox.ItemIndex];
  if (desenho = 'Linha') then
  begin
    rotacionarLinha();
  end;
  if (desenho = 'Ponto') then
  begin
    rotacionarPonto();
  end;
  if (desenho = 'Triangulo') then
  begin
    rotacionarTriangulo();
  end;
  if (desenho = 'Quadrado') then
  begin
    rotacionarQuadrado();
  end;
  if (desenho = 'Poligono') then
  begin
    rotacionarPoligono();
  end;
end;

procedure TPrincipal.rotacionarPeloCentro(graus: double);
var
  desenho: string;
  procedure rotacionarPeloCentroLinha();
  const
    NUMERO_PONTOS_LINHA = 2;
  var
    pontoResultado: TVetor;
    somaXlinha, somaYlinha: double;
  begin
    somaXlinha := linha.getXP1 + linha.getXP2;
    somaYlinha := linha.getYP1 + linha.getYP2;
    pontoResultado := calculaCentro(somaXlinha, somaYlinha, NUMERO_PONTOS_LINHA);
    translacao(-pontoResultado[0], -pontoResultado[1]);
    rotacionar(graus);
    translacao(pontoResultado[0], pontoResultado[1]);
  end;

  procedure rotacionarPeloCentroPonto();
  const
    NUMERO_PONTOS_PONTO = 1;
  var
    pontoResultadoPonto: TVetor;
    somaXPonto, somaYPonto: double;
  begin
    somaXPonto := ponto.getXP1;
    somaYPonto := ponto.getYP1;
    pontoResultadoPonto := calculaCentro(somaXPonto, somaYPonto, NUMERO_PONTOS_PONTO);
    translacao(-(pontoResultadoPonto[0]), -(pontoResultadoPonto[1]));
    rotacionar(graus);
    translacao(pontoResultadoPonto[0], pontoResultadoPonto[1]);
  end;

  procedure rotacionarPeloCentroTriangulo();
  const
    NUMERO_PONTOS_TRIANGULO = 3;
  var
    pontoResultadoTriangulo: TVetor;
    somaXTriangulo, somaYTriangulo: double;
  begin
    somaXTriangulo := triangulo.getXP1 + triangulo.getXP2 + triangulo.getXP3;
    somaYTriangulo := triangulo.getYP1 + triangulo.getYP2 + triangulo.getYP3;
    pontoResultadoTriangulo := calculaCentro(somaXTriangulo, somaYTriangulo, NUMERO_PONTOS_TRIANGULO);
    translacao(-(pontoResultadoTriangulo[0]), -(pontoResultadoTriangulo[1]));
    rotacionar(graus);
    translacao(pontoResultadoTriangulo[0], pontoResultadoTriangulo[1]);
  end;

  procedure rotacionarPeloCentroQuadrado();
  const
    NUMERO_PONTOS_QUADRADO = 4;
  var
    pontoResultadoQuadrado: TVetor;
    somaXQuadrado, somaYQuadrado: double;
  begin
    somaXQuadrado := quadrado.getXP1 + quadrado.getXP2 + quadrado.getXP3 + quadrado.getXP4;
    somaYQuadrado := quadrado.getYP1 + quadrado.getYP2 + quadrado.getYP3 + quadrado.getYP4;
    pontoResultadoQuadrado := calculaCentro(somaXQuadrado, somaYQuadrado, NUMERO_PONTOS_QUADRADO);
    translacao(-(pontoResultadoQuadrado[0]), -(pontoResultadoQuadrado[1]));
    rotacionar(graus);
    translacao(pontoResultadoQuadrado[0], pontoResultadoQuadrado[1]);
  end;

  procedure rotacionarPeloCentroPoligono();
  const
    NUMERO_PONTOS_POLIGONO = 4;
  var
    pontoResultadoPoligono: TVetor;
    somaXPoligono, somaYPoligono: double;
  begin
    somaXPoligono := poligono.getXP1 + poligono.getXP2 + poligono.getXP3 + poligono.getXP4 + poligono.getXP5
                   + poligono.getXP6 + poligono.getXP7 + poligono.getXP8 + poligono.getXP9 + poligono.getXP10;
    somaYPoligono := poligono.getYP1 + poligono.getYP2 + poligono.getYP3 + poligono.getYP4 + poligono.getYP5
                   + poligono.getYP6 + poligono.getYP7 + poligono.getYP8 + poligono.getYP10 + poligono.getYP10;
    pontoResultadoPoligono := calculaCentro(somaXPoligono, somaYPoligono, NUMERO_PONTOS_POLIGONO);
    translacao(-(pontoResultadoPoligono[0]), -(pontoResultadoPoligono[1]));
    rotacionar(graus);
    translacao(pontoResultadoPoligono[0], pontoResultadoPoligono[1]);
  end;

begin
  desenho := Principal.ListBox.Items.Strings[Principal.ListBox.ItemIndex];
  if (desenho = 'Linha') then
  begin
    rotacionarPeloCentroLinha();
  end;

  if (desenho = 'Quadrado') then
  begin
    rotacionarPeloCentroQuadrado();
  end;

  if (desenho = 'Ponto') then
  begin
    rotacionarPeloCentroPonto();
  end;

  if (desenho = 'Triangulo') then
  begin
    rotacionarPeloCentroTriangulo();
  end;

  if (desenho = 'Poligono') then
  begin
    rotacionarPeloCentroPoligono();
  end;
end;


procedure TPrincipal.rotacionarPorPonto(graus: double);
var
  matrizEscalonamento: TMatriz;
  desenho: string;
  procedure rotacionarPorPontoLinha();
  var
    x, y: double;
  begin
    x := linha.getXP1;
    y := linha.getYP1;
    translacao(-x, -y);
    rotacionar(graus);
    translacao(x, y);
  end;

  procedure rotacionarPorPontoPonto();
  var
    x, y: double;
  begin
    x := ponto.getXP1;
    y := ponto.getYP1;
    translacao(-x, -y);
    rotacionar(graus);
    translacao(x, y);
  end;

  procedure rotacionarPorPontoTriangulo();
  var
    x, y: double;
  begin
    x := triangulo.getXP1;
    y := triangulo.getYP1;
    translacao(-x, -y);
    rotacionar(graus);
    translacao(x, y);
  end;

  procedure rotacionarPorPontoQuadrado();
  var
    x, y: double;
  begin
    x := quadrado.getXP1;
    y := quadrado.getYP1;
    translacao(-x, -y);
    rotacionar(graus);
    translacao(x, y);
  end;

  procedure rotacionarPorPontoPoligono();
  var
    x, y: double;
  begin
    x := poligono.getXP1;
    y := poligono.getYP1;
    translacao(-x, -y);
    rotacionar(graus);
    translacao(x, y);
  end;

begin
  desenho := Principal.ListBox.Items.Strings[Principal.ListBox.ItemIndex];
  if ( desenho = 'Linha') then
  begin
    rotacionarPorPontoLinha();
  end;

  if (desenho = 'Quadrado') then
  begin
    rotacionarPorPontoQuadrado();
  end;

  if (desenho = 'Ponto') then
  begin
    rotacionarPorPontoPonto();
  end;

  if (desenho = 'Triangulo') then
  begin
    rotacionarPorPontoTriangulo();
  end;

  if (desenho = 'Poligono') then
  begin
    rotacionarPorPontoPoligono();
  end;
end;

procedure TPrincipal.setDesenharLinha(desenhar: boolean);
begin
  Principal.ListBox.Items.Add('Linha');
end;

procedure TPrincipal.setDesenharPoligono(desenhar: boolean);
begin
  Principal.ListBox.Items.Add('Poligono');
end;

procedure TPrincipal.setDesenharPonto(desenhar: boolean);
begin
  Principal.ListBox.Items.Add('Ponto');
end;

procedure TPrincipal.setDesenharQuadrado(desenhar: boolean);
begin
  Principal.ListBox.Items.Add('Quadrado');
end;

procedure TPrincipal.setDesenharTriangulo(desenhar: boolean);
begin
  Principal.ListBox.Items.Add('Triangulo');
end;

procedure TPrincipal.escalonamentoNatural(escX, escY: double);
var
  matrizEscalonamento: TMatriz;
  desenho: string;

  procedure escalonarLinha();
  const
    NUMERO_PONTOS_LINHA = 2;
  var
    pontoResultado: TVetor;
    somaXlinha, somaYlinha: double;
  begin
    somaXlinha := linha.getXP1 + linha.getXP2;
    somaYlinha := linha.getYP1 + linha.getYP2;
    pontoResultado := calculaCentro(somaXlinha, somaYlinha, NUMERO_PONTOS_LINHA);
    translacao(-pontoResultado[0], -pontoResultado[1]);
    escalonar(escX, escY);
    translacao(pontoResultado[0], pontoResultado[1]);
  end;

  procedure escalonarPonto();
  const
    NUMERO_PONTOS_PONTO = 1;
  var
    pontoResultadoPonto: TVetor;
    somaXPonto, somaYPonto: double;
  begin
    somaXPonto := ponto.getXP1;
    somaYPonto := ponto.getYP1;
    pontoResultadoPonto := calculaCentro(somaXPonto, somaYPonto, NUMERO_PONTOS_PONTO);
    translacao(-(pontoResultadoPonto[0]), -(pontoResultadoPonto[1]));
    escalonar(escX, escY);
    translacao(pontoResultadoPonto[0], pontoResultadoPonto[1]);
  end;

  procedure escalonarTriangulo();
  const
    NUMERO_PONTOS_TRIANGULO = 3;
  var
    pontoResultadoTriangulo: TVetor;
    somaXTriangulo, somaYTriangulo: double;
  begin
    somaXTriangulo := triangulo.getXP1 + triangulo.getXP2 + triangulo.getXP3;
    somaYTriangulo := triangulo.getYP1 + triangulo.getYP2 + triangulo.getYP3;
    pontoResultadoTriangulo := calculaCentro(somaXTriangulo, somaYTriangulo, NUMERO_PONTOS_TRIANGULO);
    translacao(-(pontoResultadoTriangulo[0]), -(pontoResultadoTriangulo[1]));
    escalonar(escX, escY);
    translacao(pontoResultadoTriangulo[0], pontoResultadoTriangulo[1]);
  end;

  procedure escalonarQuadrado();
  const
    NUMERO_PONTOS_QUADRADO = 4;
  var
    pontoResultadoQuadrado: TVetor;
    somaXQuadrado, somaYQuadrado: double;
  begin
    somaXQuadrado := quadrado.getXP1 + quadrado.getXP2 + quadrado.getXP3 + quadrado.getXP4;
    somaYQuadrado := quadrado.getYP1 + quadrado.getYP2 + quadrado.getYP3 + quadrado.getYP4;
    pontoResultadoQuadrado := calculaCentro(somaXQuadrado, somaYQuadrado, NUMERO_PONTOS_QUADRADO);
    translacao(-(pontoResultadoQuadrado[0]), -(pontoResultadoQuadrado[1]));
    escalonar(escX, escY);
    translacao(pontoResultadoQuadrado[0], pontoResultadoQuadrado[1]);
  end;

  procedure escalonarPoligono();
  const
    NUMERO_PONTOS_POLIGONO = 10;
  var
    pontoResultadoPoligono: TVetor;
    somaXPoligono, somaYPoligono: double;
  begin
    somaXPoligono := quadrado.getXP1 + quadrado.getXP2 + quadrado.getXP3 + quadrado.getXP4;
    somaYPoligono := quadrado.getYP1 + quadrado.getYP2 + quadrado.getYP3 + quadrado.getYP4;
    pontoResultadoPoligono := calculaCentro(somaXPoligono, somaYPoligono, NUMERO_PONTOS_POLIGONO);
    translacao(-(pontoResultadoPoligono[0]), -(pontoResultadoPoligono[1]));
    escalonar(escX, escY);
    translacao(pontoResultadoPoligono[0], pontoResultadoPoligono[1]);
  end;

begin
  desenho := Principal.ListBox.Items.Strings[Principal.ListBox.ItemIndex];
  if (desenho = 'Linha') then
  begin
    escalonarLinha();
  end;

  if (desenho = 'Quadrado') then
  begin
    escalonarQuadrado();
  end;

  if (desenho = 'Ponto') then
  begin
    escalonarPonto();
  end;

  if (desenho = 'Triangulo') then
  begin
    escalonarTriangulo();
  end;

  if (desenho = 'Poligono') then
  begin
    escalonarPoligono();
  end;
end;


procedure TPrincipal.escalonar(escX, escY: double);
var
  matrizEscalonamento: TMatriz;
  desenho: string;

  procedure escalonarLinha();
  var
    pontoEscalonado: TVetor;
  begin
    pontoEscalonado := multiplicarVetorPorMatriz(linha.getP1, matrizEscalonamento);
    linha.setP1X(pontoEscalonado[0]);
    linha.setP1Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(linha.getP2, matrizEscalonamento);
    linha.setP2X(pontoEscalonado[0]);
    linha.setP2Y(pontoEscalonado[1]);
  end;

  procedure escalonarPonto();
  var
    pontoEscalonado: TVetor;
  begin
    pontoEscalonado := multiplicarVetorPorMatriz(ponto.getP1, matrizEscalonamento);
    ponto.setP1X(pontoEscalonado[0]);
    ponto.setP1Y(pontoEscalonado[1]);
  end;

  procedure escalonarTriangulo();
  var
    pontoEscalonado: TVetor;
  begin
    pontoEscalonado := multiplicarVetorPorMatriz(triangulo.getP1, matrizEscalonamento);
    triangulo.setP1X(pontoEscalonado[0]);
    triangulo.setP1Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(triangulo.getP2, matrizEscalonamento);
    triangulo.setP2X(pontoEscalonado[0]);
    triangulo.setP2Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(triangulo.getP3, matrizEscalonamento);
    triangulo.setP3X(pontoEscalonado[0]);
    triangulo.setP3Y(pontoEscalonado[1]);
  end;

  procedure escalonarQuadrado();
  var
    pontoEscalonado: TVetor;
  begin
    pontoEscalonado := multiplicarVetorPorMatriz(quadrado.getP1, matrizEscalonamento);
    quadrado.setP1X(pontoEscalonado[0]);
    quadrado.setP1Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(quadrado.getP2, matrizEscalonamento);
    quadrado.setP2X(pontoEscalonado[0]);
    quadrado.setP2Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(quadrado.getP3, matrizEscalonamento);
    quadrado.setP3X(pontoEscalonado[0]);
    quadrado.setP3Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(quadrado.getP4, matrizEscalonamento);
    quadrado.setP4X(pontoEscalonado[0]);
    quadrado.setP4Y(pontoEscalonado[1]);
  end;

  procedure escalonarPoligono();
  var
    pontoEscalonado: TVetor;
  begin
    pontoEscalonado := multiplicarVetorPorMatriz(poligono.getP1, matrizEscalonamento);
    poligono.setP1X(pontoEscalonado[0]);
    poligono.setP1Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(poligono.getP2, matrizEscalonamento);
    poligono.setP2X(pontoEscalonado[0]);
    poligono.setP2Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(poligono.getP3, matrizEscalonamento);
    poligono.setP3X(pontoEscalonado[0]);
    poligono.setP3Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(poligono.getP4, matrizEscalonamento);
    poligono.setP4X(pontoEscalonado[0]);
    poligono.setP4Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(poligono.getP5, matrizEscalonamento);
    poligono.setP5X(pontoEscalonado[0]);
    poligono.setP5Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(poligono.getP6, matrizEscalonamento);
    poligono.setP6X(pontoEscalonado[0]);
    poligono.setP6Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(poligono.getP7, matrizEscalonamento);
    poligono.setP7X(pontoEscalonado[0]);
    poligono.setP7Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(poligono.getP8, matrizEscalonamento);
    poligono.setP8X(pontoEscalonado[0]);
    poligono.setP8Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(poligono.getP9, matrizEscalonamento);
    poligono.setP9X(pontoEscalonado[0]);
    poligono.setP9Y(pontoEscalonado[1]);
    pontoEscalonado := multiplicarVetorPorMatriz(poligono.getP10, matrizEscalonamento);
    poligono.setP10X(pontoEscalonado[0]);
    poligono.setP10Y(pontoEscalonado[1]);
  end;

  procedure zeraMatriz();
  begin
    matrizEscalonamento[0][0] := escX;
    matrizEscalonamento[0][1] := 0;
    matrizEscalonamento[0][2] := 0;
    matrizEscalonamento[1][0] := 0;
    matrizEscalonamento[1][1] := escY;
    matrizEscalonamento[1][2] := 0;
    matrizEscalonamento[2][0] := 0;
    matrizEscalonamento[2][1] := 0;
    matrizEscalonamento[2][2] := 1;
  end;

begin
  zeraMatriz();
  desenho := Principal.ListBox.Items.Strings[Principal.ListBox.ItemIndex];
  if (desenho = 'Linha') then
  begin
    escalonarLinha();
  end;
  if (desenho = 'Ponto') then
  begin
    escalonarPonto();
  end;
  if (desenho = 'Triangulo') then
  begin
    escalonarTriangulo();
  end;
  if (desenho = 'Quadrado') then
  begin
    escalonarQuadrado();
  end;
  if (desenho = 'Poligono') then
  begin
    escalonarPoligono();
  end;
end;

procedure TPrincipal.translacao(tX: Double; tY: Double);
var
  matrizTranslacao: TMatriz;
  desenho: string;

  procedure translacaoLinha();
  var
    pontoResultado: TVetor;
  begin
    pontoResultado := multiplicarVetorPorMatriz(linha.getP1, matrizTranslacao);
    linha.setP1X(pontoResultado[0]);
    linha.setP1Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(linha.getP2, matrizTranslacao);
    linha.setP2X(pontoResultado[0]);
    linha.setP2Y(pontoResultado[1]);
  end;

  procedure translacaoPonto();
  var
    pontoResultado: TVetor;
  begin
    pontoResultado := multiplicarVetorPorMatriz(ponto.getP1, matrizTranslacao);
    ponto.setP1X(pontoResultado[0]);
    ponto.setP1Y(pontoResultado[1]);
  end;

  procedure translacaoTriangulo();
  var
    pontoResultado: TVetor;
  begin
    pontoResultado := multiplicarVetorPorMatriz(triangulo.getP1, matrizTranslacao);
    triangulo.setP1X(pontoResultado[0]);
    triangulo.setP1Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(triangulo.getP2, matrizTranslacao);
    triangulo.setP2X(pontoResultado[0]);
    triangulo.setP2Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(triangulo.getP3, matrizTranslacao);
    triangulo.setP3X(pontoResultado[0]);
    triangulo.setP3Y(pontoResultado[1]);
  end;

  procedure translacaoQuadrado();
  var
    pontoResultado: TVetor;
  begin
    pontoResultado := multiplicarVetorPorMatriz(quadrado.getP1, matrizTranslacao);
    quadrado.setP1X(pontoResultado[0]);
    quadrado.setP1Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(quadrado.getP2, matrizTranslacao);
    quadrado.setP2X(pontoResultado[0]);
    quadrado.setP2Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(quadrado.getP3, matrizTranslacao);
    quadrado.setP3X(pontoResultado[0]);
    quadrado.setP3Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(quadrado.getP4, matrizTranslacao);
    quadrado.setP4X(pontoResultado[0]);
    quadrado.setP4Y(pontoResultado[1]);
  end;

  procedure translacaoPoligono();
  var
    pontoResultado: TVetor;
  begin
    pontoResultado := multiplicarVetorPorMatriz(poligono.getP1, matrizTranslacao);
    poligono.setP1X(pontoResultado[0]);
    poligono.setP1Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(poligono.getP2, matrizTranslacao);
    poligono.setP2X(pontoResultado[0]);
    poligono.setP2Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(poligono.getP3, matrizTranslacao);
    poligono.setP3X(pontoResultado[0]);
    poligono.setP3Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(poligono.getP4, matrizTranslacao);
    poligono.setP4X(pontoResultado[0]);
    poligono.setP4Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(poligono.getP5, matrizTranslacao);
    poligono.setP5X(pontoResultado[0]);
    poligono.setP5Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(poligono.getP6, matrizTranslacao);
    poligono.setP6X(pontoResultado[0]);
    poligono.setP6Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(poligono.getP7, matrizTranslacao);
    poligono.setP7X(pontoResultado[0]);
    poligono.setP7Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(poligono.getP8, matrizTranslacao);
    poligono.setP8X(pontoResultado[0]);
    poligono.setP8Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(poligono.getP9, matrizTranslacao);
    poligono.setP9X(pontoResultado[0]);
    poligono.setP9Y(pontoResultado[1]);
    pontoResultado := multiplicarVetorPorMatriz(poligono.getP10, matrizTranslacao);
    poligono.setP10X(pontoResultado[0]);
    poligono.setP10Y(pontoResultado[1]);
  end;

  procedure zeraMatriz();
  begin
    matrizTranslacao[0][0] := 1;
    matrizTranslacao[0][1] := 0;
    matrizTranslacao[0][2] := 0;
    matrizTranslacao[1][0] := 0;
    matrizTranslacao[1][1] := 1;
    matrizTranslacao[1][2] := 0;
    matrizTranslacao[2][0] := tX;
    matrizTranslacao[2][1] := tY;
    matrizTranslacao[2][2] := 1;
  end;

begin
  zeraMatriz();
  desenho := Principal.ListBox.Items.Strings[Principal.ListBox.ItemIndex];
  if (desenho = 'Linha') then
  begin
    translacaoLinha();
  end;
  if (desenho = 'Ponto') then
  begin
    translacaoPonto();
  end;
  if (desenho = 'Quadrado') then
  begin
    translacaoQuadrado();
  end;
  if (desenho = 'Triangulo') then
  begin
    translacaoTriangulo();
  end;
  if (desenho = 'Poligono') then
  begin
    translacaoPoligono();
  end;
end;

procedure TPrincipal.btnBaixoClick(Sender: TObject);
begin
  yViewPort := yViewPort - 2;
  heigthViewport := heigthViewport - 2;
end;

procedure TPrincipal.btnCimaClick(Sender: TObject);
begin
  yViewPort := yViewPort + 2;
  heigthViewport := heigthViewport + 2;
end;

procedure TPrincipal.btnDireitaClick(Sender: TObject);
begin
  xViewPort := xViewPort + 2;
  widthViewport := widthViewport + 2;
end;

procedure TPrincipal.btnEsquerdaClick(Sender: TObject);
begin
  xViewPort := xViewPort - 2;
  widthViewport := widthViewport - 2;
end;

procedure TPrincipal.btnZoomInClick(Sender: TObject);
begin
  xViewport := xViewport - 2;
  widthViewport := widthViewport + 4;
  yViewport := yViewport - 2;
  heigthViewport := heigthViewport + 4;
end;

procedure TPrincipal.btnZoomOutClick(Sender: TObject);
begin
  xViewport := xViewport + 2;
  widthViewport := widthViewport - 4;
  yViewport := yViewport + 2;
  heigthViewport := heigthViewport - 4;
end;

function TPrincipal.calculaCentro(somaX, somaY, numPontos: double): TVetor;
var
  pontoResultado: TVetor;
begin
  pontoResultado[0] := somaX / numPontos;
  pontoResultado[1] := somaY / numPontos;
  pontoResultado[2] := 1;
  Result := pontoResultado;
end;

procedure TPrincipal.btnEscalonamentoClick(Sender: TObject);
var
  escalonamento: TfrmEscalonamento;
begin
  escalonamento := TfrmEscalonamento.Create(self);
  escalonamento.ShowModal();
end;

procedure TPrincipal.btnTranslacaoClick(Sender: TObject);
var
  translacao: TfrmTranslacao;
begin
  translacao := TfrmTranslacao.Create(self);
  translacao.ShowModal();
end;

procedure TPrincipal.btnTrianguloClick(Sender: TObject);
var
  coordenadasTriangulo: TfrmTriangulo;
begin
  coordenadasTriangulo := TfrmTriangulo.Create(self);
  coordenadasTriangulo.showModal();
end;

procedure TPrincipal.btnLinhaClick(Sender: TObject);
var
  coordenadasLinha: TfrmLinha;
begin
  coordenadasLinha := TfrmLinha.Create(self);
  coordenadasLinha.showModal();
end;

procedure TPrincipal.btnPoligonoClick(Sender: TObject);
var
  coordenadasPoligono: TfrmPoligono;
begin
  coordenadasPoligono := TfrmPoligono.Create(self);
  coordenadasPoligono.showModal();
end;

procedure TPrincipal.btnPontoClick(Sender: TObject);
var
  coordenadasPonto: TfrmPonto;
begin
  coordenadasPonto := TfrmPonto.Create(self);
  coordenadasPonto.showModal();
end;

procedure TPrincipal.btnQuadradoClick(Sender: TObject);
var
  coordenadasQuadrado: TfrmCoordenadasQuadrado;
begin
  coordenadasQuadrado := TfrmCoordenadasQuadrado.Create(self);
  coordenadasQuadrado.showModal();
end;

procedure TPrincipal.btnRotacionarClick(Sender: TObject);
var
  grausRotacao: TfrmRotacionar;
begin
  grausRotacao := TfrmRotacionar.Create(self);
  grausRotacao.showModal();
end;


procedure TPrincipal.DesenhaLinhasDivisorias();
begin
  glColor3f(0.0, 0.0, 0.0);
  glBegin(GL_LINES);
    glVertex2f(0, -40);
    glVertex2f(0, 40);

    glVertex2f(-40, 0);
    glVertex2f(40, 0);

    glVertex2f(-40, 40);
    glVertex2f(40, 40);

    glVertex2f(-40, -40);
    glVertex2f(40, -40);

    glVertex2f(-40, -40);
    glVertex2f(-40, 40);

    glVertex2f(40, 40);
    glVertex2f(40, -40);
  glEnd();
end;

procedure TPrincipal.DesenhaLinha();
begin
  glColor3f(1.0, 1.0, 0.0);
  glLineWidth(10);
  glBegin(GL_LINES);
    glVertex2f(Linha.getXP1, Linha.getYP1);
    glVertex2f(Linha.getXP2, Linha.getYP2);
  glEnd();
  glLineWidth(1);
end;

procedure TPrincipal.DesenhaPoligono();
begin
  glColor3f(1.0, 0.0, 0.5);
  glBegin(GL_LINE_LOOP);
    glVertex2f(Poligono.getXP1, Poligono.getYP1);
    glVertex2f(Poligono.getXP2, Poligono.getYP2);
    glVertex2f(Poligono.getXP3, Poligono.getYP3);
    glVertex2f(Poligono.getXP4, Poligono.getYP4);
    glVertex2f(Poligono.getXP5, Poligono.getYP5);
    glVertex2f(Poligono.getXP6, Poligono.getYP6);
    glVertex2f(Poligono.getXP7, Poligono.getYP7);
    glVertex2f(Poligono.getXP8, Poligono.getYP8);
    glVertex2f(Poligono.getXP9, Poligono.getYP9);
    glVertex2f(Poligono.getXP10, Poligono.getYP10);
  glEnd();
end;

procedure TPrincipal.DesenhaPonto;
begin
  glPointSize(5);
  glBegin(GL_POINTS);
    glVertex2f(Ponto.getXP1, Ponto.getYP1);
  glEnd();
end;

procedure TPrincipal.DesenhaTriangulo();
begin
  glColor3f(1.0, 0.0, 1.0);
  glBegin(GL_LINE_LOOP);
    glVertex2f(Triangulo.getXP1, Triangulo.getYP1);
    glVertex2f(Triangulo.getXP2, Triangulo.getYP2);
    glVertex2f(Triangulo.getXP3, Triangulo.getYP3);
  glEnd();
end;

procedure TPrincipal.DesenhaQuadrado();
begin
  glColor3f(1.0, 0.0, 0.0);
  glBegin(GL_LINE_LOOP);
    glVertex2f(Quadrado.getXP1, Quadrado.getYP1);
    glVertex2f(Quadrado.getXP2, Quadrado.getYP2);
    glVertex2f(Quadrado.getXP3, Quadrado.getYP3);
    glVertex2f(Quadrado.getXP4, Quadrado.getYP4);
  glEnd();
end;

end.
