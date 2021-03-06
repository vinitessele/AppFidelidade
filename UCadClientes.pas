unit UCadClientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, Data.db, Permissions,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.TabControl,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FMX.Edit, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions;

type
  TFCadCliente = class(TFModelo)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    VertScrollBox2: TVertScrollBox;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    EditCpfCliente: TEdit;
    EditNomeCliente: TEdit;
    Layout5: TLayout;
    EditCelular: TEdit;
    Layout6: TLayout;
    EditEmail: TEdit;
    Layout7: TLayout;
    Rectangle2: TRectangle;
    RoundRect3: TRoundRect;
    BtnConfirmaCliente: TButton;
    StyleBook1: TStyleBook;
    ActionList1: TActionList;
    ActionPhotoLibrary: TTakePhotoFromLibraryAction;
    CircleFotoCliente: TCircle;
    ListViewCliente: TListView;
    CircleAddProdutos: TCircle;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure FormShow(Sender: TObject);
    procedure CircleAddProdutosClick(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
    procedure BtnConfirmaClienteClick(Sender: TObject);
    procedure ListViewClienteDeleteItem(Sender: TObject; AIndex: Integer);
    procedure ListViewClienteItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ActionPhotoLibraryDidFinishTaking(Image: TBitmap);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
{$IFDEF ANDROID}
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage: string;
    procedure LibraryPermissionRequestResult(Sender: TObject;
      const APermissions: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayMessageLibrary(Sender: TObject;
      const APermissions: TArray<string>; const APostProc: TProc);

{$ENDIF}
  public
    { Public declarations }
    StreamImg: TStream;
  end;

var
  FCadCliente: TFCadCliente;

implementation

{$R *.fmx}

uses UDM, FMX.DialogService

{$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
    , ULancamento;
{$IFDEF ANDROID}

procedure TFCadCliente.LibraryPermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
  // 2 Permissoes: READ_EXTERNAL_STORAGE e WRITE_EXTERNAL_STORAGE
  if (Length(AGrantResults) = 2) and
    (AGrantResults[0] = TPermissionStatus.Granted) and
    (AGrantResults[1] = TPermissionStatus.Granted) then
    ActionPhotoLibrary.Execute
  else
    TDialogService.ShowMessage('Voc� n�o tem permiss�o para acessar as fotos');
end;

procedure TFCadCliente.DisplayMessageLibrary(Sender: TObject;
  const APermissions: TArray<string>; const APostProc: TProc);
begin
  TDialogService.ShowMessage
    ('O app precisa acessar as fotos do seu dispositivo',
    procedure(const AResult: TModalResult)
    begin
      APostProc;
    end);
end;
{$ENDIF}

procedure TFCadCliente.ActionPhotoLibraryDidFinishTaking(Image: TBitmap);
begin
  inherited;
  CircleFotoCliente.Fill.Bitmap.Bitmap := Image;
end;

procedure TFCadCliente.BtnConfirmaClienteClick(Sender: TObject);
begin
  inherited;
  If not(dm.FDQClienteAll.State in [dsEdit, dsInsert]) then
  begin
    dm.FDQClienteAll.Append;
  end;
  dm.FDQClienteAllcliente_cpf.AsString := EditCpfCliente.Text;
  dm.FDQClienteAllcliente_nome.AsString := EditNomeCliente.Text;
  dm.FDQClienteAllcliente_celular.AsString := EditCelular.Text;
  dm.FDQClienteAllcliente_email.AsString := EditEmail.Text;
  StreamImg := TMemoryStream.Create;
  CircleFotoCliente.Fill.Bitmap.Bitmap.SaveToStream(StreamImg);
  dm.FDQClienteAllcliente_img.LoadFromStream(StreamImg);
  // dm.FDQClientecliente_img.Assign(CircleFotoCliente.Fill.Bitmap.Bitmap);
  dm.FDQClienteAll.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('Salvo com sucesso!');
  dm.FDQClienteAll.Close;
  dm.FDQClienteAll.Open();
  TabControl1.TabIndex := 0;
  EditCpfCliente.Text := EmptyStr;
  EditNomeCliente.Text := EmptyStr;
  EditCelular.Text := EmptyStr;
  EditEmail.Text := EmptyStr;
  TabItem2.Enabled := False;
end;

procedure TFCadCliente.CircleAddProdutosClick(Sender: TObject);
begin
  inherited;
  TabItem2.Enabled := True;
  TabControl1.TabIndex := 1;
  dm.FDQClienteAll.Append;
end;

procedure TFCadCliente.FormActivate(Sender: TObject);
begin
  inherited;
{$IFDEF ANDROID}
  PermissaoCamera := JStringToString(TJManifest_permission.JavaClass.CAMERA);
  PermissaoReadStorage := JStringToString
    (TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  PermissaoWriteStorage := JStringToString
    (TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
{$ENDIF}
end;

procedure TFCadCliente.FormShow(Sender: TObject);
begin
  inherited;
  dm.FDQClienteAll.Active := True;
  dm.FDQClienteAll.Close;
  dm.FDQClienteAll.Open();

  if Assigned(FLancamento) then
  begin
    if FLancamento.cadastroClienteFidelidade <> EmptyStr then
    begin
      EditCpfCliente.Text := FLancamento.cadastroClienteFidelidade;
      TabItem2.Enabled := True;
      TabControl1.TabIndex := 1;
    end
    else
    begin
      TabControl1.TabIndex := 0;
      TabItem2.Enabled := False;
    end;
  end
  else
  begin
    TabControl1.TabIndex := 0;
    TabItem2.Enabled := False;
  end;
end;

procedure TFCadCliente.ListViewClienteDeleteItem(Sender: TObject;
AIndex: Integer);
var
  sql: string;
begin
  inherited;
  try
    sql := 'delete from cliente where cliente_id = ' +
      dm.FDQClienteAllcliente_id.AsString;
    dm.FDConnection1.ExecSQL(sql);
    dm.FDConnection1.CommitRetaining;
    ShowMessage('Excluido com sucesso!');
  Except
    ShowMessage('Imposs�vel excluir cliente com lan�amento!');
  end;
end;

procedure TFCadCliente.ListViewClienteItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  inherited;
  TabItem2.Enabled := True;
  TabControl1.TabIndex := 1;
  dm.FDQClienteAll.Edit;
  EditCpfCliente.Text := dm.FDQClienteAllcliente_cpf.AsString;
  EditNomeCliente.Text := dm.FDQClienteAllcliente_nome.AsString;
  EditCelular.Text := dm.FDQClienteAllcliente_celular.AsString;
  EditEmail.Text := dm.FDQClienteAllcliente_email.AsString;
end;

procedure TFCadCliente.Rectangle2Click(Sender: TObject);
begin
  inherited;
{$IFDEF ANDROID}
  PermissionsService.RequestPermissions([PermissaoReadStorage,
    PermissaoWriteStorage], LibraryPermissionRequestResult,
    DisplayMessageLibrary);
{$ENDIF}
{$IFDEF IOS}
  ActionPhotoLibrary.Execute;
{$ENDIF}
end;

end.
