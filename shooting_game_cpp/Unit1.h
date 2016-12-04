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
	void __fastcall FloatAnimation_background1Finish(TObject *Sender);
	void __fastcall FloatAnimation_background2Finish(TObject *Sender);
	void __fastcall Button_startClick(TObject *Sender);
	void __fastcall Button_downClick(TObject *Sender);
	void __fastcall Button_upClick(TObject *Sender);
	void __fastcall Button_missileClick(TObject *Sender);
	void __fastcall FloatAnimation_player_xFinish(TObject *Sender);
	void __fastcall FloatAnimation_missileFinish(TObject *Sender);
private:	// ユーザー宣言
public:		// ユーザー宣言
	__fastcall TfmShooting_main(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmShooting_main *fmShooting_main;
//---------------------------------------------------------------------------
#endif
