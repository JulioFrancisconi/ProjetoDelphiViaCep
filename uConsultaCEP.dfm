object uConsultaCEPForm: TuConsultaCEPForm
  Left = 0
  Top = 0
  Caption = 'Consultar CEP'
  ClientHeight = 313
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object lblCEP: TLabel
    Left = 8
    Top = 8
    Width = 21
    Height = 15
    Caption = 'CEP'
  end
  object lblEstado: TLabel
    Left = 7
    Top = 68
    Width = 35
    Height = 15
    Caption = 'Estado'
  end
  object lblCidade: TLabel
    Left = 8
    Top = 124
    Width = 37
    Height = 15
    Caption = 'Cidade'
  end
  object lblBairro: TLabel
    Left = 8
    Top = 180
    Width = 31
    Height = 15
    Caption = 'Bairro'
  end
  object lblLogradouro: TLabel
    Left = 8
    Top = 236
    Width = 62
    Height = 15
    Caption = 'Logradouro'
  end
  object btnConsultar: TButton
    Left = 81
    Top = 31
    Width = 81
    Height = 25
    Caption = 'Consultar CEP'
    TabOrder = 1
    OnClick = btnConsultarClick
  end
  object edtEstado: TEdit
    Left = 8
    Top = 89
    Width = 264
    Height = 23
    ReadOnly = True
    TabOrder = 2
  end
  object edtCidade: TEdit
    Left = 8
    Top = 145
    Width = 264
    Height = 23
    ReadOnly = True
    TabOrder = 3
  end
  object edtBairro: TEdit
    Left = 8
    Top = 201
    Width = 264
    Height = 23
    ReadOnly = True
    TabOrder = 4
  end
  object edtLogradouro: TEdit
    Left = 8
    Top = 257
    Width = 264
    Height = 23
    ReadOnly = True
    TabOrder = 5
  end
  object medtCEP: TMaskEdit
    Left = 8
    Top = 32
    Width = 64
    Height = 23
    EditMask = '99999\-999;1;_'
    MaxLength = 9
    TabOrder = 0
    Text = '     -   '
  end
  object btnLimpar: TButton
    Left = 109
    Top = 286
    Width = 62
    Height = 21
    Caption = 'Limpar'
    TabOrder = 6
    OnClick = btnLimparClick
  end
end
