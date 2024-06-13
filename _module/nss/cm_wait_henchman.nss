

void main()
{
 object oPC=GetPCSpeaker();
 int iGold;
 int iGoldNow;
 int iGoldTake;
 ClearAllActions();
 RemoveHenchman(oPC, OBJECT_SELF);
 SetLocalString(oPC,"Henchman","");
 SetLocalInt(oPC, "leave1", 1);
 SetLocalInt(oPC, "back1", 0);
 SetLocalInt(oPC, "a_hired", 0);
 AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
 iGold = GetLocalInt(oPC,"RestGold");
 if (iGold==GetGold(oPC))
     {AssignCommand(OBJECT_SELF, ActionSpeakString("I'll be right here when you return"));}
 else
     {
      AssignCommand(OBJECT_SELF, ActionSpeakString("I'd best take what you owe me in case you don't make it back. I'll be here when you return."));
      iGoldNow = GetGold(oPC);
      SetLocalInt(oPC,"RestGold",iGoldNow);
      if (iGoldNow>iGold)
         {
          iGoldTake = (iGoldNow-iGold)/10;
          SetLocalInt(oPC, "hench_deposit", iGoldTake);
          if (iGoldTake>0)
             {
              SendMessageToPC(oPC,"Starbright takes " + IntToString(iGoldTake) + " gold pieces as her share of the spoils.");
              DelayCommand(0.1f,AssignCommand(oPC,TakeGoldFromCreature(iGoldTake,oPC,TRUE)));
             }
         }
      }
}






