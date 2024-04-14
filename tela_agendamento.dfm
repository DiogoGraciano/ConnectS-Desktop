object form_agendamento: Tform_agendamento
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Agendamentos'
  ClientHeight = 456
  ClientWidth = 665
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
  DesignSize = (
    665
    456)
  PixelsPerInch = 96
  TextHeight = 13
  object txt_inicio: TLabel
    Left = 13
    Top = 12
    Width = 25
    Height = 13
    Caption = 'Inicio'
  end
  object txt_fim: TLabel
    Left = 175
    Top = 12
    Width = 16
    Height = 13
    Caption = 'Fim'
  end
  object txt_cd_cliente: TLabel
    Left = 11
    Top = 65
    Width = 33
    Height = 13
    Caption = 'Cliente'
  end
  object txt_colocaborador: TLabel
    Left = 11
    Top = 92
    Width = 55
    Height = 13
    Caption = 'Funcionario'
  end
  object txt_descrição: TLabel
    Left = 11
    Top = 146
    Width = 46
    Height = 13
    Caption = 'Descri'#231#227'o'
  end
  object txt_codigo: TLabel
    Left = 11
    Top = 39
    Width = 33
    Height = 13
    Caption = 'Codigo'
  end
  object txt_cor: TLabel
    Left = 116
    Top = 39
    Width = 17
    Height = 13
    Caption = 'Cor'
  end
  object txt_de: TLabel
    Left = 9
    Top = 281
    Width = 13
    Height = 13
    Caption = 'De'
  end
  object txt_ate: TLabel
    Left = 177
    Top = 281
    Width = 17
    Height = 13
    Caption = 'At'#233
  end
  object txt_status: TLabel
    Left = 11
    Top = 119
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  object txt_nm_cliente: TLabel
    Left = 130
    Top = 65
    Width = 31
    Height = 13
    Constraints.MaxWidth = 183
  end
  object txt_nm_funcionario: TLabel
    Left = 153
    Top = 93
    Width = 163
    Height = 13
    AutoSize = False
    Constraints.MaxWidth = 163
  end
  object CalendarView: TCalendarView
    Left = 322
    Top = 8
    Width = 335
    Height = 261
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    HeaderInfo.DaysOfWeekFont.Color = clWindowText
    HeaderInfo.DaysOfWeekFont.Height = -13
    HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    HeaderInfo.DaysOfWeekFont.Style = []
    HeaderInfo.Font.Charset = DEFAULT_CHARSET
    HeaderInfo.Font.Color = clWindowText
    HeaderInfo.Font.Height = -20
    HeaderInfo.Font.Name = 'Segoe UI'
    HeaderInfo.Font.Style = []
    HighlightColor = clMedGray
    ParentFont = False
    ParentShowHint = False
    SelectionMode = smNone
    ShowHint = False
    TabOrder = 0
  end
  object date_cadastro_inicio: TDateTimePicker
    Left = 50
    Top = 8
    Width = 121
    Height = 21
    Date = 45042.000000000000000000
    Time = 0.555398518517904400
    TabOrder = 1
  end
  object date_cadastro_fim: TDateTimePicker
    Left = 197
    Top = 8
    Width = 119
    Height = 21
    Date = 45042.000000000000000000
    Time = 0.555398518517904400
    TabOrder = 2
  end
  object btn_cliente: TButton
    Left = 95
    Top = 62
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = btn_clienteClick
  end
  object txt_box_cd_cliente: TEdit
    Left = 50
    Top = 62
    Width = 39
    Height = 21
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 4
  end
  object btn_funcionario: TButton
    Left = 121
    Top = 89
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 5
    OnClick = btn_funcionarioClick
  end
  object txt_box_cd_funcionario: TEdit
    Left = 76
    Top = 89
    Width = 39
    Height = 21
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 6
  end
  object txt_box_obs: TEdit
    Left = 63
    Top = 143
    Width = 253
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 7
  end
  object btn_gravar: TButton
    Left = 139
    Top = 170
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 8
    OnClick = btn_gravarClick
  end
  object txt_box_cd_agenda: TEdit
    Left = 50
    Top = 35
    Width = 57
    Height = 21
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 9
  end
  object txt_box_cor: TEdit
    Left = 139
    Top = 35
    Width = 28
    Height = 21
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 10
  end
  object btn_cor: TButton
    Left = 173
    Top = 35
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 11
    OnClick = btn_corClick
  end
  object date_consulta_inicio: TDateTimePicker
    Left = 28
    Top = 277
    Width = 143
    Height = 21
    Date = 45042.000000000000000000
    Time = 0.555398518517904400
    TabOrder = 12
  end
  object date_consulta_fim: TDateTimePicker
    Left = 200
    Top = 277
    Width = 147
    Height = 21
    Date = 45042.000000000000000000
    Time = 0.555398518517904400
    TabOrder = 13
  end
  object cb_status_consulta: TComboBox
    Left = 353
    Top = 277
    Width = 229
    Height = 21
    ItemIndex = 0
    TabOrder = 14
    Text = 'TODOS'
    Items.Strings = (
      'TODOS'
      'PENDENTE'
      'N'#195'O REALIZADO'
      'REALIZADO')
  end
  object btn_buscar: TButton
    Left = 588
    Top = 275
    Width = 70
    Height = 25
    Caption = 'Buscar'
    TabOrder = 15
    OnClick = btn_buscarClick
  end
  object cb_status_cadastro: TComboBox
    Left = 63
    Top = 116
    Width = 252
    Height = 21
    ItemIndex = 0
    TabOrder = 16
    Text = 'PENDENTE'
    Items.Strings = (
      'PENDENTE'
      'N'#195'O REALIZADO'
      'REALIZADO')
  end
  object Panel1: TPanel
    Left = 6
    Top = 304
    Width = 653
    Height = 144
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Panel1'
    TabOrder = 17
    object grid_agenda: TDBGrid
      Left = 1
      Top = 1
      Width = 651
      Height = 142
      Align = alClient
      PopupMenu = PopupMenu
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = grid_agendaCellClick
      OnDrawColumnCell = grid_agendaDrawColumnCell
      OnTitleClick = grid_agendaTitleClick
    end
  end
  object check_mostrartodos: TCheckBox
    Left = 8
    Top = 244
    Width = 308
    Height = 17
    Caption = 'Mostrar todos os agendamentos no periodo selecionado'
    Checked = True
    State = cbChecked
    TabOrder = 18
    OnClick = check_mostrartodosClick
  end
  object PopupMenu: TPopupMenu
    Left = 114
    Top = 152
    object MarcarComoNoRealizado1: TMenuItem
      Caption = 'Marcar Como Pendente'
      OnClick = MarcarComoNoRealizado1Click
    end
    object MarcarcomoFinalizado1: TMenuItem
      Caption = 'Marcar Como Realizado'
      OnClick = MarcarcomoFinalizado1Click
    end
    object MarcarComoNoRealizado2: TMenuItem
      Caption = 'Marcar Como N'#227'o Realizado'
      OnClick = MarcarComoNoRealizado2Click
    end
    object Editar1: TMenuItem
      Caption = 'Editar'
      OnClick = Editar1Click
    end
    object Editar2: TMenuItem
      Caption = 'Excluir'
      OnClick = Editar2Click
    end
    object Exportar1: TMenuItem
      Caption = 'Exportar'
      OnClick = Exportar1Click
    end
  end
  object ColorDialog: TColorDialog
    Color = 65408
    CustomColors.Strings = (
      'ColorA=FFFFFFFF'
      'ColorB=FFFFFFFF'
      'ColorC=FFFFFFFF'
      'ColorD=FFFFFFFF'
      'ColorE=FFFFFFFF'
      'ColorF=FFFFFFFF'
      'ColorG=FFFFFFFF'
      'ColorH=FFFFFFFF'
      'ColorI=FFFFFFFF'
      'ColorJ=FFFFFFFF'
      'ColorK=FFFFFFFF'
      'ColorL=FFFFFFFF'
      'ColorM=FFFFFFFF'
      'ColorN=FFFFFFFF'
      'ColorO=FFFFFFFF'
      'ColorP=FFFFFFFF')
    Left = 226
    Top = 176
  end
  object data_agenda: TDataSource
    Left = 274
    Top = 168
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Port=5433'
      'Database=app'
      'Password=123456'
      'ConnectionDef=pg')
    LoginPrompt = False
    Left = 234
    Top = 77
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'lib\libpq.dll'
    Left = 42
    Top = 168
  end
  object FDQuery_agenda: TFDQuery
    Connection = FDConnection
    Left = 194
    Top = 64
  end
  object SaveDialog: TSaveDialog
    Left = 160
    Top = 200
  end
end
