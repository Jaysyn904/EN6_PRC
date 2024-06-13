#include "qst_include"

void main()
{
string sDescription;
object oPC;

oPC=GetPCSpeaker();

if (GetLocalInt(oPC,"OnQuest") == 0)
    {
    if (GetLocalInt(oPC,"QuestStored") == 1)
        {
        SetPartyString(oPC,"QuestNPC",GetLocalString(oPC,"STORE_QuestNPC"));
        SetPartyString(oPC,"QuestName",GetLocalString(oPC,"STORE_QuestName"));
        SetPartyString(oPC,"QuestTarget",GetLocalString(oPC,"STORE_QuestTarget"));
        SetPartyInt(oPC,"QuestStored",0);
        //SetPartyVariables(oPC);
        sDescription=GetLocalString(oPC,"STORE_JournalDesc");
        SetPartyString(oPC,"QuestJournalDesc",sDescription);

        SetJournalEntry(oPC,sDescription);
        } else {
        SendMessageToPC(GetPCSpeaker(),"There is no quest stored.");
        }
    } else {
    SendMessageToPC(GetPCSpeaker(),"Cannot restore quest while you are on a quest.");
    }
}
