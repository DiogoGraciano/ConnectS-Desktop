unit tela_conexao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.Menus, Vcl.AppAnalytics;

type
  Tform_conexao = class(TForm)
    Panel1: TPanel;
    txt_box_pesquisa: TEdit;
    btn_pesquisar: TButton;
    grid_conexao: TDBGrid;
    data_conexao: TDataSource;
    FDQuery_conexao: TFDQuery;
    cb_pesquisa: TComboBox;
    SaveDialog: TSaveDialog;
    btn_consultar: TSpeedButton;
    PopupMenu: TPopupMenu;
    Cadastrar1: TMenuItem;
    Editar1: TMenuItem;
    Editar2: TMenuItem;
    Cliente1: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem4: TMenuItem;
    Ramal1: TMenuItem;
    Ramal2: TMenuItem;
    Exportar1: TMenuItem;
    Exportar2: TMenuItem;
    Agenda1: TMenuItem;
    agenda2: TMenuItem;
    txt_conexões: TLabel;
    Panel2: TPanel;
    txt_usuarios: TLabel;
    grid_usuario: TDBGrid;
    PopupMenu1: TPopupMenu;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    CadastrarUsuario1: TMenuItem;
    Editar3: TMenuItem;
    Deletar1: TMenuItem;
    FDQuery_usuario: TFDQuery;
    Data_usuario: TDataSource;
    Mudarsenha1: TMenuItem;
    MudarSenha2: TMenuItem;
    MudarSenha3: TMenuItem;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_cadastrarClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_clienteClick(Sender: TObject);
    procedure btn_csvClick(Sender: TObject);
    procedure btn_pesquisarClick(Sender: TObject);
    procedure cb_pesquisaChange(Sender: TObject);
    procedure btn_consultarClick(Sender: TObject);
    procedure grid_conexaoTitleClick(Column: TColumn);
    procedure grid_conexaoCellClick(Column: TColumn);
    procedure FormClick(Sender: TObject);
    procedure Ramal1Click(Sender: TObject);
    procedure Agenda1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Deletar1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Editar3Click(Sender: TObject);
    procedure grid_usuarioTitleClick(Column: TColumn);
    procedure MenuItem7Click(Sender: TObject);
    procedure MudarSenha3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  form_conexao: Tform_conexao;

implementation

{$R *.dfm}

uses tela_login, tela_cadastro, tela_cadastro_cliente, tela_consulta_cliente,
  tela_consulta_cliente_conexao, tela_cadastro_ramal, tela_cadastro_usuario,
  tela_senha_usuario;

procedure Tform_conexao.Agenda1Click(Sender: TObject);
begin
  WinExec('agenda.exe', sw_show);
end;


procedure Tform_conexao.btn_cadastrarClick(Sender: TObject);
begin
   form_cadastro.ShowModal;
   form_cadastro.cb_nm_programa.text := 'ANYDESK';
   form_cadastro.cb_nm_terminal.text :=  'BALCAO';
end;

procedure Tform_conexao.btn_clienteClick(Sender: TObject);
begin
   form_consulta_cliente.ShowModal;
end;

procedure Tform_conexao.btn_consultarClick(Sender: TObject);
begin
  form_consulta_cliente_conexao.ShowModal
end;

procedure Tform_conexao.btn_csvClick(Sender: TObject);
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
  colunas := FDQuery_conexao.FieldCount;
  i := -1;
  colunas := colunas - 1;
  // cria colunas
  while colunas <> i do
  begin
    i := i + 1;
    Linha1 := grid_conexao.columns[i].Title.Caption;
    write(ArqTxt, ';' + Linha1);
  end;
  writeln(ArqTxt, ';');
  // cria rows
  while not FDQuery_conexao.Eof do
  begin
    for c := 0 to colunas do
    begin
      Linha1 := grid_conexao.fields[c].DisplayText;
      write(ArqTxt, ';' + Linha1);
    end;
    writeln(ArqTxt, ';');
    FDQuery_conexao.Next
  end;
  CloseFile(ArqTxt);
  Application.MessageBox('Concluido', 'SUCESSO', mb_ok + mb_iconINFORMATION);
end;

procedure Tform_conexao.btn_editarClick(Sender: TObject);
var
cd_codigo : string;
begin
  cd_codigo := grid_conexao.columns.items[0].field.text;
  FDQuery_conexao.close;
  FDQuery_conexao.SQL.Clear;
  FDQuery_conexao.SQL.Add('select cd_conexao,tb_conexao.cd_cliente,nm_cliente,nr_loja,id_conexao,nm_terminal,nr_caixa,nm_programa,nm_usuario,senha,obs from cadastro.tb_conexao inner join cadastro.tb_cliente on tb_cliente.cd_cliente = tb_conexao.cd_cliente where cd_conexao = '+cd_codigo+'');
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
  Grid_conexao.Columns[10].Title.Caption := 'Obs';
  Grid_conexao.Columns[10].Width := 200;
  form_cadastro.txt_box_cd_conexao.text := grid_conexao.columns.items[0].field.text;
  form_cadastro.txt_box_id_conexao.text := grid_conexao.columns.items[4].field.text;
  form_cadastro.txt_box_cd_cliente.text := grid_conexao.columns.items[1].field.text;
  form_cadastro.cb_nm_programa.text := grid_conexao.columns.items[7].field.text;
  form_cadastro.cb_nm_terminal.text := grid_conexao.columns.items[5].field.text;
  form_cadastro.txt_box_nr_caixa.text := grid_conexao.columns.items[6].field.text;
  if grid_conexao.columns.items[6].field.text <> '' then
    begin
      form_cadastro.txt_box_nr_caixa.ReadOnly := false;
      form_cadastro.txt_box_nr_caixa.Color := clWindow;
      form_cadastro.txt_box_nr_caixa.Font.Color := clWindowText;
    end;
  form_cadastro.txt_box_nm_usuario.text := grid_conexao.columns.items[8].field.text;
  form_cadastro.txt_box_senha.text := grid_conexao.columns.items[9].field.text;
  form_cadastro.txt_box_obs.text := grid_conexao.columns.items[10].field.text;
  form_cadastro.ShowModal;
end;

procedure Tform_conexao.btn_excluirClick(Sender: TObject);
var
cd_conexao : string;
begin
    cd_conexao := grid_conexao.columns.items[0].field.text;
    FDQuery_conexao.close;
    FDQuery_conexao.SQL.Clear;
    FDQuery_conexao.SQL.Add('delete from cadastro.tb_conexao where cd_conexao = '+cd_conexao+'');
    FDQuery_conexao.ExecSQL;
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
    Grid_conexao.Columns[10].Title.Caption := 'Obs';
    Grid_conexao.Columns[10].Width := 200;
end;

procedure Tform_conexao.btn_pesquisarClick(Sender: TObject);
begin
 //verifica se foi preenchido o campo pesquisa se não refaz o select
    if txt_box_pesquisa.text = '' then
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
        Grid_conexao.Columns[10].Title.Caption := 'Obs';
        Grid_conexao.Columns[10].Width := 200;
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
      end
    //faz o select por codigo de cliente
    else if cb_pesquisa.text = 'CODIGO CLIENTE' then
      begin
        FDQuery_conexao.close;
        FDQuery_conexao.SQL.Clear;
        FDQuery_conexao.SQL.Add('select cd_conexao,id_conexao,nm_terminal,nr_caixa,nm_programa,nm_usuario,senha,obs from cadastro.tb_conexao where cd_cliente = '+txt_box_pesquisa.Text+'');
        FDQuery_conexao.open;
        Grid_conexao.Columns[0].Title.Caption := 'Codigo';
        Grid_conexao.Columns[0].Width := 40;
        Grid_conexao.Columns[1].Title.Caption := 'Acesso';
        Grid_conexao.Columns[1].Width := 200;
        Grid_conexao.Columns[2].Title.Caption := 'Terminal';
        Grid_conexao.Columns[2].Width := 100;
        Grid_conexao.Columns[3].Title.Caption := 'Caixa';
        Grid_conexao.Columns[3].Width := 35;
        Grid_conexao.Columns[4].Title.Caption := 'Programa';
        Grid_conexao.Columns[4].Width := 80;
        Grid_conexao.Columns[5].Title.Caption := 'Usuario';
        Grid_conexao.Columns[5].Width := 150;
        Grid_conexao.Columns[6].Title.Caption := 'Senha';
        Grid_conexao.Columns[6].Width := 100;
        Grid_conexao.Columns[7].Title.Caption := 'Obs';
        Grid_conexao.Columns[7].Width := 200;
        FDQuery_usuario.close;
        FDQuery_usuario.SQL.Clear;
        FDQuery_usuario.SQL.Add('SELECT cd_usuario, nm_sistema, nm_terminal, nm_usuario, senha,obs FROM cadastro.tb_usuario where cd_usuario = '+txt_box_pesquisa.Text+'');
        FDQuery_usuario.open;
        Grid_usuario.Columns[0].Title.Caption := 'Codigo';
        Grid_usuario.Columns[0].Width := 40;
        Grid_usuario.Columns[1].Title.Caption := 'Sistema Operacional';
        Grid_usuario.Columns[1].Width := 200;
        Grid_usuario.Columns[2].Title.Caption := 'Terminal';
        Grid_usuario.Columns[2].Width := 150;
        Grid_usuario.Columns[3].Title.Caption := 'Usuario';
        Grid_usuario.Columns[3].Width := 200;
        Grid_usuario.Columns[4].Title.Caption := 'Senha';
        Grid_usuario.Columns[4].Width := 200;
        Grid_usuario.Columns[5].Title.Caption := 'Obs';
        Grid_usuario.Columns[5].Width := 200;
      end
    //faz o select por nome de cliente
    else if cb_pesquisa.text = 'NOME CLIENTE' then
      begin
        FDQuery_conexao.close;
        FDQuery_conexao.SQL.Clear;
        FDQuery_conexao.SQL.Add('select cd_conexao,tb_conexao.cd_cliente,nm_cliente,nr_loja,id_conexao,nm_terminal,nr_caixa,nm_programa,nm_usuario,senha,obs from cadastro.tb_conexao inner join cadastro.tb_cliente on tb_cliente.cd_cliente =tb_conexao.cd_cliente where nm_cliente like :nome');
        FDQuery_conexao.ParamByName('nome').Asstring := '%'+AnsiUpperCase(txt_box_pesquisa.Text)+'%';
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
        Grid_conexao.Columns[10].Title.Caption := 'Obs';
        Grid_conexao.Columns[10].Width := 200;
        FDQuery_usuario.close;
        FDQuery_usuario.SQL.Clear;
        FDQuery_usuario.SQL.Add('SELECT cd_usuario,tb_usuario.cd_cliente,nm_cliente,nm_sistema,nm_terminal,nm_usuario,senha,obs FROM cadastro.tb_usuario INNER JOIN cadastro.tb_cliente on cadastro.tb_usuario.cd_cliente = cadastro.tb_cliente.cd_cliente where nm_cliente like :nome');
        FDQuery_usuario.ParamByName('nome').Asstring := '%'+txt_box_pesquisa.Text+'%';
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
      end
end;

procedure Tform_conexao.cb_pesquisaChange(Sender: TObject);
begin
  if cb_pesquisa.Text = 'CODIGO CLIENTE' then
    begin
      btn_consultar.Visible := true;
      txt_box_pesquisa.NumbersOnly := true;
      txt_box_pesquisa.text := '';
    end
  else
    begin
      btn_consultar.Visible := false;
      txt_box_pesquisa.NumbersOnly := false;
      txt_box_pesquisa.text := '';
    end;
end;

procedure Tform_conexao.FormClick(Sender: TObject);
var
  p: TPoint;
begin
  p := Mouse.CursorPos;
  PopupMenu2.Popup(p.X, p.Y);
end;


procedure Tform_conexao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.Terminate
end;

procedure Tform_conexao.FormCreate(Sender: TObject);
begin
    FDQuery_conexao.Create(nil);
    FDQuery_conexao.Connection := form_login.FDConnection;
    data_conexao.Create(nil);
    data_conexao.DataSet := FDQuery_conexao;
    Grid_conexao.Create(nil);
    Grid_conexao.DataSource := data_conexao;
    FDQuery_usuario.Create(nil);
    FDQuery_usuario.Connection := form_login.FDConnection;
    data_usuario.Create(nil);
    data_usuario.DataSet := FDQuery_usuario;
    Grid_usuario.Create(nil);
    Grid_usuario.DataSource := data_usuario;
    //consulta as conexões
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
    Grid_conexao.Columns[10].Title.Caption := 'Obs';
    Grid_conexao.Columns[10].Width := 200;
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

procedure Tform_conexao.FormKeyPress(Sender: TObject; var Key: Char);
begin
//teclas de atalho
  If Key = #27 Then Close;
  if key = #13 then Perform(WM_nextdlgctl,0,0);
end;

procedure Tform_conexao.grid_conexaoCellClick(Column: TColumn);
  var
  p: TPoint;
begin
  p := Mouse.CursorPos;
  PopupMenu.Popup(p.X, p.Y);
end;


procedure Tform_conexao.grid_conexaoTitleClick(Column: TColumn);
var
i : integer;
begin
  for i := 0 to grid_conexao.Columns.Count - 1 do
    begin
        // retira a formatação negrito/itálico
        grid_conexao.Columns[I].Title.Font.Style := [];
        // altera a cor da fonte do título para Black
        grid_conexao.Columns[I].Title.Font.Color := clBlack;
    end;
  with FDQuery_usuario do
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
  FDQuery_usuario.First;
end;

procedure Tform_conexao.grid_usuarioTitleClick(Column: TColumn);
var
i : integer;
begin
  for i := 0 to grid_conexao.Columns.Count - 1 do
    begin
        // retira a formatação negrito/itálico
        grid_conexao.Columns[I].Title.Font.Style := [];
        // altera a cor da fonte do título para Black
        grid_conexao.Columns[I].Title.Font.Color := clBlack;
    end;
  with FDQuery_conexao do
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
  FDQuery_conexao.First;
end;

procedure Tform_conexao.MenuItem2Click(Sender: TObject);
begin
   form_cadastro_usuario.ShowModal;
   form_cadastro.cb_nm_programa.text := 'WINDOWS';
   form_cadastro.cb_nm_terminal.text :=  'BALCAO';
end;

procedure Tform_conexao.MenuItem7Click(Sender: TObject);
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
  colunas := FDQuery_usuario.FieldCount;
  i := -1;
  colunas := colunas - 1;
  // cria colunas
  while colunas <> i do
  begin
    i := i + 1;
    Linha1 := grid_usuario.columns[i].Title.Caption;
    write(ArqTxt, ';' + Linha1);
  end;
  writeln(ArqTxt, ';');
  // cria rows
  while not FDQuery_usuario.Eof do
  begin
    for c := 0 to colunas do
    begin
      Linha1 := grid_usuario.fields[c].DisplayText;
      write(ArqTxt, ';' + Linha1);
    end;
    writeln(ArqTxt, ';');
    FDQuery_usuario.Next
  end;
  CloseFile(ArqTxt);
  Application.MessageBox('Concluido', 'SUCESSO', mb_ok + mb_iconINFORMATION);
end;

procedure Tform_conexao.MudarSenha3Click(Sender: TObject);
begin
    form_senha_usuario.showmodal;
end;

procedure Tform_conexao.Ramal1Click(Sender: TObject);
begin
   WinExec('ramal.exe', sw_show);
end;

procedure Tform_conexao.CreateParams(var Params: TCreateParams);
begin
  //coloca a tela de conexoes na barra de tarefas
  inherited;
  Params.ExStyle := Params.ExStyle OR WS_EX_APPWINDOW;
end;

procedure Tform_conexao.Deletar1Click(Sender: TObject);
var
cd_usuario : string;
begin
  cd_usuario := grid_usuario.columns.items[0].field.text;
  FDQuery_usuario.close;
  FDQuery_usuario.SQL.Clear;
  FDQuery_usuario.SQL.Add('delete from cadastro.tb_usuario where cd_usuario = '+cd_usuario+'');
  FDQuery_usuario.ExecSQL;
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

procedure Tform_conexao.Editar3Click(Sender: TObject);
var
cd_usuario : string;
begin
  cd_usuario := grid_usuario.columns.items[0].field.text;
  FDQuery_usuario.close;
  FDQuery_usuario.SQL.Clear;
  FDQuery_usuario.SQL.Add('SELECT cd_usuario, tb_usuario.cd_cliente, nm_sistema, nm_terminal, nm_usuario, senha,obs FROM cadastro.tb_usuario where cd_usuario = '+cd_usuario+'');
  FDQuery_usuario.open;
  Grid_usuario.Columns[0].Title.Caption := 'Codigo';
  Grid_usuario.Columns[0].Width := 40;
  Grid_usuario.Columns[1].Title.Caption := 'Cliente';
  Grid_usuario.Columns[1].Width := 40;
  Grid_usuario.Columns[2].Title.Caption := 'Sistema Operacional';
  Grid_usuario.Columns[2].Width := 200;
  Grid_usuario.Columns[3].Title.Caption := 'Terminal';
  Grid_usuario.Columns[3].Width := 150;
  Grid_usuario.Columns[4].Title.Caption := 'Usuario';
  Grid_usuario.Columns[4].Width := 200;
  Grid_usuario.Columns[5].Title.Caption := 'Senha';
  Grid_usuario.Columns[5].Width := 200;
  Grid_usuario.Columns[6].Title.Caption := 'Obs';
  Grid_usuario.Columns[6].Width := 200;
  form_cadastro_usuario.txt_box_cd_usuario.text := Grid_usuario.columns.items[0].field.text;
  form_cadastro_usuario.txt_box_cd_cliente.text := Grid_usuario.columns.items[1].field.text;
  form_cadastro_usuario.cb_nm_programa.text := Grid_usuario.columns.items[2].field.text;
  form_cadastro_usuario.cb_nm_terminal.text := Grid_usuario.columns.items[3].field.text;
  form_cadastro_usuario.txt_box_nm_usuario.text := Grid_usuario.columns.items[4].field.text;
  form_cadastro_usuario.txt_box_senha.text := Grid_usuario.columns.items[5].field.text;
  form_cadastro_usuario.txt_box_obs.text := Grid_usuario.columns.items[6].field.text;
  form_cadastro_usuario.ShowModal;
end;

end.
