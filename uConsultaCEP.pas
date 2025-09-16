unit uConsultaCEP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Client, System.JSON, System.StrUtils,
  Vcl.Mask;

type
  TuConsultaCEPForm = class(TForm)
    lblCEP: TLabel;
    btnConsultar: TButton;
    lblEstado: TLabel;
    edtEstado: TEdit;
    lblCidade: TLabel;
    edtCidade: TEdit;
    lblBairro: TLabel;
    edtBairro: TEdit;
    lblLogradouro: TLabel;
    edtLogradouro: TEdit;
    medtCEP: TMaskEdit;
    btnLimpar: TButton;
    procedure btnConsultarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    procedure PreencherCampos(psJSON: string);
  public
    { Public declarations }
  end;

var
  uConsultaCEPForm: TuConsultaCEPForm;

implementation

{$R *.dfm}

procedure TuConsultaCEPForm.btnConsultarClick(Sender: TObject);
var
  loClient: TRESTClient;
  loRequest: TRESTRequest;
  loResponse: TRESTResponse;
  lsJSON: string;
  lsCEP: string;
begin
  // Remove caracteres não numéricos
  lsCEP := StringReplace(medtCEP.Text, '-', '', [rfReplaceAll]);
  lsCEP := StringReplace(lsCEP, '_', '', [rfReplaceAll]);
  lsCEP := StringReplace(lsCEP, ' ', '', [rfReplaceAll]);

  // Validação de comprimento do CEP
  if Length(lsCEP) <> 8 then begin
    ShowMessage('Digite um CEP válido no formato 00000-000.');
    medtCEP.SetFocus;
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    // Cria os objetos REST
    loClient := TRESTClient.Create(nil);
    loRequest := TRESTRequest.Create(nil);
    loResponse := TRESTResponse.Create(nil);
    try
      // API do ViaCEP
      loClient.BaseURL := 'https://viacep.com.br/ws/' + lsCEP + '/json/';
      loRequest.Client := loClient;
      loRequest.Response := loResponse;

      loRequest.Execute;

      lsJSON := loResponse.Content;
      PreencherCampos(lsJSON);

    finally
      loClient.Free;
      loRequest.Free;
      loResponse.Free;
    end;

  except
    on E: Exception do
      ShowMessage('Erro ao consultar CEP: ' + E.Message);
  end;

  Screen.Cursor := crDefault;
end;

procedure TuConsultaCEPForm.btnLimparClick(Sender: TObject);
begin
  // Limpa os campos
  medtCEP.Clear;
  edtLogradouro.Clear;
  edtBairro.Clear;
  edtCidade.Clear;
  edtEstado.Clear;
  medtCEP.SetFocus;
end;

procedure TuConsultaCEPForm.PreencherCampos(psJSON: string);
var
  loObj: TJSONObject;
  lsEstado: String;
begin
  loObj := TJSONObject.ParseJSONValue(psJSON) as TJSONObject;
  lsEstado := '';
  try
    if Assigned(loObj) then begin
      // Se a API retornar erro
      if (loObj.GetValue('erro') <> nil) and (loObj.GetValue<Boolean>('erro')) then begin
        ShowMessage('CEP não encontrado.');
        Exit;
      end;

      // Preenche os campos da tela com os dados recebidos
      edtLogradouro.Text := loObj.GetValue<string>('logradouro', '');
      edtBairro.Text     := loObj.GetValue<string>('bairro', '');
      edtCidade.Text     := loObj.GetValue<string>('localidade', '');
      lsEstado           := loObj.GetValue<string>('estado', '');

      if lsEstado <> '' then begin
        edtEstado.Text := lsEstado + ' - ' + loObj.GetValue<string>('uf', '')
      end else begin
        edtEstado.Text := loObj.GetValue<string>('uf', '');
      end;
    end;
  finally
    loObj.Free;
  end;
end;

end.
