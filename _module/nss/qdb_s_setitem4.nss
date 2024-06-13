#include "qdb_include"

void main()
{

string sQuest;

SetStepString("Item","en5_scroll");

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
