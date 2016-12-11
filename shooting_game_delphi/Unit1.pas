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
    Rectangle_Enm1: TRectangle;
    BitmapAnimation_Enm1: TBitmapAnimation;
    Rectangle_Enm_laserbeam: TRectangle;
    Timer_Enms: TTimer;
    FloatAnimation_Enm1: TFloatAnimation;
    Rectangle_Enm2: TRectangle;
    BitmapAnimation_Enm2: TBitmapAnimation;
    FloatAnimation_Enm2: TFloatAnimation;
    Rectangle_Enm3: TRectangle;
    BitmapAnimation_Enm3: TBitmapAnimation;
    FloatAnimation_Enm3: TFloatAnimation;
    FloatAnimation_Enm_laserbeam: TFloatAnimation;
    Timer_Enms_laserbeam: TTimer;
    Label_score: TLabel;
    procedure Button_missileClick(Sender: TObject);
    procedure FloatAnimation_background2Finish(Sender: TObject);
    procedure FloatAnimation_background1Finish(Sender: TObject);
    procedure FloatAnimation_missileFinish(Sender: TObject);
    procedure Button_upClick(Sender: TObject);
    procedure Button_downClick(Sender: TObject);
    procedure Button_startClick(Sender: TObject);
    procedure FloatAnimation_player_xFinish(Sender: TObject);
    procedure Timer_EnmsTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FloatAnimation_Enm1Finish(Sender: TObject);
    procedure FloatAnimation_Enm2Finish(Sender: TObject);
    procedure FloatAnimation_Enm3Finish(Sender: TObject);
    procedure FloatAnimation_Enm_laserbeamFinish(Sender: TObject);
    procedure Timer_Enms_laserbeam_Timer(Sender: TObject);
    procedure FloatAnimation_player_yFinish(Sender: TObject);
  private
    FiTotal:    Integer;
    FdtPlay:    TDateTime;
  public
  end;

//http://mfstg.web.fc2.com/material/index.html
var
  fmShooting_main:  TfmShooting_main;
  KanokeBuff:       TRectangle=nil;     //敵撃破変数

implementation

{$R *.fmx}

const missile_max = 900;

procedure TfmShooting_main.Button_missileClick(Sender: TObject);
var
  iExPos:   Single;     //プレーヤーミサイル最終Position.X
  iTemp:    Single;     //一旦保存用
  iEnmX:    Single;     //敵Position.X一旦保存用
  i:        Integer;    //ループ用
  em_buf_:  TRectangle; //敵一旦保存
begin
  Button_missile.Enabled            := False;       //ミサイルボタンを無効
  KanokeBuff                        := nil;         //敵保存変数をクリア
  FloatAnimation_missile.StopValue  := missile_max; //ミサイル最終地点設定
  Rectangle_missile.Position.Y      := Rectangle_player.Position.Y + 25;
  FloatAnimation_missile.StartValue := Rectangle_player.Position.X + 20;

  Rectangle_missile.Visible := True;            {ミサイルを表示}
  FloatAnimation_missile.Start;                 {ミサイル発射}
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

procedure TfmShooting_main.FloatAnimation_Enm1Finish(Sender: TObject);
begin
  Rectangle_Enm1.Visible  := False; {画面からフレームアウト後 敵1を非表示}
end;

procedure TfmShooting_main.FloatAnimation_Enm2Finish(Sender: TObject);
begin
  Rectangle_Enm2.Visible  := False; {画面からフレームアウト後 敵2を非表示}
end;

procedure TfmShooting_main.FloatAnimation_Enm3Finish(Sender: TObject);
begin
  Rectangle_Enm3.Visible  := False; {画面からフレームアウト後 敵3を非表示}
end;

procedure TfmShooting_main.FloatAnimation_Enm_laserbeamFinish(Sender: TObject);
begin
  {画面からフレームアウト後 レーザービーム1を非表示}
  Rectangle_Enm_laserbeam.Visible := False;
end;

procedure TfmShooting_main.FloatAnimation_missileFinish(Sender: TObject);
begin
  Button_missile.Enabled    := True;  //ミサイルボタンを有効にする
  Rectangle_missile.Visible := False; //ミサイルを非表示
  if Assigned(KanokeBuff) then        //敵撃破変数に敵存在するか確認
  begin
//    Inc(FiTotal);
    KanokeBuff.Visible  := False;     //敵を非表示にする
  end;
  KanokeBuff          := nil;         //敵撃破変数を空にする
end;

procedure TfmShooting_main.FloatAnimation_player_xFinish(Sender: TObject);
begin
  Button_missile.Visible  := True;
  Button_up.Visible       := True;
  Button_down.Visible     := True;
  Timer_Enms.Enabled            := True;
  Timer_Enms_laserbeam.Enabled  := True;
  FdtPlay                       := Now;
end;

procedure TfmShooting_main.FloatAnimation_player_yFinish(Sender: TObject);
begin
  Button_missile.Enabled  := True;
end;

procedure TfmShooting_main.FormCreate(Sender: TObject);
begin
  Randomize;      //乱数初期化
//  FiTotal := 0;
//  FdtPlay := 0;
  Rectangle_Enm1.Visible  := False;
  Rectangle_Enm2.Visible  := False;
  Rectangle_Enm3.Visible  := False;
end;

procedure TfmShooting_main.Timer_EnmsTimer(Sender: TObject);
var
  iEnm:   Integer;  //乱数0～4敵番号を決定する変数
  iEnm_y: Integer;  //乱数敵Position.Yを決定する変数
  procedure enm_start(enm: TRectangle; ani: TFloatAnimation; bani: TBitmapAnimation);
  begin
    if not enm.Visible then             {敵が待機している場合}
    begin
      enm.Position.Y  := iEnm_y;        {敵のY座標を決定}
      enm.Visible     := True;          {敵を表示}
      ani.StartValue  := Width + 10;
      ani.StopValue   := -enm.Width -10;
      ani.Start;                        {Position.Xを左に移動開始}
      bani.Start;                       {敵ビットマップアニメ開始}
    end;
  end;
begin
  iEnm    := Random(5);                 {0～4決定}
  iEnm_y  := Random(Self.Height - 100); {Positon.Y決定}
  case iEnm of
    1:enm_start(Rectangle_Enm1, FloatAnimation_Enm1, BitmapAnimation_Enm1);
    2:enm_start(Rectangle_Enm2, FloatAnimation_Enm2, BitmapAnimation_Enm2);
    3:enm_start(Rectangle_Enm3, FloatAnimation_Enm3, BitmapAnimation_Enm3);
  end;
end;

procedure TfmShooting_main.Timer_Enms_laserbeam_Timer(Sender: TObject);
var
  iEnm: Integer;  //乱数0～4敵番号を決定する変数
  procedure MissileStat(enm: TRectangle);
  begin
    if (not Rectangle_Enm_laserbeam.Visible) and enm.Visible then
    begin
      Rectangle_Enm_laserbeam.Position.Y      := enm.Position.Y + 25;
      Rectangle_Enm_laserbeam.Visible         := True;
      FloatAnimation_Enm_laserbeam.StartValue := enm.Position.X - 20;
      FloatAnimation_Enm_laserbeam.StopValue  := FloatAnimation_Enm_laserbeam.StartValue - (Self.Width + 50);
      FloatAnimation_Enm_laserbeam.Start;
    end;
  end;
begin
  iEnm  := Random(5); //乱数0～4決定
  case iEnm of
  1:MissileStat(Rectangle_Enm1);
  2:MissileStat(Rectangle_Enm2);
  3:MissileStat(Rectangle_Enm3);
  end;
end;

end.
