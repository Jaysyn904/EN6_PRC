#include "qst_include"
#include "nw_i0_tool"

void main()
{
object oPC;
object oQuestNPC;
int iStep;
string sQS;
string sItem;

oPC=GetPCSpeaker();

oQuestNPC=GetObjectByTag(GetLocalString(oPC,"QuestNPC"));

if (GetLocalInt(oQuestNPC,"MainQuestNPC") == 0)
    {
    SetLocalInt(oQuestNPC,"QuestComplete",1);
    SetPartyInt(oPC,"OnQuest",0);
    AddJournalQuestEntry("jQuest",21,oPC);
    SetLocalInt(oQuestNPC,"QuestLine",0);
    SetLocalInt(oQuestNPC,"QuestStep",1);
    SetLocalInt(oQuestNPC,"QuestLineStart",100);
    iStep=GetLocalInt(oQuestNPC,"QuestStep");
    sQS="QuestStep" + IntToString(iStep);
    sItem=GetLocalString(oQuestNPC,sQS + "Item");

    if (sItem != "")
        {
        if (HasItem(oPC,sItem))
            {
            object oItemToTake = GetItemPossessedBy(oPC, sItem);
            if(GetIsObjectValid(oItemToTake) != 0)
                DestroyObject(oItemToTake);
            }
        }
    } else {
    SendMessageToPC(oPC,"You are not allowed to remove main storyline quests.");
    }
SetPartyVariables(oPC);

}

