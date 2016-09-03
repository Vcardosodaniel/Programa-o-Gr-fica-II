unit Primeiro1;

interface

uses
  OpenGL, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Math, Linha, Ponto, Quadrado, Triangulo;

type
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
  desenharLinha, desenharTriangulo, desenharQuadrado, desenharPonto: bool;
  x1Linha, y1Linha, x2Linha, y2Linha : double;
  Linha: TLinha;
  Ponto: TPonto;
  Quadrado: TQuadrado;
  Triangulo: TTriangulo;
  xEsqTri, yEsqTri, xCimaTri, yCimaTri, xDirTri, yDirTri : double;
  xEsqCimaQuad, yEsqCimaQuad, xDirCimaQuad, yDirCimaQuad, xDirBaixoQuad,
  yDirBaixoQuad, xEsqBaixoQuad, yEsqBaixoQuad : double;
  xPonto, yPonto: double;
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

  function rotacionarX(grausRot, xRot, yRot: double): double;
  begin
    Result :=  xRot * cos(DegToRad(grausRot)) - yRot * sin(DegToRad(grausRot));
  end;

  function rotacionarY(grausRot, xRot, yRot: single): single;
  begin
    Result :=  xRot * sin(DegToRad(grausRot)) + yRot * cos(DegToRad(grausRot));
  end;

begin
    x1Linha := rotacionarX(graus, x1Linha, y1Linha);
    x2Linha := rotacionarX(graus, x2Linha, y2Linha);

    y1Linha := rotacionarY(graus, x1Linha, y1Linha);
    y2Linha := rotacionarY(graus, x2Linha, y2Linha);

    xEsqTri  := rotacionarX(graus, xEsqTri, yEsqTri);
    xCimaTri := rotacionarX(graus, xCimaTri, yCimaTri);
    xDirTri  := rotacionarX(graus, xDirTri, yDirTri);

    yEsqTri  := rotacionarY(graus, xEsqTri, yEsqTri);
    yCimaTri := rotacionarY(graus, xCimaTri, yCimaTri);
    yDirTri  := rotacionarY(graus, xDirTri, yDirTri);

    xEsqCimaQuad  := rotacionarX(graus, xEsqCimaQuad, yEsqCimaQuad);
    xDirCimaQuad  := rotacionarX(graus, xDirCimaQuad, yDirCimaQuad);
    xDirBaixoQuad := rotacionarX(graus, xDirBaixoQuad, yDirBaixoQuad);
    xEsqBaixoQuad := rotacionarX(graus, xEsqBaixoQuad, yEsqBaixoQuad);

    yEsqCimaQuad  := rotacionarY(graus, xEsqCimaQuad, yEsqCimaQuad);
    yDirCimaQuad  := rotacionarY(graus, xDirCimaQuad, yDirCimaQuad);
    yDirBaixoQuad := rotacionarY(graus, xDirBaixoQuad, yDirBaixoQuad);
    yEsqBaixoQuad := rotacionarY(graus, xEsqBaixoQuad, yEsqBaixoQuad);

    xPonto := rotacionarX(graus, xPonto, yPonto);
    yPonto := rotacionarY(graus, xPonto, yPonto);
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
  Linha.Inicializa();
  Ponto.Inicializa();
  Quadrado.Inicializa();
  Triangulo.Inicializa();
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
