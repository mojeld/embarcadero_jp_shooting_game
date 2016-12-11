//---------------------------------------------------------------------------

#include <fmx.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.fmx"
//#include <cmath>
TfmShooting_main *fmShooting_main;
//---------------------------------------------------------------------------
__fastcall TfmShooting_main::TfmShooting_main(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfmShooting_main::FloatAnimation_background1Finish(TObject *Sender)

{
	//http://docwiki.embarcadero.com/Libraries/Berlin/ja/System.Math.RoundTo
	int x_{(int)System::Math::RoundTo(Rectangle_background1->Position->X, 0)};
	switch (x_){
	case 0:
		FloatAnimation_background1->StartValue = 0;
		FloatAnimation_background1->StopValue  = -this->Width;
		break;
	default:
		FloatAnimation_background1->StartValue = this->Width;
		FloatAnimation_background1->StopValue  = 0;
		;
	}
	FloatAnimation_background1->Start();
}
//---------------------------------------------------------------------------
void __fastcall TfmShooting_main::FloatAnimation_background2Finish(TObject *Sender)

{
	int x_{(int)System::Math::RoundTo(Rectangle_background2->Position->X, 0)};
	switch (x_){
	case 0:
		FloatAnimation_background2->StartValue = 0;
		FloatAnimation_background2->StopValue  = -this->Width;
		break;
	default:
		FloatAnimation_background2->StartValue = this->Width;
		FloatAnimation_background2->StopValue  = 0;
		;
	}
	FloatAnimation_background2->Start();
}
//---------------------------------------------------------------------------


void __fastcall TfmShooting_main::Button_startClick(TObject *Sender)
{
  Rectangle_player->Visible      	= true;
  Rectangle_startscene->Visible		= false;
  FloatAnimation_player_x->Start();
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::Button_downClick(TObject *Sender)
{
	FloatAnimation_player_y->StartValue	= Rectangle_player->Position->Y;
	if ((Rectangle_player->Position->Y +50) < (this->Height- Rectangle_player->Height -50)){
		FloatAnimation_player_y->StopValue = Rectangle_player->Position->Y + 50;
	}
	else{
		FloatAnimation_player_y->StopValue = this->Height- Rectangle_player->Height -50;
	}
  FloatAnimation_player_y->Start();

}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::Button_upClick(TObject *Sender)
{
	FloatAnimation_player_y->StartValue = Rectangle_player->Position->Y;
	if ( Rectangle_player->Position->Y - 50 > 0){
		FloatAnimation_player_y->StopValue = Rectangle_player->Position->Y - 50;
	}
	else
	{
		FloatAnimation_player_y->StopValue = 0;
	}
	FloatAnimation_player_y->Start();
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::Button_missileClick(TObject *Sender)
{
	TRectangle* em_buf_{nullptr};       		//敵一旦保存
	KanokeBuf  = nullptr;               		//敵保存変数をクリア
	Button_missile->Enabled				= false;
	Rectangle_missile->Position->Y     	= Rectangle_player->Position->Y + 25;
	FloatAnimation_missile->StopValue   = missile_max;  //ミサイル最終地点設定
	FloatAnimation_missile->StartValue	= Rectangle_player->Position->X + 20;
	FloatAnimation_missile->StopValue	= missile_max;	//ミサイルの目標値をセット
	Rectangle_missile->Visible 			= true;     //ミサイルを表示
	FloatAnimation_missile->Start();                //ミサイル発射
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::FloatAnimation_player_xFinish(TObject *Sender)
{
	Button_missile->Visible			= true;
	Button_up->Visible				= true;
	Button_down->Visible			= true;
	Timer_Enms->Enabled     		= true;
	Timer_Enms_laserbeam->Enabled 	= true;
	//FdtPlay                 = Now();
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::FloatAnimation_missileFinish(TObject *Sender)
{
	Button_missile->Enabled   	= true;
	Rectangle_missile->Visible 	= false;
	if (KanokeBuf != nullptr) {
		//FiTotal++;
		KanokeBuf->Visible     = false;
	}
    KanokeBuf = nullptr;
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::FloatAnimation_Enm1Finish(TObject *Sender)
{
	Rectangle_Enm1->Visible = false;	//画面からフレームアウト後 敵1を非表示
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::FloatAnimation_Enm2Finish(TObject *Sender)
{
	Rectangle_Enm2->Visible = false;    //画面からフレームアウト後 敵2を非表示
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::FloatAnimation_Enm3Finish(TObject *Sender)
{
	Rectangle_Enm3->Visible = false;    //画面からフレームアウト後 敵3を非表示
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::FloatAnimation_player_yFinish(TObject *Sender)
{
    Button_missile->Enabled = true;
}
//---------------------------------------------------------------------------


void __fastcall TfmShooting_main::FormCreate(TObject *Sender)
{
	Rectangle_Enm1->Visible = false;
	Rectangle_Enm2->Visible = false;
	Rectangle_Enm3->Visible = false;
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::enm_start(TRectangle* enm, TFloatAnimation* ani, TBitmapAnimation* bani)
{
	std::uniform_int_distribution<int> enm_position( 0, this->Height-100 ) ;
	unsigned int iEnm_y = enm_position(randomize_); //
	if (! enm->Visible) {
		enm->Position->Y    = iEnm_y;
		enm->Visible        = true;
		ani->StartValue     = this->Width + 10;
		ani->StopValue      = -enm->Width - 10;
		ani->Start();
		bani->Start();
	}
}

void __fastcall TfmShooting_main::Timer_EnmsTimer(TObject *Sender)
{
	std::uniform_int_distribution<int> enm_num( 0, 4 ) ;
	unsigned int iEnm = enm_num(randomize_);
	switch(iEnm){
	case 1: enm_start(Rectangle_Enm1, FloatAnimation_Enm1, BitmapAnimation_Enm1);
        break;
	case 2: enm_start(Rectangle_Enm2, FloatAnimation_Enm2, BitmapAnimation_Enm2);
		break;
	case 3: enm_start(Rectangle_Enm3, FloatAnimation_Enm3, BitmapAnimation_Enm3);
	}
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::EnmlaserbeamStat(TRectangle* enm)
{
	if (!(Rectangle_Enm_laserbeam->Visible) && enm->Visible) {
		Rectangle_Enm_laserbeam->Position->Y  		= enm->Position->Y + 25;
		Rectangle_Enm_laserbeam->Visible      		= true;
		FloatAnimation_Enm_laserbeam->StartValue	= enm->Position->X -20;
		FloatAnimation_Enm_laserbeam->StopValue		= FloatAnimation_Enm_laserbeam->StartValue - (this->Width + 50);
		FloatAnimation_Enm_laserbeam->Start();
	}
}

void __fastcall TfmShooting_main::Timer_Enms_laserbeamTimer(TObject *Sender)
{
	std::uniform_int_distribution<int> enm_num( 0, 3 ) ;
	unsigned int iEnm = enm_num(randomize_);
	switch(iEnm){
	case 1:EnmlaserbeamStat(Rectangle_Enm1);
		break;
	case 2:EnmlaserbeamStat(Rectangle_Enm2);
		break;
	case 3:EnmlaserbeamStat(Rectangle_Enm3);
	}
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::FloatAnimation_Enm_laserbeamFinish(TObject *Sender)

{
	Rectangle_Enm_laserbeam->Visible	= false;
}


