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
    Timer_gameover: TTimer;
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
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Timer_gameoverTimer(Sender: TObject);
  private
    FiTotal:    Integer;
    FdtPlay:    TDateTime;
    procedure game_reset;
  public
  end;

//http://mfstg.web.fc2.com/material/index.html
var
  fmShooting_main:  TfmShooting_main;
  KanokeBuff:       TRectangle=nil;     //敵撃破変数

implementation

{$R *.fmx}

const missile_max = 900;

procedure TfmShooting_main.Button_missileClick(Sender: TObject);  //第9回
var
  iExPos:   Single;     //プレーヤーミサイル最終Position.X
  iTemp:    Single;     //一旦保存用
  iEnmX:    Single;     //敵Position.X一旦保存用
  i:        Integer;    //ループ用
  em_buf_:  TRectangle; //敵一旦保存
  function EnmExist(enm: TRectangle): Single;
  begin         {敵が目的の座標に居た場合敵のPosition.Xを返す}
    Result  := missile_max;
    if enm.Visible and (enm.Position.X > (Rectangle_player.Position.X + Rectangle_player.Width)) then
      if ((enm.Position.Y-10) <= Rectangle_missile.Position.Y) and
        ((enm.Position.Y + (enm.Height*enm.Scale.X))+10 >= Rectangle_missile.Position.Y) then
      begin
        Result      := enm.Position.X;
      end;
  end;
begin
  Button_missile.Enabled            := False;       //ミサイルボタンを無効
  KanokeBuff                        := nil;         //敵保存変数をクリア
  FloatAnimation_missile.StopValue  := missile_max; //ミサイル最終地点設定
  Rectangle_missile.Position.Y      := Rectangle_player.Position.Y + 25;
  FloatAnimation_missile.StartValue := Rectangle_player.Position.X + 20;
  iExPos  := missile_max;
  iEnmX   := missile_max;
  for i := 0 to 2 do  {ループで敵3つを順番に撃破可能か調べる}
  begin
    case i of
    0:em_buf_ := Rectangle_Enm1;
    1:em_buf_ := Rectangle_Enm2;
    2:em_buf_ := Rectangle_Enm3;
    end;
    iTemp   := EnmExist(em_buf_);
    if (iTemp < missile_max) and (iEnmX > em_buf_.Position.X)  then
    begin   {敵の前に敵が居る場合, 手前の敵を優先}
      iExPos      := iTemp;
      KanokeBuff  := em_buf_;
    end;
    if Assigned(KanokeBuff) then  {撃破出来る敵変数に存在するか確認}
      iEnmX := KanokeBuff.Position.X;
  end;

  if iExPos < (Rectangle_player.Position.X + Rectangle_player.Width) then
    iExPos := missile_max;  {敵がプレーヤーより後ろにいる場合標的から外す}

  FloatAnimation_missile.StopValue  := iExPos;  {ミサイルの目標値をセット}

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

procedure TfmShooting_main.FloatAnimation_missileFinish(Sender: TObject); //第9回
begin
  Button_missile.Enabled    := True;  //ミサイルボタンを有効にする
  Rectangle_missile.Visible := False; //ミサイルを非表示
  if Assigned(KanokeBuff) then        //敵撃破変数に敵存在するか確認
  begin
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
//  FdtPlay                       := Now;
  Timer_gameover.Enabled  := True;
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
  game_reset;
end;

procedure TfmShooting_main.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState); //第9回
begin
{$IFDEF WIN32}
  if Button_missile.Visible then
    case KeyChar of
    ' ':Button_missileClick(nil);
    'q': begin
      Button_up.Visible       := False;
      Button_down.Visible     := False;
      Button_missile.Position.Y := - Button_missile.Height -5;
    end;
    #0: begin
      case Key of
      38:Button_upClick(nil);
      40:Button_downClick(nil);
      end;
    end;
    end;
{$ENDIF}
end;

procedure TfmShooting_main.game_reset;
begin //ゲームリセット
  Button_up.Visible                 := False; //ボタンUp非表示
  Button_down.Visible               := False; //ボタンDown非表示
  Button_missile.Visible            := False; //ボタンミサイル非表示

  Timer_Enms.Enabled                := False; //敵出現タイマーストップ
  Timer_Enms_laserbeam.Enabled      := False; //敵レーザービームタイマーストップ
  Timer_gameover.Enabled            := False; //プレーヤーと敵接触判定タイマーストップ
  Rectangle_Enm1.Visible            := False; //敵1非表示
  Rectangle_Enm2.Visible            := False; //敵2非表示
  Rectangle_Enm3.Visible            := False; //敵3非表示
  Rectangle_Enm_laserbeam.Visible   := False; //敵レーザービーム非表示
  Rectangle_startscene.Visible  := True;      //スタートシーン表示
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
  {
  Label_score.Text  := Format('Time %s / Total Score %0.9d', [
      FormatDateTime('hh:nn:ss', Now - FdtPlay), FiTotal
    ]);
  }
end;

procedure TfmShooting_main.Timer_gameoverTimer(Sender: TObject);
var
  i: Integer;
  atari_: Boolean;                                            //プレーヤー戦闘機と敵が接触した場合True
  function hantei(r1, r2: TRectF): Boolean;                   //四角どうしが重なっているか判定
  begin
    Result  := False;
    if (r1.Left < r2.Right) and
      (r1.Right > r2.Left)  and
      (r1.Top < r2.Bottom)  and
      (r1.Bottom > r2.Top) then
    begin
      Result  := True;
    end;
  end;
  function Rect_hantei(rect1, rect2: TRectangle): Boolean;    //TRectangleどうしが重なっているか判定
  begin
    if rect2.Visible then
    begin
      Result  := Hantei(
        TRectF.Create(rect1.Position.X, rect1.Position.Y,
        rect1.Position.X + rect1.Width, rect1.Position.Y + rect1.Height
        ),
        TRectF.Create(rect2.Position.X, rect2.Position.Y,
        rect2.Position.X + rect2.Width, rect2.Position.Y + rect2.Height
        ));
    end
    else
      Result  := False;
  end;
begin
  atari_  := False;
  Timer_gameover.Enabled  := False;
  for i := 0 to 3 do  //敵1～3とlaserbeamが戦闘機と接触したかを判定
    case i of
    0: begin
      atari_  := Rect_hantei(Rectangle_player, Rectangle_Enm1);
      if atari_ then Break; end;
    1: begin
      atari_  := Rect_hantei(Rectangle_player, Rectangle_Enm2);
      if atari_ then Break; end;
    2: begin
      atari_  := Rect_hantei(Rectangle_player, Rectangle_Enm3);
      if atari_ then Break; end;
    3: begin
      atari_  := Rect_hantei(Rectangle_player, Rectangle_Enm_laserbeam);
      if atari_ then Break; end;
    end;
  if atari_ then
  begin
    Rectangle_player.Visible  := False;
    ShowMessage('ゲームオーバー');
    game_reset; //ゲームをリセットする
  end
  else
    Timer_gameover.Enabled  := True;

end;

end.
