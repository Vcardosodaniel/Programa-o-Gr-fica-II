object frmTranslacao: TfrmTranslacao
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Transla'#231#227'o'
  ClientHeight = 234
  ClientWidth = 308
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
    Height = 214
    TabOrder = 0
    object gpTranslacao: TGroupBox
      Left = 16
      Top = 24
      Width = 249
      Height = 137
      Caption = 'Transla'#231#227'o'
      TabOrder = 0
      object Label1: TLabel
        Left = 40
        Top = 26
        Width = 17
        Height = 13
        Caption = 'X= '
      end
      object Label2: TLabel
        Left = 40
        Top = 66
        Width = 17
        Height = 13
        Caption = 'Y= '
      end
      object Label3: TLabel
        Left = 40
        Top = 103
        Width = 17
        Height = 13
        Caption = 'Z= '
      end
      object edPontoX: TEdit
        Left = 63
        Top = 23
        Width = 75
        Height = 21
        TabOrder = 0
      end
      object edPontoY: TEdit
        Left = 63
        Top = 63
        Width = 75
        Height = 21
        TabOrder = 1
      end
      object edPontoZ: TEdit
        Left = 63
        Top = 100
        Width = 75
        Height = 21
        TabOrder = 2
      end
    end
    object btnOk: TButton
      Left = 102
      Top = 173
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancelar: TButton
      Left = 190
      Top = 173
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
  end
end
