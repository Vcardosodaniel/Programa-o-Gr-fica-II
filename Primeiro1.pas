unit Primeiro1;

interface

uses
  OpenGL, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Math, Linha, Ponto, Quadrado, Triangulo, Vetor, 
  Rotacionar, Escalonamento, Translacao;

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
  private
    procedure Draw; //Draws an OpenGL scene on request
    procedure DesenhaLinha();
    procedure DesenhaTriangulo();
    procedure DesenhaQuadrado();
    procedure DesenhaPonto();
    procedure DesenhaLinhasDivisorias();
    function multiplicarVetorPorMatriz(ponto: TVetor; matriz: TMatriz):TVetor;
    function calculaCentro(somaX, somaY, numPontos: double):TVetor;

  public
    procedure rotacionar(graus: double);
    procedure escalonar(escX, escY: double);
    procedure escalonamentoNatural(escX, escY: double);
    procedure translacao(tX, tY: double);
    procedure setDesenharLinha(desenhar: boolean);
    procedure setDesenharPonto(desenhar: boolean);
    procedure setDesenharQuadrado(desenhar: boolean);
    procedure setDesenharTriangulo(desenhar: boolean);

  end;

var
  Principal: TPrincipal;
  desenharLinha, desenharQuadrado, desenharTriangulo, desenharPonto: boolean;

implementation

uses
  CoordenadasQuadrado, CoordenadasTriangulo, CoordenadasLinhas, CoordenadasPonto;

var
  linha: TLinha;
  ponto: TPonto;
  quadrado: TQuadrado;
  triangulo: TTriangulo;
  zoom: double;

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
  gluOrtho2D(-30, 30, -30, 30);
  glMatrixMode(GL_MODELVIEW);
end;

function TPrincipal.multiplicarVetorPorMatriz(ponto: TVetor; matriz: TMatriz): TVetor;
var
  resultado: TVetor;
begin
  resultado[0] := (ponto[0]*matriz[0][0] + ponto[1]*matriz[1][0] + ponto[2]*matriz[2][0]);
  resultado[1] := (ponto[0]*matriz[0][1] + ponto[1]*matriz[1][1] + ponto[2]*matriz[2][1]);
  Result := resultado;
end;

procedure TPrincipal.rotacionar(graus: double);
var
  matrizRotacao: TMatriz;

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
  rotacionarLinha();
  rotacionarPonto();
  rotacionarTriangulo();
  rotacionarQuadrado();
end;

procedure TPrincipal.setDesenharLinha(desenhar: boolean);
begin
  desenharLinha := desenhar;
end;

procedure TPrincipal.setDesenharPonto(desenhar: boolean);
begin
  desenharPonto := desenhar;
end;

procedure TPrincipal.setDesenharQuadrado(desenhar: boolean);
begin
  desenharQuadrado := desenhar;
end;

procedure TPrincipal.setDesenharTriangulo(desenhar: boolean);
begin
  desenharTriangulo := desenhar;
end;

procedure TPrincipal.escalonamentoNatural(escX, escY: double);
var
  matrizEscalonamento: TMatriz;

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

begin
  if (desenharLinha) then
  begin
    escalonarLinha();  
  end;

  if (desenharQuadrado) then
  begin
    escalonarQuadrado();
  end;

  if (desenharPonto) then
  begin
    escalonarPonto();
  end;

  if (desenharTriangulo) then
  begin
    escalonarTriangulo();
  end;  
end;


procedure TPrincipal.escalonar(escX, escY: double);
var
  matrizEscalonamento: TMatriz;

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
  escalonarLinha();
  escalonarPonto();
  escalonarTriangulo();
  escalonarQuadrado();
end;

procedure TPrincipal.translacao(tX: Double; tY: Double);
var
  matrizTranslacao: TMatriz;

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
  translacaoLinha();
  translacaoPonto();
  translacaoTriangulo();
  translacaoQuadrado();
end;

procedure TPrincipal.FormCreate(Sender: TObject);
var
  DC:HDC;
  RC:HGLRC;
  i:integer;
begin
  DC := GetDC(Handle);        //Actually, you can use any windowed control here
  SetupPixelFormat(DC);
  RC := wglCreateContext(DC); //makes OpenGL window out of DC
  wglMakeCurrent(DC, RC);   //makes OpenGL window active
  GLInit;                   //initialize OpenGL
  zoom := 1;
  linha := TLinha.Create(self);
  ponto := TPonto.Create(self);
  quadrado := TQuadrado.Create(self);
  triangulo := TTriangulo.Create(self);
end;

procedure TPrincipal.Draw;
begin
  glClear(GL_COLOR_BUFFER_BIT);
  glClearColor(1.0, 1.0, 1.0, 1.0);
  glLoadIdentity();
  DesenhaLinhasDivisorias();
  glScaled(zoom, zoom, 0);
  DesenhaLinha();
  DesenhaTriangulo();
  DesenhaQuadrado();
  DesenhaPonto();
  glScaled(-zoom, -zoom, 0);
  SwapBuffers(wglGetCurrentDC);
  glFlush();
end;

procedure TPrincipal.FormPaint(Sender: TObject);
begin
   Draw;
end;

procedure TPrincipal.btnBaixoClick(Sender: TObject);
begin
  linha.setP1Y(linha.getYP1() - 0.5);
  linha.setP2Y(linha.getYP2() - 0.5);

  triangulo.setP1Y(triangulo.getYP1 - 0.5);
  triangulo.setP2Y(triangulo.getYP2 - 0.5);
  triangulo.setP3Y(triangulo.getYP3 - 0.5);

  quadrado.setP1Y(quadrado.getYP1 - 0.5);
  quadrado.setP2Y(quadrado.getYP2 - 0.5);
  quadrado.setP3Y(quadrado.getYP3 - 0.5);
  quadrado.setP4Y(quadrado.getYP4 - 0.5);

  ponto.setP1Y(ponto.getYP1 - 0.5);
end;

procedure TPrincipal.btnCimaClick(Sender: TObject);
begin
  linha.setP1Y(linha.getYP1() + 0.5);
  linha.setP2Y(linha.getYP2() + 0.5);

  triangulo.setP1Y(triangulo.getYP1 + 0.5);
  triangulo.setP2Y(triangulo.getYP2 + 0.5);
  triangulo.setP3Y(triangulo.getYP3 + 0.5);

  quadrado.setP1Y(quadrado.getYP1 + 0.5);
  quadrado.setP2Y(quadrado.getYP2 + 0.5);
  quadrado.setP3Y(quadrado.getYP3 + 0.5);
  quadrado.setP4Y(quadrado.getYP4 + 0.5);

  ponto.setP1Y(ponto.getYP1 + 0.5);
end;

procedure TPrincipal.btnDireitaClick(Sender: TObject);
begin
  linha.setP1X(linha.getXP1() + 0.5);
  linha.setP2X(linha.getXP2() + 0.5);

  triangulo.setP1X(triangulo.getXP1 + 0.5);
  triangulo.setP2X(triangulo.getXP2 + 0.5);
  triangulo.setP3X(triangulo.getXP3 + 0.5);

  quadrado.setP1X(quadrado.getXP1 + 0.5);
  quadrado.setP2X(quadrado.getXP2 + 0.5);
  quadrado.setP3X(quadrado.getXP3 + 0.5);
  quadrado.setP4X(quadrado.getXP4 + 0.5);

  ponto.setP1X(ponto.getXP1 + 0.5);
end;

procedure TPrincipal.btnEsquerdaClick(Sender: TObject);
begin
  linha.setP1X(linha.getXP1() - 0.5);
  linha.setP2X(linha.getXP2() - 0.5);

  triangulo.setP1X(triangulo.getXP1 - 0.5);
  triangulo.setP2X(triangulo.getXP2 - 0.5);
  triangulo.setP3X(triangulo.getXP3 - 0.5);

  quadrado.setP1X(quadrado.getXP1 - 0.5);
  quadrado.setP2X(quadrado.getXP2 - 0.5);
  quadrado.setP3X(quadrado.getXP3 - 0.5);
  quadrado.setP4X(quadrado.getXP4 - 0.5);

  ponto.setP1X(ponto.getXP1 - 0.5);
end;

procedure TPrincipal.btnZoomInClick(Sender: TObject);
begin
  zoom := zoom + 0.2;
end;

procedure TPrincipal.btnZoomOutClick(Sender: TObject);
begin
  zoom := zoom - 0.2;
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
    glVertex2f(0, -30);
    glVertex2f(0, 30);
  glEnd();

  glBegin(GL_LINES);
    glVertex2f(-30, 0);
    glVertex2f(30, 0);
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
