#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");
string sDB;
string sVarName;

int iLineStart;

sDB=GetDBName();
iLineStart=StringToInt(sTalk);
sVarName = "Quest" + IntToString(GetLocalInt(GetModule(),"QDB_Quest"))
            + "Step" + IntToString(GetStepNumber())
            + "Line" + IntToString(iLineStart);

if (GetCampaignString(sDB,sVarName) == "" && iLineStart>0)
    DelayCommand(0.1,SendMessageToPC(GetPCSpeaker(),"No line number " + IntToString(iLineStart) + " exists."));
else
    SetResponseInt("LineStart",iLineStart);

SetupResponse(GetResponseNumber());
}
