unit Linha;

interface
uses
  Math, Classes, Vetor;

type
  TLinha = class (TComponent)
  private
    procedure Inicializa();

  public
    Constructor Create(AOwner: TComponent); override;
    procedure setP1X(value: double);
    procedure setP1Y(value: double);
    procedure setP1Z(value: double);

    procedure setP2X(value: double);
    procedure setP2Y(value: double);
    procedure setP2Z(value: double);

    function getXP1(): double;
    function getYP1(): double;
    function getZP1(): double;

    function getXP2(): double;
    function getYP2(): double;
    function getZP2(): double;

    function getP1(): TVetor;
    function getP2(): TVetor;
  end;

implementation

var
  p1: TVetor;
  p2: TVetor;
  p1X, p1Y, p1Z, p2X, p2Y, p2Z: double;

{ TLinha }

constructor TLinha.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Inicializa();
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

function TLinha.getZP1: double;
begin
  Result := p1[2];
end;

function TLinha.getZP2: double;
begin
  Result := p2[2];
end;

procedure TLinha.Inicializa();
begin
  p1[0] := p1X;
  p1[1] := p1Y;
  p1[2] := p1Z;
  p1[3] := 1;

  p2[0] := p2X;
  p2[1] := p2Y;
  p2[2] := p2Z;
  p2[3] := 1;
end;

function TLinha.getP1: TVetor;
begin
  Result := p1;
end;

function TLinha.getP2: TVetor;
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

procedure TLinha.setP1Z(value: double);
begin
  p1[2] := value;
end;

procedure TLinha.setP2X(value: double);
begin
  p2[0] := value;
end;

procedure TLinha.setP2Y(value: double);
begin
  p2[1] := value;
end;

procedure TLinha.setP2Z(value: double);
begin
  p2[2] := value;
end;

end.
