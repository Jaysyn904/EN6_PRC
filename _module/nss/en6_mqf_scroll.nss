#include "x2_inc_switches"
#include "prc_x2_itemprop"

void UseTheScroll(object oPC);

void main()
{
int nEvent;
object oItem;
object oPC;

nEvent = GetUserDefinedItemEventNumber();

if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    oPC   = GetItemActivator();
    if (GetIsPC(oPC))
        {
        oItem = GetItemActivated();
        if (GetTag(oItem) == "en6_mqf_scroll")
            {
            UseTheScroll(oPC);
            }
        }
    }
}

void UseTheScroll(object oPC)
{
int iBoss;
object oItem;
itemproperty ip;
effect eVis;
effect eAttack;

/*
1=Lich King
2=Demi-Lich
3=Lolth
4=Randal Kross
5=Rakasha
6=Demon
7=Half Dragon Man
8=Prismatic Dragon
*/

iBoss=GetLocalInt(GetModule(),"OverallQuestBoss");

oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
if (!GetIsObjectValid(oItem))
    oItem=GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
ip=ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d6);
IPSafeAddItemProperty(oItem,ip,900.0);
IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 900.0);

eAttack = EffectAttackIncrease(10);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttack, oPC, 180.0);

AssignCommand(oPC,ActionCastSpellAtObject(SPELL_WAR_CRY,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
AssignCommand(oPC,ActionCastSpellAtObject(SPELL_RESIST_ELEMENTS,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
AssignCommand(oPC,ActionCastSpellAtObject(SPELL_GREATER_STONESKIN,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
AssignCommand(oPC,ActionCastSpellAtObject(SPELL_PRAYER,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC,3.0));


}
