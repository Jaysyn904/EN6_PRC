#include "en5_treasure"

object GetLastOpener();
void GetScroll(object oChest,int iLevel);
void CreatePotion(object oTarget, int iItemLevel);
void CreateAmmo(object oTarget, int iItemLevel);
void CreateHealingKit(object oTarget, int iItemLevel);
void CreateTrapKit(object oTarget, int iItemLevel);
void CreateJewel(object oTarget, int iItemLevel);
void CreateGem(object oTarget, int iItemLevel);

void main()
{
int iRandom;
int iItemLevel;
int iLevel;
object oLastOpener;

if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
   return;
SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);

oLastOpener = GetLastOpener();

iLevel = GetHitDice(oLastOpener);
if (GetLocalInt(oLastOpener,"QuestLevel")>0)
    iLevel =GetLocalInt(oLastOpener,"QuestLevel");
iItemLevel=GetItemLevel(iLevel);

if (Random(2)==0)
    GetMagicItem(OBJECT_SELF,iItemLevel,1);
else
    GetMagicItem(OBJECT_SELF,iItemLevel,3);

int iArcane	= GetLevelByClass(CLASS_TYPE_WIZARD, oLastOpener)
			+ GetLevelByClass(CLASS_TYPE_SORCERER, oLastOpener)
			+ GetLevelByClass(CLASS_TYPE_DRAGONFIRE_ADEPT, oLastOpener)
			+ GetLevelByClass(CLASS_TYPE_DRAGON_SHAMAN, oLastOpener)			
			+ GetLevelByClass(CLASS_TYPE_DREAD_NECROMANCER, oLastOpener)
			+ GetLevelByClass(CLASS_TYPE_BEGUILER, oLastOpener)
			+ GetLevelByClass(CLASS_TYPE_SHADOWCASTER, oLastOpener)
			+ GetLevelByClass(CLASS_TYPE_WARMAGE, oLastOpener)
			+ GetLevelByClass(CLASS_TYPE_BINDER, oLastOpener)
			+ GetLevelByClass(CLASS_TYPE_TRUENAMER, oLastOpener)			
			+ GetLevelByClass(CLASS_TYPE_WARLOCK, oLastOpener);	
			
if (iArcane > 0)
    {
    if (Random(100)<10)
        GetScroll(OBJECT_SELF,iLevel);
    } else {
    if (Random(100)<5)
        GetScroll(OBJECT_SELF,iLevel);
    }

if (Random(100)<10)
    if (Random(2)==0)
        CreatePotion(OBJECT_SELF,iLevel);
    else
        CreateHealingKit(OBJECT_SELF,iLevel);
if (Random(100)<10)
    CreateAmmo(OBJECT_SELF,iLevel);
if (Random(100)<10)
    CreateTrapKit(OBJECT_SELF,iLevel);

if (Random(100)<10)
    if (Random(5)==0)
        {
        CreateGem(OBJECT_SELF,iItemLevel);
        CreateJewel(OBJECT_SELF,iItemLevel);
        } else {
        if (Random(3)==0)
            CreateGem(OBJECT_SELF,iItemLevel);
        else
            CreateJewel(OBJECT_SELF,iItemLevel);
        }

}

void GetScroll(object oChest,int iLevel)
{
string sRes;
int iScroll;
int iScrollLevel;
int iMaxScrollLevel;
object oItem;

iMaxScrollLevel =  iLevel/2+1;

//sRes = "nw_it_sparscr216";

while (!GetIsObjectValid(oItem))
    {
    iScrollLevel = Random(iMaxScrollLevel)+1;
    if (iScrollLevel > 9)
        iScrollLevel=9;

    iScroll = Random(21)+1;
    if (iScroll < 10)
        sRes = "NW_IT_SPARSCR" + IntToString(iScrollLevel) + "0" + IntToString(iScroll);
    else
        sRes = "NW_IT_SPARSCR" + IntToString(iScrollLevel) + IntToString(iScroll);
    oItem =CreateItemOnObject(sRes, oChest, 1);
    }

}

object GetLastOpener()
{
    if (GetIsObjectValid(GetLastOpenedBy()) == TRUE)
    {
        //dbSpeak("LastOpener: GetLastOpenedBy " + GetTag(GetLastOpenedBy()));
        return GetLastOpenedBy();
    }
    else
    if (GetIsObjectValid(GetLastKiller()) == TRUE)
    {
        //dbSpeak("LastOpener: GetLastAttacker");
        return GetLastKiller();
    }
    //dbSpeak("LastOpener: The Object is Invalid you weenie!");
    return OBJECT_INVALID;
}

void CreatePotion(object oTarget, int iItemLevel)
{
    string sPotion = "";

    if (iItemLevel==1)
    {
        int nRandom = d10();
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: sPotion = "nw_it_mpotion001"; break;
            case 5: case 6: case 7: sPotion = "nw_it_mpotion020";  break;
            case 8: sPotion = "nw_it_mpotion002";  break;
            case 9: sPotion = "nw_it_mpotion009";  break;
            case 10: sPotion = "nw_it_mpotion005";  break;
        }

    }
    else if (iItemLevel==2)
    {
       int nRandom = Random(29) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: sPotion = "nw_it_mpotion001"; break;
            case 4: case 5: case 6: case 7: case 8: sPotion = "nw_it_mpotion020";  break;
            case 9: case 10: case 11: case 12: sPotion = "nw_it_mpotion002";  break;
            case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
        }
    }
    else if (iItemLevel==3)
    {
       int nRandom = Random(29) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
            case 9: case 10: case 11: case 12:
            case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
        }
    }
    else if (iItemLevel==4)
    {
       int nRandom = Random(29) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
            case 9: case 10: case 11: case 12: sPotion = "nw_it_mpotion003"; break;
            case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
        }
    }
    else  // keep 5 and 6 the same
    {
       int nRandom = Random(29) + 1;
        switch (nRandom)
        {
            case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
            case 9: sPotion = "nw_it_mpotion003" ;
            case 10: case 11: case 12: case 13: case 14: sPotion = "nw_it_mpotion003";  break;
            case 15: sPotion = "nw_it_mpotion009";  break;
            case 16: sPotion = "nw_it_mpotion005";  break;
            case 17: sPotion = "nw_it_mpotion007";  break;
            case 18: sPotion = "nw_it_mpotion008";  break;
            case 19: sPotion = "nw_it_mpotion010";  break;
            case 20: sPotion = "nw_it_mpotion011";  break;
            case 21: sPotion = "nw_it_mpotion013";  break;
            case 22: sPotion = "nw_it_mpotion014";  break;
            case 23: sPotion = "nw_it_mpotion015";  break;
            case 24: sPotion = "nw_it_mpotion016";  break;
            case 25: sPotion = "nw_it_mpotion017";  break;
            case 26: sPotion = "nw_it_mpotion018";  break;
            case 27: sPotion = "nw_it_mpotion019";  break;
            case 28: sPotion = "nw_it_mpotion004";  break;
            case 29: sPotion = "nw_it_mpotion006";  break;
        }
    }
    CreateItemOnObject(sPotion, oTarget, 1);
}

void CreateAmmo(object oTarget, int iItemLevel)
{
    string sAmmo = "";

    if (iItemLevel==1)           // * 200 gp max
    {
        int nRandom = d3();
        switch (nRandom)
        {
            case 1: sAmmo = "nw_wamar001";  break;
            case 2: sAmmo = "nw_wambo001";  break;
            case 3: sAmmo = "nw_wambu001";  break;
        }
      }
    else if (iItemLevel==2)       // * 800 gp max
    {
        int nRandom = d6();
        switch (nRandom)
        {
            case 1: sAmmo = "nw_wamar001";  break;
            case 2: sAmmo = "nw_wambo001";  break;
            case 3: sAmmo = "nw_wambu001";  break;
            case 4: sAmmo = "nw_wammar001"; break;
            case 5: sAmmo = "nw_wammbo001"; break;
            case 6: sAmmo = "nw_wammbo002"; break;
        }
    }
    else if (iItemLevel==3)    // *  - 2500 gp
    {
        int nRandom = d20();
        switch (nRandom)
        {
            case 1: sAmmo = "nw_wamar001";   break;
            case 2: sAmmo = "nw_wambo001";   break;
            case 3: sAmmo = "nw_wambu001";   break;
            case 4: sAmmo = "nw_wammar001";  break;
            case 5: sAmmo = "nw_wammbo001";  break;
            case 6: sAmmo = "nw_wammbo002";   break;
            case 7: sAmmo = "nw_wammbo003";  break;
            case 8: sAmmo = "nw_wammbu002";  break;
            case 9: sAmmo = "nw_wammar002";  break;
            case 10: sAmmo = "nw_wammar001"; break;
            case 11: sAmmo = "nw_wammar003"; break;
            case 12: sAmmo = "nw_wammar004"; break;
            case 13: sAmmo = "nw_wammar005"; break;
            case 14: sAmmo = "nw_wammar006"; break;
            case 15: sAmmo = "nw_wammbo004";  break;
            case 16: sAmmo = "nw_wammbo005"; break;
            case 17: sAmmo = "nw_wammbu004"; break;
            case 18: sAmmo = "nw_wammbu005"; break;
            case 19: sAmmo = "nw_wammbu006"; break;
            case 20: sAmmo = "nw_wammbu007"; break;
        }
    }
    else
    {
        int nRandom = d20();
        switch (nRandom)
        {
            case 1: sAmmo = "nw_wamar001";      break;
            case 2: sAmmo = "nw_wammbu001";     break;
            case 3: sAmmo = "nw_wammbu003";     break;
            case 4: sAmmo = "nw_wammar001";     break;
            case 5: sAmmo = "nw_wammbo001";      break;
            case 6: sAmmo = "nw_wammbo002";     break;
            case 7: sAmmo = "nw_wammbo003";     break;
            case 8: sAmmo = "nw_wammbu002";     break;
            case 9: sAmmo = "nw_wammar002";     break;
            case 10: sAmmo = "nw_wammar001";    break;
            case 11: sAmmo = "nw_wammar003";    break;
            case 12: sAmmo = "nw_wammar004";     break;
            case 13: sAmmo = "nw_wammar005";    break;
            case 14: sAmmo = "nw_wammar006";    break;
            case 15: sAmmo = "nw_wammbo004";    break;
            case 16: sAmmo = "nw_wammbo005";    break;
            case 17: sAmmo = "nw_wammbu004";    break;
            case 18: sAmmo = "nw_wammbu005";    break;
            case 19: sAmmo = "nw_wammbu006";    break;
            case 20: sAmmo = "nw_wammbu007";    break;
        }
    }
    //dbSpeak("ammo");
    CreateItemOnObject(sAmmo, oTarget, Random(90) + 10); // create up to 30 of the specified ammo type
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

void CreateHealingKit(object oTarget, int iItemLevel)
{
    string sKit = "";
    if (iItemLevel==1)      // 200
    {
        int nRandom = Random(1) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit001";  break;
        }
    }
    else if (iItemLevel==2)  // 800
    {
        int nRandom = Random(2) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit001";  break;
            case 2: sKit = "nw_it_medkit002";  break;
        }

    }
    else if (iItemLevel==3)   // 200 - 2500
    {
        int nRandom = Random(2) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit002"; break;
            case 2: sKit = "nw_it_medkit003";  break;
        }

   }
    else if (iItemLevel==4)  // 800 - 10000
    {
        int nRandom = Random(2) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit003";break;
            case 2: sKit = "nw_it_medkit004"; break;
        }

    }
    else if (iItemLevel==5)  // 2000 -16500
    {
        int nRandom = Random(2) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit003"; break;
            case 2: sKit = "nw_it_medkit004";break;
        }

    }
    else if (iItemLevel==6)   // 2000 - ?
    {
        int nRandom = Random(2) + 1;
        switch (nRandom)
        {
            case 1: sKit = "nw_it_medkit003"; break;
            case 2: sKit = "nw_it_medkit004";break;
         }

    }
    //dbSpeak("Create Healing Kit");

    CreateItemOnObject(sKit, oTarget, 1);

}

void CreateGem(object oTarget, int iItemLevel)
{
    string sGem = "nw_it_gem001";
    if (iItemLevel==1)
    {
        int nRandom = Random(9) + 1;
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem001";  break;
            case 2: sGem = "nw_it_gem007";  break;
            case 3: sGem = "nw_it_gem002";  break;
            case 4: case 5: sGem = "nw_it_gem004"; break;
            case 6: case 7: sGem = "nw_it_gem014"; break;
            case 8: sGem = "nw_it_gem003";         break;
            case 9: sGem = "nw_it_gem015";         break;
        }
    }
    else if (iItemLevel==2)               // 30 GP Avg; 150 gp Max
    {
        int nRandom = d12();
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem001";         break;
            case 2: sGem = "nw_it_gem007";         break;
            case 3: sGem = "nw_it_gem002";         break;
            case 4: sGem = "nw_it_gem004";         break;
            case 5: case 6: sGem = "nw_it_gem014";  break;
            case 7: case 8: sGem = "nw_it_gem003";  break;
            case 9: case 10: sGem = "nw_it_gem015"; break;
            case 11: sGem = "nw_it_gem011";         break;
            case 12: sGem = "nw_it_gem013";         break;
        }

    }
    else if (iItemLevel==3)  // 75GP Avg; 500 gp max
    {
        int nRandom = d2();
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem013";         break;
            case 2: sGem = "nw_it_gem010";         break;
        }

    }
    else if (iItemLevel==4)  // 150 gp avg; 1000 gp max
    {
        int nRandom = d3();
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem013";  break;
            case 2: sGem = "nw_it_gem010";    break;
            case 3: sGem = "nw_it_gem008";           break;
        }
    }
    else if (iItemLevel==5)  // 300 gp avg; any
    {
        int nRandom = d6();
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem013";  break;
            case 2: sGem = "nw_it_gem010";    break;
            case 3: case 4: sGem = "nw_it_gem008";           break;
            case 5: sGem = "nw_it_gem009";           break;
            case 6: sGem = "nw_it_gem009";           break;
        }
    }
    else if (iItemLevel==6)// * Anything higher than level 15    500 gp avg; any
    {
        int nRandom = Random(8) + 1;
        switch (nRandom)
        {
            case 1: sGem = "nw_it_gem013";  break;
            case 2: sGem = "nw_it_gem010";    break;
            case 3: case 4: sGem = "nw_it_gem008";           break;
            case 5: sGem = "nw_it_gem009";           break;
            case 6: sGem = "nw_it_gem009";           break;
            case 7: sGem = "nw_it_gem006";           break;
            case 8: sGem = "nw_it_gem012";           break;
        }
    }
  //dbSpeak("Create Gem");
  CreateItemOnObject(sGem, oTarget, 1);
}
void CreateJewel(object oTarget, int iItemLevel)
{
    string sJewel = "";

    if (iItemLevel==1)        // 15 gp avg; 75 gp max
    {
      int nRandom = d2();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring021";   break;
        case 2: sJewel = "nw_it_mneck020";   break;
      }
    }
    else if (iItemLevel==2)   // 30 GP Avg; 150 gp Max
    {
      int nRandom = d6();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring021";            break;
        case 2: case 3: sJewel = "nw_it_mneck020";    break;
        case 4: sJewel = "nw_it_mring022";            break;
        case 5: case 6: sJewel = "nw_it_mneck023";            break;          }
    }
    else if (iItemLevel==3)  // 75GP Avg; 500 gp max
    {
      int nRandom = d6();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring021";           break;
        case 2: case 3: sJewel = "nw_it_mneck020";   break;
        case 4: case 5: sJewel = "nw_it_mring022";   break;
        case 6: sJewel = "nw_it_mneck021";           break;
      }
    }
    else if (iItemLevel==4)  // 150 gp avg; 1000 gp max
    {
      int nRandom = d6();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring021";            break;
        case 2: sJewel = "nw_it_mring022";            break;
        case 3: case 4: case 5: sJewel = "nw_it_mneck021";    break;
        case 6: sJewel = "nw_it_mring023";            break;
      }
    }
    else if (iItemLevel==5)  // 300 gp avg; any
    {
      int nRandom = d8();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring022";           break;
        case 2: case 3: sJewel = "nw_it_mneck021";   break;
        case 4: case 5: case 6: sJewel = "nw_it_mring023"; break;
        case 7: case 8: sJewel = "nw_it_mneck022";               break;
      }
    }
    else if (iItemLevel==6)
    {
      int nRandom = d6();
      switch (nRandom)
      {
        case 1: sJewel = "nw_it_mring022";              break;
        case 2: sJewel = "nw_it_mneck021";              break;
        case 3: case 4: sJewel = "nw_it_mring023";      break;
        case 5: case 6: sJewel = "nw_it_mneck022";      break;
      }
    }
  //dbSpeak("Create Jewel");

  CreateItemOnObject(sJewel, oTarget, 1);

}

