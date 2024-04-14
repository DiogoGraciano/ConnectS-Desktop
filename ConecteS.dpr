program ConecteS;

uses
  Vcl.Forms,
  tela_login in 'tela_login.pas' {form_login},
  tela_conexao in 'tela_conexao.pas' {form_conexao},
  tela_cadastro in 'tela_cadastro.pas' {form_cadastro},
  tela_consulta_cliente in 'tela_consulta_cliente.pas' {form_consulta_cliente},
  tela_cadastro_cliente in 'tela_cadastro_cliente.pas' {form_cadastro_cliente},
  tela_consulta_cliente_cadastro in 'tela_consulta_cliente_cadastro.pas' {form_consulta_cliente_cadastro},
  tela_consulta_cliente_conexao in 'tela_consulta_cliente_conexao.pas' {form_consulta_cliente_conexao},
  tela_cadastro_usuario in 'tela_cadastro_usuario.pas' {form_cadastro_usuario},
  tela_consulta_cliente_usuario in 'tela_consulta_cliente_usuario.pas' {form_consulta_cliente_usuario},
  tela_senha_usuario in 'tela_senha_usuario.pas' {Form_senha_usuario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tform_login, form_login);
  Application.CreateForm(Tform_cadastro, form_cadastro);
  Application.CreateForm(Tform_consulta_cliente, form_consulta_cliente);
  Application.CreateForm(Tform_cadastro_cliente, form_cadastro_cliente);
  Application.CreateForm(Tform_consulta_cliente_cadastro, form_consulta_cliente_cadastro);
  Application.CreateForm(Tform_consulta_cliente_conexao, form_consulta_cliente_conexao);
  Application.CreateForm(Tform_conexao, form_conexao);
  Application.CreateForm(Tform_cadastro_usuario, form_cadastro_usuario);
  Application.CreateForm(Tform_consulta_cliente_usuario, form_consulta_cliente_usuario);
  Application.CreateForm(TForm_senha_usuario, Form_senha_usuario);
  Application.Run;
end.
