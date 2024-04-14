unit tela_ramal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.PGDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.PG, Vcl.Menus;

type
  Tform_ramal = class(TForm)
    grid_ramal: TDBGrid;
    FDConnection: TFDConnection;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    FDQuery_ramal: TFDQuery;
    data_ramal: TDataSource;
    PopupMenu: TPopupMenu;
    Cadastrar1: TMenuItem;
    Cadastrar2: TMenuItem;
    Editar1: TMenuItem;
    Exportar1: TMenuItem;
    SaveDialog: TSaveDialog;
    RelatorioDetalhado1: TMenuItem;
    RelatorioReduzido1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure grid_ramalCellClick(Column: TColumn);
    procedure Cadastrar2Click(Sender: TObject);
    procedure Cadastrar1Click(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure Exportar1Click(Sender: TObject);
    procedure grid_ramalTitleClick(Column: TColumn);
    procedure RelatorioDetalhado1Click(Sender: TObject);
    procedure RelatorioReduzido1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_ramal: Tform_ramal;

implementation

{$R *.dfm}

uses tela_cadastro, tela_cadastro_ramal;

procedure Tform_ramal.Cadastrar1Click(Sender: TObject);
var
open : Tform_cadastro_ramal;
begin
  open := Tform_cadastro_ramal.Create(self);
  open.ShowModal;
end;

procedure Tform_ramal.Cadastrar2Click(Sender: TObject);
var
ramal : string;
begin
    If MessageDlg('Você tem certeza que deseja excluir o registro selecionado? (irá excluir todas suas conexões)',mtConfirmation,[mbyes,mbno],0)=mryes then
      begin
      ramal := grid_ramal.columns.items[0].field.text;
      FDQuery_ramal.close;
      FDQuery_ramal.SQL.Clear;
      FDQuery_ramal.SQL.Add('DELETE FROM cadastro.tb_ramal WHERE cd_ramal = '+ramal+'');
      FDQuery_ramal.ExecSQL;
      FDQuery_ramal.close;
      FDQuery_ramal.SQL.Clear;
      FDQuery_ramal.SQL.Add('SELECT cd_ramal, nm_funcionario, nr_ramal, nr_telefone FROM cadastro.tb_ramal');
      FDQuery_ramal.open;
      Grid_ramal.Columns[0].Title.Caption := 'Codigo';
      Grid_ramal.Columns[0].Width := 40;
      Grid_ramal.Columns[1].Title.Caption := 'Nome';
      Grid_ramal.Columns[1].Width := 120;
      Grid_ramal.Columns[2].Title.Caption := 'Ramal';
      Grid_ramal.Columns[2].Width := 40;
      Grid_ramal.Columns[3].Title.Caption := 'Telefone';
      Grid_ramal.Columns[3].Width := 80;
     end
    else
      begin
        MessageDlg('Nenhum registro excluido!',mtInformation,[mbOk],0);
      end;
end;

procedure Tform_ramal.Editar1Click(Sender: TObject);
var
open : Tform_cadastro_ramal;
cd_ramal : string;
begin

    cd_ramal := grid_ramal.columns.items[0].field.text;
    FDQuery_ramal.close;
    FDQuery_ramal.SQL.Clear;
    FDQuery_ramal.SQL.Add('SELECT cd_ramal, nm_funcionario, nr_ramal, nr_telefone, nr_ip, nm_usuario, senha, obs FROM cadastro.tb_ramal where cd_ramal = '+cd_ramal+'');
    FDQuery_ramal.open;
    Grid_ramal.Columns[0].Title.Caption := 'Codigo';
    Grid_ramal.Columns[0].Width := 40;
    Grid_ramal.Columns[1].Title.Caption := 'Nome';
    Grid_ramal.Columns[1].Width := 120;
    Grid_ramal.Columns[2].Title.Caption := 'Ramal';
    Grid_ramal.Columns[2].Width := 40;
    Grid_ramal.Columns[3].Title.Caption := 'Telefone';
    Grid_ramal.Columns[3].Width := 80;
    Grid_ramal.Columns[4].Title.Caption := 'IP';
    Grid_ramal.Columns[4].Width := 80;
    Grid_ramal.Columns[5].Title.Caption := 'Usuario';
    Grid_ramal.Columns[5].Width := 80;
    Grid_ramal.Columns[6].Title.Caption := 'Senha';
    Grid_ramal.Columns[6].Width := 80;
    Grid_ramal.Columns[7].Title.Caption := 'Obs';
    Grid_ramal.Columns[7].Width := 150;
    open := Tform_cadastro_ramal.Create(self);
    open.txt_box_cd_ramal.text := grid_ramal.columns.items[0].field.text;
    open.txt_box_nr_ramal.text := grid_ramal.columns.items[2].field.text;
    open.txt_box_nr_telefone.text := grid_ramal.columns.items[3].field.text;
    open.txt_box_nm_funcionario.text := grid_ramal.columns.items[1].field.text;
    open.txt_box_nr_ip.text := grid_ramal.columns.items[4].field.text;
    open.txt_box_nm_usuario.text := grid_ramal.columns.items[5].field.text;
    open.txt_box_senha.text := grid_ramal.columns.items[6].field.text;
    open.txt_box_obs.text := grid_ramal.columns.items[7].field.text;
    open.ShowModal;
end;

procedure Tform_ramal.Exportar1Click(Sender: TObject);
var
   ArqTxt : TextFile;
   Linha1 : string;
   colunas,i,c : integer;
begin
  if SaveDialog.Execute = true then
  begin
  ExtractFilePath( SaveDialog.FileName );
  end;
  // cria o arquivo
  AssignFile(ArqTxt, SaveDialog.FileName + '.csv');
  Rewrite(ArqTxt);
  colunas := FDQuery_ramal.FieldCount;
  i := -1;
  colunas := colunas - 1;
  // cria colunas
  while colunas <> i do
  begin
    i := i + 1;
    Linha1 := grid_ramal.columns[i].Title.Caption;
    write(ArqTxt, ';' + Linha1);
  end;
  writeln(ArqTxt, ';');
  // cria rows
  while not FDQuery_ramal.Eof do
  begin
    for c := 0 to colunas do
    begin
      Linha1 := grid_ramal.fields[c].DisplayText;
      write(ArqTxt, ';' + Linha1);
    end;
    writeln(ArqTxt, ';');
    FDQuery_ramal.Next
  end;
  CloseFile(ArqTxt);
  Application.MessageBox('Concluido', 'SUCESSO', mb_ok + mb_iconINFORMATION);
end;



procedure Tform_ramal.FormCreate(Sender: TObject);
begin
  //cria o componente de conexão com o posrgresql
  FDConnection.Create(nil);
  try
  FDConnection.Params.Clear;
  FDConnection.Params.Values['DriverID'] := 'PG';
  FDConnection.Params.Values['User_name'] := 'postgres';
  FDConnection.Params.Values['Password'] := '123456';
  FDConnection.Params.Values['Database'] := 'app';
  FDConnection.Params.Values['Server'] := '192.168.60.206';
  FDConnection.Params.Values['Port'] := '5433';
  FDConnection.Connected := True;
  except
  Application.MessageBox('Erro na Conexão a Base Reinicie a Aplicação','ERRO', mb_ok+mb_iconerror);
  end;
  //cria o componente a query, data e grid
  FDQuery_ramal.Create(nil);
  FDQuery_ramal.Connection := FDConnection;
  data_ramal.Create(nil);
  data_ramal.DataSet := FDQuery_ramal;
  Grid_ramal.Create(nil);
  Grid_ramal.DataSource := data_ramal;
  //consulta as conexões
  FDQuery_ramal.close;
  FDQuery_ramal.SQL.Clear;
  FDQuery_ramal.SQL.Add('SELECT cd_ramal, nm_funcionario, nr_ramal, nr_telefone FROM cadastro.tb_ramal');
  FDQuery_ramal.open;
  Grid_ramal.columns[0].Title.Caption := 'Codigo';
  grid_ramal.columns[0].Width := 40;
  grid_ramal.columns[1].Title.Caption := 'Nome';
  grid_ramal.columns[1].Width := 120;
  grid_ramal.columns[2].Title.Caption := 'Ramal';
  grid_ramal.columns[2].Width := 40;
  grid_ramal.columns[3].Title.Caption := 'Telefone';
  grid_ramal.columns[3].Width := 90;
end;

procedure Tform_ramal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then Close;
  if key=#13 then Perform(WM_nextdlgctl,0,0);
end;

procedure Tform_ramal.grid_ramalCellClick(Column: TColumn);
var
  p: TPoint;
begin
  p := Mouse.CursorPos;
  PopupMenu.Popup(p.X, p.Y);
end;


procedure Tform_ramal.grid_ramalTitleClick(Column: TColumn);
var
i : integer;
begin
  for i := 0 to Grid_ramal.Columns.Count - 1 do
    begin
        // retira a formatação negrito/itálico
        Grid_ramal.Columns[I].Title.Font.Style := [];
        // altera a cor da fonte do título para Black
        Grid_ramal.Columns[I].Title.Font.Color := clBlack;
    end;
  with FDQuery_ramal do
    begin
      // coloca em cresente e formata o titulo
      if IndexFieldNames = Column.FieldName + ':D' then
        begin
           IndexFieldNames := Column.FieldName + ':A';
           Column.Title.Font.Style := [fsBold];
           Column.Title.Font.Color := clRed;
        end
      // coloca em decresente e formata o titulo
      else
         IndexFieldNames := Column.FieldName + ':D';
         Column.Title.Font.Style := [fsBold];
         Column.Title.Font.Color := clRed;
    end;
  // volta a primeira row
  FDQuery_ramal.First;
end;

procedure Tform_ramal.RelatorioDetalhado1Click(Sender: TObject);
begin
    FDQuery_ramal.close;
    FDQuery_ramal.SQL.Clear;
    FDQuery_ramal.SQL.Add('SELECT cd_ramal, nm_funcionario, nr_ramal, nr_telefone, nr_ip, nm_usuario, senha, obs FROM cadastro.tb_ramal');
    FDQuery_ramal.open;
    Grid_ramal.Columns[0].Title.Caption := 'Codigo';
    Grid_ramal.Columns[0].Width := 40;
    Grid_ramal.Columns[1].Title.Caption := 'Nome';
    Grid_ramal.Columns[1].Width := 120;
    Grid_ramal.Columns[2].Title.Caption := 'Ramal';
    Grid_ramal.Columns[2].Width := 40;
    Grid_ramal.Columns[3].Title.Caption := 'Telefone';
    Grid_ramal.Columns[3].Width := 90;
    Grid_ramal.Columns[4].Title.Caption := 'IP';
    Grid_ramal.Columns[4].Width := 90;
    Grid_ramal.Columns[5].Title.Caption := 'Usuario';
    Grid_ramal.Columns[5].Width := 80;
    Grid_ramal.Columns[6].Title.Caption := 'Senha';
    Grid_ramal.Columns[6].Width := 80;
    Grid_ramal.Columns[7].Title.Caption := 'Obs';
    Grid_ramal.Columns[7].Width := 150;
    form_ramal.Width := 750;
end;

procedure Tform_ramal.RelatorioReduzido1Click(Sender: TObject);
begin
    FDQuery_ramal.close;
    FDQuery_ramal.SQL.Clear;
    FDQuery_ramal.SQL.Add('SELECT cd_ramal, nm_funcionario, nr_ramal, nr_telefone FROM cadastro.tb_ramal');
    FDQuery_ramal.open;
    Grid_ramal.Columns[0].Title.Caption := 'Codigo';
    Grid_ramal.Columns[0].Width := 40;
    Grid_ramal.Columns[1].Title.Caption := 'Nome';
    Grid_ramal.Columns[1].Width := 120;
    Grid_ramal.Columns[2].Title.Caption := 'Ramal';
    Grid_ramal.Columns[2].Width := 40;
    Grid_ramal.Columns[3].Title.Caption := 'Telefone';
    Grid_ramal.Columns[3].Width := 90;
    form_ramal.Width := 340;
end;

end.
