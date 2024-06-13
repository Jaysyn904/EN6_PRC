#include "utl_i_sqluuid"
#include "prc_x2_itemprop"

void main()
{
object oPC;
object oItem;
int iQuestPoints;
int iEnhance;
itemproperty ip;
string sTag;


oPC=GetPCSpeaker();
sTag = SQLocalsUUID_GetString(oPC,"QPTag");
oItem = GetItemPossessedBy(oPC, sTag);

if(GetIsObjectValid(oItem) != 0)
    {
    //iEnhance=SQLocalsUUID_GetInt(oPC,"QP_Enhancment");
    iEnhance=IPGetWeaponEnhancementBonus(oItem);
    if (iEnhance < 20)
        {
        iQuestPoints = SQLocalsUUID_GetInt(oPC,"QuestPoints");
        iQuestPoints = iQuestPoints - 5;
        SQLocalsUUID_SetInt(oPC,"QuestPoints",iQuestPoints);
        //SQLocalsUUID_SetInt(oPC,"QP_Enhancment",iEnhance+1);
        ip=ItemPropertyEnhancementBonus(iEnhance+1);
        IPSafeAddItemProperty(oItem,ip);
        DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_SOUND_BURST,oPC)));
        } else {
        SendMessageToPC(oPC,"Enhancement can't be raised higher than 20.");
        }
    } else {
    SendMessageToPC(oPC,"Could not find item.");
    }
}
