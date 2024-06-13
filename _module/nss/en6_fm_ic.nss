#include "prc_x2_itemprop"

void main()
{
object oItem;
object oPC;
itemproperty ip;
int iFameUsed;

oPC=GetPCSpeaker();
oItem=GetItemPossessedBy(oPC,"en6_special_ring");
ip=ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
IPSafeAddItemProperty(oItem,ip);

iFameUsed=GetLocalInt(oPC,"FameUsed");
iFameUsed++;
SetLocalInt(oPC,"FameUsed",iFameUsed);
}
