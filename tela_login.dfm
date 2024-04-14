object form_login: Tform_login
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'LOGIN'
  ClientHeight = 126
  ClientWidth = 235
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object txt_senha: TLabel
    AlignWithMargins = True
    Left = 13
    Top = 44
    Width = 33
    Height = 13
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Caption = 'SENHA'
  end
  object txt_usuario: TLabel
    AlignWithMargins = True
    Left = 6
    Top = 11
    Width = 46
    Height = 13
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Caption = 'USUARIO'
  end
  object txt_esqueci: TLabel
    Left = 76
    Top = 105
    Width = 99
    Height = 13
    Caption = 'Esqueci minha senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = txt_esqueciClick
  end
  object btn_login: TButton
    AlignWithMargins = True
    Left = 86
    Top = 73
    Width = 81
    Height = 28
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Caption = 'ENTRAR'
    TabOrder = 2
    OnClick = btn_loginClick
  end
  object txt_box_senha: TEdit
    Left = 57
    Top = 39
    Width = 171
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object txt_box_usuario: TEdit
    Left = 57
    Top = 8
    Width = 171
    Height = 21
    CharCase = ecUpperCase
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
  end
  object FDQuery_geral: TFDQuery
    Left = 184
    Top = 32
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'lib\libpq.dll'
    Left = 72
    Top = 24
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Port=5433'
      'Database=app'
      'Password=123456'
      'ConnectionDef=pg')
    LoginPrompt = False
    Left = 136
    Top = 21
  end
end
