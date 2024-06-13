#include "utl_i_sqluuid"
#include "prc_x2_itemprop"

void main()
{
object oPC;
object oItem;
int iQuestPoints;
int iReduction;
itemproperty ip;
string sTag;


oPC=GetPCSpeaker();
sTag = SQLocalsUUID_GetString(oPC,"QPTag");
oItem = GetItemPossessedBy(oPC, sTag);

if(GetIsObjectValid(oItem) != 0)
    {
    iReduction=SQLocalsUUID_GetInt(oPC,"QP_Redfire");
    if (iReduction < 10)
        {
        iQuestPoints = SQLocalsUUID_GetInt(oPC,"QuestPoints");
        iQuestPoints = iQuestPoints - 5;
        SQLocalsUUID_SetInt(oPC,"QuestPoints",iQuestPoints);
        SQLocalsUUID_SetInt(oPC,"QP_Redfire",iReduction+1);
        ip=ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,iReduction+1);
        IPSafeAddItemProperty(oItem,ip);
        DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_CONTINUAL_FLAME,oPC)));
        } else {
        SendMessageToPC(oPC,"Reduction can't be raised higher than 50.");
        }
    } else {
    SendMessageToPC(oPC,"Could not find item.");
    }
}
