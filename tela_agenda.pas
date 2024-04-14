unit tela_agenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.Samples.Calendar, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Calendar: TCalendar;
    procedure CalendarChange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.CalendarChange(Sender: TObject);
begin
calendar.day := 25
end;

end.
