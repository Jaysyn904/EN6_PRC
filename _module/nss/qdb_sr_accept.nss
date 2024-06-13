#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");
string sDB;
string sVarName;

int iAccept;

sDB=GetDBName();
iAccept=StringToInt(sTalk);
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "Step" + IntToString(GetStepNumber())
            + "Line" + IntToString(iAccept);

if (GetCampaignString(sDB,sVarName) == "" && iAccept>0)
    DelayCommand(0.1,SendMessageToPC(GetPCSpeaker(),"No line number " + IntToString(iAccept) + " exists."));
else
    SetResponseInt("Accept",iAccept);

SetupResponse(GetResponseNumber());
}
