object frmTriangulo: TfrmTriangulo
  Left = 0
  Top = 0
  Caption = 'Tri'#226'ngulo'
  ClientHeight = 221
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object painelPrincipal: TPanel
    Left = 8
    Top = 8
    Width = 369
    Height = 207
    TabOrder = 0
    object gbCoordenadas: TGroupBox
      Left = 16
      Top = 16
      Width = 329
      Height = 144
      Caption = 'Coordenadas'
      TabOrder = 0
      object lblPonto1: TLabel
        Left = 14
        Top = 28
        Width = 44
        Height = 13
        Caption = 'Ponto 1: '
      end
      object lblPonto2: TLabel
        Left = 14
        Top = 56
        Width = 44
        Height = 13
        Caption = 'Ponto 2: '
      end
      object lblPonto3: TLabel
        Left = 14
        Top = 84
        Width = 44
        Height = 13
        Caption = 'Ponto 3: '
      end
      object lblYPonto1: TLabel
        Left = 154
        Top = 28
        Width = 17
        Height = 13
        Caption = 'Y= '
      end
      object lblYPonto2: TLabel
        Left = 154
        Top = 56
        Width = 17
        Height = 13
        Caption = 'Y= '
      end
      object lblYPonto3: TLabel
        Left = 154
        Top = 84
        Width = 17
        Height = 13
        Caption = 'Y= '
      end
      object lblXPonto1: TLabel
        Left = 66
        Top = 28
        Width = 17
        Height = 13
        Caption = 'X= '
      end
      object lblXPonto2: TLabel
        Left = 66
        Top = 56
        Width = 17
        Height = 13
        Caption = 'X= '
      end
      object lblXPonto3: TLabel
        Left = 66
        Top = 84
        Width = 17
        Height = 13
        Caption = 'X= '
      end
      object edXPonto1: TEdit
        Left = 93
        Top = 25
        Width = 48
        Height = 21
        NumbersOnly = True
        TabOrder = 0
      end
      object edXPonto2: TEdit
        Left = 93
        Top = 53
        Width = 48
        Height = 21
        NumbersOnly = True
        TabOrder = 2
      end
      object edXPonto3: TEdit
        Left = 93
        Top = 81
        Width = 48
        Height = 21
        NumbersOnly = True
        TabOrder = 4
      end
      object edYPonto1: TEdit
        Left = 181
        Top = 25
        Width = 47
        Height = 21
        NumbersOnly = True
        TabOrder = 1
      end
      object edYPonto2: TEdit
        Left = 181
        Top = 53
        Width = 47
        Height = 20
        NumbersOnly = True
        TabOrder = 3
      end
      object edYPonto3: TEdit
        Left = 181
        Top = 81
        Width = 47
        Height = 21
        NumbersOnly = True
        TabOrder = 5
      end
    end
    object btnOK: TButton
      Left = 176
      Top = 167
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 270
      Top = 167
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
end
