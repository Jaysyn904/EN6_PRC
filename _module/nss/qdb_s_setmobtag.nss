#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");

string sQuest;

SetStepString("MobTag",sTalk);

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
