program Agenda;

uses
  Vcl.Forms,
  tela_agendamento in 'tela_agendamento.pas' {form_agendamento},
  tela_consulta_cliente_agenda in 'tela_consulta_cliente_agenda.pas' {form_consulta_cliente_agenda},
  tela_consulta_funcionario in 'tela_consulta_funcionario.pas' {form_consulta_funcionario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tform_agendamento, form_agendamento);
  Application.CreateForm(Tform_consulta_cliente_agenda, form_consulta_cliente_agenda);
  Application.CreateForm(Tform_consulta_funcionario, form_consulta_funcionario);
  Application.Run;
end.
