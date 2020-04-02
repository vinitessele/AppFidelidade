unit USelectProcedimento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UModelo, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFSelectProcedimentos = class(TFModelo)
    ListViewSelectProcedimentos: TListView;
    StyleBook1: TStyleBook;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure FormShow(Sender: TObject);
    procedure ListViewSelectProcedimentosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSelectProcedimentos: TFSelectProcedimentos;

implementation

{$R *.fmx}

uses UDM, ULancamento;

procedure TFSelectProcedimentos.FormShow(Sender: TObject);
begin
  inherited;
  dm.FDQProcedimentos.Active := True;
  dm.FDQProcedimentos.Close;
  dm.FDQProcedimentos.Open();
end;

procedure TFSelectProcedimentos.ListViewSelectProcedimentosItemClick
  (const Sender: TObject; const AItem: TListViewItem);
begin
  inherited;
  dm.FDQPontuacao.Active := True;
  dm.FDQPontuacao.Append;
  dm.FDQPontuacaopontuacao_id_cliente.AsString :=
    dm.FDQClientecliente_id.AsString;
  dm.FDQPontuacaopontuacao_pontos.AsString :=
    dm.FDQProcedimentosprocedimento_pontos.AsString;
  dm.FDQPontuacaopontuacao_data.AsDateTime := Date;
  dm.FDQPontuacao.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('Parab�ns voc� acaba de receber +' +
    dm.FDQProcedimentosprocedimento_pontos.AsString);
  Close;
end;

end.
