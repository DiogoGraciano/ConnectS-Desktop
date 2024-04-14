object form_cadastro_cliente: Tform_cadastro_cliente
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Cliente'
  ClientHeight = 90
  ClientWidth = 317
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
    Top = 8
    Width = 69
    Height = 13
    Caption = 'Codigo Cliente'
  end
  object txt_nm_cliente: TLabel
    Left = 8
    Top = 37
    Width = 63
    Height = 13
    Caption = 'Nome Cliente'
  end
  object txt_nr_loja: TLabel
    Left = 135
    Top = 8
    Width = 20
    Height = 13
    Caption = 'Loja'
  end
  object txt_box_cd_cliente: TEdit
    Left = 83
    Top = 5
    Width = 46
    Height = 21
    CharCase = ecUpperCase
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 3
  end
  object btn_gravar: TButton
    Left = 123
    Top = 59
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 2
    OnClick = btn_gravarClick
  end
  object txt_box_nm_cliente: TEdit
    Left = 77
    Top = 32
    Width = 232
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object txt_box_nr_loja: TEdit
    Left = 161
    Top = 5
    Width = 48
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 2
    NumbersOnly = True
    TabOrder = 0
  end
  object FDQuery_cadastro_cliente: TFDQuery
    Left = 248
    Top = 16
  end
end
