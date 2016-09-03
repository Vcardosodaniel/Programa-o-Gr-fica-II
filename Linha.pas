unit Linha;

interface
uses
  Math, Classes;

type
  Ponto1 = array[0..2] of double;
  Ponto2 = array[0..2] of double;
  TLinha = class (TComponent)

  public
    Constructor Create(AOwner: TComponent); override;
    procedure Inicializa();
    procedure setP1X(value: double);
    procedure setP1Y(value: double);
    procedure setP2X(value: double);
    procedure setP2Y(value: double);
    function getXP1(): double;
    function getYP1(): double;
    function getXP2(): double;
    function getYP2(): double;
    function getP1(): Ponto1;
    function getP2(): Ponto2;
  end;

implementation

var
  p1: Ponto1;
  p2: Ponto2;
  p1X, p1Y, p2X, p2Y: double;

{ TLinha }

constructor TLinha.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TLinha.getXP1: double;
begin
  Result := p1[0];
end;

function TLinha.getXP2: double;
begin
  Result := p2[0];
end;

function TLinha.getYP1: double;
begin
  Result := p1[1];
end;

function TLinha.getYP2: double;
begin
  Result := p2[1];
end;

procedure TLinha.Inicializa();
begin
  p1[0] := p1X;
  p1[1] := p1Y;
  p1[2] := 1;

  p2[0] := p2X;
  p2[1] := p2Y;
  p2[2] := 1;
end;

function TLinha.getP1: Ponto1;
begin
  Result := p1;
end;

function TLinha.getP2: Ponto2;
begin
  Result := p2;
end;

procedure TLinha.setP1X(value: double);
begin
  p1[0] := value;
end;

procedure TLinha.setP1Y(value: double);
begin
  p1[1] := value;
end;

procedure TLinha.setP2X(value: double);
begin
  p2[0] := value;
end;

procedure TLinha.setP2Y(value: double);
begin
  p2[1] := value;
end;

end.