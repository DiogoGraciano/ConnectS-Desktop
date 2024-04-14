unit tela_consulta_funcionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls;

type
  Tform_consulta_funcionario = class(TForm)
    Panel1: TPanel;
    grid_consulta_funcionario: TDBGrid;
    txt_box_pesquisa: TEdit;
    btn_pesquisa: TButton;
    cb_pesquisa: TComboBox;
    btn_retornar: TButton;
    FDQuery_consulta_funcionario: TFDQuery;
    data_consulta_funcionario: TDataSource;
    procedure btn_pesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grid_consulta_funcionarioCellClick(Column: TColumn);
    procedure grid_consulta_funcionarioTitleClick(Column: TColumn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btn_retornarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_consulta_funcionario: Tform_consulta_funcionario;

implementation

{$R *.dfm}

uses tela_agendamento;

procedure Tform_consulta_funcionario.btn_pesquisaClick(Sender: TObject);
begin
      //verifica se foi preenchido o campo pesquisa se não refaz o select
    if txt_box_pesquisa.text = '' then
      begin
        FDQuery_consulta_funcionario.close;
        FDQuery_consulta_funcionario.SQL.Clear;
        FDQuery_consulta_funcionario.SQL.Add('SELECT cd_ramal,nm_funcionario FROM cadastro.tb_ramal');
        FDQuery_consulta_funcionario.open;
        grid_consulta_funcionario.Columns[0].Title.Caption := 'Codigo';
        grid_consulta_funcionario.Columns[0].Width := 40;
        grid_consulta_funcionario.Columns[1].Title.Caption := 'Nome Funcionario';
        grid_consulta_funcionario.Columns[1].Width := 200;
      end
    //faz o select por codigo de cliente
    else if cb_pesquisa.text = 'CODIGO CLIENTE' then
      begin
        FDQuery_consulta_funcionario.close;
        FDQuery_consulta_funcionario.SQL.Clear;
        FDQuery_consulta_funcionario.SQL.Add('SELECT cd_ramal,nm_funcionario FROM cadastro.tb_ramal');
        FDQuery_consulta_funcionario.open;
        grid_consulta_funcionario.Columns[0].Title.Caption := 'Codigo';
        grid_consulta_funcionario.Columns[0].Width := 40;
        grid_consulta_funcionario.Columns[1].Title.Caption := 'Nome Funcionario';
        grid_consulta_funcionario.Columns[1].Width := 200;
      end
    //faz o select por nome de cliente
    else if cb_pesquisa.text = 'NOME CLIENTE' then
      begin
        FDQuery_consulta_funcionario.close;
        FDQuery_consulta_funcionario.SQL.Clear;
        FDQuery_consulta_funcionario.SQL.Add('SELECT cd_ramal,nm_funcionario FROM cadastro.tb_ramal');
        FDQuery_consulta_funcionario.open;
        grid_consulta_funcionario.Columns[0].Title.Caption := 'Codigo';
        grid_consulta_funcionario.Columns[0].Width := 40;
        grid_consulta_funcionario.Columns[1].Title.Caption := 'Nome Funcionario';
        grid_consulta_funcionario.Columns[1].Width := 200;
      end
end;

procedure Tform_consulta_funcionario.btn_retornarClick(Sender: TObject);
begin
  close;
  form_agendamento.txt_box_cd_funcionario.Text := grid_consulta_funcionario.columns.items[0].field.text;
  form_agendamento.txt_nm_funcionario.Caption := grid_consulta_funcionario.columns.items[1].field.text;
  form_agendamento.cb_status_cadastro.SetFocus;
end;

procedure Tform_consulta_funcionario.FormCreate(Sender: TObject);
begin
  FDQuery_consulta_funcionario.Create(nil);
  FDQuery_consulta_funcionario.Connection := form_agendamento.FDConnection;
  data_consulta_funcionario.Create(nil);
  data_consulta_funcionario.DataSet := FDQuery_consulta_funcionario;
  grid_consulta_funcionario.Create(nil);
  grid_consulta_funcionario.DataSource := data_consulta_funcionario;
  //consulta as conexões
  FDQuery_consulta_funcionario.close;
  FDQuery_consulta_funcionario.SQL.Clear;
  FDQuery_consulta_funcionario.SQL.Add('SELECT cd_ramal,nm_funcionario FROM cadastro.tb_ramal');
  FDQuery_consulta_funcionario.open;
  grid_consulta_funcionario.Columns[0].Title.Caption := 'Codigo';
  grid_consulta_funcionario.Columns[0].Width := 40;
  grid_consulta_funcionario.Columns[1].Title.Caption := 'Nome Funcionario';
  grid_consulta_funcionario.Columns[1].Width := 200;
end;

procedure Tform_consulta_funcionario.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key = #27 Then Close;
  if key=#13 then Perform(WM_nextdlgctl,0,0);
end;

procedure Tform_consulta_funcionario.FormShow(Sender: TObject);
begin
  FDQuery_consulta_funcionario.close;
  FDQuery_consulta_funcionario.SQL.Clear;
  FDQuery_consulta_funcionario.SQL.Add('SELECT cd_ramal,nm_funcionario FROM cadastro.tb_ramal');
  FDQuery_consulta_funcionario.open;
  grid_consulta_funcionario.Columns[0].Title.Caption := 'Codigo';
  grid_consulta_funcionario.Columns[0].Width := 40;
  grid_consulta_funcionario.Columns[1].Title.Caption := 'Nome Funcionario';
  grid_consulta_funcionario.Columns[1].Width := 200;
end;

procedure Tform_consulta_funcionario.grid_consulta_funcionarioCellClick(
  Column: TColumn);
begin
  close;
  form_agendamento.txt_box_cd_funcionario.Text := grid_consulta_funcionario.columns.items[0].field.text;
  form_agendamento.txt_nm_funcionario.Caption := grid_consulta_funcionario.columns.items[1].field.text;
  form_agendamento.cb_status_cadastro.SetFocus;
end;

procedure Tform_consulta_funcionario.grid_consulta_funcionarioTitleClick(
  Column: TColumn);
var
i : integer;
begin
  for i := 0 to grid_consulta_funcionario.Columns.Count - 1 do
    begin
        // retira a formatação negrito/itálico
        grid_consulta_funcionario.Columns[I].Title.Font.Style := [];
        // altera a cor da fonte do título para Black
        grid_consulta_funcionario.Columns[I].Title.Font.Color := clBlack;
    end;
  with FDQuery_consulta_funcionario do
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
  FDQuery_consulta_funcionario.First;
end;

end.
