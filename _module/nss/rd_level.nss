int LevelMob(object oCreature, int iLevels);
int GetPackage(int iClass);

int LevelMob(object oCreature, int iLevels)
{
int iNewLevel;
int iIndex;
int iClass;
int iPackage;

if (GetClassByPosition(2,oCreature) == CLASS_TYPE_INVALID)
    {
    iClass = GetClassByPosition(1,oCreature);
    iPackage =PACKAGE_INVALID;
    } else {
    iClass = CLASS_TYPE_INVALID;
    iPackage =PACKAGE_INVALID;
    }

iIndex = 1;
while (iIndex <= iLevels)
    {
    iNewLevel=LevelUpHenchman(oCreature,iClass,TRUE,iPackage);
    iIndex++;
    }

//Force Rest to mem spells
ForceRest(oCreature);

//Give more treasure to be lvl appropriate
//rem this out cuz too much code is running and getting error
//CTG_GenerateNPCTreasure(TREASURE_TYPE_MONSTER, oCreature);

return iNewLevel;
}

//Setup Random Packages, note that Wizards won't get random packages
//so that specific wizard types can be used.  Example: Necromancer.
int GetPackage(int iClass)
{
int iPackage;
int iRandom;

iPackage = PACKAGE_INVALID;
switch (iClass)
    {
    case CLASS_TYPE_SORCERER:
        iRandom=Random(10)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_SORCERER; break;
            case 2: iPackage = PACKAGE_SORCERER_ABJURATION; break;
            case 3: iPackage = PACKAGE_SORCERER_CONJURATION; break;
            case 4: iPackage = PACKAGE_SORCERER_DIVINATION; break;
            case 5: iPackage = PACKAGE_SORCERER_DRAGONDISCIPLE; break;
            case 6: iPackage = PACKAGE_SORCERER_ENCHANTMENT; break;
            case 7: iPackage = PACKAGE_SORCERER_EVOCATION; break;
            case 8: iPackage = PACKAGE_SORCERER_ILLUSION; break;
            case 9: iPackage = PACKAGE_SORCERER_NECROMANCY; break;
            case 10: iPackage = PACKAGE_SORCERER_TRANSMUTATION; break;
            }
        break;
    case CLASS_TYPE_CLERIC:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_CLERIC; break;
            case 2: iPackage = PACKAGE_CLERIC_BATTLE_PRIEST; break;
            case 3: iPackage = PACKAGE_CLERIC_DEADWALKER; break;
            case 4: iPackage = PACKAGE_CLERIC_DIVINE; break;
            case 5: iPackage = PACKAGE_CLERIC_ELEMENTALIST; break;
            case 6: iPackage = PACKAGE_CLERIC_SHAMAN; break;
            }
        break;
    case CLASS_TYPE_DRUID:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_DRUID; break;
            case 2: iPackage = PACKAGE_DRUID_DEATH; break;
            case 3: iPackage = PACKAGE_DRUID_GRAY; break;
            case 4: iPackage = PACKAGE_DRUID_HAWKMASTER; break;
            case 5: iPackage = PACKAGE_DRUID_INTERLOPER; break;
            case 6: iPackage = PACKAGE_DRUID_SHIFTER; break;
            }
        break;
    case CLASS_TYPE_BARD:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_BARD; break;
            case 2: iPackage = PACKAGE_BARD_BLADE; break;
            case 3: iPackage = PACKAGE_BARD_GALLANT; break;
            case 4: iPackage = PACKAGE_BARD_HARPER; break;
            case 5: iPackage = PACKAGE_BARD_JESTER; break;
            case 6: iPackage = PACKAGE_BARD_LOREMASTER; break;
            }
        break;
    case CLASS_TYPE_BARBARIAN:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_BARBARIAN; break;
            case 2: iPackage = PACKAGE_BARBARIAN_BLACKGUARD; break;
            case 3: iPackage = PACKAGE_BARBARIAN_BRUTE; break;
            case 4: iPackage = PACKAGE_BARBARIAN_ORCBLOOD; break;
            case 5: iPackage = PACKAGE_BARBARIAN_SAVAGE; break;
            case 6: iPackage = PACKAGE_BARBARIAN_SLAYER; break;
            }
        break;
    case CLASS_TYPE_FIGHTER:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_FIGHTER; break;
            case 2: iPackage = PACKAGE_FIGHTER_COMMANDER; break;
            case 3: iPackage = PACKAGE_FIGHTER_FINESSE; break;
            case 4: iPackage = PACKAGE_FIGHTER_GLADIATOR; break;
            case 5: iPackage = PACKAGE_FIGHTER_PIRATE; break;
            case 6: iPackage = PACKAGE_FIGHTER_WEAPONMASTER; break;
            }
        break;
    case CLASS_TYPE_MONK:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_MONK; break;
            case 2: iPackage = PACKAGE_MONK_ASSASSIN; break;
            case 3: iPackage = PACKAGE_MONK_DEVOUT; break;
            case 4: iPackage = PACKAGE_MONK_GIFTED; break;
            case 5: iPackage = PACKAGE_MONK_PEASANT; break;
            case 6: iPackage = PACKAGE_MONK_SPIRIT; break;
            }
        break;
    case CLASS_TYPE_RANGER:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_RANGER; break;
            case 2: iPackage = PACKAGE_RANGER_ARCANEARCHER; break;
            case 3: iPackage = PACKAGE_RANGER_GIANTKILLER; break;
            case 4: iPackage = PACKAGE_RANGER_MARKSMAN; break;
            case 5: iPackage = PACKAGE_RANGER_STALKER; break;
            case 6: iPackage = PACKAGE_RANGER_WARDEN; break;
            }
        break;
    case CLASS_TYPE_ROGUE:
        iRandom=Random(6)+1;
        switch (iRandom)
            {
            case 1: iPackage = PACKAGE_ROGUE; break;
            case 2: iPackage = PACKAGE_ROGUE_BANDIT; break;
            case 3: iPackage = PACKAGE_ROGUE_GYPSY; break;
            case 4: iPackage = PACKAGE_ROGUE_SCOUT; break;
            case 5: iPackage = PACKAGE_ROGUE_SHADOWDANCER; break;
            case 6: iPackage = PACKAGE_ROGUE_SWASHBUCKLER; break;
            }
        break;
    }

return iPackage;
}


