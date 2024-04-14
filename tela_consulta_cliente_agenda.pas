unit tela_consulta_cliente_agenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls;

type
  Tform_consulta_cliente_agenda = class(TForm)
    Panel1: TPanel;
    grid_consulta_cliente: TDBGrid;
    txt_box_pesquisa: TEdit;
    btn_pesquisa: TButton;
    cb_pesquisa: TComboBox;
    btn_retornar: TButton;
    FDQuery_consulta_cliente: TFDQuery;
    data_consulta_cliente: TDataSource;
    procedure btn_retornarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_pesquisaClick(Sender: TObject);
    procedure grid_consulta_clienteCellClick(Column: TColumn);
    procedure grid_consulta_clienteKeyPress(Sender: TObject; var Key: Char);
    procedure grid_consulta_clienteTitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_consulta_cliente_agenda: Tform_consulta_cliente_agenda;

implementation

{$R *.dfm}

uses tela_agendamento;

procedure Tform_consulta_cliente_agenda.btn_pesquisaClick(Sender: TObject);
begin
    //verifica se foi preenchido o campo pesquisa se não refaz o select
    if txt_box_pesquisa.text = '' then
      begin
        FDQuery_consulta_cliente.close;
        FDQuery_consulta_cliente.SQL.Clear;
        FDQuery_consulta_cliente.SQL.Add('select cd_cliente, nr_loja, nm_cliente from cadastro.tb_cliente');
        FDQuery_consulta_cliente.open;
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

procedure Tform_consulta_cliente_agenda.btn_retornarClick(Sender: TObject);
begin
  close;
  form_agendamento.txt_box_cd_cliente.Text := grid_consulta_cliente.columns.items[0].field.text;
  form_agendamento.txt_nm_cliente.Caption := grid_consulta_cliente.columns.items[2].field.text;
  form_agendamento.btn_funcionario.SetFocus;
end;

procedure Tform_consulta_cliente_agenda.FormCreate(Sender: TObject);
begin
  FDQuery_consulta_cliente.Create(nil);
  FDQuery_consulta_cliente.Connection := form_agendamento.FDConnection;
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

procedure Tform_consulta_cliente_agenda.FormShow(Sender: TObject);
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
end;

procedure Tform_consulta_cliente_agenda.grid_consulta_clienteCellClick(
  Column: TColumn);
begin
  close;
  form_agendamento.txt_box_cd_cliente.Text := grid_consulta_cliente.columns.items[0].field.text;
  form_agendamento.txt_nm_cliente.Caption := grid_consulta_cliente.columns.items[2].field.text;
  form_agendamento.btn_funcionario.SetFocus;
end;

procedure Tform_consulta_cliente_agenda.grid_consulta_clienteKeyPress(
  Sender: TObject; var Key: Char);
begin
  If Key = #27 Then Close;
  if key=#13 then Perform(WM_nextdlgctl,0,0);
end;

procedure Tform_consulta_cliente_agenda.grid_consulta_clienteTitleClick(
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
