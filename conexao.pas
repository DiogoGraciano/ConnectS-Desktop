unit conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Phys.PGDef,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PG,
  FireDAC.Comp.DataSet;

type
  TDataModule1 = class(TDataModule)
    FDQuery_geral: TFDQuery;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    FDConnection: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
//cria o componente de conexão com o posrgresql
  FDConnection.Create(nil);
  FDConnection.Params.Clear;
  FDConnection.Params.Values['DriverID'] := 'PG';
  FDConnection.Params.Values['User_name'] := 'postgres';
  FDConnection.Params.Values['Password'] := 'hm1722+#()';
  FDConnection.Params.Values['Database'] := 'app';
  FDConnection.Params.Values['Server'] := '192.168.60.206';
  //cria o componente a query
  FDQuery_geral.Create(nil);
  FDQuery_geral.Connection := FDConnection;
end;

end.
