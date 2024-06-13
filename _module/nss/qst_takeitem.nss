void main()
{
int iStep;
int iSteps;
object oPC;
object oItemToTake;
string sTag;

oPC = GetPCSpeaker();
sTag = GetLocalString(oPC,"QuestItem");

oItemToTake = GetItemPossessedBy(oPC, sTag);
if(GetIsObjectValid(oItemToTake) != 0)
    DestroyObject(oItemToTake);

}

