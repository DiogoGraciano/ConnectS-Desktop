object form_cadastro: Tform_cadastro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro'
  ClientHeight = 173
  ClientWidth = 438
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
    Left = 8
    Top = 38
    Width = 69
    Height = 13
    Caption = 'Codigo Cliente'
  end
  object txt_nm_programa: TLabel
    Left = 8
    Top = 65
    Width = 46
    Height = 13
    Caption = 'Programa'
  end
  object txt_id_conexao: TLabel
    Left = 187
    Top = 38
    Width = 56
    Height = 13
    Caption = 'Id Conexao'
  end
  object txt_terminal: TLabel
    Left = 187
    Top = 66
    Width = 40
    Height = 13
    Caption = 'Terminal'
  end
  object txt_nm_usuario: TLabel
    Left = 8
    Top = 92
    Width = 36
    Height = 13
    Caption = 'Usuario'
  end
  object txt_obs: TLabel
    Left = 8
    Top = 119
    Width = 63
    Height = 13
    Caption = 'Observa'#231#245'es'
  end
  object txt_senha: TLabel
    Left = 226
    Top = 92
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object txt_nr_caixa: TLabel
    Left = 360
    Top = 66
    Width = 41
    Height = 13
    Caption = 'Nr Caixa'
    Color = clWindow
    ParentColor = False
  end
  object txt_box_cd_conexao: TEdit
    Left = 93
    Top = 8
    Width = 59
    Height = 21
    CharCase = ecUpperCase
    Color = clScrollBar
    TabOrder = 9
  end
  object txt_box_cd_cliente: TEdit
    Left = 83
    Top = 35
    Width = 69
    Height = 21
    CharCase = ecUpperCase
    Color = clScrollBar
    TabOrder = 10
  end
  object txt_box_id_conexao: TEdit
    Left = 249
    Top = 35
    Width = 181
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object txt_box_obs: TEdit
    Left = 77
    Top = 116
    Width = 353
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 7
  end
  object txt_box_senha: TEdit
    Left = 262
    Top = 89
    Width = 168
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 6
  end
  object txt_box_nm_usuario: TEdit
    Left = 50
    Top = 89
    Width = 168
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 5
  end
  object cb_nm_programa: TComboBox
    Left = 60
    Top = 62
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    ItemIndex = 0
    TabOrder = 2
    Text = 'ANYDESK'
    Items.Strings = (
      'ANYDESK'
      'TEAMVIWER'
      'NETSUPORTE'
      'RUSKDESK'
      'WTS'
      'RADMIN'
      'VNC'
      'OUTRO')
  end
  object cb_nm_terminal: TComboBox
    Left = 233
    Top = 62
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    ItemIndex = 0
    TabOrder = 3
    Text = 'BALCAO'
    OnChange = cb_nm_terminalChange
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
    Top = 143
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 8
    OnClick = btn_gravarClick
  end
  object txt_box_nr_caixa: TEdit
    Left = 404
    Top = 62
    Width = 26
    Height = 21
    CharCase = ecUpperCase
    Color = clScrollBar
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clScrollBar
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 2
    NumbersOnly = True
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object btn_consultar: TButton
    Left = 158
    Top = 35
    Width = 23
    Height = 21
    Caption = '...'
    TabOrder = 0
    OnClick = SpeedButton1Click
  end
  object FDQuery_cadastro: TFDQuery
    Left = 344
    Top = 80
  end
end
