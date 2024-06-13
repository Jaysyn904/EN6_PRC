#include "en5_rankings"
//#include "en3_prcclsconst"
#include "en5_misc"

int GetRank(int iScore);
void GetKiller();

void main()
{
int iLevel;
int iXP;
int iGold;
int iQuest;
int iScore;
int iIndex;
int iFame;
string sClass;
string sRace;
string sMsg;
string sName;
string sKiller;
int iRank;
int iAccomplishments;
string sAccomplishments;
string sRank;
string sNameX;
string sClassX;
string sRaceX;
string sLevelX;
string sScoreX;
string sRankX;
string sRankY;
string sKillerX;
string sKillerY;
string sCampaign;
string sMAccomp;
string sMAccompX;
string sMAccompY;
string sFameX;

object oPC;

oPC = GetEnteringObject();

if (GetIsPC(oPC))
    {
    if (GetXP(oPC) <1)
        {
        SendMessageToPC(oPC,"You are in purgatory.");
        return;
        }

    sCampaign = "Endless Nights VI";
    if (GetCampaignInt(sCampaign,"MP") == 1)
        sCampaign = "MP_Endless Nights VI";

    iLevel = GetHitDice(oPC);
    iXP = GetXP(oPC);
    iGold = GetGold(oPC);
    iFame = GetLocalInt(oPC,"Fame");
    iScore = iXP;
    iScore = iScore + (iFame * 100) + iGold/100;
    sClass = GetClass(oPC);
    //string sClassName = GetStringByStrRef(StringToInt(Get2DAString("classes", "Name", nClass)));
    sRace = GetRace(oPC);
    if (sRace == "")
        sRace = GetStringByStrRef(StringToInt(Get2DAString("racialtypes", "Name", GetRacialType(oPC))));
    sName = GetName(oPC);
    iRank = GetRank(iScore);
    sRank = IntToString(iRank);
    sKiller = GetLocalString(oPC,"Killer");
    if (sKiller == "")
        sKiller = "Unknown";
    //SendMessageToPC(oPC,"Score = " + IntToString(iScore));

    sAccomplishments=GetAllAccomplishments(oPC);

    sMAccomp=GetMajorAccomplishment(oPC);
    if (sMAccomp=="")
        {
        sMAccomp=GetLocalString(oPC,"Accomplishment" + IntToString(GetLocalInt(oPC,"Accomplishments")));
        if (sMAccomp=="")
            sMAccomp="done nothing special";
        }

    if (iRank>0)
        {
        iIndex = 19;
        while (iIndex>=iRank)
            {
            sRankX = IntToString(iIndex);
            sRankY = IntToString(iIndex+1);

            sNameX = GetCampaignString(sCampaign,"Name" + sRankX);
            sClassX = GetCampaignString(sCampaign,"Class" + sRankX);
            sRaceX = GetCampaignString(sCampaign,"Race" + sRankX);
            sLevelX = GetCampaignString(sCampaign,"Level" + sRankX);
            sScoreX = GetCampaignString(sCampaign,"Score" + sRankX);
            sKillerX= GetCampaignString(sCampaign,"Killer" + sRankX);
            sMAccompX = GetCampaignString(sCampaign,"Accomplishment" + sRankX);
            sFameX = GetCampaignString(sCampaign,"Fame" + sRankX);

            SetCampaignString(sCampaign,"Name" + sRankY,sNameX);
            SetCampaignString(sCampaign,"Class" + sRankY,sClassX);
            SetCampaignString(sCampaign,"Race" + sRankY,sRaceX);
            SetCampaignString(sCampaign,"Level" + sRankY,sLevelX);
            SetCampaignString(sCampaign,"Score" + sRankY,sScoreX);
            SetCampaignString(sCampaign,"Killer" + sRankY,sKillerX);
            SetCampaignString(sCampaign,"Accomplishment" + sRankY,sMAccompX);
            SetCampaignString(sCampaign,"Fame" + sRankY,sFameX);

            iIndex--;
            }

        SetCampaignString(sCampaign,"Name" + sRank,sName);
        SetCampaignString(sCampaign,"Class" + sRank,sClass);
        SetCampaignString(sCampaign,"Race" + sRank,sRace);
        SetCampaignString(sCampaign,"Level" + sRank,IntToString(iLevel));
        SetCampaignString(sCampaign,"Score" + sRank,IntToString(iScore));
        SetCampaignString(sCampaign,"Fame" + sRank,IntToString(iFame));
        SetCampaignString(sCampaign,"Killer" + sRank,sKiller);
        SetCampaignString(sCampaign,"Accomplishment" + sRank,sMAccomp);
        }

    }
DisplayRankings(oPC);
if (iRank>0)
    SendMessageToPC(oPC,"Congragulations on achieving rank " + sRank);
SendMessageToPC(oPC," ");
SendMessageToPC(oPC,"In your time in the lands you were best known for having " + sMAccomp + ".");

}

int GetRank(int iScore)
{
int iIndex;
int iRankScore;
string sRank;
string sCampaign;
int iPlace;

iIndex = 20;
iPlace = 0;

sCampaign = "Endless Nights VI";
if (GetCampaignInt(sCampaign,"MP") == 1)
    sCampaign = "MP_Endless Nights VI";

while (iIndex > 0)
    {
    sRank = IntToString(iIndex);
    iRankScore= StringToInt(GetCampaignString(sCampaign,"Score" + sRank));
    if (iScore>=iRankScore)
        iPlace = iIndex;
    iIndex--;
    }
return iPlace;
}

void GetKiller()
{
SetLocalString(OBJECT_SELF,"Killer",GetName(GetLastKiller()));
}
