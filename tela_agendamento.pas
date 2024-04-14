unit tela_agendamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ActnMan, Vcl.ActnColorMaps,
  Vcl.Menus, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls,DateUtils,
  Vcl.WinXCalendars, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.CustomizeDlg;

type
  Tform_agendamento = class(TForm)
    CalendarView: TCalendarView;
    date_cadastro_inicio: TDateTimePicker;
    date_cadastro_fim: TDateTimePicker;
    txt_inicio: TLabel;
    txt_fim: TLabel;
    txt_cd_cliente: TLabel;
    btn_cliente: TButton;
    txt_box_cd_cliente: TEdit;
    txt_colocaborador: TLabel;
    btn_funcionario: TButton;
    txt_box_cd_funcionario: TEdit;
    txt_descrição: TLabel;
    txt_box_obs: TEdit;
    grid_agenda: TDBGrid;
    btn_gravar: TButton;
    PopupMenu: TPopupMenu;
    txt_codigo: TLabel;
    txt_box_cd_agenda: TEdit;
    ColorDialog: TColorDialog;
    txt_cor: TLabel;
    txt_box_cor: TEdit;
    btn_cor: TButton;
    Editar1: TMenuItem;
    Editar2: TMenuItem;
    MarcarcomoFinalizado1: TMenuItem;
    MarcarComoNoRealizado1: TMenuItem;
    MarcarComoNoRealizado2: TMenuItem;
    date_consulta_inicio: TDateTimePicker;
    date_consulta_fim: TDateTimePicker;
    txt_de: TLabel;
    txt_ate: TLabel;
    cb_status_consulta: TComboBox;
    btn_buscar: TButton;
    data_agenda: TDataSource;
    FDConnection: TFDConnection;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    FDQuery_agenda: TFDQuery;
    cb_status_cadastro: TComboBox;
    txt_status: TLabel;
    Panel1: TPanel;
    txt_nm_cliente: TLabel;
    txt_nm_funcionario: TLabel;
    check_mostrartodos: TCheckBox;
    Exportar1: TMenuItem;
    SaveDialog: TSaveDialog;
    procedure btn_corClick(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_clienteClick(Sender: TObject);
    procedure btn_funcionarioClick(Sender: TObject);
    procedure grid_agendaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Editar2Click(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure MarcarComoNoRealizado1Click(Sender: TObject);
    procedure MarcarcomoFinalizado1Click(Sender: TObject);
    procedure MarcarComoNoRealizado2Click(Sender: TObject);
    procedure grid_agendaCellClick(Column: TColumn);
    procedure btn_buscarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure grid_agendaTitleClick(Column: TColumn);
    procedure check_mostrartodosClick(Sender: TObject);
    procedure Exportar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_agendamento: Tform_agendamento;
  data_inicial,data_final : Tdate;

implementation

{$R *.dfm}

uses tela_consulta_cliente_agenda, tela_consulta_funcionario;


procedure Tform_agendamento.btn_corClick(Sender: TObject);
begin
   colordialog.Execute();
   txt_box_cor.Color := colordialog.Color;
end;


procedure Tform_agendamento.btn_buscarClick(Sender: TObject);
begin
  if (cb_status_consulta.text = 'TODOS') then
    begin
      FDQuery_agenda.close;
      FDQuery_agenda.SQL.Clear;
      FDQuery_agenda.SQL.Add('SELECT a.cd_agenda, a.cd_cliente, c.nm_cliente, c.nr_loja, a.cd_funcionario, r.nm_funcionario, a.dt_inicio, a.dt_fim, a.status, a.obs, a.cor FROM cadastro.tb_agendamento a INNER JOIN cadastro.tb_cliente C ON a.cd_cliente = c.cd_cliente');
      FDQuery_agenda.SQL.Add('INNER JOIN cadastro.tb_ramal r ON a.cd_funcionario = r.cd_ramal');
      FDQuery_agenda.SQL.Add('WHERE dt_inicio >= :dt_inicio and dt_fim <= :dt_fim');
      FDQuery_agenda.ParamByName('dt_inicio').asDate := date_consulta_inicio.Date;
      FDQuery_agenda.ParamByName('dt_fim').asDate := date_consulta_fim.Date;
      FDQuery_agenda.open;
      grid_agenda.Columns[0].Visible := false;
      grid_agenda.Columns[1].Visible := false;
      grid_agenda.Columns[4].Visible := false;
      grid_agenda.Columns[10].Visible := false;
      grid_agenda.Columns[2].Title.Caption := 'Cliente';
      grid_agenda.Columns[2].Width := 200;
      grid_agenda.Columns[3].Title.Caption := 'Loja';
      grid_agenda.Columns[3].Width := 35;
      grid_agenda.Columns[5].Title.Caption := 'Funcionario';
      grid_agenda.Columns[5].Width := 200;
      grid_agenda.Columns[6].Title.Caption := 'Data Inicial';
      grid_agenda.Columns[6].Width := 70;
      grid_agenda.Columns[7].Title.Caption := 'Data Final';
      grid_agenda.Columns[7].Width := 70;
      grid_agenda.Columns[8].Title.Caption := 'Status';
      grid_agenda.Columns[8].Width := 80;
      grid_agenda.Columns[9].Title.Caption
    end
  else
    begin
      FDQuery_agenda.close;
      FDQuery_agenda.SQL.Clear;
      FDQuery_agenda.SQL.Add('SELECT a.cd_agenda, a.cd_cliente, c.nm_cliente, c.nr_loja, a.cd_funcionario, r.nm_funcionario, a.dt_inicio, a.dt_fim, a.status, a.obs, a.cor FROM cadastro.tb_agendamento a INNER JOIN cadastro.tb_cliente C ON a.cd_cliente = c.cd_cliente');
      FDQuery_agenda.SQL.Add('INNER JOIN cadastro.tb_ramal r ON a.cd_funcionario = r.cd_ramal');
      FDQuery_agenda.SQL.Add('WHERE dt_inicio >= :dt_inicio and dt_fim <= :dt_fim');
      FDQuery_agenda.SQL.Add('and status = :status');
      FDQuery_agenda.ParamByName('dt_inicio').asDate := date_consulta_inicio.Date;
      FDQuery_agenda.ParamByName('dt_fim').asDate := date_consulta_fim.Date;
      FDQuery_agenda.ParamByName('status').asString := cb_status_consulta.Text;
      FDQuery_agenda.open;
      grid_agenda.Columns[0].Visible := false;
      grid_agenda.Columns[1].Visible := false;
      grid_agenda.Columns[4].Visible := false;
      grid_agenda.Columns[10].Visible := false;
      grid_agenda.Columns[2].Title.Caption := 'Cliente';
      grid_agenda.Columns[2].Width := 200;
      grid_agenda.Columns[3].Title.Caption := 'Loja';
      grid_agenda.Columns[3].Width := 35;
      grid_agenda.Columns[5].Title.Caption := 'Funcionario';
      grid_agenda.Columns[5].Width := 200;
      grid_agenda.Columns[6].Title.Caption := 'Data Inicial';
      grid_agenda.Columns[6].Width := 70;
      grid_agenda.Columns[7].Title.Caption := 'Data Final';
      grid_agenda.Columns[7].Width := 70;
      grid_agenda.Columns[8].Title.Caption := 'Status';
      grid_agenda.Columns[8].Width := 80;
      grid_agenda.Columns[9].Title.Caption
    end;
    if check_mostrartodos.Checked = true then
    begin
      try
      CalendarView.SelectionColor := Tcolor($8B1A1A);
      FDQuery_agenda.First;
      while not FDQuery_agenda.Eof do
        begin
          data_inicial := strtodate(grid_agenda.columns.items[6].Field.text);
          data_final := strtodate(grid_agenda.columns.items[7].Field.text);
          while data_inicial <> data_final + 1 do
          begin
            CalendarView.AddToSelectedDates(data_inicial);
            data_inicial := data_inicial + 1;
          end;
          FDQuery_agenda.Next;
        end;
      except
      end;
    end;
end;

procedure Tform_agendamento.btn_clienteClick(Sender: TObject);
begin
  form_consulta_cliente_agenda.showmodal
end;

procedure Tform_agendamento.btn_funcionarioClick(Sender: TObject);
begin
  form_consulta_funcionario.showmodal
end;

procedure Tform_agendamento.btn_gravarClick(Sender: TObject);
var
color : string;
cd_agenda : integer;
begin
    color := colortostring(txt_box_cor.Color);
    if (txt_box_cd_cliente.text = '') or (txt_box_cd_funcionario.text = '') then
      begin
        Application.MessageBox('Preencha todos os campos obrigatorios','ERRO', mb_ok+mb_iconERROR);
      end
    else if date_cadastro_inicio.date > date_cadastro_fim.Date then
      begin
        Application.MessageBox('Data incial maior que data final','ERRO', mb_ok+mb_iconERROR);
      end
    else
      begin
        if txt_box_cd_agenda.Text = '' then
          begin
            FDQuery_agenda.close;
            FDQuery_agenda.SQL.Clear;
            FDQuery_agenda.SQL.Add('SELECT cd_agenda FROM cadastro.tb_agendamento order by cd_agenda desc limit 1');
            FDQuery_agenda.open;
            cd_agenda := FDQuery_agenda.FieldByName('cd_agenda').AsInteger;
            cd_agenda := cd_agenda + 1;
            FDQuery_agenda.close;
            FDQuery_agenda.SQL.Clear;
            FDQuery_agenda.SQL.Add('INSERT INTO cadastro.tb_agendamento (cd_agenda,cd_cliente,cd_funcionario,obs,dt_inicio,dt_fim, cor, status) VALUES (:cd_agenda, :cd_cliente, :cd_funcionario, :obs, :dt_inicio, :dt_fim, :cor, :status );');
            FDQuery_agenda.ParamByName('cd_agenda').asInteger := cd_agenda;
            FDQuery_agenda.ParamByName('cd_cliente').asInteger := strtoint(txt_box_cd_cliente.Text);
            FDQuery_agenda.ParamByName('cd_funcionario').asInteger := strtoint(txt_box_cd_funcionario.Text);
            FDQuery_agenda.ParamByName('obs').asString := txt_box_obs.Text;
            FDQuery_agenda.ParamByName('dt_inicio').asDate := date_cadastro_inicio.Date;
            FDQuery_agenda.ParamByName('dt_fim').asDate := date_cadastro_fim.Date;
            FDQuery_agenda.ParamByName('cor').asString := color;
            FDQuery_agenda.ParamByName('status').asString := cb_status_cadastro.text;
            FDQuery_agenda.ExecSQL;
            Application.MessageBox('Concluido','SUCESSO', mb_ok+mb_iconINFORMATION);
            txt_box_cd_cliente.text := '';
            txt_box_cd_agenda.text := '';
            txt_box_cd_funcionario.text := '';
            txt_box_obs.text := '';
            txt_nm_cliente.Caption := '';
            txt_nm_funcionario.Caption := '';
            txt_box_cd_agenda.text := '';
            txt_box_cor.color := clScrollBar;
            txt_box_cd_agenda.ComponentIndex := 0;
          end
        else if txt_box_cd_agenda.Text <> '' then
          begin
            FDQuery_agenda.close;
            FDQuery_agenda.SQL.Clear;
            FDQuery_agenda.SQL.Add('UPDATE cadastro.tb_agendamento SET cd_cliente = :cd_cliente, cd_funcionario = :cd_funcionario, obs = :obs, dt_inicio = :dt_inicio, dt_fim = :dt_fim, cor = :cor, status = :status WHERE cd_agenda = :cd_agenda');
            FDQuery_agenda.ParamByName('cd_agenda').asInteger := strtoint(txt_box_cd_agenda.text);
            FDQuery_agenda.ParamByName('cd_cliente').asInteger := strtoint(txt_box_cd_cliente.Text);
            FDQuery_agenda.ParamByName('cd_funcionario').asInteger := strtoint(txt_box_cd_funcionario.Text);
            FDQuery_agenda.ParamByName('obs').asString := txt_box_obs.Text;
            FDQuery_agenda.ParamByName('dt_inicio').asDate := date_cadastro_inicio.Date;
            FDQuery_agenda.ParamByName('dt_fim').asDate := date_cadastro_fim.Date;
            FDQuery_agenda.ParamByName('cor').asString := color;
            FDQuery_agenda.ParamByName('status').asString := cb_status_cadastro.text;
            FDQuery_agenda.ExecSQL;
            Application.MessageBox('Concluido','SUCESSO', mb_ok+mb_iconINFORMATION);
            txt_box_cd_cliente.text := '';
            txt_box_cd_agenda.text := '';
            txt_box_cd_funcionario.text := '';
            txt_box_obs.text := '';
            txt_box_cd_agenda.text := '';
            txt_nm_cliente.Caption := '';
            txt_nm_funcionario.Caption := '';
            txt_box_cor.color := clScrollBar;
            txt_box_cd_agenda.ComponentIndex := 0;
          end;
          FDQuery_agenda.close;
          FDQuery_agenda.SQL.Clear;
          FDQuery_agenda.SQL.Add('SELECT a.cd_agenda, a.cd_cliente, c.nm_cliente, c.nr_loja, a.cd_funcionario, r.nm_funcionario, a.dt_inicio, a.dt_fim, a.status, a.obs, a.cor FROM cadastro.tb_agendamento a INNER JOIN cadastro.tb_cliente C ON a.cd_cliente = c.cd_cliente');
          FDQuery_agenda.SQL.Add('INNER JOIN cadastro.tb_ramal r ON a.cd_funcionario = r.cd_ramal');
          FDQuery_agenda.SQL.Add('where dt_inicio >= current_date - 31 and dt_fim <= current_date + 31');
          FDQuery_agenda.open;
          grid_agenda.Columns[0].Visible := false;
          grid_agenda.Columns[1].Visible := false;
          grid_agenda.Columns[4].Visible := false;
          grid_agenda.Columns[10].Visible := false;
          grid_agenda.Columns[2].Title.Caption := 'Cliente';
          grid_agenda.Columns[2].Width := 200;
          grid_agenda.Columns[3].Title.Caption := 'Loja';
          grid_agenda.Columns[3].Width := 35;
          grid_agenda.Columns[5].Title.Caption := 'Funcionario';
          grid_agenda.Columns[5].Width := 200;
          grid_agenda.Columns[6].Title.Caption := 'Data Inicial';
          grid_agenda.Columns[6].Width := 70;
          grid_agenda.Columns[7].Title.Caption := 'Data Final';
          grid_agenda.Columns[7].Width := 70;
          grid_agenda.Columns[8].Title.Caption := 'Status';
          grid_agenda.Columns[8].Width := 80;
          grid_agenda.Columns[9].Title.Caption
      end;
    if check_mostrartodos.Checked = true then
      begin
        try
        CalendarView.SelectionColor := Tcolor($8B1A1A);
        FDQuery_agenda.First;
        while not FDQuery_agenda.Eof do
          begin
            data_inicial := strtodate(grid_agenda.columns.items[6].Field.text);
            data_final := strtodate(grid_agenda.columns.items[7].Field.text);
            while data_inicial <> data_final + 1 do
            begin
              CalendarView.AddToSelectedDates(data_inicial);
              data_inicial := data_inicial + 1;
            end;
            FDQuery_agenda.Next;
          end;
        except
        end;
      end;
end;


procedure Tform_agendamento.check_mostrartodosClick(Sender: TObject);
begin
   if check_mostrartodos.Checked = false then
    begin
      try
      calendarview.SelectionMode := TSelectionMode(0);
      calendarview.SelectionMode := TSelectionMode(2);
      CalendarView.SelectionColor := StringToColor(grid_agenda.columns.items[10].field.text);
      data_inicial := strtodate(grid_agenda.columns.items[6].Field.text);
      data_final := strtodate(grid_agenda.columns.items[7].Field.text);
      CalendarView.date := data_inicial;
        while data_inicial <> data_final + 1 do
          begin
            CalendarView.AddToSelectedDates(data_inicial);
            data_inicial := data_inicial + 1;
          end;
      except
      end;
    end;
  if check_mostrartodos.Checked = true then
    begin
      try
      CalendarView.SelectionColor := Tcolor($8B1A1A);
      FDQuery_agenda.First;
      while not FDQuery_agenda.Eof do
        begin
          data_inicial := strtodate(grid_agenda.columns.items[6].Field.text);
          data_final := strtodate(grid_agenda.columns.items[7].Field.text);
          while data_inicial <> data_final + 1 do
          begin
            CalendarView.AddToSelectedDates(data_inicial);
            data_inicial := data_inicial + 1;
          end;
          FDQuery_agenda.Next;
        end;
      except
      end;
    end;
end;

procedure Tform_agendamento.Editar1Click(Sender: TObject);
begin
  try
    txt_box_cd_agenda.text := Grid_agenda.columns.items[0].field.text;
    txt_box_cd_cliente.text := Grid_agenda.columns.items[1].field.text;
    txt_box_cd_funcionario.text := Grid_agenda.columns.items[4].field.text;
    date_cadastro_inicio.date := strtodate(Grid_agenda.columns.items[6].field.text);
    date_cadastro_fim.date := strtodate(Grid_agenda.columns.items[7].field.text);
    cb_status_cadastro.text := Grid_agenda.columns.items[8].field.text;
    txt_box_obs.text := Grid_agenda.columns.items[9].field.text;
    txt_box_cor.color := stringtocolor(grid_agenda.columns.items[10].field.text);
    form_agendamento.btn_cor.SetFocus;
  except
    Application.MessageBox('Nada selecionado','ERRO', mb_ok+mb_iconerror);
  end;
end;

procedure Tform_agendamento.Editar2Click(Sender: TObject);
var
cd_agenda :  string;
begin
  try
  cd_agenda := Grid_agenda.columns.items[0].field.text;
  FDQuery_agenda.close;
  FDQuery_agenda.SQL.Clear;
  FDQuery_agenda.SQL.Add('delete from cadastro.tb_agendamento where cd_agenda = '+cd_agenda+'');
  FDQuery_agenda.ExecSQL;
  FDQuery_agenda.close;
  FDQuery_agenda.SQL.Clear;
  FDQuery_agenda.SQL.Add('SELECT a.cd_agenda, a.cd_cliente, c.nm_cliente, c.nr_loja, a.cd_funcionario, r.nm_funcionario, a.dt_inicio, a.dt_fim, a.status, a.obs, a.cor FROM cadastro.tb_agendamento a INNER JOIN cadastro.tb_cliente C ON a.cd_cliente = c.cd_cliente');
  FDQuery_agenda.SQL.Add('INNER JOIN cadastro.tb_ramal r ON a.cd_funcionario = r.cd_ramal');
  FDQuery_agenda.SQL.Add('where dt_inicio >= current_date - 31 and dt_fim <= current_date + 31');
  FDQuery_agenda.open;
  grid_agenda.Columns[0].Visible := false;
  grid_agenda.Columns[1].Visible := false;
  grid_agenda.Columns[4].Visible := false;
  grid_agenda.Columns[10].Visible := false;
  grid_agenda.Columns[2].Title.Caption := 'Cliente';
  grid_agenda.Columns[2].Width := 200;
  grid_agenda.Columns[3].Title.Caption := 'Loja';
  grid_agenda.Columns[3].Width := 35;
  grid_agenda.Columns[5].Title.Caption := 'Funcionario';
  grid_agenda.Columns[5].Width := 200;
  grid_agenda.Columns[6].Title.Caption := 'Data Inicial';
  grid_agenda.Columns[6].Width := 70;
  grid_agenda.Columns[7].Title.Caption := 'Data Final';
  grid_agenda.Columns[7].Width := 70;
  grid_agenda.Columns[8].Title.Caption := 'Status';
  grid_agenda.Columns[8].Width := 80;
  grid_agenda.Columns[9].Title.Caption := 'Descrição';
  grid_agenda.Columns[9].Width := 200;
  except
  Application.MessageBox('Nada selecionado','ERRO', mb_ok+mb_iconerror);
  end;
end;

procedure Tform_agendamento.Exportar1Click(Sender: TObject);
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
  colunas := FDQuery_agenda.FieldCount;
  i := -1;
  colunas := colunas - 1;
  // cria colunas
  while colunas <> i do
  begin
    i := i + 1;
    Linha1 := grid_agenda.columns[i].Title.Caption;
    write(ArqTxt, ';' + Linha1);
  end;
  writeln(ArqTxt, ';');
  // cria rows
  while not FDQuery_agenda.Eof do
  begin
    for c := 0 to colunas do
    begin
      Linha1 := grid_agenda.fields[c].DisplayText;
      write(ArqTxt, ';' + Linha1);
    end;
    writeln(ArqTxt, ';');
    FDQuery_agenda.Next
  end;
  CloseFile(ArqTxt);
  Application.MessageBox('Concluido', 'SUCESSO', mb_ok + mb_iconINFORMATION);
end;

procedure Tform_agendamento.FormCreate(Sender: TObject);
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
  FDQuery_agenda.Create(nil);
  FDQuery_agenda.Connection := FDConnection;
  data_agenda.Create(nil);
  data_agenda.DataSet := FDQuery_agenda;
  Grid_agenda.Create(nil);
  Grid_agenda.DataSource := data_agenda;
  CalendarView.date := date();
  date_cadastro_fim.Date := date()+7;
  date_cadastro_inicio.Date := date();
  date_consulta_fim.Date := date()+31;
  date_consulta_inicio.Date := date()-31;
  //consulta as conexões
  FDQuery_agenda.close;
  FDQuery_agenda.SQL.Clear;
  FDQuery_agenda.SQL.Add('SELECT a.cd_agenda, a.cd_cliente, c.nm_cliente, c.nr_loja, a.cd_funcionario, r.nm_funcionario, a.dt_inicio, a.dt_fim, a.status, a.obs, a.cor FROM cadastro.tb_agendamento a INNER JOIN cadastro.tb_cliente C ON a.cd_cliente = c.cd_cliente');
  FDQuery_agenda.SQL.Add('INNER JOIN cadastro.tb_ramal r ON a.cd_funcionario = r.cd_ramal');
  FDQuery_agenda.SQL.Add('where dt_inicio >= current_date - 31 and dt_fim <= current_date + 31');
  FDQuery_agenda.open;
  grid_agenda.Columns[0].Visible := false;
  grid_agenda.Columns[1].Visible := false;
  grid_agenda.Columns[4].Visible := false;
  grid_agenda.Columns[10].Visible := false;
  grid_agenda.Columns[2].Title.Caption := 'Cliente';
  grid_agenda.Columns[2].Width := 200;
  grid_agenda.Columns[3].Title.Caption := 'Loja';
  grid_agenda.Columns[3].Width := 35;
  grid_agenda.Columns[5].Title.Caption := 'Funcionario';
  grid_agenda.Columns[5].Width := 200;
  grid_agenda.Columns[6].Title.Caption := 'Data Inicial';
  grid_agenda.Columns[6].Width := 70;
  grid_agenda.Columns[7].Title.Caption := 'Data Final';
  grid_agenda.Columns[7].Width := 70;
  grid_agenda.Columns[8].Title.Caption := 'Status';
  grid_agenda.Columns[8].Width := 80;
  grid_agenda.Columns[9].Title.Caption := 'Descrição';
  grid_agenda.Columns[9].Width := 200;
  check_mostrartodos.Checked := false;
  check_mostrartodos.Checked := true;
end;

procedure Tform_agendamento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #27 Then Close;
  if key=#13 then Perform(WM_nextdlgctl,0,0);
end;

procedure Tform_agendamento.grid_agendaCellClick(Column: TColumn);
begin
  if check_mostrartodos.Checked = false then
    begin
      try
      calendarview.SelectionMode := TSelectionMode(0);
      calendarview.SelectionMode := TSelectionMode(2);
      CalendarView.SelectionColor := StringToColor(grid_agenda.columns.items[10].field.text);
      data_inicial := strtodate(grid_agenda.columns.items[6].Field.text);
      data_final := strtodate(grid_agenda.columns.items[7].Field.text);
      CalendarView.date := data_inicial;
        while data_inicial <> data_final + 1 do
          begin
            CalendarView.AddToSelectedDates(data_inicial);
            data_inicial := data_inicial + 1;
          end;
      except
      end;
    end;
  if check_mostrartodos.Checked = true then
    begin
      try
      CalendarView.SelectionColor := Tcolor($8B1A1A);
      FDQuery_agenda.First;
      while not FDQuery_agenda.Eof do
        begin
          data_inicial := strtodate(grid_agenda.columns.items[6].Field.text);
          data_final := strtodate(grid_agenda.columns.items[7].Field.text);
          while data_inicial <> data_final + 1 do
          begin
            CalendarView.AddToSelectedDates(data_inicial);
            data_inicial := data_inicial + 1;
          end;
          FDQuery_agenda.Next;
        end;
      except
      end;
    end;
end;

procedure Tform_agendamento.grid_agendaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
color : string;
begin
  try
  color := grid_agenda.columns.items[10].field.text;
  grid_agenda.Canvas.Brush.Color := StringToColor(color);
  grid_agenda.Canvas.FillRect(Rect);
  grid_agenda.DefaultDrawColumnCell(rect,datacol,column,state)
  except
  end;
end;

procedure Tform_agendamento.grid_agendaTitleClick(Column: TColumn);
var
i : integer;
begin
  for i := 0 to grid_agenda.Columns.Count - 1 do
    begin
        // retira a formatação negrito/itálico
        grid_agenda.Columns[I].Title.Font.Style := [];
        // altera a cor da fonte do título para Black
        grid_agenda.Columns[I].Title.Font.Color := clBlack;
    end;
  with FDQuery_agenda do
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
  FDQuery_agenda.First;
end;

procedure Tform_agendamento.MarcarcomoFinalizado1Click(Sender: TObject);
var
cd_agenda :  string;
begin
  try
  cd_agenda := Grid_agenda.columns.items[0].field.text;
  FDQuery_agenda.close;
  FDQuery_agenda.SQL.Clear;
  FDQuery_agenda.SQL.Add('update cadastro.tb_agendamento set status = :status where cd_agenda = '+cd_agenda+'');
  FDQuery_agenda.ParamByName('status').asString := 'REALIZADO';
  FDQuery_agenda.ExecSQL;
  FDQuery_agenda.close;
  FDQuery_agenda.SQL.Clear;
  FDQuery_agenda.SQL.Add('SELECT a.cd_agenda, a.cd_cliente, c.nm_cliente, c.nr_loja, a.cd_funcionario, r.nm_funcionario, a.dt_inicio, a.dt_fim, a.status, a.obs, a.cor FROM cadastro.tb_agendamento a INNER JOIN cadastro.tb_cliente C ON a.cd_cliente = c.cd_cliente');
  FDQuery_agenda.SQL.Add('INNER JOIN cadastro.tb_ramal r ON a.cd_funcionario = r.cd_ramal');
  FDQuery_agenda.SQL.Add('where dt_inicio >= current_date - 31 and dt_fim <= current_date + 31');
  FDQuery_agenda.open;
  grid_agenda.Columns[0].Visible := false;
  grid_agenda.Columns[1].Visible := false;
  grid_agenda.Columns[4].Visible := false;
  grid_agenda.Columns[10].Visible := false;
  grid_agenda.Columns[2].Title.Caption := 'Cliente';
  grid_agenda.Columns[2].Width := 200;
  grid_agenda.Columns[3].Title.Caption := 'Loja';
  grid_agenda.Columns[3].Width := 35;
  grid_agenda.Columns[5].Title.Caption := 'Funcionario';
  grid_agenda.Columns[5].Width := 200;
  grid_agenda.Columns[6].Title.Caption := 'Data Inicial';
  grid_agenda.Columns[6].Width := 70;
  grid_agenda.Columns[7].Title.Caption := 'Data Final';
  grid_agenda.Columns[7].Width := 70;
  grid_agenda.Columns[8].Title.Caption := 'Status';
  grid_agenda.Columns[8].Width := 80;
  grid_agenda.Columns[9].Title.Caption := 'Descrição';
  grid_agenda.Columns[9].Width := 200;
  except
  Application.MessageBox('Nada selecionado','ERRO', mb_ok+mb_iconerror);
  end;
end;

procedure Tform_agendamento.MarcarComoNoRealizado1Click(Sender: TObject);
begin
var
cd_agenda :  string;
begin
  try
  cd_agenda := Grid_agenda.columns.items[0].field.text;
  FDQuery_agenda.close;
  FDQuery_agenda.SQL.Clear;
  FDQuery_agenda.SQL.Add('update cadastro.tb_agendamento set status = :status where cd_agenda = '+cd_agenda+'');
  FDQuery_agenda.ParamByName('status').asString := 'PENDENTE';
  FDQuery_agenda.ExecSQL;
  FDQuery_agenda.close;
  FDQuery_agenda.SQL.Clear;
  FDQuery_agenda.SQL.Add('SELECT a.cd_agenda, a.cd_cliente, c.nm_cliente, c.nr_loja, a.cd_funcionario, r.nm_funcionario, a.dt_inicio, a.dt_fim, a.status, a.obs, a.cor FROM cadastro.tb_agendamento a INNER JOIN cadastro.tb_cliente C ON a.cd_cliente = c.cd_cliente');
  FDQuery_agenda.SQL.Add('INNER JOIN cadastro.tb_ramal r ON a.cd_funcionario = r.cd_ramal');
  FDQuery_agenda.SQL.Add('where dt_inicio >= current_date - 31 and dt_fim <= current_date + 31');
  FDQuery_agenda.open;
  grid_agenda.Columns[0].Visible := false;
  grid_agenda.Columns[1].Visible := false;
  grid_agenda.Columns[4].Visible := false;
  grid_agenda.Columns[10].Visible := false;
  grid_agenda.Columns[2].Title.Caption := 'Cliente';
  grid_agenda.Columns[2].Width := 200;
  grid_agenda.Columns[3].Title.Caption := 'Loja';
  grid_agenda.Columns[3].Width := 35;
  grid_agenda.Columns[5].Title.Caption := 'Funcionario';
  grid_agenda.Columns[5].Width := 200;
  grid_agenda.Columns[6].Title.Caption := 'Data Inicial';
  grid_agenda.Columns[6].Width := 70;
  grid_agenda.Columns[7].Title.Caption := 'Data Final';
  grid_agenda.Columns[7].Width := 70;
  grid_agenda.Columns[8].Title.Caption := 'Status';
  grid_agenda.Columns[8].Width := 80;
  grid_agenda.Columns[9].Title.Caption := 'Descrição';
  grid_agenda.Columns[9].Width := 200;
  except
  Application.MessageBox('Nada selecionado','ERRO', mb_ok+mb_iconerror);
  end;
end;
end;

procedure Tform_agendamento.MarcarComoNoRealizado2Click(Sender: TObject);
var
cd_agenda :  string;
begin
  try
  cd_agenda := Grid_agenda.columns.items[0].field.text;
  FDQuery_agenda.close;
  FDQuery_agenda.SQL.Clear;
  FDQuery_agenda.SQL.Add('update cadastro.tb_agendamento set status = :status where cd_agenda = '+cd_agenda+'');
  FDQuery_agenda.ParamByName('status').asString := 'NÃO REALIZADO';
  FDQuery_agenda.ExecSQL;
  FDQuery_agenda.close;
  FDQuery_agenda.SQL.Clear;
  FDQuery_agenda.SQL.Add('SELECT a.cd_agenda, a.cd_cliente, c.nm_cliente, c.nr_loja, a.cd_funcionario, r.nm_funcionario, a.dt_inicio, a.dt_fim, a.status, a.obs, a.cor FROM cadastro.tb_agendamento a INNER JOIN cadastro.tb_cliente C ON a.cd_cliente = c.cd_cliente');
  FDQuery_agenda.SQL.Add('INNER JOIN cadastro.tb_ramal r ON a.cd_funcionario = r.cd_ramal');
  FDQuery_agenda.SQL.Add('where dt_inicio >= current_date - 31 and dt_fim <= current_date + 31');
  FDQuery_agenda.open;
  grid_agenda.Columns[0].Visible := false;
  grid_agenda.Columns[1].Visible := false;
  grid_agenda.Columns[4].Visible := false;
  grid_agenda.Columns[10].Visible := false;
  grid_agenda.Columns[2].Title.Caption := 'Cliente';
  grid_agenda.Columns[2].Width := 200;
  grid_agenda.Columns[3].Title.Caption := 'Loja';
  grid_agenda.Columns[3].Width := 35;
  grid_agenda.Columns[5].Title.Caption := 'Funcionario';
  grid_agenda.Columns[5].Width := 200;
  grid_agenda.Columns[6].Title.Caption := 'Data Inicial';
  grid_agenda.Columns[6].Width := 70;
  grid_agenda.Columns[7].Title.Caption := 'Data Final';
  grid_agenda.Columns[7].Width := 70;
  grid_agenda.Columns[8].Title.Caption := 'Status';
  grid_agenda.Columns[8].Width := 80;
  grid_agenda.Columns[9].Title.Caption := 'Descrição';
  grid_agenda.Columns[9].Width := 200;
  except
  Application.MessageBox('Nada selecionado','ERRO', mb_ok+mb_iconerror);
  end;
end;

end.
