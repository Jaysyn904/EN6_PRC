#include "qdb_include"

void main()
{
string sDB;
int iIndex;
int iFlag;
string sQuest;

sDB=GetDBName();

iIndex=1;
iFlag=TRUE;
while (iFlag && iIndex<5000)
    {
    SetLocalInt(GetModule(),"QDB_Quest",iIndex);
    sQuest=GetQuestString("Name");
    if (sQuest=="")
        iFlag=FALSE;
    else
        {
        SendMessageToPC(GetPCSpeaker(),IntToString(iIndex) + "=" + sQuest);
        iIndex++;
        }
    }
SetLocalInt(GetModule(),"QDB_Quest",0);
}
