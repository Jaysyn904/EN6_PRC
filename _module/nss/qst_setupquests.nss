#include "qst_include"
#include "qdb_include"

void main()
{
string sZone;
int iQuest;

sZone=GetLocalString(OBJECT_SELF,"Zone");
iQuest=GetLocalInt(GetModule(),"QDB_Quest");

if (CheckQuest(sZone))
    {
    SetupQuest(sZone);
    SetLocalInt(GetModule(),"RAN_QUEST_" + IntToString(iQuest),1);
    SetLocalInt(GetModule(),sZone + "_QUEST_" + IntToString(iQuest),1);
    } else {
    SetLocalInt(GetModule(),"QDB_Quest",1);
    GrabQuest(sZone);
    SetupQuest(sZone);
    }
}
