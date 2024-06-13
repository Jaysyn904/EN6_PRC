#include "en5_misc"

void SetupAreaEncounters(object oArea=OBJECT_SELF);
void SetupEncounters(int iSpawnType, int iMinLevel, int iMaxLevel, int iIndoorsOutdoors=0);
void GetWanderingMonster(object oPC, int iDice=20);
string GetRandomMob();
string RandomColor();
string GetQuestTag(int iLevel);

string GetRandomMob()
{
int iCount;
int iRandom;
string sTag;

sTag = "en5_kobold";

iCount = GetLocalInt(GetModule(),"MOBS");
iRandom = Random(iCount)+1;
sTag = GetLocalString(GetModule(),"MOB" + IntToString(iRandom));

return sTag;
}

void GetWanderingMonster(object oPC, int iDice=20)
{
string sTag;
int iLevel;
int iSpots;
int iIndex;
int iFlag;
object oSpot;
string sMob;
object oMob;

if (Random(iDice)==0)
    {
    sTag = GetZone(GetArea(oPC)) + "_W_";
    iLevel = ZoneLevel(GetArea(oPC));
    iSpots = MaxObject(sTag);
    iIndex=1;
    sTag = sTag + IntToString(iIndex);
    oSpot = GetObjectByTag(sTag);
    while (GetIsObjectValid(oSpot) && iFlag==FALSE)
        {
        if (GetArea(oPC) == GetArea(oSpot))
            iFlag=TRUE;
        else
            {
            iIndex++;
            sTag = sTag + IntToString(iIndex);
            oSpot = GetObjectByTag(sTag);
            }
        }
    if (GetIsObjectValid(oSpot))
        {
        SetupAreaEncounters(GetArea(oPC));
        sMob=GetRandomMob();
        oMob=CreateObject(OBJECT_TYPE_CREATURE,sMob,GetLocation(oSpot));
        GetTreasureOnMob(oMob,GetHitDice(oMob),0);
        if (GetIsObjectValid(oMob))
            if (GetIsReactionTypeHostile(oPC,oMob))
                DelayCommand(1.0,AssignCommand(oMob,ActionAttack(oPC)));
            else
                DelayCommand(1.0,AssignCommand(oMob,ActionMoveToLocation(GetLocation(oPC))));
        }
    }


}

void SetupAreaEncounters(object oArea=OBJECT_SELF)
{
int iSpawnType;
int iMinLevel;
int iMaxLevel;
int iIndoorsOutdoors;
string sZone;

sZone=GetLocalString(oArea,"Zone");
iSpawnType=GetLocalInt(GetObjectByTag(sZone + "_INFO"),"SpawnType");
iMinLevel=GetLocalInt(oArea,"MinLevel");
iMaxLevel=GetLocalInt(oArea,"MaxLevel");
iMinLevel=GetMinLevel(sZone);
iMaxLevel=GetMaxLevel(sZone);
iIndoorsOutdoors=1;
if (GetIsAreaAboveGround(oArea) && !(GetIsAreaInterior(oArea)))
    iIndoorsOutdoors=0;

SetupEncounters(iSpawnType, iMinLevel, iMaxLevel, iIndoorsOutdoors);
}

void SetupEncounters(int iSpawnType, int iMinLevel, int iMaxLevel, int iIndoorsOutdoors=0)
{
int iIndex;
int iMaxMob;
int iCount;
int iIndoors;
int iOutdoors;
int iLevel;
string sCount;
string sTag;

iIndex=1;
iCount=0;
iMaxMob = 186;
while (iIndex <= iMaxMob)
    {
    iIndoors=0;
    iOutdoors=0;
    switch (iIndex)
        {
        case 1: sTag="en5_kobold"; iLevel=1; break;
        case 2: sTag="en5_skeleton"; iLevel=1; break;
        case 3: sTag="en5_zombie1"; iLevel=1; break;
        case 4: sTag="en5_stirge"; iLevel=1; break;
        case 5: sTag="en5_wererat"; iLevel=1; break;
        case 6: sTag="en5_orc"; iLevel=1; break;
        case 7: sTag="en5_goblin"; iLevel=1; break;
        case 8: sTag="en5_hobgoblin"; iLevel=1; break;
        case 9: sTag="en5_goblin"; iLevel=1; break;
        case 10: sTag="en5_hobgoblin"; iLevel=1; break;
        case 11: sTag="en5_rabiddog"; iLevel=1; iOutdoors=1; break;
        case 12: sTag="EN5_BEHOLDER"; iLevel=11; break;
        case 13: sTag="en5_wolf"; iLevel=1; iOutdoors=1; break;
        case 14: sTag="EN5_FENHOUND"; iLevel=4; iOutdoors=1; break;
        case 15: sTag="EN5_ETTERCAP"; iLevel=5; break;
        case 16: sTag="EN5_BEHOLDER3"; iLevel=3; break;
        case 17: sTag="EN5_HORROR"; iLevel=5; iIndoors=1; break;
        case 18: sTag="EN5_DEVOUR"; iLevel=7; iIndoors=1; break;
        case 19: sTag="EN5_MINDFLAYER1"; iLevel=9; break;
        case 20: sTag="en5_mindfdark"; iLevel=16; break;
        case 21: sTag="EN5_MINDFVEN"; iLevel=20; break;
        case 22: sTag="EN5_RUSTMONSTER"; iLevel=5; break;
        case 23: sTag="EN5_BEARBRWN"; iLevel=5; break;
        case 24: sTag="EN5_UMBERHULK"; iLevel=9; iIndoors=1; break;
        case 25: sTag="EN5_WILLOWISP"; iLevel=8; iOutdoors=1; break;
        case 26: sTag="EN5_BEARDIREBOSS"; iLevel=15; break;
        case 27: sTag="EN5_BEARBLCK"; iLevel=2; iOutdoors=1; break;
        case 28: sTag="EN5_BEARBRWN"; iLevel=5; iOutdoors=1; break;
        case 29: sTag="EN5_BEARDIRE"; iLevel=9; break;
        case 30: sTag="EN5_BEARKODIAK"; iLevel=6; iOutdoors=1; break;
        case 31: sTag="EN5_DIREWOLF"; iLevel=5; iOutdoors=1; break;
        case 32: sTag="EN5_WORG"; iLevel=3; iOutdoors=1; break;
        case 33: sTag="EN5_COUGAR"; iLevel=2; iOutdoors=1; break;
        case 34: sTag="EN5_DIRETIGER"; iLevel=11; iOutdoors=1; break;
        case 35: sTag="EN5_PANTHER"; iLevel=2; iOutdoors=1;  break;
        case 36: sTag="EN5_LION"; iLevel=3; iOutdoors=1; break;
        case 37: sTag="EN5_BEASTMALAR"; iLevel=7; break;
        case 38: sTag="en5_bulette"; iLevel=7; break;
        case 39: sTag="EN5_RATDIRE"; iLevel=1; break;
        case 40: sTag="EN5_OWLBEAR"; iLevel=3; break;
        case 41: sTag="EN5_GOLFLESH"; iLevel=8; break;
        case 42: sTag="en5_wolf"; iLevel=1; iOutdoors=1; break;
        case 43: sTag="en5_dragon_fair"; iLevel=5; iOutdoors=1; break;
        case 44: sTag="EN5_PSEUDOD"; iLevel=1; break;
        case 45: sTag="EN5_WYRMLING_" + RandomColor(); iLevel=4; break;
        case 46: sTag="en5_goldmflesh"; iLevel=25; break;
        case 47: sTag="en5_fbeetle"; iLevel=1; break;
        case 48: sTag="en5_hbeetle"; iLevel=13; break;
        case 49: sTag="en5_WOLFWINT"; iLevel=5; break;
        case 50: sTag="EN5_BELKER"; iLevel=6; break;
        case 51: sTag="EN5_OGRE01"; iLevel=3; break;
        case 52: sTag="EN5_TROLL"; iLevel=5; break;
        case 53: sTag="EN5_ETTIN"; iLevel=8; break;
        case 54: sTag="EN5_BUGBEARA"; iLevel=2; break;
        case 55: sTag="EN5_DRYAD"; iLevel=3; iOutdoors=1; break;
        case 56: sTag="EN5_NYMPH"; iLevel=1; iOutdoors=1; break;
        case 57: sTag="EN5_PIXIE"; iLevel=4; iOutdoors=1; break;
        case 58: sTag="EN5_SATYR"; iLevel=2; break;
        case 59: sTag="EN5_OLDWARB"; iLevel=2; break;
        case 60: sTag="en5_trog001"; iLevel=5; break;
        case 61: sTag="EN5_YUAN_TI001"; iLevel=5; break;
        case 62: sTag="EN5_MINOTAUR"; iLevel=4; break;
        case 63: sTag="EN5_OGRILLON"; iLevel=2; break;
        case 64: sTag="EN5_TROLLOCB"; iLevel=2; break;
        case 65: sTag="EN5_BTLSTINK"; iLevel=3; break;
        case 66: sTag="EN5_BTLSTAG"; iLevel=7; break;
        case 67: sTag="EN5_GANTFIRE"; iLevel=3; break;
        case 68: sTag="EN5_GIANTANTWORK"; iLevel=2; break;
        case 69: sTag="EN5_GWASP"; iLevel=3; break;
        case 70: sTag="EN5_BUGCLOUD"; iLevel=2; iOutdoors=1; break;
        case 71: sTag="EN5_SCORPG"; iLevel=3; break;
        case 72: sTag="EN5_SCORPG002"; iLevel=3; break;
        case 73: sTag="EN5_SPIDGIANT"; iLevel=3; break;
        case 74: sTag="EN5_SPIDDIRE"; iLevel=7; break;
        case 75: sTag="en5_gsnake"; iLevel=4; break;
        case 76: sTag="EN5_ANDROSPHINX"; iLevel=13; break;
        case 77: sTag="EN5_BASILISK"; iLevel=5; break;
        case 78: sTag="EN5_BLINKDOG"; iLevel=3; break;
        case 79: sTag="EN5_SPHINXGYNO"; iLevel=8; break;
        case 80: sTag="EN5_COCKATRICE"; iLevel=5; break;
        case 81: sTag="EN5_GARGOYLE"; iLevel=3; break;
        case 82: sTag="EN5_GORGON"; iLevel=7; break;
        case 83: sTag="EN5_KRENSHAR"; iLevel=2; break;
        case 84: sTag="EN5_MANTICORE"; iLevel=6; break;
        case 85: sTag="EN5_SPHINXHIER"; iLevel=7; break;
        case 86: sTag="EN5_GELCUBE"; iLevel=3; break;
        case 87: sTag="EN5_GRAYREND"; iLevel=8; break;
        case 88: sTag="EN5_HARPY001"; iLevel=5; break;
        case 89: sTag="en5_greenslime"; iLevel=4; break;
        case 90: sTag="en5_halfcel001"; iLevel=9; break;
        case 91: sTag="EN5_MEPMAGMA"; iLevel=3; break;
        case 92: sTag="EN5_MEPICE"; iLevel=3; break;
        case 93: sTag="EN5_PLANETARM"; iLevel=16; break;
        case 94: sTag="EN5_MARILITH"; iLevel=20; break;
        case 95: sTag="EN5_HALFFND001"; iLevel=8; break;
        case 96: sTag="EN5_MERILITH2"; iLevel=20; break;
        case 97: sTag="EN5_MARILITHBG"; iLevel=28; break;
        case 98: sTag="EN5_MYCONID"; iLevel=2; break;
        case 99: sTag="EN5_THORNY"; iLevel=3; break;
        case 100: sTag="EN5_TREANT"; iLevel=8; iOutdoors=1; break;
        case 101: sTag="EN5_VEGEPYGMY"; iLevel=1; iOutdoors=1; break;
        case 102: sTag="EN5_BARGHESTG"; iLevel=8; break;
        case 103: sTag="EN5_SKULKM"; iLevel=2; break;
        case 104: sTag="EN5_WEREWOLF"; iLevel=2; break;
        case 105: sTag="EN5_WERECAT"; iLevel=5; break;
        case 106: sTag="EN5_GHOUL"; iLevel=2; break;
        case 107: sTag="EN5_Bodak"; iLevel=9; break;
        case 108: sTag="EN5_WENDIGO"; iLevel=8; break;
        case 109: sTag="EN5_SHADOW"; iLevel=3; break;
        case 110: sTag="EN5_WIGHT"; iLevel=4; break;
        case 111: sTag="EN5_SKUNK"; iLevel=1; iOutdoors=1; break;
        case 112: sTag="EN5_DEER"; iLevel=1; iOutdoors=1; break;
        case 113: sTag="EN5_SCARECR"; iLevel=6; break;
        case 114: sTag="EN5_TWIGBLIGHT"; iLevel=1; break;
        case 115: sTag="en4_seahag"; iLevel=4; break;
        case 116: sTag="EN5_HALFDRASOR"; iLevel=9; break;
        case 117: sTag="EN5_HALFDRACLR"; iLevel=10; break;
        case 118: sTag="en4_adaemon"; iLevel=21; break;
        case 119: sTag="en4_daemon"; iLevel=18; break;
        case 120: sTag="EN5_SALANOB"; iLevel=11; break;
        case 121: sTag="EN5_SALAFLAMEBRO"; iLevel=3; break;
        case 122: sTag="EN5_SALA"; iLevel=6; break;
        case 123: sTag="EN5_ELDERXORN"; iLevel=11; break;
        case 124: sTag="en3_werelord"; iLevel=17; break;
        case 125: sTag="EN5_MOHRG"; iLevel=12; break;
        case 126: sTag="en4_Banshee"; iLevel=22; break;
        case 127: sTag="en4_orcusknight"; iLevel=33; break;
        case 128: sTag="en3_nosferatu"; iLevel=23; break;
        case 129: sTag="en3_shadowlord"; iLevel=39; break;
        case 130: sTag="EN5_BLACKROSEM"; iLevel=3; break;
        case 131: sTag="en4_kukriwar"; iLevel=19; break;
        case 132: sTag="en3_palemaster"; iLevel=30; break;
        case 133: sTag="en3_dragondisc"; iLevel=37; break;
        case 134: sTag="en3_wmaster"; iLevel=39; break;
        case 135: sTag="en3_fservent"; iLevel=17; break;
        case 136: sTag="en5_baelnorn"; iLevel=18; break;
        case 137: sTag="EN5_REVENANT"; iLevel=7; break;
        case 138: sTag="EN5_HALFDRAFTR"; iLevel=8; break;
        case 139: sTag="en5_phantom"; iLevel=16; break;
        case 140: sTag="en5_phantomwar"; iLevel=24; break;
        case 141: sTag="en5_phantombeast"; iLevel=28; break;
        case 142: sTag="en3_blackguard"; iLevel=33; break;
        case 143: sTag="en3_massassin"; iLevel=28; break;
        case 144: sTag="en3_darkagent"; iLevel=21; break;
        case 145: sTag="en3_ancientbear"; iLevel=24; break;
        case 146: sTag="en5_goldmflesh"; iLevel=27; break;
        case 147: sTag="EN5_GOLEM002"; iLevel=33; break;
        case 148: sTag="en4_FireBat"; iLevel=5; break;
        case 149: sTag="en4_AshRat"; iLevel=1; break;
        case 150: sTag="en4_ChaosRoc"; iLevel=22; break;
        case 151: sTag="en6_amummy"; iLevel=33; break;
        case 152: sTag="en4_alhoon"; iLevel=21; break;
        case 153: sTag="EN4_GHOULBOSS"; iLevel=10; break;
        case 154: sTag="en4_Effigy"; iLevel=21; break;
        case 155: sTag="en4_vminion"; iLevel=26; break;
        case 156: sTag="en3_unkempt20"; iLevel=21; break;
        case 157: sTag="EN6_WEMIC" + IntToString(Random(2)+1); iLevel=5; break;
        case 158: sTag="EN5_CYCLOPS"; iLevel=9; break;
        case 159: sTag="EN5_CYCLOPSA"; iLevel=9; break;
        case 160: sTag="en5_gnthill"; iLevel=10; break;
        case 161: sTag="EN5_GNTMOUNT"; iLevel=11; break;
        case 162: sTag="EN5_GNTFIRE"; iLevel=12; break;
        case 163: sTag="EN6_ICEGHOUL"; iLevel=3; break;

        case 164: sTag="EN6_BEHOLDER_DT"; iLevel=12; break;
        case 165: sTag="EN6_APE"; iLevel=3; break;
        case 166: sTag="EN6_GRIFFON"; iLevel=5; break;
        case 167: sTag="EN6_PURPLEWORM"; iLevel=9; break;
        case 168: sTag="EN6_RAZORBOAR"; iLevel=11; break;
        case 169: sTag="EN6_GOLEM_DAM2"; iLevel=15; break;
        case 170: sTag="EN6_GOLEM_DAM1"; iLevel=19; break;
        case 171: sTag="EN6_GOLEM_WEATH"; iLevel=23; break;
        case 172: sTag="EN6_GENIE_001"; iLevel=8; break;
        case 173: sTag="EN6_ELEMMAGMAL"; iLevel=11; break;

        case 174: sTag="EN6_ELEMICEM"; iLevel=6; break;
        case 175: sTag="EN6_ANNIS"; iLevel=6; break;
        case 176: sTag="EN6_GREENHAG"; iLevel=5; break;
        case 177: sTag="EN6_KENKU_002"; iLevel=2; break;
        case 178: sTag="EN6_KUOTOA_001"; iLevel=2; break;
        case 179: sTag="EN6_KUOTOA_002"; iLevel=4; break;
        case 180: sTag="EN6_MCENTI_001"; iLevel=2; break;
        case 181: sTag="EN6_CBASLSK_001"; iLevel=6; break;
        case 182: sTag="EN6_DRETCH"; iLevel=4; break;
        case 183: sTag="EN6_NIGHTHAG"; iLevel=8; break;

        case 184: sTag="EN6_WEREJAG_001"; iLevel=5; break;
        case 185: sTag="EN6_CJGUARD_001"; iLevel=12; break;
        case 186: sTag="EN6_REAVER_001"; iLevel=16; break;

        }

    if (iLevel>=iMinLevel && iLevel<=iMaxLevel)
        {
        if ((iIndoors == 0 && iOutdoors ==0) || (iIndoorsOutdoors == 0 && iOutdoors == 1) || (iIndoorsOutdoors == 1 && iIndoors == 1))
        iCount++;
        SetLocalString(GetModule(),"MOB" + IntToString(iCount),sTag);
        }
    iIndex++;
    }
SetLocalInt(GetModule(),"MOBS",iCount);
}

string GetQuestTag(int iLevel)
{
int iRandom;
string sTag;

sTag = "en5_kobold";

if (iLevel<3)
    {
    iRandom = Random(9)+1;
    switch (iRandom)
        {
        case 1: sTag = "en5_kobold"; break;
        case 2: sTag = "en5_orc"; break;
        case 3: sTag = "en5_goblin"; break;
        case 4: sTag = "en5_skeleton"; break;
        case 5: sTag = "en5_fbeetle"; break;
        case 6: sTag = "en5_rabiddog"; break;
        case 7: sTag = "en5_hobgoblin"; break;
        case 8: sTag = "en5_zombie1"; break;
        case 9: sTag = "en5_stirge"; break;
        }
    }
else if (iLevel<7)
    {
    iRandom = Random(7)+1;
    switch (iRandom)
        {
        case 1: sTag = "en5_ogre"; break;
        case 2: sTag = "EN5_WYRMLING_" + RandomColor(); break;
        case 3: sTag = "EN5_OWLBEAR"; break;
        case 4: sTag = "EN5_TROLL"; break;
        case 5: sTag = "EN5_YUAN_TI001"; break;
        case 6: sTag = "EN5_MINOTAUR"; break;
        case 7: sTag = "EN5_HARPY001"; break;
        }
    }
else if (iLevel<11)
    {
    iRandom = Random(9)+1;
    switch (iRandom)
        {
        case 1: sTag = "en5_bulette"; break;
        case 2: sTag = "EN5_GOLFLESH"; break;
        case 3: sTag = "EN5_BELKER"; break;
        case 4: sTag = "EN5_ETTIN"; break;
        case 5: sTag = "EN5_BTLSTAG"; break;
        case 6: sTag = "EN5_SPIDDIRE"; break;
        case 7: sTag = "EN5_REVENANT"; break;
        case 8: sTag = "EN4_GHOULBOSS"; break;
        case 9: sTag = "EN6_PURPLEWORM"; break;
        }
    }
else if (iLevel<16)
    {
    iRandom = Random(7)+1;
    switch (iRandom)
        {
        case 1: sTag = "EN5_BEHOLDER"; break;
        case 2: sTag = "en5_hbeetle"; break;
        case 3: sTag = "EN6_RAZORBOAR"; break;
        case 4: sTag = "EN6_ELEMMAGMAL"; break;
        case 5: sTag = "EN6_CJGUARD_001"; break;
        case 6: sTag = "EN6_SHGUARD_007"; break;
        case 7: sTag = "EN6_ABISHAIR_002"; break;
        }
    }
else if (iLevel<21)
    {
    iRandom = Random(5)+1;
    switch (iRandom)
        {
        case 1: sTag = "en4_daemon"; break;
        case 2: sTag = "en3_werelord"; break;
        case 3: sTag = "EN6_GOLEM_DAM1"; break;
        case 4: sTag = "EN6_NABASSU"; break;
        case 5: sTag = "EN6_REAVER_001"; break;
        }
    }
else if (iLevel<26)
    {
    iRandom = Random(4)+1;
    switch (iRandom)
        {
        case 1: sTag = "EN5_MERILITH2"; break;
        case 2: sTag = "en4_adaemon"; break;
        case 3: sTag = "EN6_GNTSTONE"; break;
        case 4: sTag = "EN6_GOLEM_WEATH"; break;
        }
    }
else
    {
    iRandom = Random(3)+1;
    switch (iRandom)
        {
        case 1: sTag = "en3_palemaster"; break;
        case 2: sTag = "en4_orcusknight"; break;
        case 3: sTag = "EN5_MARILITHBG"; break;
        }
    }

return sTag;
}

string RandomColor()
{
int iRandom;
string sTag;

sTag = "BLK";

iRandom=Random(5)+1;
switch (iRandom)
    {
    case 1: sTag="BLK"; break;
    case 2: sTag="BLU"; break;
    case 3: sTag="GRN"; break;
    case 4: sTag="RED"; break;
    case 5: sTag="WHT"; break;
    }
return sTag;
}
