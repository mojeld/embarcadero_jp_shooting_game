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
	//long double
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
	Button_missile->Enabled				= false;
	FloatAnimation_missile->StartValue 	= Rectangle_player->Position->X + 20;
	Rectangle_missile->Position->Y     	= Rectangle_player->Position->Y + 25;
	Rectangle_missile->Visible 			= true;
	FloatAnimation_missile->Start();
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::FloatAnimation_player_xFinish(TObject *Sender)
{
	Button_missile->Visible	= true;
	Button_up->Visible		= true;
	Button_down->Visible	= true;
}
//---------------------------------------------------------------------------

void __fastcall TfmShooting_main::FloatAnimation_missileFinish(TObject *Sender)
{
	Button_missile->Enabled   	= true;
	Rectangle_missile->Visible 	= false;
}
//---------------------------------------------------------------------------

