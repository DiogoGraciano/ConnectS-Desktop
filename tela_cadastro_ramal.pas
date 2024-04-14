unit tela_cadastro_ramal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask;

type
  Tform_cadastro_ramal = class(TForm)
    txt_cd_cliente: TLabel;
    txt_nm_cliente: TLabel;
    txt_nr_loja: TLabel;
    txt_box_cd_ramal: TEdit;
    btn_gravar: TButton;
    txt_box_nm_funcionario: TEdit;
    txt_box_nr_ramal: TEdit;
    FDQuery_cadastro_ramal: TFDQuery;
    txt_telefone: TLabel;
    txt_box_nr_telefone: TMaskEdit;
    txt_ip: TLabel;
    txt_box_nr_ip: TEdit;
    txt_usuario: TLabel;
    txt_box_nm_usuario: TEdit;
    txt_senha: TLabel;
    txt_box_senha: TEdit;
    Label1: TLabel;
    txt_box_obs: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_cadastro_ramal: Tform_cadastro_ramal;

implementation

{$R *.dfm}

uses tela_ramal;

procedure Tform_cadastro_ramal.btn_gravarClick(Sender: TObject);
var
cd_ramal : integer;
begin
    if (txt_box_nm_funcionario.text = '') or (txt_box_nr_telefone.text = '') then
      begin
        Application.MessageBox('Preencha todos os campos obrigatorios','ERRO', mb_ok+mb_iconERROR);
      end
    else
      begin
        if txt_box_nr_ramal.Text = '' then
          begin
             txt_box_nr_ramal.Text := 'null';
             txt_box_nr_ramal.Font.Color := clWindow;
          end;
        if txt_box_cd_ramal.Text = '' then
          begin
            FDQuery_cadastro_ramal.close;
            FDQuery_cadastro_ramal.SQL.Clear;
            FDQuery_cadastro_ramal.SQL.Add('select cd_ramal from cadastro.tb_ramal order by cd_ramal desc limit 1 ');
            FDQuery_cadastro_ramal.open;
            cd_ramal := FDQuery_cadastro_ramal.FieldByName('cd_ramal').AsInteger;
            cd_ramal := cd_ramal + 1;
            FDQuery_cadastro_ramal.close;
            FDQuery_cadastro_ramal.SQL.Clear;
            FDQuery_cadastro_ramal.SQL.Add('INSERT INTO cadastro.tb_ramal (cd_ramal, nm_funcionario, nr_ramal, nr_telefone, nr_ip, nm_usuario, senha, obs) VALUES ( '+inttostr(cd_ramal)+',:nm_funcionario,'+txt_box_nr_ramal.Text+',:nr_telefone,:nr_ip,:nm_usuario,:senha,:obs)');
            FDQuery_cadastro_ramal.ParamByName('nm_funcionario').asString := txt_box_nm_funcionario.Text;
            FDQuery_cadastro_ramal.ParamByName('nr_telefone').asString := txt_box_nr_telefone.Text;
            FDQuery_cadastro_ramal.ParamByName('nr_ip').asString := txt_box_nr_ip.Text;
            FDQuery_cadastro_ramal.ParamByName('nm_usuario').asString := txt_box_nm_usuario.Text;
            FDQuery_cadastro_ramal.ParamByName('senha').asString := txt_box_senha.Text;
            FDQuery_cadastro_ramal.ParamByName('obs').asString := txt_box_obs.Text;
            FDQuery_cadastro_ramal.ExecSQL;
            Application.MessageBox('Concluido','SUCESSO', mb_ok+mb_iconINFORMATION);
            txt_box_nm_funcionario.text := '';
            txt_box_cd_ramal.text := '';
            txt_box_nr_telefone.text := '';
            txt_box_nr_ramal.text := '';
            txt_box_nr_ramal.Font.Color := clWindowText;
            txt_box_nr_ip.text := '';
            txt_box_nm_usuario.text := '';
            txt_box_senha.text := '';
            txt_box_obs.text := '';
          end
        else if txt_box_cd_ramal.Text <> '' then
          begin
            FDQuery_cadastro_ramal.close;
            FDQuery_cadastro_ramal.SQL.Clear;
            FDQuery_cadastro_ramal.SQL.Add('UPDATE cadastro.tb_ramal SET nm_funcionario = :nm_funcionario, nr_ramal = '+txt_box_nr_ramal.Text+', nr_telefone = :nr_telefone, nr_ip = :nr_ip, nm_usuario = :nm_usuario, senha = :senha, obs = :obs WHERE cd_ramal = '+txt_box_cd_ramal.Text+'');
            FDQuery_cadastro_ramal.ParamByName('nm_funcionario').asString := txt_box_nm_funcionario.Text;
            FDQuery_cadastro_ramal.ParamByName('nr_telefone').asString := txt_box_nr_telefone.Text;
            FDQuery_cadastro_ramal.ParamByName('nr_ip').asString := txt_box_nr_ip.Text;
            FDQuery_cadastro_ramal.ParamByName('nm_usuario').asString := txt_box_nm_usuario.Text;
            FDQuery_cadastro_ramal.ParamByName('senha').asString := txt_box_senha.Text;
            FDQuery_cadastro_ramal.ParamByName('obs').asString := txt_box_obs.Text;
            FDQuery_cadastro_ramal.ExecSQL;
            Application.MessageBox('Concluido','SUCESSO', mb_ok+mb_iconINFORMATION);
            txt_box_nm_funcionario.text := '';
            txt_box_cd_ramal.text := '';
            txt_box_nr_telefone.text := '';
            txt_box_nr_ramal.text := '';
            txt_box_nr_ramal.Font.Color := clWindowText;
            txt_box_nr_ip.text := '';
            txt_box_nm_usuario.text := '';
            txt_box_senha.text := '';
            txt_box_obs.text := '';
            close;
          end;
      end;
end;

procedure Tform_cadastro_ramal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  form_ramal.FDQuery_ramal.close;
  form_ramal.FDQuery_ramal.SQL.Clear;
  form_ramal.FDQuery_ramal.SQL.Add('SELECT cd_ramal, nm_funcionario, nr_ramal, nr_telefone FROM cadastro.tb_ramal');
  form_ramal.FDQuery_ramal.open;
  form_ramal.Grid_ramal.Columns[0].Title.Caption := 'Codigo';
  form_ramal.Grid_ramal.Columns[0].Width := 40;
  form_ramal.Grid_ramal.Columns[1].Title.Caption := 'Nome';
  form_ramal.Grid_ramal.Columns[1].Width := 120;
  form_ramal.Grid_ramal.Columns[2].Title.Caption := 'Ramal';
  form_ramal.Grid_ramal.Columns[2].Width := 40;
  form_ramal.Grid_ramal.Columns[3].Title.Caption := 'Telefone';
  form_ramal.Grid_ramal.Columns[3].Width := 90;
  form_ramal.Width := 340;
end;

procedure Tform_cadastro_ramal.FormCreate(Sender: TObject);
begin
    FDQuery_cadastro_ramal.Create(nil);
    FDQuery_cadastro_ramal.Connection := form_ramal.FDConnection;
    txt_box_cd_ramal.ReadOnly := true;
end;

procedure Tform_cadastro_ramal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then Close;
  if key=#13 then Perform(WM_nextdlgctl,0,0);
end;

procedure Tform_cadastro_ramal.FormShow(Sender: TObject);
begin
  form_ramal.FDQuery_ramal.close;
  form_ramal.FDQuery_ramal.SQL.Clear;
  form_ramal.FDQuery_ramal.SQL.Add('SELECT cd_ramal, nm_funcionario, nr_ramal, nr_telefone FROM cadastro.tb_ramal');
  form_ramal.FDQuery_ramal.open;
  form_ramal.Grid_ramal.Columns[0].Title.Caption := 'Codigo';
  form_ramal.Grid_ramal.Columns[0].Width := 40;
  form_ramal.Grid_ramal.Columns[1].Title.Caption := 'Nome';
  form_ramal.Grid_ramal.Columns[1].Width := 120;
  form_ramal.Grid_ramal.Columns[2].Title.Caption := 'Ramal';
  form_ramal.Grid_ramal.Columns[2].Width := 40;
  form_ramal.Grid_ramal.Columns[3].Title.Caption := 'Telefone';
  form_ramal.Grid_ramal.Columns[3].Width := 90;
  form_ramal.Width := 340;
end;

end.
