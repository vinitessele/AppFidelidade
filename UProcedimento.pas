unit UProcedimento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, data.db,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  MultiDetailAppearanceU, FMX.Edit, FMX.ListView, FMX.TabControl, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, data.Bind.EngExt,
  FMX.Bind.DBEngExt, data.Bind.Components, data.Bind.DBScope;

type
  TFProcedimentos = class(TFModelo)
    TabControl1: TTabControl;
    Lista: TTabItem;
    ListViewListaProcedimentos: TListView;
    CircleAddProcedimentos: TCircle;
    Cadastro: TTabItem;
    VertScrollBox2: TVertScrollBox;
    Layout13: TLayout;
    Layout15: TLayout;
    RoundRect5: TRoundRect;
    BtnConfirmarProcedimento: TButton;
    Layout16: TLayout;
    EditDescricao: TEdit;
    Layout18: TLayout;
    Editvalor: TEdit;
    Layout19: TLayout;
    ChckProcedimento: TCheckBox;
    Layout20: TLayout;
    EditPontos: TEdit;
    StyleBook1: TStyleBook;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure CircleAddProcedimentosClick(Sender: TObject);
    procedure BtnConfirmarProcedimentoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListViewListaProcedimentosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListViewListaProcedimentosDeleteItem(Sender: TObject;
      AIndex: Integer);
    procedure ChckProcedimentoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FProcedimentos: TFProcedimentos;

implementation

{$R *.fmx}

uses UDM;

procedure TFProcedimentos.BtnConfirmarProcedimentoClick(Sender: TObject);
begin
  inherited;
  dm.FDQProcedimentosprocedimento_descricao.AsString := EditDescricao.Text;
  dm.FDQProcedimentosprocedimento_valor.AsString := Editvalor.Text;
  dm.FDQProcedimentosprocedimento_pontos.AsString := EditPontos.Text;
  if ChckProcedimento.IsChecked then
  begin
    dm.FDQProcedimentosprocedimentos_status.AsString := 'I';
  end
  else
  begin
    dm.FDQProcedimentosprocedimentos_status.AsString := 'A';
  end;
  dm.FDQProcedimentos.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('Salvo com sucesso!');
  EditDescricao.Text := EmptyStr;
  Editvalor.Text := EmptyStr;
  EditPontos.Text := EmptyStr;
  Cadastro.Enabled := false;
  TabControl1.TabIndex := 0;
end;

procedure TFProcedimentos.ChckProcedimentoClick(Sender: TObject);
begin
  inherited;
  if ChckProcedimento.IsChecked then
  begin
    ChckProcedimento.Text := 'Inativo';
  end
  else
  begin
    ChckProcedimento.Text := 'Ativo';
  end;
end;

procedure TFProcedimentos.CircleAddProcedimentosClick(Sender: TObject);
begin
  inherited;
  Cadastro.Enabled := True;
  TabControl1.TabIndex := 1;
  dm.FDQProcedimentos.Append;
end;

procedure TFProcedimentos.FormCreate(Sender: TObject);
begin
  inherited;
  TabControl1.TabIndex := 0;
  dm.FDQProcedimentos.Active := True;
end;

procedure TFProcedimentos.ListViewListaProcedimentosDeleteItem(Sender: TObject;
  AIndex: Integer);
var
  sql: string;
begin
  inherited;
  try
    sql := 'delete from procedimento where procedimento_id = ' +
      dm.FDQProcedimentosprocedimento_id.AsString;
    dm.FDConnection1.ExecSQL(sql);
    dm.FDConnection1.CommitRetaining;
    ShowMessage('Excluido com sucesso!');
  Except
    ShowMessage('Impossível excluir procedimento com lançamento!');
  end;
end;

procedure TFProcedimentos.ListViewListaProcedimentosItemClick
  (const Sender: TObject; const AItem: TListViewItem);
begin
  inherited;
  dm.FDQProcedimentos.Edit;
  EditDescricao.Text := dm.FDQProcedimentosprocedimento_descricao.AsString;
  Editvalor.Text := dm.FDQProcedimentosprocedimento_valor.AsString;
  EditPontos.Text := dm.FDQProcedimentosprocedimento_pontos.AsString;
  if dm.FDQProcedimentosprocedimentos_status.AsString = 'I' then
  begin
    ChckProcedimento.IsChecked := True;
    ChckProcedimento.Text := 'Inativo';
  end
  else
  begin
    ChckProcedimento.IsChecked := false;
    ChckProcedimento.Text := 'Ativo';
  end;
  Cadastro.Enabled := True;
  TabControl1.TabIndex := 1;
end;

end.
