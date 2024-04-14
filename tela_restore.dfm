object form_restore: Tform_restore
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gera Script Restore'
  ClientHeight = 161
  ClientWidth = 558
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btn_pg: TSpeedButton
    Left = 528
    Top = 54
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = btn_pgClick
  end
  object txt_sistema: TLabel
    Left = 8
    Top = 30
    Width = 97
    Height = 13
    Caption = 'Sistema Operacional'
  end
  object txt_caminho: TLabel
    Left = 8
    Top = 57
    Width = 78
    Height = 13
    Caption = 'Caminho PG/BIN'
  end
  object txt_ip: TLabel
    Left = 208
    Top = 31
    Width = 10
    Height = 13
    Caption = 'IP'
  end
  object txt_nome: TLabel
    Left = 328
    Top = 31
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object SpeedButton1: TSpeedButton
    Left = 528
    Top = 81
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = SpeedButton1Click
  end
  object txt_base: TLabel
    Left = 8
    Top = 85
    Width = 67
    Height = 13
    Caption = 'Caminho Base'
  end
  object txt_box_pg: TEdit
    Left = 111
    Top = 54
    Width = 411
    Height = 21
    TabOrder = 0
    Text = 'C:\Program Files\PostgreSQL\13\bin\'
  end
  object cb_sistema: TComboBox
    Left = 111
    Top = 27
    Width = 90
    Height = 21
    ItemIndex = 0
    TabOrder = 1
    Text = 'WINDOWS'
    Items.Strings = (
      'WINDOWS'
      'LINUX')
  end
  object txt_box_ip: TEdit
    Left = 224
    Top = 27
    Width = 97
    Height = 21
    TabOrder = 2
    Text = '000.000.000.000'
  end
  object txt_box_nome: TEdit
    Left = 361
    Top = 27
    Width = 161
    Height = 21
    TabOrder = 3
  end
  object checkbox_restaurar: TCheckBox
    Left = 101
    Top = 108
    Width = 100
    Height = 17
    Caption = 'Restaurar'
    TabOrder = 4
  end
  object CheckBox_excluir: TCheckBox
    Left = 201
    Top = 108
    Width = 100
    Height = 17
    Caption = 'Excluir'
    TabOrder = 5
  end
  object CheckBox_criar: TCheckBox
    Left = 307
    Top = 108
    Width = 100
    Height = 17
    Caption = 'Criar'
    TabOrder = 6
  end
  object CheckBox_backup: TCheckBox
    Left = 413
    Top = 108
    Width = 100
    Height = 17
    Caption = 'Backup'
    TabOrder = 7
  end
  object btn_gerar: TButton
    Left = 246
    Top = 131
    Width = 75
    Height = 25
    Caption = 'Gerar'
    TabOrder = 8
    OnClick = btn_gerarClick
  end
  object txt_box_base: TEdit
    Left = 111
    Top = 81
    Width = 411
    Height = 21
    TabOrder = 9
    Text = 'C:\base.backup'
  end
  object CheckBox_bat: TCheckBox
    Left = 8
    Top = 4
    Width = 100
    Height = 17
    Caption = 'Gerar em BAT'
    TabOrder = 10
  end
  object SaveDialog: TSaveDialog
    Left = 392
  end
  object OpenDialog: TOpenDialog
    Left = 488
    Top = 16
  end
end
