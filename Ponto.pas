unit Ponto;

interface
uses
  Math, Classes;

type
  Ponto1 = array[0..2] of double;
  TPonto = class (TComponent)

  public
    Constructor Create(AOwner: TComponent); override;
    procedure Inicializa();
    procedure setP1X(value: double);
    procedure setP1Y(value: double);
    function getXP1(): double;
    function getYP1(): double;
    function getP1(): Ponto1;
  end;

implementation

var
  p1: Ponto1;
  p1X, p1Y: double;

{ TPonto }

constructor TPonto.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TPonto.getP1: Ponto1;
begin
  Result := p1;
end;

function TPonto.getXP1: double;
begin
  Result := p1[0];
end;

function TPonto.getYP1: double;
begin
  Result := p1[1]
end;

procedure TPonto.Inicializa;
begin
  p1[0] := p1X;
  p1[1] := p1Y;
  p1[2] := 1;
end;

procedure TPonto.setP1X(value: double);
begin
  p1[0] := value;
end;

procedure TPonto.setP1Y(value: double);
begin
  p1[1] := value;
end;

end.
