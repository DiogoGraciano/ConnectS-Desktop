unit tela_cadastro_usuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  Tform_cadastro_usuario = class(TForm)
    txt_cd_cliente: TLabel;
    txt_cd_criente: TLabel;
    txt_nm_sistema: TLabel;
    txt_terminal: TLabel;
    txt_nm_usuario: TLabel;
    txt_obs: TLabel;
    txt_senha: TLabel;
    txt_box_cd_usuario: TEdit;
    txt_box_cd_cliente: TEdit;
    txt_box_obs: TEdit;
    txt_box_senha: TEdit;
    txt_box_nm_usuario: TEdit;
    cb_nm_programa: TComboBox;
    cb_nm_terminal: TComboBox;
    btn_gravar: TButton;
    btn_consultar: TButton;
    FDQuery_cadastro_usuario: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btn_consultarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro_usuario: Tform_cadastro_usuario;

implementation

{$R *.dfm}

uses tela_login, tela_consulta_cliente_usuario, tela_conexao;

procedure Tform_cadastro_usuario.btn_consultarClick(Sender: TObject);
begin
  form_consulta_cliente_usuario.showmodal;
end;

procedure Tform_cadastro_usuario.btn_gravarClick(Sender: TObject);
var
cd_usuario : integer;
begin
    if (txt_box_nm_usuario.text <> '') or (txt_box_cd_cliente.text <> '') or (txt_box_senha.text <> '') then
      begin
      if txt_box_cd_usuario.text = '' then
        begin
          FDQuery_cadastro_usuario.close;
          FDQuery_cadastro_usuario.SQL.Clear;
          FDQuery_cadastro_usuario.SQL.Add('select cd_usuario from cadastro.tb_usuario order by cd_usuario desc limit 1');
          FDQuery_cadastro_usuario.open;
          cd_usuario := FDQuery_cadastro_usuario.FieldByName('cd_usuario').AsInteger;
          cd_usuario := cd_usuario + 1;
          FDQuery_cadastro_usuario.close;
          FDQuery_cadastro_usuario.SQL.Clear;
          FDQuery_cadastro_usuario.SQL.Add('INSERT INTO cadastro.tb_usuario ( cd_usuario, cd_cliente, nm_usuario, senha, nm_sistema, nm_terminal, obs ) VALUES ( '+inttostr(cd_usuario)+', '+txt_box_cd_cliente.text+', :nm_usuario, :senha, :nm_programa, :nm_terminal, :obs);');
          FDQuery_cadastro_usuario.ParamByName('nm_terminal').asString := cb_nm_terminal.text;
          FDQuery_cadastro_usuario.ParamByName('nm_programa').asString := cb_nm_programa.text;
          FDQuery_cadastro_usuario.ParamByName('nm_usuario').asString := txt_box_nm_usuario.text;
          FDQuery_cadastro_usuario.ParamByName('senha').asString := txt_box_senha.text;
          FDQuery_cadastro_usuario.ParamByName('obs').asString := txt_box_obs.text;
          FDQuery_cadastro_usuario.ExecSQL;
          Application.MessageBox('Concluido', 'SUCESSO', mb_ok + mb_iconINFORMATION);
          cb_nm_terminal.text := '';
          cb_nm_programa.text := '';
          txt_box_nm_usuario.text := '';
          txt_box_senha.text := '';
          txt_box_obs.text := '';
          cb_nm_programa.text := 'WINDOWS';
          cb_nm_terminal.text := 'BALCAO';
        end
      else if txt_box_cd_usuario.text <> '' then
        begin
          FDQuery_cadastro_usuario.close;
          FDQuery_cadastro_usuario.SQL.Clear;
          FDQuery_cadastro_usuario.SQL.Add('UPDATE cadastro.tb_usuario SET cd_cliente = '+txt_box_cd_cliente.text+', nm_usuario = :nm_usuario, senha = :senha, nm_sistema = :nm_programa, nm_terminal = :nm_terminal, obs = :obs WHERE cd_usuario = '+txt_box_cd_usuario.text+'');
          FDQuery_cadastro_usuario.ParamByName('nm_terminal').asString := cb_nm_terminal.text;
          FDQuery_cadastro_usuario.ParamByName('nm_programa').asString := cb_nm_programa.text;
          FDQuery_cadastro_usuario.ParamByName('nm_usuario').asString := txt_box_nm_usuario.text;
          FDQuery_cadastro_usuario.ParamByName('senha').asString := txt_box_senha.text;
          FDQuery_cadastro_usuario.ParamByName('obs').asString := txt_box_obs.text;
          FDQuery_cadastro_usuario.ExecSQL;
          Application.MessageBox('Concluido', 'SUCESSO', mb_ok + mb_iconINFORMATION);
          cb_nm_terminal.text := '';
          cb_nm_programa.text := '';
          txt_box_nm_usuario.text := '';
          txt_box_senha.text := '';
          txt_box_obs.text := '';
          cb_nm_programa.text := 'WINDOWS';
          cb_nm_terminal.text := 'BALCAO';
          close;
        end;
      end
    else
      begin
        Application.MessageBox('Preencha os campos obrigatorios','ERRO', mb_ok+mb_iconerror);
      end;
end;

procedure Tform_cadastro_usuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  txt_box_cd_usuario.Text := '';
  txt_box_nm_usuario.Text := '';
  txt_box_senha.Text := '';
  txt_box_obs.Text := '';
  txt_box_cd_cliente.Text := '';
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

procedure Tform_cadastro_usuario.FormCreate(Sender: TObject);
begin
  FDQuery_cadastro_usuario.Create(nil);
  FDQuery_cadastro_usuario.Connection := form_login.FDConnection;
  txt_box_cd_usuario.ReadOnly := true;
  txt_box_cd_cliente.ReadOnly := true;
end;

procedure Tform_cadastro_usuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then Close;
  if key=#13 then Perform(WM_nextdlgctl,0,0);
end;

end.
