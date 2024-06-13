void main()
{
object oPC;

oPC=GetPCSpeaker();
FadeToBlack(oPC);
DelayCommand(3.0,FadeFromBlack(oPC));
DelayCommand(3.1,SendMessageToPC(oPC,"You wait in the mage's guild until the item is ready.  Finally, it is brought out to you, and you can sense the power of it as soon as you touch it.  You also know it's power will increase as your own does."));
}
