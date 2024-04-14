unit tela_cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  Tform_cadastro = class(TForm)
    txt_box_cd_conexao: TEdit;
    txt_box_cd_cliente: TEdit;
    txt_box_id_conexao: TEdit;
    txt_box_obs: TEdit;
    txt_box_senha: TEdit;
    txt_box_nm_usuario: TEdit;
    txt_cd_cliente: TLabel;
    txt_cd_criente: TLabel;
    txt_nm_programa: TLabel;
    txt_id_conexao: TLabel;
    txt_terminal: TLabel;
    txt_nm_usuario: TLabel;
    txt_obs: TLabel;
    txt_senha: TLabel;
    cb_nm_programa: TComboBox;
    cb_nm_terminal: TComboBox;
    btn_gravar: TButton;
    FDQuery_cadastro: TFDQuery;
    txt_nr_caixa: TLabel;
    txt_box_nr_caixa: TEdit;
    btn_consultar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cb_nm_terminalChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro: Tform_cadastro;

implementation

{$R *.dfm}

uses tela_login, tela_cadastro_cliente, tela_consulta_cliente,
  tela_consulta_cliente_cadastro, tela_conexao;

procedure Tform_cadastro.btn_gravarClick(Sender: TObject);
var
  cd_codigo: integer;
begin
  FDQuery_cadastro.close;
  FDQuery_cadastro.SQL.Clear;
  FDQuery_cadastro.SQL.Add
    ('select cd_conexao from cadastro.tb_conexao order by cd_conexao desc limit 1 ');
  FDQuery_cadastro.open;
  cd_codigo := FDQuery_cadastro.FieldByName('cd_conexao').AsInteger;
  cd_codigo := cd_codigo + 1;
  if txt_box_nr_caixa.text = '' then
  begin
    txt_box_nr_caixa.text := 'null'
  end;
  if (txt_box_id_conexao.text <> '') or (txt_box_cd_cliente.text <> '') then
  begin
    if (cb_nm_terminal.text = 'FRENTE DE CAIXA') and
      (txt_box_nr_caixa.text = 'NULL') then
    begin
      Application.MessageBox('Preencha o campo "nr caixa"', 'ERRO',
        mb_ok + mb_iconerror);
      txt_box_nr_caixa.text := '';
    end
    else
    begin
      if txt_box_cd_conexao.text = '' then
      begin
        FDQuery_cadastro.close;
        FDQuery_cadastro.SQL.Clear;
        FDQuery_cadastro.SQL.Add
          ('INSERT INTO cadastro.tb_conexao (cd_conexao, id_conexao, cd_cliente, nm_terminal, nm_programa, nm_usuario, senha, obs, nr_caixa) VALUES ('
          + inttostr(cd_codigo) + ', :id_conexao, ' + txt_box_cd_cliente.text +
          ', :nm_terminal, :nm_programa, :nm_usuario, :senha, :obs, ' +
          txt_box_nr_caixa.text + ')');
        FDQuery_cadastro.ParamByName('id_conexao').asString :=
          txt_box_id_conexao.text;
        FDQuery_cadastro.ParamByName('nm_terminal').asString :=
          cb_nm_terminal.text;
        FDQuery_cadastro.ParamByName('nm_programa').asString :=
          cb_nm_programa.text;
        FDQuery_cadastro.ParamByName('nm_usuario').asString :=
          txt_box_nm_usuario.text;
        FDQuery_cadastro.ParamByName('senha').asString := txt_box_senha.text;
        FDQuery_cadastro.ParamByName('obs').asString := txt_box_obs.text;
        FDQuery_cadastro.ExecSQL;
        Application.MessageBox('Concluido', 'SUCESSO',
          mb_ok + mb_iconINFORMATION);
        txt_box_id_conexao.text := '';
        cb_nm_terminal.text := '';
        cb_nm_programa.text := '';
        txt_box_nm_usuario.text := '';
        txt_box_nr_caixa.text := '';
        txt_box_senha.text := '';
        txt_box_obs.text := '';
        cb_nm_programa.text := 'ANYDESK';
        cb_nm_terminal.text := 'BALCAO';
        txt_box_nr_caixa.ReadOnly := true;
        txt_box_nr_caixa.Color := clScrollBar;
        txt_box_nr_caixa.Font.Color := clScrollBar;
      end
      else if txt_box_cd_conexao.text <> '' then
      begin
        FDQuery_cadastro.close;
        FDQuery_cadastro.SQL.Clear;
        FDQuery_cadastro.SQL.Add
          ('UPDATE cadastro.tb_conexao SET id_conexao = :id_conexao, cd_cliente = '
          + txt_box_cd_cliente.text +
          ', nm_terminal = :nm_terminal, nm_programa = :nm_programa, nm_usuario = :nm_usuario, senha = :senha, obs = :obs, nr_caixa = '
          + txt_box_nr_caixa.text + ' WHERE cd_conexao = ' +
          txt_box_cd_conexao.text + '');
        FDQuery_cadastro.ParamByName('id_conexao').asString :=
          txt_box_id_conexao.text;
        FDQuery_cadastro.ParamByName('nm_terminal').asString :=
          cb_nm_terminal.text;
        FDQuery_cadastro.ParamByName('nm_programa').asString :=
          cb_nm_programa.text;
        FDQuery_cadastro.ParamByName('nm_usuario').asString :=
          txt_box_nm_usuario.text;
        FDQuery_cadastro.ParamByName('senha').asString := txt_box_senha.text;
        FDQuery_cadastro.ParamByName('obs').asString := txt_box_obs.text;
        FDQuery_cadastro.ExecSQL;
        Application.MessageBox('Concluido', 'SUCESSO',
          mb_ok + mb_iconINFORMATION);
        txt_box_id_conexao.text := '';
        cb_nm_terminal.text := '';
        cb_nm_programa.text := '';
        txt_box_nm_usuario.text := '';
        txt_box_nr_caixa.text := '';
        txt_box_senha.text := '';
        txt_box_obs.text := '';
        cb_nm_programa.text := 'ANYDESK';
        cb_nm_terminal.text := 'BALCAO';
        txt_box_nr_caixa.ReadOnly := true;
        txt_box_nr_caixa.Color := clScrollBar;
        txt_box_nr_caixa.Font.Color := clScrollBar;
        close;
      end;
    end;
  end
  else
  begin
    Application.MessageBox('Preencha os campos obrigatorios', 'ERRO',
      mb_ok + mb_iconerror);
  end;

end;

procedure Tform_cadastro.cb_nm_terminalChange(Sender: TObject);
begin
  if cb_nm_terminal.text = 'FRENTE DE CAIXA' then
  begin
    txt_box_nr_caixa.text := '';
    txt_box_nr_caixa.ReadOnly := false;
    txt_box_nr_caixa.Color := clWindow;
    txt_box_nr_caixa.Font.Color := clWindowText;
  end
  else
  begin
    txt_box_nr_caixa.text := '';
    txt_box_nr_caixa.ReadOnly := true;
    txt_box_nr_caixa.Color := clScrollBar;
    txt_box_nr_caixa.Font.Color := clScrollBar;
  end;
end;

procedure Tform_cadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  txt_box_cd_conexao.text := '';
  txt_box_cd_cliente.text := '';
  txt_box_id_conexao.text := '';
  txt_box_nr_caixa.text := '';
  txt_box_nm_usuario.text := '';
  txt_box_senha.text := '';
  txt_box_obs.text := '';
  with form_conexao do
  begin
    FDQuery_conexao.close;
    FDQuery_conexao.SQL.Clear;
    FDQuery_conexao.SQL.Add
      ('select cd_conexao,tb_conexao.cd_cliente,nm_cliente,nr_loja,id_conexao,nm_terminal,nr_caixa,nm_programa,nm_usuario,senha,obs from cadastro.tb_conexao inner join cadastro.tb_cliente on tb_cliente.cd_cliente = tb_conexao.cd_cliente');
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
end;

procedure Tform_cadastro.FormCreate(Sender: TObject);
begin
  FDQuery_cadastro.Create(nil);
  FDQuery_cadastro.Connection := form_login.FDConnection;
  txt_box_cd_conexao.ReadOnly := true;
  txt_box_cd_cliente.ReadOnly := true;
  if cb_nm_terminal.text <> 'FRENTE DE CAIXA' then
  begin
    txt_box_nr_caixa.ReadOnly := true;
    txt_box_nr_caixa.Color := clScrollBar;
    txt_box_nr_caixa.Font.Color := clScrollBar;
  end;
end;

procedure Tform_cadastro.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then
    close;
  if Key = #13 then
    Perform(WM_nextdlgctl, 0, 0);
end;

procedure Tform_cadastro.SpeedButton1Click(Sender: TObject);
begin
  form_consulta_cliente_cadastro.ShowModal;
end;

end.
