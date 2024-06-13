void main()
{
int iQuestType;
int iIndex;
int iTarget;
string sTag;
string sWP;
string sMessage;
object oWP;
object oMob;

iTarget=0;

iQuestType = GetLocalInt(GetPCSpeaker(),"QuestType");

if (iQuestType>0)
    sMessage = "You are not on a quest involving creatures as primary targets.";
else
    sMessage = "You are not on a quest.";

//SendMessageToPC(GetFirstPC(),"QuestType=" + IntToString(iQuestType));
if (iQuestType == 1 || iQuestType == 6)
    {
    sMessage = "Target is no longer alive.";
    sTag = GetLocalString(GetPCSpeaker(),"QuestMob");
    //SendMessageToPC(GetFirstPC(),"QuestMob=" + sTag);
    oMob = GetObjectByTag(sTag);

    if (GetIsObjectValid(oMob))
        {
        if (GetArea(oMob) != GetArea(GetPCSpeaker()))
            sMessage = GetName(oMob) + " not in the area.";
        else if (GetDistanceBetween(oMob,GetPCSpeaker()) > 50.0)
            sMessage = GetName(oMob) + " is in the area.";
        else
            sMessage = GetName(oMob) + " is close by in the area.";
        }
    }
if (iQuestType == 2 || iQuestType == 7)
    {
    sMessage = "Target is no longer alive.";
    iIndex = 1;
    sTag = GetLocalString(GetPCSpeaker(),"QuestMobZone") + "_" + GetLocalString(GetPCSpeaker(),"QuestCamp") + "_";
    sWP = sTag + IntToString(iIndex);
    oWP = GetObjectByTag(sWP);
    //GetError("Checking " + GetTag(oWP));
    while (GetIsObjectValid(oWP))
        {
        oMob = GetObjectByTag(sWP + "_S");
        //GetError(GetTag(oMob) + "=" + GetName(oMob));
        if (GetIsObjectValid(oMob))
            {
            if (GetArea(oMob) != GetArea(GetPCSpeaker()))
                {
                if (iTarget<1)
                    {
                    iTarget=1;
                    sMessage = "Target not in the area.";
                    }
                }
            else if (GetDistanceBetween(oMob,GetPCSpeaker()) > 50.0)
                {
                if (iTarget<2)
                    {
                    iTarget=2;
                    sMessage = "Target is in the area.";
                    }
                }
            else
                {
                if (iTarget<3)
                    {
                    iTarget=3;
                    sMessage = "Target is close by in the area.";
                    }
                }
            }
        iIndex++;
        sWP = sTag + IntToString(iIndex);
        oWP = GetObjectByTag(sWP);
        }
    }

SendMessageToPC(GetPCSpeaker(),sMessage);
}
