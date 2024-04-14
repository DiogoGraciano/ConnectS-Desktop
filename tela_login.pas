unit tela_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Phys.PGDef, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.PG, FireDAC.Comp.DataSet;

type
  Tform_login = class(TForm)
    btn_login: TButton;
    txt_box_senha: TEdit;
    txt_box_usuario: TEdit;
    txt_senha: TLabel;
    txt_usuario: TLabel;
    FDQuery_geral: TFDQuery;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    FDConnection: TFDConnection;
    txt_esqueci: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btn_loginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txt_esqueciClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_login: Tform_login;
  txtusuario : string;
  senha : string;

implementation

{$R *.dfm}

uses conexao, tela_conexao, tela_senha_usuario;

procedure Tform_login.btn_loginClick(Sender: TObject);
begin
  //faz uma consulta para encontrar o usuario no banco de dados local
  FDQuery_geral.close;
  FDQuery_geral.SQL.Clear;
  FDQuery_geral.SQL.Add('SELECT * FROM cadastro.tb_login where nm_usuario = :nome and senha = :senha');
  FDQuery_geral.ParamByName('senha').AsString := txt_box_senha.text;
  FDQuery_geral.ParamByName('nome').AsString := txt_box_usuario.text;
  FDQuery_geral.open;
  //pega senha do banco de dados
  senha := FDQuery_geral.FieldByName('senha').AsString;
  //verifica se senha é igual a senha digitada
  if (senha = txt_box_senha.text) and (senha <> '') then
    begin
      hide;
      form_conexao.ShowModal;
      form_conexao.WindowState := TWindowState(0);
      form_conexao.Position := poScreenCenter;
    end
  else
    begin
      ShowMessage('Usuario ou Senha Invalidos');
    end;
end;

procedure Tform_login.FormCreate(Sender: TObject);
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
  form_login.Position := poScreenCenter;
  except
  Application.MessageBox('Erro na Conexão a Base Reinicie a Aplicação','ERRO', mb_ok+mb_iconerror);
  end;
  //cria o componente a query
  FDQuery_geral.Create(nil);
  FDQuery_geral.Connection := FDConnection;
end;

procedure Tform_login.FormKeyPress(Sender: TObject; var Key: Char);
begin
//teclas de atalho
  If Key = #27 Then Close;
  if key = #13 then Perform(WM_nextdlgctl,0,0);
end;

procedure Tform_login.txt_esqueciClick(Sender: TObject);
begin
    FDQuery_geral.close;
    FDQuery_geral.SQL.Clear;
    FDQuery_geral.SQL.Add('SELECT nm_usuario as nome FROM cadastro.tb_login where nm_usuario = :nome');
    FDQuery_geral.ParamByName('nome').AsString := txt_box_usuario.text;
    FDQuery_geral.open;
    if (txt_box_usuario.Text <> '') and (FDQuery_geral.FieldByName('nome').AsString <> '') then
      begin
        form_senha_usuario.showmodal;
      end
    else
      begin
        Application.MessageBox('Verifique o usuario digitado', 'ERRO', mb_ok + mb_iconERROR);
      end;
end;

end.
