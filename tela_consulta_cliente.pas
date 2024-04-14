unit tela_consulta_cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus;

type
  Tform_consulta_cliente = class(TForm)
    Panel1: TPanel;
    grid_consulta_cliente: TDBGrid;
    txt_box_pesquisa: TEdit;
    btn_pesquisa: TButton;
    btn_novo: TButton;
    btn_editar: TButton;
    FDQuery_consulta_cliente: TFDQuery;
    data_consulta_cliente: TDataSource;
    btn_excluir: TButton;
    cb_pesquisa: TComboBox;
    PopupMenu: TPopupMenu;
    Cadastrar1: TMenuItem;
    Editar1: TMenuItem;
    Editar2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_pesquisaClick(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_editarKeyPress(Sender: TObject; var Key: Char);
    procedure grid_consulta_clienteTitleClick(Column: TColumn);
    procedure grid_consulta_clienteCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_consulta_cliente: Tform_consulta_cliente;

implementation

{$R *.dfm}

uses tela_login, tela_cadastro_cliente, tela_cadastro, tela_conexao;

procedure Tform_consulta_cliente.btn_editarClick(Sender: TObject);
var
open : Tform_cadastro_cliente;
begin
   open := Tform_cadastro_cliente.Create(self);
   open.txt_box_cd_cliente.Text := grid_consulta_cliente.columns.items[0].field.text;
   open.txt_box_nm_cliente.Text := grid_consulta_cliente.columns.items[2].field.text;
   open.txt_box_nr_loja.Text := grid_consulta_cliente.columns.items[1].field.text;
   open.ShowModal;
end;

procedure Tform_consulta_cliente.btn_editarKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key = #27 Then Close;
  if key=#13 then Perform(WM_nextdlgctl,0,0);
end;

procedure Tform_consulta_cliente.btn_excluirClick(Sender: TObject);
var
cd_conexao : string;
begin
  If  MessageDlg('Você tem certeza que deseja excluir o registro selecionado? (irá excluir todas suas conexões e usuarios)',mtConfirmation,[mbyes,mbno],0)=mryes
  then
     begin
        cd_conexao := grid_consulta_cliente.columns.items[0].field.text;
        FDQuery_consulta_cliente.close;
        FDQuery_consulta_cliente.SQL.Clear;
        FDQuery_consulta_cliente.SQL.Add('delete from cadastro.tb_cliente where cd_cliente = '+cd_conexao+'');
        FDQuery_consulta_cliente.ExecSQL;
        FDQuery_consulta_cliente.close;
        FDQuery_consulta_cliente.SQL.Clear;
        FDQuery_consulta_cliente.SQL.Add('select cd_cliente, nr_loja, nm_cliente from cadastro.tb_cliente');
        FDQuery_consulta_cliente.open;
        grid_consulta_cliente.Columns[0].Title.Caption := 'Codigo';
        grid_consulta_cliente.Columns[0].Width := 40;
        grid_consulta_cliente.Columns[1].Title.Caption := 'Loja';
        grid_consulta_cliente.Columns[1].Width := 40;
        grid_consulta_cliente.Columns[2].Title.Caption := 'Nome Cliente';
        grid_consulta_cliente.Columns[2].Width := 200;
     end
  else
    begin
      MessageDlg('Nenhum registro excluido!',mtInformation,[mbOk],0);
    end;

end;

procedure Tform_consulta_cliente.btn_novoClick(Sender: TObject);
var
open : Tform_cadastro_cliente;
begin
   open := Tform_cadastro_cliente.Create(self);
   open.ShowModal;
end;

procedure Tform_consulta_cliente.btn_pesquisaClick(Sender: TObject);
begin
    //verifica se foi preenchido o campo pesquisa se não refaz o select
    if txt_box_pesquisa.text = '' then
      begin
        FDQuery_consulta_cliente.close;
        FDQuery_consulta_cliente.SQL.Clear;
        FDQuery_consulta_cliente.SQL.Add('select cd_cliente, nr_loja, nm_cliente from cadastro.tb_cliente');
        FDQuery_consulta_cliente.open;
        grid_consulta_cliente.Columns[0].Title.Caption := 'Codigo';
        grid_consulta_cliente.Columns[0].Width := 40;
        grid_consulta_cliente.Columns[1].Title.Caption := 'Loja';
        grid_consulta_cliente.Columns[1].Width := 40;
        grid_consulta_cliente.Columns[2].Title.Caption := 'Nome Cliente';
        grid_consulta_cliente.Columns[2].Width := 200;

      end
    //faz o select por codigo de cliente
    else if cb_pesquisa.text = 'CODIGO CLIENTE' then
      begin
        FDQuery_consulta_cliente.close;
        FDQuery_consulta_cliente.SQL.Clear;
        FDQuery_consulta_cliente.SQL.Add('select cd_cliente, nr_loja, nm_cliente from cadastro.tb_cliente where cd_cliente = '+txt_box_pesquisa.Text+'');
        FDQuery_consulta_cliente.open;
        grid_consulta_cliente.Columns[0].Title.Caption := 'Codigo';
        grid_consulta_cliente.Columns[0].Width := 40;
        grid_consulta_cliente.Columns[1].Title.Caption := 'Loja';
        grid_consulta_cliente.Columns[1].Width := 40;
        grid_consulta_cliente.Columns[2].Title.Caption := 'Nome Cliente';
        grid_consulta_cliente.Columns[2].Width := 200;
      end
    //faz o select por nome de cliente
    else if cb_pesquisa.text = 'NOME CLIENTE' then
      begin
        FDQuery_consulta_cliente.close;
        FDQuery_consulta_cliente.SQL.Clear;
        FDQuery_consulta_cliente.SQL.Add('select cd_cliente, nr_loja, nm_cliente from cadastro.tb_cliente where nm_cliente like :nome');
        FDQuery_consulta_cliente.ParamByName('nome').Asstring := '%'+AnsiUpperCase(txt_box_pesquisa.Text)+'%';
        FDQuery_consulta_cliente.open;
        grid_consulta_cliente.Columns[0].Title.Caption := 'Codigo';
        grid_consulta_cliente.Columns[0].Width := 40;
        grid_consulta_cliente.Columns[1].Title.Caption := 'Loja';
        grid_consulta_cliente.Columns[1].Width := 40;
        grid_consulta_cliente.Columns[2].Title.Caption := 'Nome Cliente';
        grid_consulta_cliente.Columns[2].Width := 200;
      end
end;

procedure Tform_consulta_cliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with form_conexao do
    begin
      FDQuery_conexao.close;
      FDQuery_conexao.SQL.Clear;
      FDQuery_conexao.SQL.Add('select cd_conexao,tb_conexao.cd_cliente,nm_cliente,nr_loja,id_conexao,nm_terminal,nr_caixa,nm_programa,nm_usuario,senha,obs from cadastro.tb_conexao inner join cadastro.tb_cliente on tb_cliente.cd_cliente = tb_conexao.cd_cliente');
      FDQuery_conexao.open;
      Grid_conexao.Columns[0].Title.Caption := 'Codigo';
      Grid_conexao.Columns[0].Width := 40;
      Grid_conexao.Columns[1].Title.Caption := 'Cliente';
      Grid_conexao.Columns[1].Width := 40;
      Grid_conexao.Columns[2].Title.Caption := 'Nome Cliente';
      Grid_conexao.Columns[2].Width := 300;
      Grid_conexao.Columns[3].Title.Caption := 'Loja';
      Grid_conexao.Columns[3].Width := 35;
      Grid_conexao.Columns[4].Title.Caption := 'Acesso';
      Grid_conexao.Columns[4].Width := 200;
      Grid_conexao.Columns[5].Title.Caption := 'Terminal';
      Grid_conexao.Columns[5].Width := 100;
      Grid_conexao.Columns[6].Title.Caption := 'Caixa';
      Grid_conexao.Columns[6].Width := 35;
      Grid_conexao.Columns[7].Title.Caption := 'Programa';
      Grid_conexao.Columns[7].Width := 80;
      Grid_conexao.Columns[8].Title.Caption := 'Usuario';
      Grid_conexao.Columns[8].Width := 150;
      Grid_conexao.Columns[9].Title.Caption := 'Senha';
      Grid_conexao.Columns[9].Width := 100;
    end;
  with form_conexao do
    begin
        FDQuery_usuario.close;
        FDQuery_usuario.SQL.Clear;
        FDQuery_usuario.SQL.Add('SELECT cd_usuario, tb_usuario.cd_cliente, nm_cliente, nm_sistema, nm_terminal, nm_usuario, senha, obs FROM cadastro.tb_usuario INNER JOIN cadastro.tb_cliente on cadastro.tb_usuario.cd_cliente = cadastro.tb_cliente.cd_cliente');
        FDQuery_usuario.open;
        Grid_usuario.Columns[0].Title.Caption := 'Codigo';
        Grid_usuario.Columns[0].Width := 40;
        Grid_usuario.Columns[1].Title.Caption := 'Cliente';
        Grid_usuario.Columns[1].Width := 40;
        Grid_usuario.Columns[2].Title.Caption := 'Nome Cliente';
        Grid_usuario.Columns[2].Width := 300;
        Grid_usuario.Columns[3].Title.Caption := 'Sistema Operacional';
        Grid_usuario.Columns[3].Width := 200;
        Grid_usuario.Columns[4].Title.Caption := 'Terminal';
        Grid_usuario.Columns[4].Width := 150;
        Grid_usuario.Columns[5].Title.Caption := 'Usuario';
        Grid_usuario.Columns[5].Width := 200;
        Grid_usuario.Columns[6].Title.Caption := 'Senha';
        Grid_usuario.Columns[6].Width := 200;
        Grid_usuario.Columns[7].Title.Caption := 'Obs';
        Grid_usuario.Columns[7].Width := 200;
    end;
end;

procedure Tform_consulta_cliente.FormCreate(Sender: TObject);
begin
    FDQuery_consulta_cliente.Create(nil);
    FDQuery_consulta_cliente.Connection := form_login.FDConnection;
    data_consulta_cliente.Create(nil);
    data_consulta_cliente.DataSet := FDQuery_consulta_cliente;
    grid_consulta_cliente.Create(nil);
    grid_consulta_cliente.DataSource := data_consulta_cliente;
    //consulta as conexões
    FDQuery_consulta_cliente.close;
    FDQuery_consulta_cliente.SQL.Clear;
    FDQuery_consulta_cliente.SQL.Add('select cd_cliente, nr_loja, nm_cliente from cadastro.tb_cliente');
    FDQuery_consulta_cliente.open;
    grid_consulta_cliente.Columns[0].Title.Caption := 'Codigo';
    grid_consulta_cliente.Columns[0].Width := 40;
    grid_consulta_cliente.Columns[1].Title.Caption := 'Loja';
    grid_consulta_cliente.Columns[1].Width := 40;
    grid_consulta_cliente.Columns[2].Title.Caption := 'Nome Cliente';
    grid_consulta_cliente.Columns[2].Width := 200;

end;

procedure Tform_consulta_cliente.grid_consulta_clienteCellClick(
  Column: TColumn);
var
  p: TPoint;
begin
  p := Mouse.CursorPos;
  PopupMenu.Popup(p.X, p.Y);
end;

procedure Tform_consulta_cliente.grid_consulta_clienteTitleClick(
  Column: TColumn);
var
i : integer;
begin
  for i := 0 to grid_consulta_cliente.Columns.Count - 1 do
    begin
        // retira a formatação negrito/itálico
        grid_consulta_cliente.Columns[I].Title.Font.Style := [];
        // altera a cor da fonte do título para Black
        grid_consulta_cliente.Columns[I].Title.Font.Color := clBlack;
    end;
  with FDQuery_consulta_cliente do
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
  FDQuery_consulta_cliente.First;
end;

end.
