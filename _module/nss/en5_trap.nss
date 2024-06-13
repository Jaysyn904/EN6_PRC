#include "en5_misc"

void CreateTrapKit(object oTarget, int iItemLevel);
void DetectTrap(object oPC,int iDC,int iLevel);

void main()
{
int iMinLevel;
int iMaxLevel;
int iLevel;
int iDC;
object oPC;
object oArea;

int iRogue	= GetLevelByClass(CLASS_TYPE_ROGUE, oPC)
			+ GetLevelByClass(CLASS_TYPE_SCOUT, oPC)
			+ GetLevelByClass(CLASS_TYPE_BEGUILER, oPC)
			+ GetLevelByClass(CLASS_TYPE_NINJA, oPC)
			+ GetLevelByClass(CLASS_TYPE_FACTOTUM, oPC)
			+ GetLevelByClass(CLASS_TYPE_PSYCHIC_ROGUE, oPC);
			
if (GetLocalInt(OBJECT_SELF,"Disabled") == 1)
   return;

if (Random(12)>0 && iRogue == 0)
    {
    SetLocalInt(OBJECT_SELF,"Disabled",1);
    return;
    }

if (Random(8)>0 && iRogue > 0)
    {
    SetLocalInt(OBJECT_SELF,"Disabled",1);
    return;
    }

oPC = GetEnteringObject();

if (GetLocalInt(GetArea(OBJECT_SELF),"SpecialArea") == 1)
    {
    oArea=GetArea(GetObjectByTag(GetLocalString(GetArea(OBJECT_SELF),"Zone") + "_Enter"));
    iMinLevel = GetLocalInt(oArea,"MinLevel");
    iMaxLevel = GetLocalInt(oArea,"MaxLevel");
    } else {
    iMinLevel = GetLocalInt(GetArea(OBJECT_SELF),"MinLevel");
    iMaxLevel = GetLocalInt(GetArea(OBJECT_SELF),"MaxLevel");
    }

iLevel = Random(iMaxLevel-iMinLevel+1)+iMinLevel;
//GetError("Trap Level = " + IntToString(iLevel));

if (iLevel<1)
    iLevel = GetHitDice(oPC);

iDC=GetLocalInt(OBJECT_SELF,"iDC");
if (iDC == 0)
    {
    iDC = iLevel + 8 + Random(10);
    SetLocalInt(OBJECT_SELF,"iDC",iDC);
    }

if (GetLocalInt(OBJECT_SELF,"Detected")==0)
    {
    DetectTrap(oPC,iDC,iLevel);
    } else {
    if (GetLocalInt(OBJECT_SELF,GetName(oPC))==0)
        DetectTrap(oPC,iDC,iLevel);
    }

}

void DetectTrap(object oPC,int iDC,int iLevel)
{
int iDetect;
int iDisable;
int iAquire;
int iItemLevel;
int iEffect;
int iDamageType;
int iRandom;
int iDice;
int iDamage;
object oGlow;
location lLoc;
effect eVisu;
effect eDamg;

iDetect=FALSE;
iDisable=FALSE;
iAquire=FALSE;

iItemLevel=GetItemLevel(iLevel);

if (GetHasSkill(SKILL_SEARCH,oPC))
    if (GetIsSkillSuccessful(oPC,SKILL_SEARCH,iDC))
        {
        iDetect=TRUE;
        SetLocalInt(OBJECT_SELF,GetName(oPC),1);
        }

if (iDetect==TRUE && GetHasSkill(SKILL_DISABLE_TRAP,oPC))
    if (GetIsSkillSuccessful(oPC,SKILL_DISABLE_TRAP,iDC))
        iDisable=TRUE;

if (iDisable==TRUE && GetHasSkill(SKILL_DISABLE_TRAP,oPC) && GetLevelByClass(CLASS_TYPE_ROGUE,oPC)>0)
    if (GetIsSkillSuccessful(oPC,SKILL_DISABLE_TRAP,iDC+10))
        iAquire=TRUE;

if (iDetect == FALSE)
    {
    iDice = iLevel/2;
    if (iDice<1)
        iDice=1;
    iDamage = d4(iDice);
    iRandom = Random(9)+1;
    switch (iRandom)
        {
        case 1: iEffect=VFX_FNF_GAS_EXPLOSION_ACID;
                iDamageType=DAMAGE_TYPE_ACID;
                break;
        case 2: iEffect=VFX_FNF_GAS_EXPLOSION_EVIL;
                iDamageType=DAMAGE_TYPE_NEGATIVE;
                break;
        case 3: iEffect=VFX_FNF_SWINGING_BLADE;
                iDamageType=DAMAGE_TYPE_SLASHING;
                break;
        case 4: if (iDamage<30)
                    {
                    iEffect=VFX_IMP_SPIKE_TRAP;
                    iDamageType=DAMAGE_TYPE_PIERCING;
                    } else {
                    iEffect=VFX_FNF_MYSTICAL_EXPLOSION;
                    iDamageType=DAMAGE_TYPE_MAGICAL;
                    }
                break;
        case 5: if (iDamage<30)
                    iEffect=VFX_COM_HIT_ELECTRICAL;
                else
                    iEffect=VFX_FNF_ELECTRIC_EXPLOSION;
                iDamageType=DAMAGE_TYPE_ELECTRICAL;
                break;
        case 6: if (iDamage<30)
                    iEffect=VFX_COM_HIT_DIVINE;
                else
                    iEffect=VFX_FNF_STRIKE_HOLY;
                iDamageType=DAMAGE_TYPE_DIVINE;
                break;
        case 7: iEffect=VFX_IMP_SPIKE_TRAP;
                iDamageType=DAMAGE_TYPE_PIERCING;
                break;
        case 8: iEffect=VFX_COM_HIT_FROST;
                iDamageType=DAMAGE_TYPE_COLD;
                break;
        case 9: iEffect=VFX_COM_HIT_SONIC;
                iDamageType=DAMAGE_TYPE_SONIC;
                break;
        }
    eVisu = EffectVisualEffect(iEffect, FALSE);
    eDamg = EffectDamage(iDamage,iDamageType);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisu, GetLocation(oPC));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamg, oPC);
    SendMessageToPC(oPC, "A trap hits you for " + IntToString(iDamage) + " points of damage.");
    SetLocalInt(OBJECT_SELF,"Disabled",1);
    }

if (iDetect == TRUE && iDisable == FALSE)
    {
    lLoc=GetLocation(GetNearestObjectByTag("en5_trap"));
    oGlow=CreateObject(OBJECT_TYPE_PLACEABLE,"en5_trapglow",lLoc);
    ApplyEffectToObject(2, EffectVisualEffect(VFX_DUR_GLOW_RED),oGlow);
    ApplyEffectToObject(2, EffectVisualEffect(VFX_DUR_LIGHT_RED_15), oGlow);
    SetLocalInt(OBJECT_SELF,"Detected",1);
    SendMessageToPC(oPC, "You have detected a trap but are unable to disable it.");
    }

if (iDetect == TRUE && iDisable == TRUE && iAquire==FALSE)
    {
    SendMessageToPC(oPC, "You have detected and disabled a trap.");
    SetLocalInt(OBJECT_SELF,"Disabled",1);
    GiveXPToCreature(oPC,iDC*10);
    }

if (iDetect == TRUE && iDisable == TRUE && iAquire==TRUE)
    {
    CreateTrapKit(oPC,iItemLevel);
    SendMessageToPC(oPC, "You have detected and disabled a trap, and you have aquired the device.");
    SetLocalInt(OBJECT_SELF,"Disabled",1);
    GiveXPToCreature(oPC,iDC*20);
    }
}

void CreateTrapKit(object oTarget, int iItemLevel)
{
  string sKit = "";
    if (iItemLevel==1)      // 200
    {
        int nRandom = d3();
        switch (nRandom)
        {
            case 1: sKit = "nw_it_trap001";    break;
            case 2: sKit = "nw_it_trap029";    break;
            case 3: sKit = "nw_it_trap033";    break;
        }
    }
    else if (iItemLevel==2)  // 800
    {
        int nRandom = d12();
        switch (nRandom)
        {
            case 1: sKit = "nw_it_trap001";    break;
            case 2: sKit = "nw_it_trap029";    break;
            case 3: sKit = "nw_it_trap033";    break;
            case 4: sKit = "nw_it_trap002";    break;
            case 5: sKit = "nw_it_trap030";    break;
            case 6: sKit = "nw_it_trap037";    break;
            case 7: sKit = "nw_it_trap034";   break;
            case 8: sKit = "nw_it_trap005";   break;
            case 9: sKit = "nw_it_trap038";   break;
            case 10: sKit = "nw_it_trap041";   break;
            case 11: sKit = "nw_it_trap003";    break;
            case 12: sKit = "nw_it_trap031";   break;
        }

    }
    else if (iItemLevel==3)   // 200 - 2500
    {
        int nRandom = Random(17) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_trap002";  break;
            case 2: sKit = "nw_it_trap030";  break;
            case 3: sKit = "nw_it_trap037";  break;
            case 4: sKit = "nw_it_trap034";   break;
            case 5: sKit = "nw_it_trap005";  break;
            case 6: sKit = "nw_it_trap038";   break;
            case 7: sKit = "nw_it_trap041";   break;
            case 8: sKit = "nw_it_trap003";   break;
            case 9: sKit = "nw_it_trap031";   break;
            case 10: sKit = "nw_it_trap035";   break;
            case 11: sKit = "nw_it_trap006";   break;
            case 12: sKit = "nw_it_trap042";   break;
            case 13: sKit = "nw_it_trap004";   break;
            case 14: sKit = "nw_it_trap032";   break;
            case 15: sKit = "nw_it_trap039";    break;
            case 16: sKit = "nw_it_trap009";   break;
            case 17: sKit = "nw_it_trap036";   break;
        }

   }
    else if (iItemLevel==4)  // 800 - 10000
    {
        int nRandom = Random(19) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_trap035";  break;
            case 2: sKit = "nw_it_trap006";  break;
            case 3: sKit = "nw_it_trap042";  break;
            case 4: sKit = "nw_it_trap004";   break;
            case 5: sKit = "nw_it_trap032";   break;
            case 6: sKit = "nw_it_trap039";   break;
            case 7: sKit = "nw_it_trap009";   break;
            case 8: sKit = "nw_it_trap036";   break;
            case 9: sKit = "nw_it_trap013";   break;
            case 10: sKit = "nw_it_trap040";  break;
            case 11: sKit = "nw_it_trap007";  break;
            case 12: sKit = "nw_it_trap043";  break;
            case 13: sKit = "nw_it_trap010";  break;
            case 14: sKit = "nw_it_trap017";  break;
            case 15: sKit = "nw_it_trap021"; break;
            case 16: sKit = "nw_it_trap014"; break;
            case 17: sKit = "nw_it_trap025"; break;
            case 18: sKit = "nw_it_trap008";  break;
            case 19: sKit = "nw_it_trap044";  break;
        }

    }
    else if (iItemLevel==5)  // 2000 -16500
    {
        int nRandom = Random(18) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_trap039";   break;
            case 2: sKit = "nw_it_trap009";   break;
            case 3: sKit = "nw_it_trap036";   break;
            case 4: sKit = "nw_it_trap013";   break;
            case 5: sKit = "nw_it_trap040";   break;
            case 6: sKit = "nw_it_trap007";   break;
            case 7: sKit = "nw_it_trap043";   break;
            case 8: sKit = "nw_it_trap010";  break;
            case 9: sKit = "nw_it_trap017";  break;
            case 10: sKit = "nw_it_trap021";  break;
            case 11: sKit = "nw_it_trap014";  break;
            case 12: sKit = "nw_it_trap025";  break;
            case 13: sKit = "nw_it_trap008";  break;
            case 14: sKit = "nw_it_trap044";  break;
            case 15: sKit = "nw_it_trap018";  break;
            case 16: sKit = "nw_it_trap011";  break;
            case 17: sKit = "nw_it_trap022";  break;
            case 18: sKit = "nw_it_trap026";  break;
        }

    }
    else if (iItemLevel==6)   // 2000 - ?
    {
        int nRandom = Random(27) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_trap039";  break;
            case 2: sKit = "nw_it_trap009";  break;
            case 3: sKit = "nw_it_trap036";  break;
            case 4: sKit = "nw_it_trap013";  break;
            case 5: sKit = "nw_it_trap040";  break;
            case 6: sKit = "nw_it_trap007";  break;
            case 7: sKit = "nw_it_trap043";  break;
            case 8: sKit = "nw_it_trap010"; break;
            case 9: sKit = "nw_it_trap017"; break;
            case 10: sKit = "nw_it_trap021"; break;
            case 11: sKit = "nw_it_trap014"; break;
            case 12: sKit = "nw_it_trap025"; break;
            case 13: sKit = "nw_it_trap008"; break;
            case 14: sKit = "nw_it_trap044"; break;
            case 15: sKit = "nw_it_trap018"; break;
            case 16: sKit = "nw_it_trap011"; break;
            case 17: sKit = "nw_it_trap022"; break;
            case 18: sKit = "nw_it_trap026"; break;
            case 19: sKit = "nw_it_trap015"; break;
            case 20: sKit = "nw_it_trap012"; break;
            case 21: sKit = "nw_it_trap019"; break;
            case 22: sKit = "nw_it_trap023"; break;
            case 23: sKit = "nw_it_trap016"; break;
            case 24: sKit = "nw_it_trap027"; break;
            case 25: sKit = "nw_it_trap020"; break;
            case 26: sKit = "nw_it_trap024"; break;
            case 27: sKit = "nw_it_trap028"; break;
         }

    }
    //dbSpeak("Create Trapkit");
    CreateItemOnObject(sKit, oTarget, 1);

}
