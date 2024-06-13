#include "qdb_include"

void main()
{

string sQuest;

SetStepString("Item","en5_letter");

sQuest=GetStepInfo();

SetCustomToken(100,sQuest);
}
