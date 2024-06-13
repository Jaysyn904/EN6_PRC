void main()
{
object oPC;
int iGold;
int iGoldNow;
int iGoldTake;

oPC = GetPCSpeaker();
ClearAllActions();
RemoveHenchman(oPC, OBJECT_SELF);
SetLocalString(oPC,"Henchman","");

iGold = GetLocalInt(oPC,"RestGold");
iGoldNow = GetGold(oPC);
SetLocalInt(oPC,"RestGold",iGoldNow);
if (iGoldNow>iGold)
    {
    iGoldTake = (iGoldNow-iGold)/10;
    if (iGoldTake>0)
        {
        SendMessageToPC(oPC,"Your henchman takes " + IntToString(iGoldTake) + " gold pieces as his share of the spoils.");
        //DelayCommand(0.1f,TakeGold(iGoldTake,oPC));
        DelayCommand(0.1f,AssignCommand(oPC,TakeGoldFromCreature(iGoldTake,oPC,TRUE)));
        }
    }


}
