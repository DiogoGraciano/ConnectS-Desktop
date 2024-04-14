object form_conexao: Tform_conexao
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Conex'#245'es'
  ClientHeight = 546
  ClientWidth = 1323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = PopupMenu2
  WindowState = wsMaximized
  OnClick = FormClick
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  DesignSize = (
    1323
    546)
  PixelsPerInch = 96
  TextHeight = 13
  object btn_consultar: TSpeedButton
    Left = 199
    Top = 8
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = btn_consultarClick
  end
  object txt_conexões: TLabel
    Left = 8
    Top = 35
    Width = 48
    Height = 13
    Caption = 'Conex'#245'es'
  end
  object txt_usuarios: TLabel
    Left = 8
    Top = 392
    Width = 88
    Height = 13
    Caption = 'Usuarios e Senhas'
  end
  object Panel1: TPanel
    Left = 8
    Top = 54
    Width = 1307
    Height = 332
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Panel1'
    TabOrder = 2
    object grid_conexao: TDBGrid
      Left = 1
      Top = 1
      Width = 1305
      Height = 330
      Align = alClient
      PopupMenu = PopupMenu
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Visible = False
      OnCellClick = grid_conexaoCellClick
      OnTitleClick = grid_conexaoTitleClick
    end
  end
  object txt_box_pesquisa: TEdit
    Left = 228
    Top = 8
    Width = 1006
    Height = 21
    CharCase = ecUpperCase
    NumbersOnly = True
    TabOrder = 0
  end
  object btn_pesquisar: TButton
    Left = 1240
    Top = 6
    Width = 75
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'PESQUISAR'
    TabOrder = 1
    OnClick = btn_pesquisarClick
  end
  object cb_pesquisa: TComboBox
    Left = 8
    Top = 8
    Width = 185
    Height = 21
    ItemIndex = 0
    TabOrder = 3
    Text = 'CODIGO CLIENTE'
    OnChange = cb_pesquisaChange
    Items.Strings = (
      'CODIGO CLIENTE'
      'NOME CLIENTE')
  end
  object Panel2: TPanel
    Left = 8
    Top = 411
    Width = 1307
    Height = 127
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 4
    object grid_usuario: TDBGrid
      Left = 1
      Top = 1
      Width = 1305
      Height = 125
      Align = alClient
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnTitleClick = grid_usuarioTitleClick
    end
  end
  object data_conexao: TDataSource
    Left = 368
    Top = 175
  end
  object FDQuery_conexao: TFDQuery
    Left = 272
    Top = 181
  end
  object SaveDialog: TSaveDialog
    FileName = 'Relatorio'
    Left = 432
    Top = 181
  end
  object PopupMenu: TPopupMenu
    Left = 160
    Top = 85
    object Cadastrar1: TMenuItem
      Caption = 'Cadastrar'
      OnClick = btn_cadastrarClick
    end
    object Editar2: TMenuItem
      Caption = 'Deletar'
      OnClick = btn_excluirClick
    end
    object Editar1: TMenuItem
      Caption = 'Editar'
      OnClick = btn_editarClick
    end
    object Agenda1: TMenuItem
      Caption = 'Agenda'
      OnClick = Agenda1Click
    end
    object Cliente1: TMenuItem
      Caption = 'Clientes'
      OnClick = btn_clienteClick
    end
    object Ramal1: TMenuItem
      Caption = 'Ramal'
      OnClick = Ramal1Click
    end
    object Mudarsenha1: TMenuItem
      Caption = 'Mudar Senha'
      OnClick = MudarSenha3Click
    end
    object Exportar1: TMenuItem
      Caption = 'Exportar'
      OnClick = btn_csvClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 160
    Top = 197
    object MenuItem1: TMenuItem
      Caption = 'Cadastrar Conex'#227'o'
      OnClick = btn_cadastrarClick
    end
    object CadastrarUsuario1: TMenuItem
      Caption = 'Cadastrar Usuario'
      OnClick = MenuItem2Click
    end
    object MenuItem4: TMenuItem
      Caption = 'Clientes'
      OnClick = btn_clienteClick
    end
    object agenda2: TMenuItem
      Caption = 'Agenda'
      OnClick = Agenda1Click
    end
    object MudarSenha2: TMenuItem
      Caption = 'Mudar Senha'
      OnClick = MudarSenha3Click
    end
    object Ramal2: TMenuItem
      Caption = 'Ramal'
      OnClick = Ramal1Click
    end
    object Exportar2: TMenuItem
      Caption = 'Exportar'
      OnClick = btn_csvClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 176
    Top = 461
    object MenuItem2: TMenuItem
      Caption = 'Cadastrar'
      OnClick = MenuItem2Click
    end
    object Editar3: TMenuItem
      Caption = 'Editar'
      OnClick = Editar3Click
    end
    object Deletar1: TMenuItem
      Caption = 'Deletar'
      OnClick = Deletar1Click
    end
    object MenuItem3: TMenuItem
      Caption = 'Clientes'
      OnClick = btn_clienteClick
    end
    object MenuItem5: TMenuItem
      Caption = 'Agenda'
      OnClick = Agenda1Click
    end
    object MenuItem6: TMenuItem
      Caption = 'Ramal'
      OnClick = Ramal1Click
    end
    object MudarSenha3: TMenuItem
      Caption = 'Mudar Senha'
      OnClick = MudarSenha3Click
    end
    object MenuItem7: TMenuItem
      Caption = 'Exportar'
      OnClick = MenuItem7Click
    end
  end
  object FDQuery_usuario: TFDQuery
    Left = 288
    Top = 285
  end
  object Data_usuario: TDataSource
    Left = 392
    Top = 287
  end
end
