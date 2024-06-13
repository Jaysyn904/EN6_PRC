#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");

string sQuest;

SetNewQuestNumber();
SetQuestString("Name",sTalk);
SetQuestInt("MinLevel",1);
SetQuestInt("MaxLevel",40);
SetQuestInt("NPCType",1);
SetQuestInt("Frequency",2);
SetStepNumber(1);
SetLineNumber(1);
SetLine("Hello.");
SetLineNumber(100);
SetLine("May I help you?");
SetResponseNumber(1);
SetResponse("Not right now, thanks.");

sQuest=GetQuestInfo();

SetCustomToken(100,sQuest);
}
