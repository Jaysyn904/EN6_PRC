void main()
{
int iXP;

iXP = GetLocalInt(OBJECT_SELF,"QuestXP");
iXP=iXP+10000;
SetLocalInt(OBJECT_SELF,"QuestXP",iXP);
SendMessageToPC(GetPCSpeaker(),"Bumping the XP!");
}
