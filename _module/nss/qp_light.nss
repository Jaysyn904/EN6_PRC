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
    iQuestPoints = SQLocalsUUID_GetInt(oPC,"QuestPoints");
    iQuestPoints = iQuestPoints - 2;
    SQLocalsUUID_SetInt(oPC,"QuestPoints",iQuestPoints);
    ip=ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_WHITE);
    IPSafeAddItemProperty(oItem,ip);
    DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_AID,oPC)));
    } else {
    SendMessageToPC(oPC,"Could not find item.");
    }
}
