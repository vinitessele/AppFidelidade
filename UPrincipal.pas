unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, Data.db, System.JSON, FMX.Types, FMX.Controls, FMX.Forms,
  FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.MultiView,
  FMX.TabControl, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Edit, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TFPrincipal = class(TForm)
    ToolBar1: TToolBar;
    BtnMenu: TSpeedButton;
    StyleBook1: TStyleBook;
    Label2: TLabel;
    LayoutLogo: TLayout;
    RectangleLogoEmpresa: TRectangle;
    ProgressBar1: TProgressBar;
    RectBarra: TRectangle;
    Image1: TImage;
    LabelEmpresa: TLabel;
    LabelVersao: TLabel;
    btnInf: TSpeedButton;
    LayoutUpdate: TLayout;
    rect_botao: TRectangle;
    btnAtualizar: TSpeedButton;
    RectUpadate: TRectangle;
    Layout2: TLayout;
    lbl_titulo: TLabel;
    lbl_texto: TLabel;
    ImageCirclo: TImage;
    img_seta: TImage;
    ImageBase: TImage;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    MultiView1: TMultiView;
    RectangleMenuTopo: TRectangle;
    Label1: TLabel;
    RectConfiguracao: TRectangle;
    btnConfiguracao: TButton;
    Circle1: TCircle;
    RectLancamento: TRectangle;
    btnLancamento: TButton;
    RectCadastro: TRectangle;
    BtnCadastro: TButton;
    Circle3: TCircle;
    RectProcedimentos: TRectangle;
    btnProcedimentos: TButton;
    Circle4: TCircle;
    Circle2: TCircle;
    procedure FormCreate(Sender: TObject);
    procedure btnInfClick(Sender: TObject);
    procedure btnConfiguracaoClick(Sender: TObject);
    procedure BtnCadastroClick(Sender: TObject);
    procedure btnLancamentoClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnAtualizarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure btnAtualizarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormShow(Sender: TObject);
    procedure btnProcedimentosClick(Sender: TObject);
  private
    { Private declarations }
    versao_app, versao_server: string;
  public
    { Public declarations }
    procedure OnFinishUpdate(Sender: TObject);
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.fmx}

uses uOpenViewUrl, USobre, UDM, UCadClientes, UConfiguracao, ULancamento,
  UProcedimento;
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.XLgXhdpiTb.fmx ANDROID}

procedure TFPrincipal.OnFinishUpdate(Sender: TObject);
begin
  // Ocorreu algum erro na Thread...
  if Assigned(TThread(Sender).FatalException) then
  begin
    showmessage(Exception(TThread(Sender).FatalException).Message);
    exit;
  end;

  if versao_app < versao_server then
  begin
    // Exibe o painel de update...
    LayoutLogo.Visible := False;
    LayoutUpdate.Visible := true;
    img_seta.Position.Y := 0;
    img_seta.Opacity := 0.5;
    lbl_titulo.Opacity := 0;
    lbl_texto.Opacity := 0;
    rect_botao.Opacity := 0;

    LayoutUpdate.BringToFront;
    LayoutUpdate.AnimateFloat('Margins.Top', 0, 0.8, TAnimationType.InOut,
      TInterpolationType.Circular);

    img_seta.AnimateFloatDelay('Position.Y', 50, 0.5, 1, TAnimationType.Out,
      TInterpolationType.Back);
    img_seta.AnimateFloatDelay('Opacity', 1, 0.4, 0.9);

    lbl_titulo.AnimateFloatDelay('Opacity', 1, 0.7, 1.3);
    lbl_texto.AnimateFloatDelay('Opacity', 1, 0.7, 1.6);
    rect_botao.AnimateFloatDelay('Opacity', 1, 0.7, 1.9);
  end;
end;

procedure TFPrincipal.btnAtualizarClick(Sender: TObject);
var
  url: string;
begin
{$IFDEF ANDROID}
  url := 'https://drive.google.com/drive/folders/1RQLKyKAMUWcl96WW_VT2k07FQSsvdNJn?usp=sharing';
{$ELSE}
  url := 'https://drive.google.com/drive/folders/1RQLKyKAMUWcl96WW_VT2k07FQSsvdNJn?usp=sharing';
{$ENDIF}
  OpenURL(url, False);
  Application.Terminate;
end;

procedure TFPrincipal.btnAtualizarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  rect_botao.Opacity := 0.5;
end;

procedure TFPrincipal.btnAtualizarMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  rect_botao.Opacity := 1;
end;

procedure TFPrincipal.BtnCadastroClick(Sender: TObject);
begin
  if not Assigned(FCadCliente) then
    FCadCliente := TFCadCliente.Create(nil);
  FCadCliente.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.btnConfiguracaoClick(Sender: TObject);
begin
  if not Assigned(FConfiguracao) then
    FConfiguracao := TFConfiguracao.Create(nil);
  FConfiguracao.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.btnInfClick(Sender: TObject);
begin
  if not Assigned(FSobre) then
    FSobre := TFSobre.Create(nil);
  FSobre.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.btnLancamentoClick(Sender: TObject);
begin
  if not Assigned(FLancamento) then
    FLancamento := TFLancamento.Create(nil);
  FLancamento.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.btnProcedimentosClick(Sender: TObject);
begin
  if not Assigned(FProcedimentos) then
    FProcedimentos := TFProcedimentos.Create(nil);
  FProcedimentos.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
var
  vFoto: TStream;
begin
  versao_app := '1,5';
  versao_server := '0.0';
  LabelVersao.Text := 'Versão ' + versao_app;
  LayoutUpdate.Margins.Top := FPrincipal.Height + 50;
  DM.FDQParametro.Close;
  DM.FDQParametro.Open();
  // Lendo a imagem do campo BLOB para a Memória
  vFoto := DM.FDQParametro.CreateBlobStream
    (DM.FDQParametro.FieldByName('parametro_logo'), bmRead);
  if vFoto.Size > 0 then
  begin
    RectangleLogoEmpresa.Fill.Bitmap.Bitmap.LoadFromStream(vFoto);
  end;
end;

procedure TFPrincipal.FormShow(Sender: TObject);
var
  t: TThread;
begin
  t := TThread.CreateAnonymousThread(
    procedure
    var
      JsonObj: TJSONObject;
    begin
      Sleep(2000);
      try
        RESTRequest1.Execute;
      except
        on ex: Exception do
        begin
          raise Exception.Create('Erro ao acessar o servidor' + ex.Message);
          exit
        end;
      end;
      try
        JsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes
          (RESTRequest1.Response.JSONValue.ToString), 0) as TJSONObject;

        versao_server := TJSONObject(JsonObj).GetValue('Versao').Value;
      finally
        JsonObj.DisposeOf;
      end;
    end);
  t.OnTerminate := OnFinishUpdate;
  t.Start;
end;

end.
