unit Primeiro1;

interface

uses
  OpenGL, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Math, Linha, Ponto, Quadrado, Triangulo;

type
//  TVetor = array[0..2] of double;
  TMatrizRotacao = array[0..2,0..2] of double;
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
  private
    procedure Draw; //Draws an OpenGL scene on request
    procedure DesenhaLinha();
    procedure DesenhaTriangulo();
    procedure DesenhaQuadrado();
    procedure DesenhaPonto();
    procedure DesenhaLinhasDivisorias();
    procedure rotacionar(graus: double);

  end;

var
  Principal: TPrincipal;

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

procedure TPrincipal.rotacionar(graus: double);
var
  matrizRotacao: TMatrizRotacao;

  function rotacionar(ponto: TVetor; matriz: TMatrizRotacao): TVetor;
  var
    resultado: TVetor;
  begin
    resultado[0] := (ponto[0]*matriz[0][0] + ponto[1]*matriz[1][0] + ponto[2]*matriz[2][0]);
    resultado[1] := (ponto[0]*matriz[0][1] + ponto[1]*matriz[1][1] + ponto[2]*matriz[2][1]);
    Result := resultado;
  end;

  procedure rotacionarLinha();
  var
    pontoRotacionado: TVetor;
  begin
    pontoRotacionado := rotacionar(linha.getP1, matrizRotacao);
    linha.setP1X(pontoRotacionado[0]);
    linha.setP1Y(pontoRotacionado[1]);
    pontoRotacionado := rotacionar(linha.getP2, matrizRotacao);
    linha.setP2X(pontoRotacionado[0]);
    linha.setP2Y(pontoRotacionado[1]);
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
begin
  rotacionar(45);
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
