unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfmShooting_main = class(TForm)
    Button_missile: TButton;
    Rectangle_missile: TRectangle;
    FloatAnimation_missile: TFloatAnimation;
    Rectangle_player: TRectangle;
    Rectangle_background1: TRectangle;
    Rectangle_background2: TRectangle;
    FloatAnimation_background1: TFloatAnimation;
    FloatAnimation_background2: TFloatAnimation;
    FloatAnimation_player_y: TFloatAnimation;
    Button_up: TButton;
    Button_down: TButton;
    Rectangle_startscene: TRectangle;
    Label_geme_title: TLabel;
    Button_start: TButton;
    Rectangle1: TRectangle;
    ColorAnimation1: TColorAnimation;
    FloatAnimation_player_x: TFloatAnimation;
    Label_geme_title_shadow: TLabel;
    procedure Button_missileClick(Sender: TObject);
    procedure FloatAnimation_background2Finish(Sender: TObject);
    procedure FloatAnimation_background1Finish(Sender: TObject);
    procedure FloatAnimation_missileFinish(Sender: TObject);
    procedure Button_upClick(Sender: TObject);
    procedure Button_downClick(Sender: TObject);
    procedure Button_startClick(Sender: TObject);
    procedure FloatAnimation_player_xFinish(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
  end;

var
  fmShooting_main: TfmShooting_main;

implementation

{$R *.fmx}

procedure TfmShooting_main.Button_missileClick(Sender: TObject);
begin
  //http://mfstg.web.fc2.com/material/index.html
  Button_missile.Enabled            := False;
  FloatAnimation_missile.StartValue := Rectangle_player.Position.X + 20;
  Rectangle_missile.Position.Y      := Rectangle_player.Position.Y + 25;
  Rectangle_missile.Visible := True;
  FloatAnimation_missile.Start;
end;

procedure TfmShooting_main.Button_startClick(Sender: TObject);
begin
  Rectangle_player.Visible      := True;
  Rectangle_startscene.Visible  := False;
  FloatAnimation_player_x.Start;
end;

procedure TfmShooting_main.Button_downClick(Sender: TObject);
begin
  FloatAnimation_player_y.StartValue  := Rectangle_player.Position.Y;
  if Rectangle_player.Position.Y +50 < (Self.Height- Rectangle_player.Height -50) then
  begin
    FloatAnimation_player_y.StopValue   := Rectangle_player.Position.Y + 50;
  end
  else
  begin
    FloatAnimation_player_y.StopValue   := Self.Height- Rectangle_player.Height -50;
  end;

  FloatAnimation_player_y.Start;
end;

procedure TfmShooting_main.Button_upClick(Sender: TObject);
begin
  FloatAnimation_player_y.StartValue  := Rectangle_player.Position.Y;
  if Rectangle_player.Position.Y - 50 > 0 then
  begin
    FloatAnimation_player_y.StopValue   := Rectangle_player.Position.Y - 50;
  end
  else
  begin
    FloatAnimation_player_y.StopValue   := 0;
  end;

  FloatAnimation_player_y.Start;
end;

procedure TfmShooting_main.FloatAnimation_background1Finish(Sender: TObject);
begin
  case Round(Rectangle_background1.Position.X) of
    0: begin
      FloatAnimation_background1.StartValue := 0;
      FloatAnimation_background1.StopValue  := -Self.Width;
    end;
    else
    begin
      FloatAnimation_background1.StartValue := Self.Width;
      FloatAnimation_background1.StopValue  := 0;
    end;
  end;
  FloatAnimation_background1.Start;
end;

procedure TfmShooting_main.FloatAnimation_background2Finish(Sender: TObject);
begin
  case Round(Rectangle_background2.Position.X) of
    0: begin
      FloatAnimation_background2.StartValue := 0;
      FloatAnimation_background2.StopValue  := -Self.Width;
    end;
    else
    begin
      FloatAnimation_background2.StartValue := Self.Width;
      FloatAnimation_background2.StopValue  := 0;
    end;
  end;
  FloatAnimation_background2.Start;
end;

procedure TfmShooting_main.FloatAnimation_missileFinish(Sender: TObject);
begin
  Button_missile.Enabled    := True;
  Rectangle_missile.Visible := False;
end;

procedure TfmShooting_main.FloatAnimation_player_xFinish(Sender: TObject);
begin
  Button_missile.Visible  := True;
  Button_up.Visible       := True;
  Button_down.Visible     := True;
end;

end.
