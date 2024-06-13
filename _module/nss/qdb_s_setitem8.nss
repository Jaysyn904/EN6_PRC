#include "qdb_include"

void main()
{

string sQuest;

SetStepString("Item","en5_tornscroll");

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
