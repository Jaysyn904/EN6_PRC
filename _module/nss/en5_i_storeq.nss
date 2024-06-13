#include "qst_include"

void main()
{
//object oQuestNPC;
object oPC;

oPC=GetPCSpeaker();

if (GetLocalInt(oPC,"OnQuest") > 0)
    {
    if (GetLocalInt(oPC,"QuestStored") == 0)
        {
        SetLocalString(oPC,"STORE_QuestNPC",GetLocalString(oPC,"QuestNPC"));
        SetLocalString(oPC,"STORE_QuestName",GetLocalString(oPC,"QuestName"));
        SetLocalString(oPC,"STORE_QuestTarget",GetLocalString(oPC,"QuestTarget"));
        SetLocalString(oPC,"STORE_JournalDesc",GetLocalString(oPC,"QuestJournalDesc"));

        SetLocalInt(oPC,"QuestStored",1);
        SetPartyVariables(oPC);
        AddJournalQuestEntry("jQuest",20,oPC);
        } else {
        SendMessageToPC(GetPCSpeaker(),"Cannot store quest. There is already a quest stored.");
        }
    } else {
    SendMessageToPC(GetPCSpeaker(),"You are not on a quest.");
    }
}
