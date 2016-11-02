unit Triangulo;

interface
uses
  Math, Classes, Vetor;

type
  TTriangulo = class (TComponent)

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

    function getXP1(): double;
    function getYP1(): double;
    function getXP2(): double;
    function getYP2(): double;
    function getXP3(): double;
    function getYP3(): double;

    function getP1(): TVetor;
    function getP2(): TVetor;
    function getP3(): TVetor;
  end;

implementation

var
  p1: TVetor;
  p2: TVetor;
  p3: TVetor;
  p1X, p1Y, p2X, p2Y, p3X, p3Y: double;

{ TLinha }

constructor TTriangulo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Inicializa();
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

function TTriangulo.getP1: TVetor;
begin
  Result := p1;
end;

function TTriangulo.getP2: TVetor;
begin
  Result := p2;
end;

function TTriangulo.getP3: TVetor;
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
