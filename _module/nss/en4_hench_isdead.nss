object GetHench(object oPC);

int StartingConditional()
{
int iResult;
int iGold;
int iIndex;
int iHench;
string sTag;
object oHench;
object oPC;

oPC=GetPCSpeaker();

iResult = FALSE;

iHench=GetLocalInt(oPC,"HenchmenBought");
iIndex=1;

while (iIndex<=iHench)
    {
    sTag=GetLocalString(oPC,"Henchman" + IntToString(iIndex));
    oHench = GetObjectByTag(sTag);
    if (GetIsObjectValid(oHench) && GetIsDead(oHench))
        {
        iResult = TRUE;
        SetLocalString(OBJECT_SELF,"RezTag",sTag);
        }
    iIndex++;
    }
return iResult;
}

