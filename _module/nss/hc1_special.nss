void GetWings(object oPC);
void GetTail(object oPC);
void GetPowers(object oPC,int iPower);

void main()
{
int iRandom;
object oPC;

oPC=GetEnteringObject();

if (!GetIsPC(oPC))
    return;

if (GetLocalInt(OBJECT_SELF,GetName(oPC)) != 0)
   return;
SetLocalInt(OBJECT_SELF,GetName(oPC),1);

iRandom=GetLocalInt(oPC,"HC1_SPECIAL");
if (iRandom==0)
    iRandom=Random(100);

if (GetCampaignInt("Endless Nights VI","GameMode") == 1)
    iRandom++;
if (GetLocalInt(oPC,"PCRacePower") > 0)
    iRandom=99;
if (GetLocalInt(oPC,"SpecialPowers") > 0 && iRandom<10)
    iRandom=98;

if (iRandom<1)
    GetPowers(oPC,3);
else if (iRandom<5)
    GetPowers(oPC,1);
else if (iRandom<10)
    GetPowers(oPC,2);
else if (iRandom==98)
    {
    if (GetLocalInt(oPC,"WeaponBonus") == 0)
        {
        SetLocalInt(oPC,"WeaponBonus",Random(4)+1);
        ExecuteScript("en6_special",oPC);
        SendMessageToPC(oPC,"You feel magic surge through you and flow out through your weapon.");
        }
    }
}

void GetPowers(object oPC,int iPower)
{
effect eVis;
int iRandom;

AssignCommand(oPC,ClearAllActions());

eVis = EffectVisualEffect(VFX_IMP_EVIL_HELP);
DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC,3.0));
eVis = EffectVisualEffect(246);
DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC,3.0));

if (iPower==1)
    {
    GetTail(oPC);
    SetLocalInt(oPC,"SpecialPowers",13);
    SendMessageToPC(oPC,"A strange magic rushes through you, and you feel your body changing.");
    }
if (iPower==2)
    {
    GetWings(oPC);
    SetLocalInt(oPC,"SpecialPowers",14);
    SendMessageToPC(oPC,"A strange magic rushes through you, and you feel your body changing.");
    }
if (iPower==3)
    {
    GetTail(oPC);
    GetWings(oPC);
    SetLocalInt(oPC,"SpecialPowers",12);
    SendMessageToPC(oPC,"A strange magic rushes through you, your body begins changing, and you feel an incredible surge of god-like power.");
    }

ExecuteScript("en6_special",oPC);
}


void GetTail(object oPC)
{
int iRandom;

iRandom=Random(3)+1;
switch (iRandom)
    {
    case 1: SetCreatureTailType(CREATURE_TAIL_TYPE_DEVIL,oPC); break;
    case 2: SetCreatureTailType(CREATURE_TAIL_TYPE_LIZARD,oPC); break;
    case 3: SetCreatureTailType(CREATURE_TAIL_TYPE_BONE,oPC); break;
    }
}

void GetWings(object oPC)
{
int iRandom;

iRandom=Random(6)+1;
switch (iRandom)
    {
    case 1: SetCreatureWingType(CREATURE_WING_TYPE_DEMON,oPC); break;
    case 2: SetCreatureWingType(CREATURE_WING_TYPE_ANGEL,oPC); break;
    case 3: SetCreatureWingType(CREATURE_WING_TYPE_BAT,oPC); break;
    case 4: SetCreatureWingType(CREATURE_WING_TYPE_DRAGON,oPC); break;
    case 5: SetCreatureWingType(CREATURE_WING_TYPE_BUTTERFLY,oPC); break;
    case 6: SetCreatureWingType(CREATURE_WING_TYPE_BIRD,oPC); break;
    }
}
