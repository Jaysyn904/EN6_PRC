#include "utl_i_sqluuid"
#include "prc_x2_itemprop"

void main()
{
object oPC;
object oItem;
int iQuestPoints;
int iReduction;
int iReduction2;
itemproperty ip;
string sTag;
int iDR;

oPC=GetPCSpeaker();
sTag = SQLocalsUUID_GetString(oPC,"QPTag");
oItem = GetItemPossessedBy(oPC, sTag);
iDR=GetLocalInt(GetPCSpeaker(),"DR");

if(GetIsObjectValid(oItem) != 0)
    {
    iReduction=SQLocalsUUID_GetInt(oPC,"QP_DmgRed1");
    iReduction2=SQLocalsUUID_GetInt(oPC,"QP_DmgRed2");
    if (iReduction == 0)
        iReduction2=1;
    if (iReduction < 10)
        {
        iQuestPoints = SQLocalsUUID_GetInt(oPC,"QuestPoints");
        iQuestPoints = iQuestPoints - 5;
        if (iDR == 0)
            iQuestPoints = iQuestPoints - 5;
        SQLocalsUUID_SetInt(oPC,"QuestPoints",iQuestPoints);
        SQLocalsUUID_SetInt(oPC,"QP_DmgRed1",iReduction+1);
        SQLocalsUUID_SetInt(oPC,"QP_DmgRed2",iReduction2);
        SQLocalsUUID_SetInt(oPC,"DR",1);
        ip=ItemPropertyDamageReduction(iReduction2-1,iReduction+1);
        IPRemoveMatchingItemProperties(oItem,GetItemPropertyType(ip),DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem,ip);
        DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_MAGIC_WEAPON,oPC)));
        } else {
        SendMessageToPC(oPC,"Reduction can't be raised higher than 50.");
        }
    } else {
    SendMessageToPC(oPC,"Could not find item.");
    }
}
