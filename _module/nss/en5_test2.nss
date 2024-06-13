#include "en5_misc"
#include "en5_encounters"

void spawn(int iLevel)
{
GetPlanar(iLevel);
}

void main()
{
SetLocalString(GetModule(),"SPAWN_Zone",GetMyZone(OBJECT_SELF));
SetLocalString(GetModule(),"SPAWN_CampType","Q");
SetLocalInt(GetModule(),"SPAWN_Camp",3);
SetLocalInt(GetModule(),"SPAWN_Boss",2);

//GetClassTest(25);
GetPlanar(15);

DelayCommand(10.0,spawn(12));

DelayCommand(20.0,spawn(16));
/*
DelayCommand(30.0,spawn(11));

DelayCommand(40.0,spawn(13));
*/
}


