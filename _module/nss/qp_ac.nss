#include "utl_i_sqluuid"
#include "prc_x2_itemprop"

void main()
{
object oPC;
object oItem;
int iQuestPoints;
int iAC;
itemproperty ip;
string sTag;


oPC=GetPCSpeaker();
sTag = SQLocalsUUID_GetString(oPC,"QPTag");
oItem = GetItemPossessedBy(oPC, sTag);

if(GetIsObjectValid(oItem) != 0)
    {
    iAC=GetItemACValue(oItem);
    if (iAC < 20)
        {
        iQuestPoints = SQLocalsUUID_GetInt(oPC,"QuestPoints");
        iQuestPoints = iQuestPoints - 5;
        SQLocalsUUID_SetInt(oPC,"QuestPoints",iQuestPoints);
        ip=ItemPropertyACBonus(iAC+1);
        IPSafeAddItemProperty(oItem,ip);
        DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_AID,oPC)));
        } else {
        SendMessageToPC(oPC,"AC Bonus can't be raised higher than 20.");
        }
    } else {
    SendMessageToPC(oPC,"Could not find item.");
    }
}
