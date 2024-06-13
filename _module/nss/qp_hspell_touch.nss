#include "utl_i_sqluuid"
#include "prc_x2_itemprop"

void main()
{
object oPC;
object oItem;
int iQuestPoints;
int iSpell;
itemproperty ip;
string sTag;


oPC=GetPCSpeaker();
sTag = SQLocalsUUID_GetString(oPC,"QPTag");
oItem = GetItemPossessedBy(oPC, sTag);

if(GetIsObjectValid(oItem) != 0)
    {
    iSpell=SQLocalsUUID_GetInt(oPC,"QP_HitSpell");
    if (iSpell == 0)
        {
        iQuestPoints = SQLocalsUUID_GetInt(oPC,"QuestPoints");
        iQuestPoints = iQuestPoints - 15;
        SQLocalsUUID_SetInt(oPC,"QuestPoints",iQuestPoints);
        SQLocalsUUID_SetInt(oPC,"QP_HitSpell",1);
        ip=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH,15);
        IPSafeAddItemProperty(oItem,ip);
        DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_MAGIC_MISSILE,oPC)));
        } else {
        SendMessageToPC(oPC,"Spells can only be put on once.");
        }
    } else {
    SendMessageToPC(oPC,"Could not find item.");
    }
}
