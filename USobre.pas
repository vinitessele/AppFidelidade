unit USobre;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFSobre = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Rectangle1: TRectangle;
    btnFechar: TSpeedButton;
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSobre: TFSobre;

implementation

{$R *.fmx}

procedure TFSobre.btnFecharClick(Sender: TObject);
begin
  close;
end;

end.
