object Principal: TPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Primitivas Geogr'#225'ficas'
  ClientHeight = 591
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object btnTriangulo: TButton
    Left = 0
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Triangulo'
    TabOrder = 0
    OnClick = btnTrianguloClick
  end
  object btnQuadrado: TButton
    Left = 80
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Quadrado'
    TabOrder = 1
    OnClick = btnQuadradoClick
  end
  object btnLinha: TButton
    Left = 159
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Linha'
    TabOrder = 2
    OnClick = btnLinhaClick
  end
  object btnCima: TButton
    Left = 510
    Top = 534
    Width = 41
    Height = 27
    Caption = 'Cima'
    TabOrder = 3
    OnClick = btnCimaClick
  end
  object btnBaixo: TButton
    Left = 510
    Top = 557
    Width = 41
    Height = 27
    Caption = 'Baixo'
    TabOrder = 4
    OnClick = btnBaixoClick
  end
  object btnEsquerda: TButton
    Left = 470
    Top = 550
    Width = 41
    Height = 27
    Caption = 'Esq.'
    TabOrder = 5
    OnClick = btnEsquerdaClick
  end
  object btnDireita: TButton
    Left = 550
    Top = 550
    Width = 41
    Height = 27
    Caption = 'Dir.'
    TabOrder = 6
    OnClick = btnDireitaClick
  end
  object btnPonto: TButton
    Left = 240
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Ponto'
    TabOrder = 7
    OnClick = btnPontoClick
  end
  object btnZoomIn: TButton
    Left = -2
    Top = 558
    Width = 75
    Height = 25
    Caption = 'Zoom IN'
    TabOrder = 8
    OnClick = btnZoomInClick
  end
  object btnZoomOut: TButton
    Left = 79
    Top = 558
    Width = 75
    Height = 25
    Caption = 'Zoom OUT'
    TabOrder = 9
    OnClick = btnZoomOutClick
  end
  object btnRotacionar: TButton
    Left = 159
    Top = 558
    Width = 75
    Height = 25
    Caption = 'Rota'#231#227'o'
    TabOrder = 10
    OnClick = btnRotacionarClick
  end
  object btnEscalonamento: TButton
    Left = 240
    Top = 558
    Width = 92
    Height = 25
    Caption = 'Escalonamento'
    TabOrder = 11
    OnClick = btnEscalonamentoClick
  end
  object btnTranslacao: TButton
    Left = 339
    Top = 558
    Width = 88
    Height = 25
    Caption = 'Transla'#231#227'o'
    TabOrder = 12
    OnClick = btnTranslacaoClick
  end
end
