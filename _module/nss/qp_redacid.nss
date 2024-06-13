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
    iReduction=SQLocalsUUID_GetInt(oPC,"QP_Redacid");
    if (iReduction < 10)
        {
        iQuestPoints = SQLocalsUUID_GetInt(oPC,"QuestPoints");
        iQuestPoints = iQuestPoints - 5;
        SQLocalsUUID_SetInt(oPC,"QuestPoints",iQuestPoints);
        SQLocalsUUID_SetInt(oPC,"QP_Redacid",iReduction+1);
        //IP_CONST_DAMAGETYPE_ELECTRICAL IP_CONST_DAMAGETYPE_MAGICAL IP_CONST_DAMAGETYPE_ACID
        ip=ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,iReduction+1);
        IPSafeAddItemProperty(oItem,ip);
        DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_CONTINUAL_FLAME,oPC)));
        } else {
        SendMessageToPC(oPC,"Reduction can't be raised higher than 50.");
        }
    } else {
    SendMessageToPC(oPC,"Could not find item.");
    }
}
