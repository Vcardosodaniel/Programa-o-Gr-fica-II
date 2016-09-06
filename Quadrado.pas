unit Quadrado;

interface
uses
  Math, Classes, Vetor;

type
  TQuadrado = class (TComponent)

  private
      procedure Inicializa();

  public
    Constructor Create(AOwner: TComponent); override;

    procedure setP1X(value: double);
    procedure setP1Y(value: double);
    procedure setP2X(value: double);
    procedure setP2Y(value: double);
    procedure setP3X(value: double);
    procedure setP3Y(value: double);
    procedure setP4X(value: double);
    procedure setP4Y(value: double);

    function getXP1(): double;
    function getYP1(): double;
    function getXP2(): double;
    function getYP2(): double;
    function getXP3(): double;
    function getYP3(): double;
    function getXP4(): double;
    function getYP4(): double;

    function getP1(): TVetor;
    function getP2(): TVetor;
    function getP3(): TVetor;
    function getP4(): TVetor;
  end;

implementation

var
  p1: TVetor;
  p2: TVetor;
  p3: TVetor;
  p4: TVetor;
  p1X, p1Y, p2X, p2Y, p3X, p3Y, p4X, p4Y: double;

{ TLinha }

constructor TQuadrado.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Inicializa();
end;

function TQuadrado.getXP1: double;
begin
  Result := p1[0];
end;

function TQuadrado.getXP2: double;
begin
  Result := p2[0];
end;

function TQuadrado.getXP3: double;
begin
  Result := p3[0];
end;

function TQuadrado.getXP4: double;
begin
  Result := p4[0];
end;

function TQuadrado.getYP1: double;
begin
  Result := p1[1];
end;

function TQuadrado.getYP2: double;
begin
  Result := p2[1];
end;

function TQuadrado.getYP3: double;
begin
  Result := p3[1];
end;

function TQuadrado.getYP4: double;
begin
  Result := p4[1];
end;

procedure TQuadrado.Inicializa();
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

  p4[0] := p4X;
  p4[1] := p4Y;
  p4[2] := 1;
end;

function TQuadrado.getP1: TVetor;
begin
  Result := p1;
end;

function TQuadrado.getP2: TVetor;
begin
  Result := p2;
end;

function TQuadrado.getP3: TVetor;
begin
  Result := p3;
end;

function TQuadrado.getP4: TVetor;
begin
  Result := p4;
end;

procedure TQuadrado.setP1X(value: double);
begin
  p1[0] := value;
end;

procedure TQuadrado.setP1Y(value: double);
begin
  p1[1] := value;
end;

procedure TQuadrado.setP2X(value: double);
begin
  p2[0] := value;
end;

procedure TQuadrado.setP2Y(value: double);
begin
  p2[1] := value;
end;

procedure TQuadrado.setP3X(value: double);
begin
  p3[0] := value;
end;

procedure TQuadrado.setP3Y(value: double);
begin
  p3[1] := value;
end;

procedure TQuadrado.setP4X(value: double);
begin
  p4[0] := value;
end;

procedure TQuadrado.setP4Y(value: double);
begin
  p4[1] := value;
end;

end.
