unit Triangulo;

interface
uses
  Math, Classes;

type
  Ponto1 = array[0..2] of double;
  Ponto2 = array[0..2] of double;
  Ponto3 = array[0..2] of double;
  TTriangulo = class (TComponent)

  public
    Constructor Create(AOwner: TComponent); override;
    procedure Inicializa();

    procedure setP1X(value: double);
    procedure setP1Y(value: double);
    procedure setP2X(value: double);
    procedure setP2Y(value: double);
    procedure setP3X(value: double);
    procedure setP3Y(value: double);

    function getXP1(): double;
    function getYP1(): double;
    function getXP2(): double;
    function getYP2(): double;
    function getXP3(): double;
    function getYP3(): double;

    function getP1(): Ponto1;
    function getP2(): Ponto2;
    function getP3(): Ponto3;
  end;

implementation

var
  p1: Ponto1;
  p2: Ponto2;
  p3: Ponto3;
  p1X, p1Y, p2X, p2Y, p3X, p3Y: double;

{ TLinha }

constructor TTriangulo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TTriangulo.getXP1: double;
begin
  Result := p1[0];
end;

function TTriangulo.getXP2: double;
begin
  Result := p2[0];
end;

function TTriangulo.getXP3: double;
begin
  Result := p3[0];
end;

function TTriangulo.getYP1: double;
begin
  Result := p1[1];
end;

function TTriangulo.getYP2: double;
begin
  Result := p2[1];
end;

function TTriangulo.getYP3: double;
begin
  Result := p3[1];
end;

procedure TTriangulo.Inicializa();
begin
  p1[0] := p1X;
  p1[1] := p1Y;
  p1[2] := 1;

  p2[0] := p2X;
  p2[1] := p2Y;
  p2[2] := 1;

  p3[0] := p3X;
  p3[1] := p3Y;
  p3[2] := 1;
end;

function TTriangulo.getP1: Ponto1;
begin
  Result := p1;
end;

function TTriangulo.getP2: Ponto2;
begin
  Result := p2;
end;

function TTriangulo.getP3: Ponto3;
begin
  Result := p3;
end;

procedure TTriangulo.setP1X(value: double);
begin
  p1[0] := value;
end;

procedure TTriangulo.setP1Y(value: double);
begin
  p1[1] := value;
end;

procedure TTriangulo.setP2X(value: double);
begin
  p2[0] := value;
end;

procedure TTriangulo.setP2Y(value: double);
begin
  p2[1] := value;
end;

procedure TTriangulo.setP3X(value: double);
begin
  p3[0] := value;
end;

procedure TTriangulo.setP3Y(value: double);
begin
  p3[1] := value;
end;

end.
