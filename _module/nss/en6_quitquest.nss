void main()
{
object oPC;
object oQuestNPC;
int iStep;
int iSteps;

oPC=GetPCSpeaker();
if (GetLocalString(oPC,"QuestNPC") != "")
    oQuestNPC=GetObjectByTag(GetLocalString(oPC,"QuestNPC"));
else
    oQuestNPC=OBJECT_SELF;

iStep=GetLocalInt(oQuestNPC,"QuestStep");
iStep--;
if (iStep<1)
    iStep==1;

SetLocalInt(oQuestNPC,"QuestSteps",iStep);
SetLocalInt(oQuestNPC,"QuestItemChance",-100);
SetLocalString(oQuestNPC,"QuestAccomplishment","");
}
