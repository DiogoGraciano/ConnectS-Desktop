object form_cadastro_ramal: Tform_cadastro_ramal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro'
  ClientHeight = 178
  ClientWidth = 346
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object txt_cd_cliente: TLabel
    Left = 16
    Top = 11
    Width = 33
    Height = 13
    Caption = 'Codigo'
  end
  object txt_nm_cliente: TLabel
    Left = 22
    Top = 38
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object txt_nr_loja: TLabel
    Left = 107
    Top = 11
    Width = 29
    Height = 13
    Caption = 'Ramal'
  end
  object txt_telefone: TLabel
    Left = 7
    Top = 66
    Width = 42
    Height = 13
    Caption = 'Telefone'
  end
  object txt_ip: TLabel
    Left = 151
    Top = 66
    Width = 10
    Height = 13
    Caption = 'IP'
  end
  object txt_usuario: TLabel
    Left = 13
    Top = 93
    Width = 36
    Height = 13
    Caption = 'Usuario'
  end
  object txt_senha: TLabel
    Left = 179
    Top = 92
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object Label1: TLabel
    Left = 30
    Top = 119
    Width = 19
    Height = 13
    Caption = 'Obs'
  end
  object txt_box_cd_ramal: TEdit
    Left = 55
    Top = 8
    Width = 46
    Height = 21
    CharCase = ecUpperCase
    Color = clScrollBar
    NumbersOnly = True
    ReadOnly = True
    TabOrder = 8
  end
  object btn_gravar: TButton
    Left = 142
    Top = 146
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 7
    OnClick = btn_gravarClick
  end
  object txt_box_nm_funcionario: TEdit
    Left = 55
    Top = 35
    Width = 283
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object txt_box_nr_ramal: TEdit
    Left = 142
    Top = 8
    Width = 43
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 0
  end
  object txt_box_nr_telefone: TMaskEdit
    Left = 55
    Top = 62
    Width = 90
    Height = 21
    EditMask = '!\(99\)00000-0000;1;_'
    MaxLength = 14
    TabOrder = 1
    Text = '(  )     -    '
  end
  object txt_box_nr_ip: TEdit
    Left = 167
    Top = 62
    Width = 169
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 15
    TabOrder = 3
  end
  object txt_box_nm_usuario: TEdit
    Left = 55
    Top = 89
    Width = 114
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 15
    TabOrder = 4
  end
  object txt_box_senha: TEdit
    Left = 215
    Top = 89
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 15
    TabOrder = 5
  end
  object txt_box_obs: TEdit
    Left = 55
    Top = 116
    Width = 281
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 6
  end
  object FDQuery_cadastro_ramal: TFDQuery
    Left = 248
    Top = 67
  end
end
