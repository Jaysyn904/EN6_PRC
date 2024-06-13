#include "en5_treasure"
void main()
{
int iRandom;
itemproperty ip;
object oPC;
object oItem;

oPC=GetPCSpeaker();
oItem=CreateItemOnObject("en6_runering",oPC);

ip=ItemPropertyACBonus(6);
IPSafeAddItemProperty(oItem,ip);
ip=ArtifactProperty();
IPSafeAddItemProperty(oItem,ip);
ip=ArtifactProperty();
IPSafeAddItemProperty(oItem,ip);
ip=ItemPropertyCastSpell(IP_CONST_CASTSPELL_TRUE_STRIKE_5,IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY);
IPSafeAddItemProperty(oItem,ip);
SetLocalInt(GetPCSpeaker(),"RuneRing",1);
}


