object frmRotacionar: TfrmRotacionar
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Rota'#231#227'o'
  ClientHeight = 262
  ClientWidth = 439
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
    Width = 425
    Height = 246
    TabOrder = 0
    object gpRotacao: TGroupBox
      Left = 16
      Top = 16
      Width = 393
      Height = 187
      Caption = 'Rotacionar'
      TabOrder = 0
      object lblGraus: TLabel
        Left = 24
        Top = 39
        Width = 71
        Height = 13
        Caption = 'Graus (Deg*) :'
      end
      object edGraus: TEdit
        Left = 101
        Top = 36
        Width = 92
        Height = 21
        TabOrder = 0
      end
      object rbOrigem: TRadioButton
        Left = 24
        Top = 154
        Width = 113
        Height = 17
        Caption = 'Pela Origem'
        TabOrder = 1
      end
      object rbCentro: TRadioButton
        Left = 152
        Top = 154
        Width = 113
        Height = 17
        Caption = 'Pelo Centro'
        TabOrder = 2
      end
      object rbPonto: TRadioButton
        Left = 279
        Top = 154
        Width = 113
        Height = 17
        Caption = 'Por Ponto'
        TabOrder = 3
      end
      object GroupBox1: TGroupBox
        Left = 15
        Top = 72
        Width = 347
        Height = 62
        Caption = 'Eixo de Rota'#231#227'o'
        TabOrder = 4
        object rbRotacaoX: TRadioButton
          Left = 9
          Top = 32
          Width = 113
          Height = 17
          Caption = 'X'
          TabOrder = 0
        end
        object rbRotacaoY: TRadioButton
          Left = 137
          Top = 32
          Width = 113
          Height = 17
          Caption = 'Y'
          TabOrder = 1
        end
        object rbRotacaoZ: TRadioButton
          Left = 264
          Top = 32
          Width = 113
          Height = 17
          Caption = 'Z'
          TabOrder = 2
        end
      end
    end
    object btnOk: TButton
      Left = 253
      Top = 209
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancelar: TButton
      Left = 334
      Top = 209
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
  end
end
