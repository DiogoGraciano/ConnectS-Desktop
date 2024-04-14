object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object FDQuery_geral: TFDQuery
    Left = 144
    Top = 40
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'lib\libpq.dll'
    Left = 56
    Top = 32
  end
  object FDConnection: TFDConnection
    Left = 56
    Top = 96
  end
end
