#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");
//SendMessageToPC(GetPCSpeaker(),"You said: " + sTalk);
//PrintString(sTalk);
string sQuest;

sQuest = "Name: " + sTalk + "\n";
sQuest = sQuest + "Lvls=1-40 | Freq=2 | DoOnce=1 \n";
sQuest = sQuest + "Gold=0 | ItemChance=0 | Item= \n";
sQuest = sQuest + "NPCType=1 | NPCSpawn=0 | OneLiner= \n";
SetCustomToken(100,sQuest);
}
