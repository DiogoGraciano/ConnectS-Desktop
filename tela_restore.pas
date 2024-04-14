unit tela_restore;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.WinXPanels, Vcl.Menus, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  Tform_restore = class(TForm)
    btn_pg: TSpeedButton;
    txt_box_pg: TEdit;
    cb_sistema: TComboBox;
    txt_sistema: TLabel;
    txt_caminho: TLabel;
    txt_box_ip: TEdit;
    txt_ip: TLabel;
    txt_box_nome: TEdit;
    txt_nome: TLabel;
    checkbox_restaurar: TCheckBox;
    CheckBox_excluir: TCheckBox;
    CheckBox_criar: TCheckBox;
    CheckBox_backup: TCheckBox;
    btn_gerar: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    SpeedButton1: TSpeedButton;
    txt_box_base: TEdit;
    txt_base: TLabel;
    CheckBox_bat: TCheckBox;
    procedure btn_gerarClick(Sender: TObject);
    procedure btn_pgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_restore: Tform_restore;

implementation

{$R *.dfm}

procedure Tform_restore.btn_gerarClick(Sender: TObject);
var
   ArqTxt : TextFile;
   a,b,c,d,e,f,g,h,i : string;
begin
  if SaveDialog.Execute = true then
  begin
    ExtractFilePath(SaveDialog.FileName);
  end;
  // verifica se o caminho foi preechido
  if (txt_box_pg.text <> '') and (txt_box_ip.text <> '') and (txt_box_nome.text <> '') and (CheckBox_restaurar.Checked = true) and (txt_box_base.text <> '') then
  begin
    a := '"'+txt_box_pg.text+'pg_restore.exe" -h '+txt_box_ip.text+' -p 5432 -u postgres -d '+txt_box_nome.text+' -v "'+txt_box_base.text+'"';
  end;
  if (txt_box_pg.text <> '') and (txt_box_ip.text <> '') and (txt_box_nome.text <> '') and (CheckBox_excluir.Checked = true) then
  begin
    b := '"'+txt_box_pg.text+'dropdb.exe" -h '+txt_box_ip.text+' -u postgres '+txt_box_nome.text+'';
  end;
  if (txt_box_pg.text <> '') and (txt_box_ip.text <> '') and (txt_box_nome.text <> '') and (CheckBox_criar.Checked = true) then
  begin
    c := '"'+txt_box_pg.text+'create.exe" -h '+txt_box_ip.text+' -e UTF8 -u postgres '+txt_box_nome.text+'';
  end;
  if (txt_box_pg.text <> '') and (txt_box_ip.text <> '') and (txt_box_nome.text <> '') and (txt_box_base.text <> '') and (CheckBox_backup.Checked = true) then
  begin
    d := '"'+txt_box_pg.text+'pg_dump.exe" -h '+txt_box_ip.text+' -p 5432 -U postgres -F c -b -v -f "'+txt_box_base.text+'" '+txt_box_nome.text+'';
  end;
  if CheckBox_bat.Checked = true then
  begin
    AssignFile(ArqTxt, SaveDialog.FileName + '.bat');
    rewrite(arqtxt);
    writeln(arqtxt,'@echo off');
    writeln(arqtxt,'set PGPASSWORD=hm1722+#()');
    writeln(arqtxt,a);
    writeln(arqtxt,b);
    writeln(arqtxt,c);
    writeln(arqtxt,d);
    writeln(arqtxt,'set PGPASSWORD=');
    writeln(arqtxt,'exit');
    closefile(arqtxt);
  end
  else
  begin
    AssignFile(ArqTxt, SaveDialog.FileName + '.txt');
    rewrite(arqtxt);
    writeln(arqtxt,a);
    writeln(arqtxt,b);
    writeln(arqtxt,c);
    writeln(arqtxt,d);
    closefile(arqtxt);
  end;
  Application.MessageBox('Concluido', 'SUCESSO', mb_ok + mb_iconINFORMATION);
end;

procedure Tform_restore.btn_pgClick(Sender: TObject);
begin
  if OpenDialog.Execute = true then
  txt_box_pg.text := ExtractFilePath(OpenDialog.FileName)
end;

procedure Tform_restore.FormCreate(Sender: TObject);
begin
  CheckBox_restaurar.Checked := true;
  CheckBox_backup.Checked := true;
  CheckBox_criar.Checked := true;
  CheckBox_excluir.Checked := true;
end;

procedure Tform_restore.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog.Execute = true then
  txt_box_base.text := OpenDialog.FileName
end;

end.
