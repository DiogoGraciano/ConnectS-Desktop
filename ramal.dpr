program ramal;

uses
  Vcl.Forms,
  tela_ramal in 'tela_ramal.pas' {form_ramal},
  tela_cadastro_ramal in 'tela_cadastro_ramal.pas' {form_cadastro_ramal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tform_ramal, form_ramal);
  Application.CreateForm(Tform_cadastro_ramal, form_cadastro_ramal);
  Application.Run;
end.
