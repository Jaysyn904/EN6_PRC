#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");

string sQuest;

SetStepInt("MobClass",StringToInt(sTalk));

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
