#include "prc_x2_itemprop"
#include "utl_i_sqluuid"

void main()
{
object oPC;
object oItem;
int iQuestPoints;
int iAbility;
itemproperty ip;
string sTag;


oPC=GetPCSpeaker();
sTag = SQLocalsUUID_GetString(oPC,"QPTag");
oItem = GetItemPossessedBy(oPC, sTag);

if(GetIsObjectValid(oItem) != 0)
    {
    iAbility=SQLocalsUUID_GetInt(oPC,"QP_CON");
    if (iAbility < 10)
        {
        iQuestPoints = SQLocalsUUID_GetInt(oPC,"QuestPoints");
        iQuestPoints = iQuestPoints - 5;
        SQLocalsUUID_SetInt(oPC,"QuestPoints",iQuestPoints);
        SQLocalsUUID_SetInt(oPC,"QP_CON",iAbility+1);
        ip=ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,iAbility+1);
        IPSafeAddItemProperty(oItem,ip);
        DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_BULLS_STRENGTH,oPC)));
        } else {
        SendMessageToPC(oPC,"Ability bonus can't be raised higher than 10.");
        }
    } else {
    SendMessageToPC(oPC,"Could not find item.");
    }
}
