object form_cadastro_usuario: Tform_cadastro_usuario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro Usuario e Senhas'
  ClientHeight = 150
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object txt_cd_cliente: TLabel
    Left = 8
    Top = 13
    Width = 79
    Height = 13
    Caption = 'Codigo Conex'#227'o'
  end
  object txt_cd_criente: TLabel
    Left = 158
    Top = 12
    Width = 69
    Height = 13
    Caption = 'Codigo Cliente'
  end
  object txt_nm_sistema: TLabel
    Left = 8
    Top = 38
    Width = 97
    Height = 13
    Caption = 'Sistema Operacional'
  end
  object txt_terminal: TLabel
    Left = 249
    Top = 39
    Width = 40
    Height = 13
    Caption = 'Terminal'
  end
  object txt_nm_usuario: TLabel
    Left = 8
    Top = 65
    Width = 36
    Height = 13
    Caption = 'Usuario'
  end
  object txt_obs: TLabel
    Left = 8
    Top = 93
    Width = 63
    Height = 13
    Caption = 'Observa'#231#245'es'
  end
  object txt_senha: TLabel
    Left = 226
    Top = 65
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object txt_box_cd_usuario: TEdit
    Left = 93
    Top = 8
    Width = 59
    Height = 21
    CharCase = ecUpperCase
    Color = clScrollBar
    TabOrder = 7
  end
  object txt_box_cd_cliente: TEdit
    Left = 233
    Top = 8
    Width = 69
    Height = 21
    CharCase = ecUpperCase
    Color = clScrollBar
    TabOrder = 8
  end
  object txt_box_obs: TEdit
    Left = 77
    Top = 89
    Width = 353
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 6
  end
  object txt_box_senha: TEdit
    Left = 262
    Top = 62
    Width = 168
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 4
  end
  object txt_box_nm_usuario: TEdit
    Left = 50
    Top = 62
    Width = 168
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 3
  end
  object cb_nm_programa: TComboBox
    Left = 111
    Top = 35
    Width = 132
    Height = 21
    CharCase = ecUpperCase
    ItemIndex = 0
    TabOrder = 1
    Text = 'WINDOWS'
    Items.Strings = (
      'WINDOWS'
      'LINUX'
      'MAC OS'
      'TEF WEB'
      'TOKEN EMAIL'
      '')
  end
  object cb_nm_terminal: TComboBox
    Left = 295
    Top = 35
    Width = 133
    Height = 21
    CharCase = ecUpperCase
    ItemIndex = 0
    TabOrder = 2
    Text = 'BALCAO'
    Items.Strings = (
      'BALCAO'
      'DEPOSITO'
      'ESCRITORIO'
      'FRENTE DE CAIXA'
      'SERVIDOR APP'
      'SERVIDOR SUPER'
      'SERVIDOR SITEF'
      '')
  end
  object btn_gravar: TButton
    Left = 191
    Top = 116
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 5
    OnClick = btn_gravarClick
  end
  object btn_consultar: TButton
    Left = 308
    Top = 8
    Width = 23
    Height = 21
    Caption = '...'
    TabOrder = 0
    OnClick = btn_consultarClick
  end
  object FDQuery_cadastro_usuario: TFDQuery
    Left = 312
    Top = 72
  end
end
