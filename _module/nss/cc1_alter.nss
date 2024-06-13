#include "en5_treasure"

void GetPowers(object oPC);

void main()
{
object oPC;
object oMob;
effect eVis;
effect eDam;
int iRandom;
int iRandom2;
string sTag;
string sString;
oPC=GetPlaceableLastClickedBy();

if (GetDistanceBetween(oPC,OBJECT_SELF) > 5.0)
    {
    SendMessageToPC(oPC,"You are too far away to touch the alter.");
    AssignCommand(oPC,ClearAllActions());
    }
else
    {
    if (GetLocalInt(oPC,"EvilAlter") == 0)
        {
        SetLocalInt(oPC,"EvilAlter",1);

        sString="You touch the alter.";
        AssignCommand(oPC,ClearAllActions());


        iRandom=GetLocalInt(oPC,"CC1_ALTER");
        if (iRandom==0)
            iRandom=Random(50);

        if (GetLocalInt(oPC,"PCRacePower") > 0)
            iRandom--;

        if (iRandom<5)
            {
            eVis = EffectVisualEffect(VFX_FNF_SWINGING_BLADE);
            DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oPC),3.0));
            eDam = EffectDamage(d6(2), DAMAGE_TYPE_SLASHING);
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));
            }
        else if (iRandom<10)
            {
            object oWP=GetObjectByTag("CC2_GP_Enter");
            AssignCommand(oPC,JumpToLocation(GetLocation(oWP)));
            sString="You touch the alter and a hole opens up under you which you fall through.";
            eDam = EffectDamage(d6(2), DAMAGE_TYPE_BLUDGEONING);
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));
            if (Random(10)==0)
                GetMagicItem(GetObjectByTag("CC1_Corpse"),1,0,oPC);
            }
        else if (iRandom<15)
            {
            eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
            DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oPC),3.0));
            eDam = EffectDamage(d6(2), DAMAGE_TYPE_ELECTRICAL);
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));
            }

        else if (iRandom<20)
            {
            ActionCastSpellAtObject(SPELL_INFESTATION_OF_MAGGOTS,oPC,METAMAGIC_ANY,TRUE);
            }
        else if (iRandom<25)
            {
            ActionCastSpellAtObject(SPELL_DARKFIRE,oPC,METAMAGIC_ANY,TRUE);
            }
        else if (iRandom<30)
            {
            AssignCommand(oPC,ActionCastSpellAtObject(SPELL_DIVINE_FAVOR,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
            }
        else if (iRandom<35)
            {
            AssignCommand(oPC,ActionCastSpellAtObject(SPELL_SHADOW_CONJURATION_SUMMON_SHADOW,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
            }
        else if (iRandom<40)
            {
            iRandom2=Random(4)+1;
            switch (iRandom2)
                {
                case 1: sTag="EN5_SHADOW"; break;
                case 2: sTag="EN5_IMP"; break;
                case 3: sTag="en5_quasit"; break;
                case 4: sTag="en6_xorax"; break;
                }
            oMob=CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(OBJECT_SELF));
            if (Random(5)==0 || iRandom2==4)
                GetMagicItem(oMob,1,0,oPC);
            }
        else if (iRandom<46)
            {
            sString="You touch the alter and your fingers come away stained with blood.";
            }
        else if (iRandom<48)
            {
            AssignCommand(oPC,ActionCastSpellAtObject(SPELL_DECK_AVATAR,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
            }
        else if (iRandom<49)
            {
            ExecuteScript("en6_draw",oPC);
            }
        else if (iRandom<50)
            {
            GetPowers(oPC);
            sString="You touch the alter and feel a demonic power fill your soul.";
            }

        SendMessageToPC(oPC,sString);
        } else {
        AssignCommand(oPC,ClearAllActions());
        eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oPC),3.0));
        eDam = EffectDamage(d6(2), DAMAGE_TYPE_ELECTRICAL);
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));
        DelayCommand(0.7,SendMessageToPC(oPC,"The powers frown upon your greed."));
        }
    }
}

void GetPowers(object oPC)
{
int iRandom;
int iRandom2;
string sString;
effect eVis;

sString="You have gained the ability to imbue your weapon with power.";

iRandom=Random(5)+1;

switch (iRandom)
    {
    case 1: SetLocalInt(oPC,"SpecialPowers",1); sString = "You are imbued with the powers of the abyss."; break;
    case 2: SetLocalInt(oPC,"SpecialPowers",3); sString = "You are imbued with great strength."; break;
    case 3: SetLocalInt(oPC,"WeaponBonus",Random(4)+1); break;
    case 4: SetLocalInt(oPC,"SpecialWeapon",1); break;
    case 5: SetLocalInt(oPC,"SpecialWeapon",2); break;
    }

eVis = EffectVisualEffect(VFX_IMP_EVIL_HELP);
DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC,3.0));
eVis = EffectVisualEffect(246);
DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC,3.0));

DelayCommand(0.5,SendMessageToPC(oPC,sString));

if (iRandom == 1 || iRandom>3)
    {
    SetCreatureWingType(CREATURE_WING_TYPE_DEMON,oPC);
    SetCreatureTailType(CREATURE_TAIL_TYPE_DEVIL,oPC);
    iRandom2=Random(6)*5;
    if (iRandom2>0)
        AdjustAlignment(oPC,ALIGNMENT_EVIL,iRandom2);
    }

ExecuteScript("en6_special",oPC);

}

