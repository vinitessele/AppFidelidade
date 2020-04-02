unit UModelo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TFModelo = class(TForm)
    ToolBar1: TToolBar;
    bntMenu: TSpeedButton;
    LabelMenu: TLabel;
    btnInf: TSpeedButton;
    Rectangle1: TRectangle;
    Image1: TImage;
    Layout1: TLayout;
    LabelMenuModelo: TLabel;
    VertScrollBox1: TVertScrollBox;
    procedure bntMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FModelo: TFModelo;

implementation

{$R *.fmx}

procedure TFModelo.bntMenuClick(Sender: TObject);
begin
close;
end;

end.
