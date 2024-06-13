#include "utl_i_sqluuid"
#include "prc_x2_itemprop"

void main()
{
object oPC;
object oItem;
int iQuestPoints;
int iProp;
itemproperty ip;
string sTag;


oPC=GetPCSpeaker();
sTag = SQLocalsUUID_GetString(oPC,"QPTag");
oItem = GetItemPossessedBy(oPC, sTag);

if(GetIsObjectValid(oItem) != 0)
    {
    iProp=SQLocalsUUID_GetInt(oPC,"QP_ImmuneCrit");
    if (iProp==0)
        {
        iQuestPoints = SQLocalsUUID_GetInt(oPC,"QuestPoints");
        iQuestPoints = iQuestPoints - 15;
        SQLocalsUUID_SetInt(oPC,"QuestPoints",iQuestPoints);
        SQLocalsUUID_SetInt(oPC,"QP_ImmuneCrit",1);
        ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
        IPSafeAddItemProperty(oItem,ip);
        DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_CURE_SERIOUS_WOUNDS,oPC)));
        } else {
        SendMessageToPC(oPC,"You already have that enhancement.");
        }
    } else {
    SendMessageToPC(oPC,"Could not find item.");
    }
}
