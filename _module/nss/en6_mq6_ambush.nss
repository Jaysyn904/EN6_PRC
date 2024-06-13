#include "qst_include"

void main()
{
object oPC;
int iMQNumber;
string sZone;
int iBoss;

if (GetLocalInt(OBJECT_SELF,"DoOnce")>0)
    return;

oPC=GetEnteringObject();
iMQNumber=GetLocalInt(GetModule(),"MQNumber");

if (GetIsPC(oPC) && iMQNumber == 6 && GetLocalInt(oPC,"MQ6ItemMade")>0 && !GetIsDead(GetObjectByTag(GetOverallBossTag())))
    {
    SetLocalInt(OBJECT_SELF,"DoOnce",1);
    sZone=GetLocalString(GetArea(oPC),"Zone");

    SetLocalString(GetModule(),"SPAWN_Zone",sZone);
    SetLocalString(GetModule(),"SPAWN_CampType","A");
    SetLocalInt(GetModule(),"SPAWN_Camp",1);
    SetLocalInt(GetModule(),"SPAWN_Boss",0);
    iBoss=GetLocalInt(GetModule(),"OverallQuestBoss");
    if (iBoss > 2 && iBoss != 4)
        {
        GetQuestCamp(1,GetMinLevel(sZone)+ Random(2) + 1);
        SetLocalInt(GetModule(),"SPAWN_Camp",2);
        GetQuestCamp(12,GetMinLevel(sZone)+ Random(2) + 1);
        }
    else if (iBoss==4)
        {
        if (Random(2)==0)
            GetQuestCamp(8,GetMinLevel(sZone)+ Random(2) + 1);
        else
            GetQuestCamp(16,GetMinLevel(sZone)+ Random(2) + 1);
        SetLocalInt(GetModule(),"SPAWN_Camp",2);
        GetQuestCamp(12,GetMinLevel(sZone)+ Random(2) + 1);
        }
    else
        {
        GetQuestCamp(12,GetMinLevel(sZone)+ Random(2) + 1);
        SetLocalInt(GetModule(),"SPAWN_Camp",2);
        GetQuestCamp(12,GetMinLevel(sZone)+ Random(2) + 1);
        }

    }
SetLocalString(GetModule(),"SPAWN_CampType","C");
}
