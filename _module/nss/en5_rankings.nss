string Space(string sSpace, int iSpace);
string GetAllAccomplishments(object oPC,int iEnd=1);
void DisplayRankings(object oPC);
void ClearRankings();
string GetMajorAccomplishment(object oPC);

void DisplayRankings(object oPC)
{
int iIndex;
string sMsg;
string sName;
string sClass;
string sRace;
string sLevel;
string sScore;
string sRank;
string sKiller;
string sCampaign;
string sAccomplishment;
string sFame;

iIndex = 1;
sMsg = Space("Rank",10) + Space("Name",40) + Space("Class",40) + Space("Race",20) + Space("Level",10) + Space("Score",10) + Space("Died by",10);
//SendMessageToPC(oPC,sMsg);
sMsg = Space("----",10) + Space("----",40) + Space("-----",40) + Space("----",20) + Space("-----",10) + Space("-----",10) + Space("-----",10);
//SendMessageToPC(oPC,sMsg);

sCampaign = "Endless Nights VI";
if (GetCampaignInt(sCampaign,"MP") == 1)
    sCampaign = "MP_Endless Nights VI";

while (iIndex < 21)
    {
    sRank = IntToString(iIndex);
    sName = GetCampaignString(sCampaign,"Name" + sRank);
    sClass = GetCampaignString(sCampaign,"Class" + sRank);
    sRace = GetCampaignString(sCampaign,"Race" + sRank);
    sLevel = GetCampaignString(sCampaign,"Level" + sRank);
    sScore = GetCampaignString(sCampaign,"Score" + sRank);
    sFame = GetCampaignString(sCampaign,"Fame" + sRank);
    sKiller = GetCampaignString(sCampaign,"Killer" + sRank);
    sAccomplishment = GetCampaignString(sCampaign,"Accomplishment" + sRank);

    //sMsg = Space(sRank,10) + Space(sName,40) + Space(sClass,40) + Space(sRace,20) + Space(sLevel,10) + Space(sScore,10) + sKiller;
    sMsg = "#" + sRank + " : " + sName + " (Score: " +sScore + " Fame:" + sFame + "), a " + sRace + " " + sClass + " who achieved level " + sLevel + " and was best known for having " + sAccomplishment + " before being killed by a " + sKiller;
    if (GetStringLength(sName) > 0)
        SendMessageToPC(oPC,sMsg);
    iIndex++;
    }
}

string Space(string sSpace, int iSpace)
{
int iLen;

iLen = GetStringLength(sSpace);
if (iLen < iSpace)
    {
    while (iLen < iSpace)
        {
        sSpace = sSpace + " ";
        iLen++;
        }
    } else {
        sSpace = GetStringLeft(sSpace,iSpace);
    }
return sSpace;
}

void ClearRankings()
{
int iIndex;
string sRank;
string sCampaign;

sCampaign = "Endless Nights VI";
if (GetCampaignInt(sCampaign,"MP") == 1)
    sCampaign = "MP_Endless Nights VI";

iIndex = 1;

while (iIndex < 21)
    {
    sRank=IntToString(iIndex);
    SetCampaignString(sCampaign,"Name" + sRank,"");
    SetCampaignString(sCampaign,"Class" + sRank,"");
    SetCampaignString(sCampaign,"Race" + sRank,"");
    SetCampaignString(sCampaign,"Level" + sRank,"");
    SetCampaignString(sCampaign,"Score" + sRank,"");
    SetCampaignString(sCampaign,"Killer" + sRank,"");
    iIndex++;
    }
}

string GetAllAccomplishments(object oPC,int iEnd=1)
{
string sAccomplishments;
string sAccomp;
string sMAccomp;
string sReturn;
int iAccomplishments;
int iIndex;
int iDiff;
int iMaxDiff;

iAccomplishments = GetLocalInt(oPC,"Accomplishments");
iIndex = 1;
while (iIndex <= iAccomplishments)
    {
    sAccomp=GetLocalString(oPC,"Accomplishment" + IntToString(iIndex));
    iDiff=GetLocalInt(oPC,"Accomplishment" + IntToString(iIndex) + "Diff");
    if (iDiff>=iMaxDiff)
        {
        iMaxDiff=iDiff;
        sMAccomp=sAccomp;
        }
    if (iIndex > 1)
        sAccomplishments = sAccomplishments + " You have also " + GetLocalString(oPC,"Accomplishment" + IntToString(iIndex));
    else
        sAccomplishments = "You have " + GetLocalString(oPC,"Accomplishment" + IntToString(iIndex));
    iIndex++;
    }
if (iAccomplishments == 0)
    sAccomplishments = "You have done nothing special.";
else
    sAccomplishments = sAccomplishments + ".  You are best known for having " + sMAccomp;
sReturn = sAccomplishments;


return sReturn;
}

string GetMajorAccomplishment(object oPC)
{
string sAccomplishments;
string sAccomp;
string sMAccomp;
string sReturn;
int iAccomplishments;
int iIndex;
int iDiff;
int iMaxDiff;

iAccomplishments = GetLocalInt(oPC,"Accomplishments");
iIndex = 1;
while (iIndex <= iAccomplishments)
    {
    sAccomp=GetLocalString(oPC,"Accomplishment" + IntToString(iIndex));
    iDiff=GetLocalInt(oPC,"Accomplishment" + IntToString(iIndex) + "Diff");
    if (iDiff>=iMaxDiff)
        {
        iMaxDiff=iDiff;
        sMAccomp=sAccomp;
        }
    iIndex++;
    }

return sMAccomp;
}
