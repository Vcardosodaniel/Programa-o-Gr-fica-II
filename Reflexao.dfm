object frmReflexao: TfrmReflexao
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Reflex'#227'o'
  ClientHeight = 308
  ClientWidth = 306
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
    Width = 289
    Height = 289
    TabOrder = 0
    object gpReflexao: TGroupBox
      Left = 24
      Top = 24
      Width = 233
      Height = 209
      Caption = 'Refletir em'
      TabOrder = 0
      object rbReflexaoX: TRadioButton
        Left = 48
        Top = 48
        Width = 113
        Height = 17
        Caption = 'Reflexao em X'
        TabOrder = 0
      end
      object rbReflexaoY: TRadioButton
        Left = 48
        Top = 101
        Width = 113
        Height = 17
        Caption = 'Reflexao em Y'
        TabOrder = 1
      end
      object rbReflexaoOrigem: TRadioButton
        Left = 48
        Top = 152
        Width = 137
        Height = 17
        Caption = 'Reflexao pela Origem'
        TabOrder = 2
      end
    end
    object btnOk: TButton
      Left = 101
      Top = 246
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancelar: TButton
      Left = 182
      Top = 246
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
  end
end
