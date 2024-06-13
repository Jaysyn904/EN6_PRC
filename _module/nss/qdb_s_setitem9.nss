#include "qdb_include"

void main()
{

string sQuest;

SetStepString("Item","en3_package");

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
