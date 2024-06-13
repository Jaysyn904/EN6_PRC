void main()
{
object oQuestNPC;
string sString;

oQuestNPC=GetObjectByTag("dm_helper");

sString="I was wondering if you could help me";
SetLocalString(oQuestNPC,"QuestStep1Line1",sString);

sString="What do you need?";
SetLocalString(oQuestNPC,"QuestStep1Line1Response1",sString);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response1Goto",2);

sString="What's in it for me??";
SetLocalString(oQuestNPC,"QuestStep1Line1Response2",sString);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response2Goto",100);

sString="Not now I am busy.";
SetLocalString(oQuestNPC,"QuestStep1Line1Response3",sString);
SetLocalInt(oQuestNPC,"QuestStep1Line1Response3Goto",0);

sString="There are some goblins after me.";
SetLocalString(oQuestNPC,"QuestStep1Line2",sString);
SetLocalInt(oQuestNPC,"QuestStep1Line2Response1Goto",3);

sString="I was hoping you could go kill them for me.";
SetLocalString(oQuestNPC,"QuestStep1Line3",sString);

sString="Where are they located?";
SetLocalString(oQuestNPC,"QuestStep1Line3Response1",sString);
SetLocalInt(oQuestNPC,"QuestStep1Line3Response1Goto",4);

sString="I am busy right now.";
SetLocalString(oQuestNPC,"QuestStep1Line3Response2",sString);
SetLocalInt(oQuestNPC,"QuestStep1Line3Response2Goto",0);

sString="They are somewhere around here.";
SetLocalString(oQuestNPC,"QuestStep1Line4",sString);

sString="I will go kill them.";
SetLocalString(oQuestNPC,"QuestStep1Line4Response1",sString);
SetLocalInt(oQuestNPC,"QuestStep1Line4Response1Goto",0);
sString="I am busy right now.";
SetLocalString(oQuestNPC,"QuestStep1Line4Response2",sString);
SetLocalInt(oQuestNPC,"QuestStep1Line4Response2Goto",0);


sString="They are somewhere around here.";
SetLocalString(oQuestNPC,"QuestStep1Line4",sString);

sString="I don't have much to offer, but I can give you what I have for your aid.";
SetLocalString(oQuestNPC,"QuestStep1Line100",sString);

sString="That sounds good.";
SetLocalString(oQuestNPC,"QuestStep1Line100Response1",sString);
SetLocalInt(oQuestNPC,"QuestStep1Line100Response1Goto",2);
sString="I am busy right now.";
SetLocalString(oQuestNPC,"QuestStep1Line100Response2",sString);
SetLocalInt(oQuestNPC,"QuestStep1Line100Response2Goto",0);


}
