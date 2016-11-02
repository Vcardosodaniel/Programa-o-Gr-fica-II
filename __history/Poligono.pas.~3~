unit Poligono;

interface
uses
  Math, Classes, Vetor;

type
  TPoligono = class (TComponent)

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
    procedure setP5X(value: double);
    procedure setP5Y(value: double);
    procedure setP6X(value: double);
    procedure setP6Y(value: double);
    procedure setP7X(value: double);
    procedure setP7Y(value: double);
    procedure setP8X(value: double);
    procedure setP8Y(value: double);
    procedure setP9X(value: double);
    procedure setP9Y(value: double);
    procedure setP10X(value: double);
    procedure setP10Y(value: double);


    function getXP1(): double;
    function getYP1(): double;
    function getXP2(): double;
    function getYP2(): double;
    function getXP3(): double;
    function getYP3(): double;
    function getXP4(): double;
    function getYP4(): double;
    function getXP5(): double;
    function getYP5(): double;
    function getXP6(): double;
    function getYP6(): double;
    function getXP7(): double;
    function getYP7(): double;
    function getXP8(): double;
    function getYP8(): double;
    function getXP9(): double;
    function getYP9(): double;
    function getXP10(): double;
    function getYP10(): double;

    function getP1(): TVetor;
    function getP2(): TVetor;
    function getP3(): TVetor;
    function getP4(): TVetor;
    function getP5(): TVetor;
    function getP6(): TVetor;
    function getP7(): TVetor;
    function getP8(): TVetor;
    function getP9(): TVetor;
    function getP10(): TVetor;
  end;

implementation

var
  p1: TVetor;
  p2: TVetor;
  p3: TVetor;
  p4: TVetor;
  p5: TVetor;
  p6: TVetor;
  p7: TVetor;
  p8: TVetor;
  p9: TVetor;
  p10: TVetor;
  p1X, p1Y, p2X, p2Y, p3X, p3Y, p4X, p4Y, p5X, p5Y,
  p6X, p6Y, p7X, p7Y, p8X, p8Y, p9X, p9Y, p10X, p10Y: double;

{ TLinha }

constructor TPoligono.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Inicializa();
end;


function TPoligono.getP1: TVetor;
begin
  Result := p1;
end;

function TPoligono.getP10: TVetor;
begin
  Result := p10;
end;

function TPoligono.getP2: TVetor;
begin
  Result := p2;
end;

function TPoligono.getP3: TVetor;
begin
  Result := p3;
end;

function TPoligono.getP4: TVetor;
begin
  Result := p4;
end;

function TPoligono.getP5: TVetor;
begin
  Result := p5;
end;

function TPoligono.getP6: TVetor;
begin
  Result := p6;
end;

function TPoligono.getP7: TVetor;
begin
  Result := p7;
end;

function TPoligono.getP8: TVetor;
begin
  Result := p8;
end;

function TPoligono.getP9: TVetor;
begin
  Result := p9;
end;

function TPoligono.getXP1: double;
begin
  Result := p1[0];
end;

function TPoligono.getXP10: double;
begin
  Result := p10[0];
end;

function TPoligono.getXP2: double;
begin
  Result := p2[0];
end;

function TPoligono.getXP3: double;
begin
  Result := p3[0];
end;

function TPoligono.getXP4: double;
begin
  Result := p4[0];
end;

function TPoligono.getXP5: double;
begin
  Result := p5[0];
end;

function TPoligono.getXP6: double;
begin
  Result := p6[0];
end;

function TPoligono.getXP7: double;
begin
  Result := p7[0];
end;

function TPoligono.getXP8: double;
begin
  Result := p8[0];
end;

function TPoligono.getXP9: double;
begin
  Result := p9[0];
end;

function TPoligono.getYP1: double;
begin
  Result := p1[1];
end;

function TPoligono.getYP10: double;
begin
  Result := p10[1];
end;

function TPoligono.getYP2: double;
begin
  Result := p2[1];
end;

function TPoligono.getYP3: double;
begin
  Result :=  p3[1];
end;

function TPoligono.getYP4: double;
begin
  Result := p4[1];
end;

function TPoligono.getYP5: double;
begin
  Result := p5[1];
end;

function TPoligono.getYP6: double;
begin
  Result := p6[1];
end;

function TPoligono.getYP7: double;
begin
  Result := p7[1];
end;

function TPoligono.getYP8: double;
begin
  Result := p8[1];
end;

function TPoligono.getYP9: double;
begin
  Result := p9[1];
end;

procedure TPoligono.Inicializa();
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

  p5[0] := p5X;
  p5[1] := p5Y;
  p5[2] := 1;

  p6[0] := p6X;
  p6[1] := p6Y;
  p6[2] := 1;

  p7[0] := p7X;
  p7[1] := p7Y;
  p7[2] := 1;

  p8[0] := p8X;
  p8[1] := p8Y;
  p8[2] := 1;

  p9[0] := p9X;
  p9[1] := p9Y;
  p9[2] := 1;

  p10[0] := p10X;
  p10[1] := p10Y;
  p10[2] := 1;
end;

procedure TPoligono.setP10X(value: double);
begin
  p10[0] := value;
end;

procedure TPoligono.setP10Y(value: double);
begin
  p10[1] := value;
end;

procedure TPoligono.setP1X(value: double);
begin
  p1[0] := value;
end;

procedure TPoligono.setP1Y(value: double);
begin
  p1[1] := value;
end;

procedure TPoligono.setP2X(value: double);
begin
  p2[0] := value;
end;

procedure TPoligono.setP2Y(value: double);
begin
  p2[1] := value;
end;

procedure TPoligono.setP3X(value: double);
begin
  p3[0] := value;
end;

procedure TPoligono.setP3Y(value: double);
begin
  p3[1] := value;
end;

procedure TPoligono.setP4X(value: double);
begin
  p4[0] := value;
end;

procedure TPoligono.setP4Y(value: double);
begin
  p4[1] := value;
end;

procedure TPoligono.setP5X(value: double);
begin
  p5[0] := value;
end;

procedure TPoligono.setP5Y(value: double);
begin
  p5[1] := value;
end;

procedure TPoligono.setP6X(value: double);
begin
  p6[0] := value;
end;

procedure TPoligono.setP6Y(value: double);
begin
  p6[1] := value;
end;

procedure TPoligono.setP7X(value: double);
begin
  p7[0] := value;
end;

procedure TPoligono.setP7Y(value: double);
begin
  p7[1] := value;
end;

procedure TPoligono.setP8X(value: double);
begin
  p8[0] := value;
end;

procedure TPoligono.setP8Y(value: double);
begin
  p8[1] := value;
end;

procedure TPoligono.setP9X(value: double);
begin
  p9[0] := value;
end;

procedure TPoligono.setP9Y(value: double);
begin
  p9[1] := value;
end;

end.
