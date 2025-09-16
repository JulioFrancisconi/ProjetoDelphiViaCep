program ConsultaCEP;

uses
  Vcl.Forms,
  uConsultaCEP in 'uConsultaCEP.pas' {uConsultaCEPForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TuConsultaCEPForm, uConsultaCEPForm);
  Application.Run;
end.
