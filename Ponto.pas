unit Ponto;

interface
uses
  Math, Classes, Vetor;

type
  TPonto = class (TComponent)
  private
      procedure Inicializa();

  public
    Constructor Create(AOwner: TComponent); override;
    procedure setP1X(value: double);
    procedure setP1Y(value: double);
    procedure setP1Z(value: double);

    function getXP1(): double;
    function getYP1(): double;
    function getZP1(): double;

    function getP1(): TVetor;
  end;

implementation

var
  p1: TVetor;
  p1X, p1Y, p1Z: double;

{ TPonto }

constructor TPonto.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Inicializa();
end;

function TPonto.getP1: TVetor;
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

function TPonto.getZP1: double;
begin
  Result := p1[2];
end;

procedure TPonto.Inicializa;
begin
  p1[0] := p1X;
  p1[1] := p1Y;
  p1[2] := p1Z;
  p1[3] := 1;
end;

procedure TPonto.setP1X(value: double);
begin
  p1[0] := value;
end;

procedure TPonto.setP1Y(value: double);
begin
  p1[1] := value;
end;

procedure TPonto.setP1Z(value: double);
begin
  p1[2] := value;
end;

end.
