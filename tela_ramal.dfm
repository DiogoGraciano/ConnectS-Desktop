object form_ramal: Tform_ramal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Ramais'
  ClientHeight = 441
  ClientWidth = 330
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
  object grid_ramal: TDBGrid
    Left = 0
    Top = 0
    Width = 330
    Height = 441
    Align = alClient
    PopupMenu = PopupMenu
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = grid_ramalCellClick
    OnTitleClick = grid_ramalTitleClick
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Port=5433'
      'Database=app'
      'Password=123456'
      'ConnectionDef=pg')
    LoginPrompt = False
    Left = 168
    Top = 85
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'lib\libpq.dll'
    Left = 72
    Top = 24
  end
  object FDQuery_ramal: TFDQuery
    Connection = FDConnection
    Left = 240
    Top = 16
  end
  object data_ramal: TDataSource
    Left = 272
    Top = 168
  end
  object PopupMenu: TPopupMenu
    Left = 184
    Top = 168
    object Cadastrar1: TMenuItem
      Caption = 'Cadastrar'
      OnClick = Cadastrar1Click
    end
    object Cadastrar2: TMenuItem
      Caption = 'Deletar'
      OnClick = Cadastrar2Click
    end
    object Editar1: TMenuItem
      Caption = 'Editar'
      OnClick = Editar1Click
    end
    object Exportar1: TMenuItem
      Caption = 'Exportar'
      OnClick = Exportar1Click
    end
    object RelatorioDetalhado1: TMenuItem
      Caption = 'Relatorio Detalhado'
      OnClick = RelatorioDetalhado1Click
    end
    object RelatorioReduzido1: TMenuItem
      Caption = 'Relatorio Reduzido'
      OnClick = RelatorioReduzido1Click
    end
  end
  object SaveDialog: TSaveDialog
    Left = 200
    Top = 280
  end
end
