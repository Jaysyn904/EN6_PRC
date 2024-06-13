void main()
{
int iQuestPoints;

iQuestPoints = GetLocalInt(GetPCSpeaker(),"QuestPoints");

SpeakString("You have " + IntToString(iQuestPoints) + " quest points available to spend.");
}
