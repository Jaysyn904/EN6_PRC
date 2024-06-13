void MoveToAmbush(object oNPC);

void main()
{
int iRandom;

iRandom=Random(2);

if (iRandom==1)
    {
    DelayCommand(30.0,MoveToAmbush(OBJECT_SELF));
    }
}

void MoveToAmbush(object oNPC)
{
object oBoss;
string sTag;

SetLocalInt(oNPC,"Betrayal",1);
sTag=GetLocalString(oNPC,"QuestStep1MobTag");
oBoss=GetObjectByTag(sTag);

object oItemToTake = GetItemPossessedBy(oBoss, GetLocalString(oNPC,"QuestStep1Item"));
if(GetIsObjectValid(oItemToTake) != 0)
    DestroyObject(oItemToTake);

ChangeFaction(oNPC,oBoss);
AssignCommand(oNPC,JumpToLocation(GetLocation(oBoss)));
}
