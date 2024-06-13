void main()
{
object oPC;
int iGold;
int iSelfish;
int iDifficulty;

oPC=GetPCSpeaker();
iDifficulty = 13 + GetLocalInt(GetArea(OBJECT_SELF),"MinLevel");

if (GetIsSkillSuccessful(oPC,SKILL_INTIMIDATE,iDifficulty))
    {
    iGold = GetLocalInt(OBJECT_SELF,"QuestGold");
    iGold = iGold * 3 / 2;
    SetLocalInt(OBJECT_SELF,"QuestGold",iGold);
    }

if (GetGoodEvilValue(oPC)>30)
    {
    iSelfish = GetLocalInt(oPC,"Selfish");
    iSelfish++;
    SetLocalInt(oPC,"Selfish",iSelfish);
    if (iSelfish % 5 == 0 && GetGoodEvilValue(oPC)>60)
        {
        AdjustAlignment(oPC,ALIGNMENT_GOOD,-1);
        }
    else if (iSelfish % 10 == 0)
        {
        AdjustAlignment(oPC,ALIGNMENT_EVIL,1);
        }
    }
}
