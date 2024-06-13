#include "utl_i_sqluuid"
#include "prc_x2_itemprop"

int DamageBonus(int iNumber);

void main()
{
object oPC;
object oItem;
int iQuestPoints;
int iBonus;
itemproperty ip;
string sTag;


oPC=GetPCSpeaker();
sTag = SQLocalsUUID_GetString(oPC,"QPTag");
oItem = GetItemPossessedBy(oPC, sTag);

if(GetIsObjectValid(oItem) != 0)
    {
    iBonus=SQLocalsUUID_GetInt(oPC,"QP_Bonussonic");
    if (iBonus < 8)
        {
        iQuestPoints = SQLocalsUUID_GetInt(oPC,"QuestPoints");
        iQuestPoints = iQuestPoints - 5;
        SQLocalsUUID_SetInt(oPC,"QuestPoints",iQuestPoints);
        SQLocalsUUID_SetInt(oPC,"QP_Bonussonic",iBonus+1);
        ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,DamageBonus(iBonus+1));
        IPSafeAddItemProperty(oItem,ip);
        DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_HARM,oPC)));
        } else {
        SendMessageToPC(oPC,"Bonus can't be raised higher.");
        }
    } else {
    SendMessageToPC(oPC,"Could not find item.");
    }
}

int DamageBonus(int iNumber)
{
int iBonus;

iBonus = IP_CONST_DAMAGEBONUS_1;

switch (iNumber)
    {
    case 1: iBonus = IP_CONST_DAMAGEBONUS_1d4; break;
    case 2: iBonus = IP_CONST_DAMAGEBONUS_1d6; break;
    case 3: iBonus = IP_CONST_DAMAGEBONUS_1d8; break;
    case 4: iBonus = IP_CONST_DAMAGEBONUS_1d10; break;
    case 5: iBonus = IP_CONST_DAMAGEBONUS_1d12; break;
    case 6: iBonus = IP_CONST_DAMAGEBONUS_2d8; break;
    case 7: iBonus = IP_CONST_DAMAGEBONUS_2d10; break;
    case 8: iBonus = IP_CONST_DAMAGEBONUS_2d12; break;
    }

return iBonus;
}
