#include "qdb_include"

int StartingConditional()
{
int iResult;
string sQuest;

iResult = FALSE;
sQuest=GetQuestString("Name");
if (sQuest=="" || sQuest=="DELETE")
    iResult=TRUE;

iResult = FALSE;
return iResult;
}
