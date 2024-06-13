#include "qdb_include"

void main()
{

string sQuest;

SetStepString("Item","en5_book2");

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
