object frmEscalonamento: TfrmEscalonamento
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Escalonamento'
  ClientHeight = 216
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Principal: TPanel
    Left = 8
    Top = 8
    Width = 321
    Height = 201
    TabOrder = 0
    object gpEscalonar: TGroupBox
      Left = 8
      Top = 8
      Width = 297
      Height = 137
      Caption = 'Escalonar'
      TabOrder = 0
      object lblPontoX: TLabel
        Left = 21
        Top = 29
        Width = 17
        Height = 13
        Caption = 'X= '
      end
      object lblPontoY: TLabel
        Left = 105
        Top = 29
        Width = 17
        Height = 13
        Caption = 'Y= '
      end
      object lblPontoZ: TLabel
        Left = 192
        Top = 29
        Width = 17
        Height = 13
        Caption = 'Z= '
      end
      object edPontoX: TEdit
        Left = 40
        Top = 26
        Width = 48
        Height = 21
        TabOrder = 0
      end
      object edPontoY: TEdit
        Left = 127
        Top = 26
        Width = 48
        Height = 21
        TabOrder = 1
      end
      object rbOrigem: TRadioButton
        Left = 40
        Top = 72
        Width = 113
        Height = 17
        Caption = 'Pela Origem'
        TabOrder = 2
      end
      object rbCentro: TRadioButton
        Left = 179
        Top = 72
        Width = 113
        Height = 17
        Caption = 'Pelo Centro'
        TabOrder = 3
      end
      object edPontoZ: TEdit
        Left = 209
        Top = 26
        Width = 48
        Height = 21
        TabOrder = 4
      end
    end
    object btnOK: TButton
      Left = 144
      Top = 160
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancelar: TButton
      Left = 230
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
  end
end
