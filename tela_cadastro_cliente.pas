unit tela_cadastro_cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  Tform_cadastro_cliente = class(TForm)
    txt_box_cd_cliente: TEdit;
    btn_gravar: TButton;
    txt_box_nm_cliente: TEdit;
    txt_cd_cliente: TLabel;
    txt_nm_cliente: TLabel;
    txt_nr_loja: TLabel;
    txt_box_nr_loja: TEdit;
    FDQuery_cadastro_cliente: TFDQuery;
    procedure btn_gravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro_cliente: Tform_cadastro_cliente;

implementation

{$R *.dfm}

uses tela_login, tela_consulta_cliente;

procedure Tform_cadastro_cliente.btn_gravarClick(Sender: TObject);
var
cd_cliente : integer;
begin
    if (txt_box_nm_cliente.text = '') or (txt_box_nr_loja.text = '') then
      begin
        Application.MessageBox('Preencha todos os campos obrigatorios','ERRO', mb_ok+mb_iconERROR);
      end
    else
      begin
        if txt_box_cd_cliente.Text = '' then
          begin
            FDQuery_cadastro_cliente.close;
            FDQuery_cadastro_cliente.SQL.Clear;
            FDQuery_cadastro_cliente.SQL.Add('select cd_cliente from cadastro.tb_cliente order by cd_cliente desc limit 1 ');
            FDQuery_cadastro_cliente.open;
            cd_cliente := FDQuery_cadastro_cliente.FieldByName('cd_cliente').AsInteger;
            cd_cliente := cd_cliente + 1;
            FDQuery_cadastro_cliente.close;
            FDQuery_cadastro_cliente.SQL.Clear;
            FDQuery_cadastro_cliente.SQL.Add('INSERT INTO cadastro.tb_cliente(cd_cliente,nm_cliente,nr_loja) VALUES ('+inttostr(cd_cliente)+',:nm_cliente,'+txt_box_nr_loja.Text+')');
            FDQuery_cadastro_cliente.ParamByName('nm_cliente').asString := txt_box_nm_cliente.Text;
            FDQuery_cadastro_cliente.ExecSQL;
            Application.MessageBox('Concluido','SUCESSO', mb_ok+mb_iconINFORMATION);
            txt_box_nm_cliente.text := '';
            txt_box_cd_cliente.text := '';
            txt_box_nr_loja.text := '';
          end;
        if txt_box_cd_cliente.Text <> '' then
          begin
            FDQuery_cadastro_cliente.close;
            FDQuery_cadastro_cliente.SQL.Clear;
            FDQuery_cadastro_cliente.SQL.Add('UPDATE cadastro.tb_cliente SET nm_cliente = :nm_cliente, nr_loja = '+txt_box_nr_loja.Text+' WHERE cd_cliente = '+txt_box_cd_cliente.text+'');
            FDQuery_cadastro_cliente.ParamByName('nm_cliente').asString := txt_box_nm_cliente.Text;
            FDQuery_cadastro_cliente.ExecSQL;
            Application.MessageBox('Concluido','SUCESSO', mb_ok+mb_iconINFORMATION);
            txt_box_nm_cliente.text := '';
            txt_box_cd_cliente.text := '';
            txt_box_nr_loja.text := '';
            close;
          end;
      end;
end;

procedure Tform_cadastro_cliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  txt_box_nm_cliente.text := '';
  txt_box_cd_cliente.text := '';
  txt_box_nr_loja.text := '';
    with form_consulta_cliente do
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
end;

procedure Tform_cadastro_cliente.FormCreate(Sender: TObject);
begin
    FDQuery_cadastro_cliente.Create(nil);
    FDQuery_cadastro_cliente.Connection := form_login.FDConnection;
    txt_box_cd_cliente.ReadOnly := true;
end;

procedure Tform_cadastro_cliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then Close;
  if key=#13 then Perform(WM_nextdlgctl,0,0);
end;

end.
