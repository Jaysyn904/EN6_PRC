#include "qdb_include"

void WriteToLog(string sMessage);
void WriteQuest(int iQuest);

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
        DelayCommand(0.1 * iIndex,WriteQuest(iIndex));
        iIndex++;
        }
    }
SetLocalInt(GetModule(),"QDB_Quest",0);
}

void WriteQuest(int iQuest)
{
string sQuest;
int iLine;
string sLine;
int iResponse;
int iStep;
string sResponse;
int iType;


SetLocalInt(GetModule(),"QDB_Quest",iQuest);
sQuest=GetQuestString("Name");
WriteToLog("Quest" + IntToString(iQuest) + ": " + sQuest);

iStep=1;
SetStepNumber(iStep);
iType=GetStepInt("Type");
while (iType>0 && iStep<10)
    {
    WriteToLog("STEP #" + IntToString(iStep));
    iLine=1;
    SetLineNumber(iLine);
    sLine=GetLine();
    while (sLine != "")
        {
        WriteToLog("LINE " + IntToString(iLine) + ": " +sLine);

        iResponse=1;
        while (iResponse<6)
            {
            SetResponseNumber(iResponse);
            sResponse=GetResponse();
            if (sResponse != "")
                WriteToLog("RESPONSE " + IntToString(iResponse) + ": " + sResponse);
            iResponse++;
            }

        iLine++;
        SetLineNumber(iLine);
        sLine=GetLine();
        }
    iStep++;
    SetStepNumber(iStep);
    iType=GetStepInt("Type");
    }
}

void WriteToLog(string sMessage)
{

WriteTimestampedLogEntry(sMessage);
SendMessageToPC(GetFirstPC(),sMessage);

}
