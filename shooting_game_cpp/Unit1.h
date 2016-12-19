//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Ani.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.Objects.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Types.hpp>
#include <random>

//---------------------------------------------------------------------------
class TfmShooting_main : public TForm
{
__published:	// IDE で管理されるコンポーネント
	TButton *Button_down;
	TButton *Button_missile;
	TButton *Button_up;
	TRectangle *Rectangle_background1;
	TFloatAnimation *FloatAnimation_background1;
	TRectangle *Rectangle_background2;
	TFloatAnimation *FloatAnimation_background2;
	TRectangle *Rectangle_missile;
	TFloatAnimation *FloatAnimation_missile;
	TRectangle *Rectangle_player;
	TFloatAnimation *FloatAnimation_player_y;
	TFloatAnimation *FloatAnimation_player_x;
	TRectangle *Rectangle_startscene;
	TLabel *Label_geme_title_shadow;
	TLabel *Label_geme_title;
	TButton *Button_start;
	TColorAnimation *ColorAnimation1;
	TRectangle *Rectangle1;
	TRectangle *Rectangle_Enm_laserbeam;
	TFloatAnimation *FloatAnimation_Enm_laserbeam;
	TRectangle *Rectangle_Enm1;
	TBitmapAnimation *BitmapAnimation_Enm1;
	TFloatAnimation *FloatAnimation_Enm1;
	TRectangle *Rectangle_Enm2;
	TBitmapAnimation *BitmapAnimation_Enm2;
	TFloatAnimation *FloatAnimation_Enm2;
	TRectangle *Rectangle_Enm3;
	TBitmapAnimation *BitmapAnimation_Enm3;
	TFloatAnimation *FloatAnimation_Enm3;
	TTimer *Timer_Enms;
	TTimer *Timer_Enms_laserbeam;
	TLabel *Label_score;
	TTimer *Timer_gameover;
	void __fastcall FloatAnimation_background1Finish(TObject *Sender);
	void __fastcall FloatAnimation_background2Finish(TObject *Sender);
	void __fastcall Button_startClick(TObject *Sender);
	void __fastcall Button_downClick(TObject *Sender);
	void __fastcall Button_upClick(TObject *Sender);
	void __fastcall Button_missileClick(TObject *Sender);
	void __fastcall FloatAnimation_player_xFinish(TObject *Sender);
	void __fastcall FloatAnimation_missileFinish(TObject *Sender);
	void __fastcall FloatAnimation_Enm1Finish(TObject *Sender);
	void __fastcall FloatAnimation_Enm2Finish(TObject *Sender);
	void __fastcall FloatAnimation_Enm3Finish(TObject *Sender);
	void __fastcall FloatAnimation_player_yFinish(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall Timer_EnmsTimer(TObject *Sender);
	void __fastcall Timer_Enms_laserbeamTimer(TObject *Sender);
	void __fastcall FloatAnimation_Enm_laserbeamFinish(TObject *Sender);
	void __fastcall FormKeyDown(TObject *Sender, WORD &Key, System::WideChar &KeyChar,
		  TShiftState Shift);
	void __fastcall Timer_gameoverTimer(TObject *Sender);
private:	// ユーザー宣言
	const unsigned int missile_max{900};
	unsigned int 	FiTotal{0};
	TDateTime       FdtPlay{0};
	std::random_device rnd_;
	std::mt19937 	randomize_{rnd_()};
	void __fastcall enm_start(TRectangle* enm, TFloatAnimation* ani, TBitmapAnimation* bani);
	void __fastcall EnmlaserbeamStat(TRectangle* enm);
	float __fastcall EnmExist(TRectangle* enm);
	void __fastcall game_reset();
	bool __fastcall hantei(TRectF& r1,TRectF& r2);
    bool __fastcall Rect_hantei(TRectangle* rect1, TRectangle* rect2);
public:		// ユーザー宣言
	__fastcall TfmShooting_main(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmShooting_main *fmShooting_main;
//---------------------------------------------------------------------------
TRectangle* 	KanokeBuf{nullptr};
#endif
