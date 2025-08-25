#include "en5_treasure"
#include "x2_inc_switches"
#include "en5_w_a_check"
#include "en5_include"
#include "qst_main"
#include "prc_inc_racial"
#include "prc_class_const"
#include "utl_i_sqlocals"

void RemoveAllItems(object oPC);
void AddToDynamicMerchant(object oPC);
void CheckSpecialRace(object oPC);
void SetupCharacter(object oPC);
void SetupModule();
void SetupDynamicMerchant();
void SetupFence(int iFence);
void AddToFence(object oPC, int iFence);

void main()
{
	object oPC;
	int iDebug;
	int iPCs;

	oPC = GetEnteringObject();

	//iDebug=1;

	SQLocals_SetInt(GetModule(),"ClientEnter",1);
	DelayCommand(1.0f,SQLocals_SetInt(GetModule(),"ClientEnter",0));
	
	//:: Number PCs to tell distinct henchmen apart
	if (SQLocals_GetInt(oPC,"PlayerStart") == 0)
    {
		iPCs=SQLocals_GetInt(GetModule(),"PCs");
		iPCs++;
		SQLocals_SetInt(GetModule(),"PCs",iPCs);
		SQLocals_SetInt(oPC,"PCNumber",iPCs);
    }

	if (SQLocals_GetInt(oPC,"PlayerStart") == 0 && iDebug==0)
    {
		SetupCharacter(oPC);
    
		if (SQLocals_GetInt(oPC,"PCRacePower") == 0 || GetCampaignInt("Endless Nights VI","GameMode") == 1)
			SetLocalString(oPC,"Respawn","NH1_Spawn");
    
		else
        {
			SetLocalString(oPC,"Respawn","spawn_purgatory");
			SendMessageToPC(oPC,"PRC races with extra abilities/powers can only be used on Hack and Slash mode.  Use the Endless Nights Information item to set the game mode.");
        }
		
		if (SQLocals_GetInt(oPC,"PCRacePower") > 0)
			SQLocals_SetInt(oPC,"Deaths",1);
			SQLocals_SetInt(oPC,"PlayerStart",1);
	} 
	else 
	{
		if (SQLocals_GetInt(oPC,"PlayerStart") == 0 && iDebug==1)
        {
			SQLocals_SetInt(oPC,"Debug",1);
			//SetLocalString(oPC,"Respawn","NH1_Spawn");
			//SQLocals_SetInt(GetModule(),"MainQuest",2);
			//SetLocalString(oPC,"Respawn",GetOverallBossTag());
			SetLocalString(oPC,"Respawn","TST_START");
			//SetLocalString(oPC,"Respawn","MainQuest_F");

			CreateItemOnObject("en5_info",oPC);
        }
    }

	if (SQLocals_GetInt(GetModule(),"ModuleStart") == 0)
    {
		DelayCommand(0.1,SetupModule());
		SQLocals_SetInt(GetModule(),"ModuleStart",1);
    }
	
	AddJournalQuestEntry("JRNL_XPCHART", 1, oPC, FALSE, FALSE, FALSE);
    AddJournalQuestEntry("JRNL_LA_BUYOFF", 1, oPC, FALSE, FALSE, FALSE);
	AddJournalQuestEntry("JRNL_PRC8", 1, oPC, FALSE, FALSE, FALSE);
	
	ExecuteScript("0e_onclientload", oPC);
}

void SetSpecialVariables(object oPC)
{
	SQLocals_SetInt(oPC,"TM1_FOUNTAIN",Random(50));
	SQLocals_SetInt(oPC,"CC1_ALTER",Random(50));
	SQLocals_SetInt(oPC,"HC1_CHEST",Random(100));
	SQLocals_SetInt(oPC,"HC1_SPECIAL",Random(100));
	SQLocals_SetInt(oPC,"HC1_SDOOR",Random(10));
}

void SetupCharacter(object oPC)
{
	object oFaction;
	object oNPC;

	int iAnimal	= GetLevelByClass(CLASS_TYPE_DRUID, oPC)
				+ GetLevelByClass(CLASS_TYPE_FACTOTUM, oPC)
				+ GetLevelByClass(CLASS_TYPE_HEALER, oPC)
				+ GetLevelByClass(CLASS_TYPE_RANGER, oPC)
				+ GetLevelByClass(CLASS_TYPE_SOULBORN, oPC)
				+ GetLevelByClass(CLASS_TYPE_TOTEMIST, oPC);

	SetXP(oPC,0);
	RemoveAllItems(oPC);
	CreateItemOnObject("en5_info",oPC);

	//Delay this to make sure plenty of Random statements have been run cuz randomization in NWN is subpar
	DelayCommand(3.0,SetSpecialVariables(oPC));

	if (iAnimal > 0)
    {
		oFaction = GetObjectByTag("en6_animal");
		AdjustReputation(oPC,oFaction,50);
    }

	if (Random(50)==40)
    {
		if (GetIsObjectValid(GetObjectByTag("en6_inheret2")))
			oNPC = GetObjectByTag("en6_inheret2");
		else
        {
			oNPC = CreateObject(OBJECT_TYPE_CREATURE,"en6_inheret2",GetLocation(GetObjectByTag("NH1_Q_NPC1")));
			
			if (!GetIsObjectValid(oNPC))
				oNPC = CreateObject(OBJECT_TYPE_CREATURE,"en6_inheret2",GetLocation(GetObjectByTag("NH1_Town")));
        }
		
		SQLocals_SetInt(oNPC,GetName(oPC),1);
    }
}

void RemoveAllItems(object oPC)
{
	object oObject;
	string sTag;
	int iGold;

	int iRogue	= GetLevelByClass(CLASS_TYPE_ROGUE, oPC)
				+ GetLevelByClass(CLASS_TYPE_SCOUT, oPC)
				+ GetLevelByClass(CLASS_TYPE_NINJA, oPC)
				+ GetLevelByClass(CLASS_TYPE_FACTOTUM, oPC)
				+ GetLevelByClass(CLASS_TYPE_PSYCHIC_ROGUE, oPC);
				
	int iArcane	= GetLevelByClass(CLASS_TYPE_WIZARD, oPC)
				+ GetLevelByClass(CLASS_TYPE_SORCERER, oPC)
				+ GetLevelByClass(CLASS_TYPE_DRAGONFIRE_ADEPT, oPC)
				+ GetLevelByClass(CLASS_TYPE_DRAGON_SHAMAN, oPC)			
				+ GetLevelByClass(CLASS_TYPE_DREAD_NECROMANCER, oPC)
				+ GetLevelByClass(CLASS_TYPE_BEGUILER, oPC)
				+ GetLevelByClass(CLASS_TYPE_SHADOWCASTER, oPC)
				+ GetLevelByClass(CLASS_TYPE_WARMAGE, oPC)
				+ GetLevelByClass(CLASS_TYPE_BINDER, oPC)
				+ GetLevelByClass(CLASS_TYPE_TRUENAMER, oPC)			
				+ GetLevelByClass(CLASS_TYPE_WARLOCK, oPC);				

	int iMonk	= GetLevelByClass(CLASS_TYPE_MONK, oPC)
				+ GetLevelByClass(CLASS_TYPE_SOHEI, oPC)
				+ GetLevelByClass(CLASS_TYPE_SWORDSAGE, oPC)
				+ GetLevelByClass(CLASS_TYPE_PSION, oPC);
				
	oObject = GetFirstItemInInventory(oPC);

	while (GetIsObjectValid(oObject))
	{
		//DelayCommand(1.0,SendMessageToPC(oPC,"Destroyed " + GetName(oObject)));
		DestroyObject(oObject);
		oObject = GetNextItemInInventory(oPC);
	}

	oObject=GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
		DestroyObject(oObject);
	oObject=GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
		DestroyObject(oObject);

	if (iRogue > 0 || GetLevelByClass(CLASS_TYPE_RANGER,oPC)>0)
		oObject = CreateItemOnObject("en5_start_rogue",oPC);

	else if (iArcane > 0)
		oObject = CreateItemOnObject("en5_start_sorc",oPC);

	else if (iMonk > 0)
		oObject = CreateItemOnObject("en5_start_monk",oPC);

	else
		oObject = CreateItemOnObject("en5_start_chain",oPC);

	DelayCommand(0.1,AssignCommand(oPC,ActionEquipItem(oObject,INVENTORY_SLOT_CHEST)));

	GetWeaponType(oPC);
	sTag = "en3_" + GetWeaponTag(oPC);
	oObject = CreateItemOnObject(sTag,oPC);
	DelayCommand(0.1,AssignCommand(oPC,ActionEquipItem(oObject,INVENTORY_SLOT_RIGHTHAND)));

	if (sTag == "en3_hxbow" || sTag == "en3_lxbow")
		CreateItemOnObject("en3_bolt",oPC,99);
	if (sTag == "en3_longbow" || sTag == "en3_sbow")
		CreateItemOnObject("en3_arrow",oPC,99);
	if (sTag == "en3_sling")
		CreateItemOnObject("en3_bullet",oPC,99);

	CreateItemOnObject("en5_potionclw",oPC,3);

	iGold=GetGold(oPC);
	DelayCommand(0.1,AssignCommand(oPC,TakeGoldFromCreature(iGold,oPC,TRUE)));
	DelayCommand(0.2,GiveGoldToCreature(oPC,50));
	//if (GetGold(oPC)<50)
	//    DelayCommand(0.1,GiveGoldToCreature(oPC,200-GetGold(oPC)));
}

void AddToDynamicMerchant(object oPC)
{
	object oMer;
	int iIndex;

	oMer = GetObjectByTag("en5_dmer1");

	GetMagicItem(oMer,3,0,oPC);
	GetMagicItem(oMer,Random(2)+1,1,oPC);
	GetMagicItem(oMer,Random(2)+1,3,oPC);
	GetMagicItem(oMer,Random(2)+1,13,oPC);

	if (Random(4)==0)
		GetMagicItem(oMer,Random(2)+2,1,oPC);
	
	if (Random(4)==0)
		GetMagicItem(oMer,Random(2)+2,3,oPC);
}

void CheckSpecialRace(object oPC)
{
	int iMonstrous 	= 0;
	int iRacePower 	= 0;
	int iRace 		= GetRacialType(oPC);
	
	string sRace	= GetRace(oPC);

	//SendMessageToPC(oPC,"Race = " + sRace);
	//SendMessageToPC(oPC,"Sub-Race = " + GetSubRace(oPC));

	if 		(iRace == RACIAL_TYPE_AASIMAR) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_ABOM_YUAN) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_AIR_GEN) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_ARANEA) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_ARC_DWARF) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_ARKAMOI) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_ASHERATI) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_AVARIEL) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_AZER) {iRacePower = 3; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_AZURIN) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_BARIAUR) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_BHUKA) {iRacePower = 0; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_BLUE_GOBLIN) {iRacePower = 0; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_BRALANI) {iRacePower = 3; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_BROWNIE) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_BUGBEAR) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_BUOMMANS) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_CATFOLK) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_CENTAUR) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_CHANGELING) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_CHITINE) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_CRUCIAN) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_DEEP_GNOME) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_DEEP_HALFLING) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_DOPPELGANGER) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_DRIDER) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_DROMITE) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_DROW_FEMALE) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_DROW_MALE) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_DUERGAR) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_DUSKLING) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_EARTH_GEN) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_ELAN) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_EXTAMINAAR) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_FERAL_GARGUN) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_FEYRI) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_FIRE_GEN) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_FIREBLOOD_DWARF) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_FLIND) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_FOR_GNOME) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_FORESTLORD_ELF) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_FROST_FOLK) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_FROSTBLOOD_ORC) {iRacePower = 0; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_GHOSTWISE_HALFLING) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_GITHYANKI) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_GITHZERAI) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_GLIMMERSKIN_HALFING) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_GLOURA) {iRacePower = 3; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_GNOLL) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_GOBLIN) {iRacePower = 0; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_GOLD_DWARF) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_GOLIATH) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_GRAYORC) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_HADOZEE) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_HADRIMOI) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_HAGSPAWN) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_HALFDROW) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_HALFOGRE) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_HOBGOBLIN) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_HOUND_ARCHON) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_HYBSIL) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_ILLITHID) {iRacePower = 3; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_IMASKARI) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_KALASHTAR) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_KARSITE) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_KHAASTA) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_KILLOREN) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_KOBOLD) {iRacePower = 0; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_KRINTH) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_LASHEMOI) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_LIZARDFOLK) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_MAENADS) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_MARRULURK) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_MARRUSAULT) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_MARRUTACT) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_MEPHLING_AIR) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_MEPHLING_EARTH) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_MEPHLING_FIRE) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_MEPHLING_WATER) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_MINOTAUR) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_MONGRELFOLK) {iRacePower = 0; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_MUCKDWELLER) {iRacePower = 0; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_NATHRI) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_NAZTHARUNE_RAKSHASA) {iRacePower = 3; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_NEANDERTHAL) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_NERAPHIM) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_OGRE) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_ORC) {iRacePower = 0; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_OROG) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_PH_HALFGIANT) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_PIXIE) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_POISON_DUSK) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_PURE_YUAN) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_RAKSHASA) {iRacePower = 3; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_REDSPAWN_ARCANISS) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_RETH_DEKALA) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_RILKAN) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_ROCK_GNOME) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_SHADOWSWYFT) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_SHARAKIM) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_SHIFTER) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_SILVERBROW_HUMAN) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_SKARN) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_SKULK) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_SNOW_ELF) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_SPIKER) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_SPIRETOPDRAGON) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_SPIRIT_FOLK) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_STONECHILD) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_STONEHUNTER_GNOME) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_STRONGHEART_HALFLING) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_SUN_ELF) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_SUNSCORCH_HOBGOBLIN) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_TAER) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_TALLFELLOW_HALFLING) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_TANARUKK) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_TASLOI) {iRacePower = 0; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_TIEFLING) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_TROGLODYTE) {iRacePower = 0; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_TROLL) {iRacePower = 3; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_TUNDRA_HALFLING) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_TURLEMOI) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_ULDRA) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_UNDERFOLK) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_URDINNIR) {iRacePower = 1; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_VARAG) {iRacePower = 2; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_VILETOOTH_LIZARDFOLK) {iRacePower = 1; iMonstrous = 1;}
	else if (iRace == RACIAL_TYPE_VOLODNI) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_WARFORGED) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_WARFORGED_CHARGER) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_WATER_GEN) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_WEMIC) {iRacePower = 3; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_WHISPER_GNOME) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_WILD_DWARF) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_WILD_ELF) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_WILDREN) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_WOOD_ELF) {iRacePower = 0; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_XEPH) {iRacePower = 2; iMonstrous = 0;}
	else if (iRace == RACIAL_TYPE_ZAKYA_RAKSHASA) {iRacePower = 3; iMonstrous = 0;}

	if (iRacePower > 0)
    {
		SQLocals_SetInt(oPC,"PCRacePower",iRacePower);
		SQLocals_SetInt(oPC,"PCLevelMod",iRacePower);
    }
}

void SetupModule()
{
	string sTag;
	int iRandom;

	SQLocals_SetInt(GetModule(),"ModuleStart",1);
	SetMaxHenchmen(10);

	SetModuleSwitch(MODULE_SWITCH_ENABLE_UMD_SCROLLS,TRUE);
	SetModuleSwitch(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS,TRUE);
	SetModuleSwitch(MODULE_SWITCH_ENABLE_CROSSAREA_WALKWAYPOINTS,TRUE);
	SetModuleSwitch(MODULE_SWITCH_ENABLE_BEBILITH_RUIN_ARMOR,TRUE);
	
/* 	SQLocals_SetInt(GetModule(),"PRC_165_DEATH_IMMUNITY",TRUE);  <-- All handled w/ personal_switch.2da
	SQLocals_SetInt(GetModule(),"PRC_PNP_TRUESEEING",TRUE);
	SQLocals_SetInt(GetModule(),"PRC_TIMESTOP_LOCAL",TRUE);
	SQLocals_SetInt(GetModule(),"PRC_PNP_FEAR_AURAS",TRUE);
	SQLocals_SetInt(GetModule(),"PRC_PNP_ANIMATE_DEAD",TRUE);
	SQLocals_SetInt(GetModule(),"PRC_CREATE_UNDEAD_PERMANENT",TRUE);
	SQLocals_SetInt(GetModule(),"PRC_USE_NEW_IMBUE_ARROW",TRUE);
	SQLocals_SetInt(GetModule(),"PRC_STAFF_CASTER_LEVEL",TRUE);

	SQLocals_SetInt(GetModule(),"PRC_PNP_ABILITY_DAMAGE_EFFECTS",TRUE);
	SQLocals_SetInt(GetModule(),"PRC_PNP_ELEMENTAL_SWARM",TRUE);
	SQLocals_SetInt(GetModule(),"PRC_MULTISUMMON",TRUE);
	SQLocals_SetInt(GetModule(),"PRC_USE_BIOWARE_DATABASE",1500); */

	SetLocalString(GetModule(),"EN6_QST_DB","EN6_QST");
	WriteTimestampedLogEntry("*** Endless Night VI Loaded ***");

	string sCampaign = "Endless Nights VI";
	if (GetCampaignInt(sCampaign,"GameMode") == 1)
	{
		SQLocals_SetInt(GetModule(),"GameMode",1);
		DelayCommand(2.0,SendMessageToPC(GetFirstPC(),"Game is set for Hack and Slash mode."));
	}
	else
	{
		iRandom=Random(100);

		if (iRandom<1)
			SQLocals_SetInt(GetModule(),"MagicLevel",3);
		else if (iRandom<3)
			SQLocals_SetInt(GetModule(),"MagicLevel",2);
		else if (iRandom<10)
			SQLocals_SetInt(GetModule(),"MagicLevel",1);
		else
			SQLocals_SetInt(GetModule(),"MagicLevel",0);
	}

	SetupMainQuest();
	//DelayCommand(1.0,SetupDynamicMerchant());
}

void SetupDynamicMerchant()
{
	object oMer;
	object oPC;
	int iIndex;

	oMer = GetObjectByTag("en5_dmer1");
	oPC = GetFirstPC();

	iIndex = 1;
	while (iIndex < 7)
	{
		GetMagicItem(oMer,1,0,oPC);
		iIndex++;
	}

	iIndex = 1;
	while (iIndex < 5)
	{
		GetMagicItem(oMer,2,0,oPC);
		iIndex++;
	}

	iIndex = 1;
	while (iIndex < 3)
	{
		GetMagicItem(oMer,3,0,oPC);
		iIndex++;
	}

	GetMagicItem(oMer,4,0,oPC);

	SetupFence(1);
	SetupFence(2);
	SetupFence(3);
}

void SetupFence(int iFence)
{
	object oMer;
	object oPC;
	string sTag;
	int iIndex;

	sTag = "en6_fence" + IntToString(iFence);

	oPC = GetFirstPC();
	oMer = GetObjectByTag(sTag);

	iIndex = 1;
	while (iIndex < 11)
    {
		GetMagicItem(oMer,Random(6)+1,0,oPC);
		iIndex++;
    }
}

void AddToFence(object oPC, int iFence)
{
	object oMer;
	object oPC;
	string sTag;
	int iIndex;

	sTag = "en6_fence" + IntToString(iFence);

	oMer = GetObjectByTag(sTag);

	iIndex = 1;
	while (iIndex < 3)
	{
		GetMagicItem(oMer,Random(6)+1,1,oPC);
		iIndex++;
	}

	iIndex = 1;
	while (iIndex < 3)
	{
		GetMagicItem(oMer,Random(6)+1,2,oPC);
		iIndex++;
	}
}