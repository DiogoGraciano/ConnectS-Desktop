object form_consulta_cliente: Tform_consulta_cliente
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Consulta Clientes'
  ClientHeight = 347
  ClientWidth = 492
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 40
    Width = 480
    Height = 271
    Caption = 'Panel1'
    TabOrder = 2
    object grid_consulta_cliente: TDBGrid
      Left = 1
      Top = 1
      Width = 478
      Height = 269
      Align = alClient
      PopupMenu = PopupMenu
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = grid_consulta_clienteCellClick
      OnTitleClick = grid_consulta_clienteTitleClick
    end
  end
  object txt_box_pesquisa: TEdit
    Left = 159
    Top = 8
    Width = 248
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 0
  end
  object btn_pesquisa: TButton
    Left = 413
    Top = 6
    Width = 75
    Height = 25
    Caption = 'Pesquisar'
    TabOrder = 1
    OnClick = btn_pesquisaClick
  end
  object btn_novo: TButton
    Left = 8
    Top = 317
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 3
    OnClick = btn_novoClick
  end
  object btn_editar: TButton
    Left = 89
    Top = 317
    Width = 75
    Height = 25
    Caption = 'Editar'
    TabOrder = 4
    OnClick = btn_editarClick
    OnKeyPress = btn_editarKeyPress
  end
  object btn_excluir: TButton
    Left = 170
    Top = 317
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 5
    OnClick = btn_excluirClick
  end
  object cb_pesquisa: TComboBox
    Left = 8
    Top = 8
    Width = 145
    Height = 21
    CharCase = ecUpperCase
    ItemIndex = 0
    TabOrder = 6
    Text = 'CODIGO CLIENTE'
    Items.Strings = (
      'CODIGO CLIENTE'
      'NOME CLIENTE')
  end
  object FDQuery_consulta_cliente: TFDQuery
    Left = 240
    Top = 160
  end
  object data_consulta_cliente: TDataSource
    Left = 400
    Top = 184
  end
  object PopupMenu: TPopupMenu
    Left = 200
    Top = 104
    object Cadastrar1: TMenuItem
      Caption = 'Cadastrar'
      OnClick = btn_novoClick
    end
    object Editar1: TMenuItem
      Caption = 'Editar'
      OnClick = btn_editarClick
    end
    object Editar2: TMenuItem
      Caption = 'Excluir'
      OnClick = btn_excluirClick
    end
  end
end
