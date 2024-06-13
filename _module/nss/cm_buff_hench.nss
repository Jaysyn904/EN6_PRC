#include "cm_hench_include"

void main()
{
object oPC=GetModule();
object oPC1=GetPCSpeaker();
object oStar=OBJECT_SELF;
float oDelay = 120.0;
SetLocalInt(oStar, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oStar, "buffing", 0));
int i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,
    s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17;
i1=GetLocalInt(oPC, "aidtook");
i2=GetLocalInt(oPC, "bulltook");
i3=GetLocalInt(oPC, "speedtook");
i4=GetLocalInt(oPC, "cleartook");
i5=GetLocalInt(oPC, "barktook");
i6=GetLocalInt(oPC, "eagletook");
i7=GetLocalInt(oPC, "endtook");
i8=GetLocalInt(oPC, "cattook");
i9=GetLocalInt(oPC, "foxtook");
i10=GetLocalInt(oPC, "owltook");
i11=GetLocalInt(oPC, "irontook");
i12=GetLocalInt(oPC, "deathtook");
i13=GetLocalInt(oPC, "blesstook");
s1=GetLocalInt(oPC1, "aidswitch");
s2=GetLocalInt(oPC1, "bulswitch");
s3=GetLocalInt(oPC1, "speswitch");
s4=GetLocalInt(oPC1, "cleswitch");
s5=GetLocalInt(oPC1, "barswitch");
s6=GetLocalInt(oPC1, "eagswitch");
s7=GetLocalInt(oPC1, "endswitch");
s8=GetLocalInt(oPC1, "catswitch");
s9=GetLocalInt(oPC1, "foxswitch");
s10=GetLocalInt(oPC1, "owlswitch");
s11=GetLocalInt(oPC1, "iroswitch");
s12=GetLocalInt(oPC1, "deaswitch");
s13=GetLocalInt(oPC1, "blsswitch");

object oPot = GetItemPossessedBy(oStar, "NW_IT_MPOTION015"); //Bullstrength
object oPot1 = GetItemPossessedBy(oStar, "NW_IT_MPOTION004");//Speed
object oPot2 = GetItemPossessedBy(oStar, "NW_IT_MPOTION016");//Aid
object oPot3 = GetItemPossessedBy(oStar, "NW_IT_MPOTION005");//Barkskin
object oPot4 = GetItemPossessedBy(oStar, "NW_IT_MPOTION007");//Clarity
object oPot5 = GetItemPossessedBy(oStar, "NW_IT_MPOTION010");//Eagle's Splend
object oPot6 = GetItemPossessedBy(oStar, "NW_IT_MPOTION013");//Endurance
object oPot7 = GetItemPossessedBy(oStar, "NW_IT_MPOTION014");//Cat's Grace
object oPot8 = GetItemPossessedBy(oStar, "NW_IT_MPOTION017");// Fox's Cunning
object oPot9 = GetItemPossessedBy(oStar, "NW_IT_MPOTION018");// Owl's Wisdom
object oPot10 = GetItemPossessedBy(oStar, "X2_IT_MPOTION001");//Iron Guts
object oPot11 = GetItemPossessedBy(oStar, "NW_IT_MPOTION002");//Death Armor
object oPot12 = GetItemPossessedBy(oStar, "NW_IT_MPOTION009");//Bless

if ((oPot==OBJECT_INVALID)&&(oPot1==OBJECT_INVALID)
   &&(oPot2==OBJECT_INVALID)&&(oPot3==OBJECT_INVALID)
   &&(oPot4==OBJECT_INVALID)&&(oPot5==OBJECT_INVALID)
   &&(oPot7==OBJECT_INVALID)&&(oPot7==OBJECT_INVALID)
   &&(oPot8==OBJECT_INVALID)&&(oPot9==OBJECT_INVALID)
   &&(oPot10==OBJECT_INVALID)&&(oPot11==OBJECT_INVALID)
   &&(oPot12==OBJECT_INVALID))
   {
    ClearAllActions();
    ActionSpeakString("I don't have any buff potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
   else if ((i1!=1)||(i2!=1)||(i3!=1)||(i3!=1)||(i4!=1)||(i5!=1)||(i6!=1)
            ||(i7!=1)||(i8!=1)||(i9!=1)||(i10!=1)||(i11!=1)||(i12!=1)||(i13!=1))

     {
      if ((i1!=1)&&(s1==1)&&(oPot2!=OBJECT_INVALID))
     {
      TakeAid(OBJECT_SELF);
      SetLocalInt(oPC, "aidtook", 1);
      DelayCommand(oDelay, SetLocalInt(oPC, "aidtook", 0));
      return;
     }
      if ((i2!=1)&&(s2==1)&&(oPot!=OBJECT_INVALID))
     {
      TakeBull(OBJECT_SELF);
      SetLocalInt(oPC, "bulltook", 1);
      DelayCommand(oDelay, SetLocalInt(oPC, "bulltook", 0));
      return;
     }
     if ((i3!=1)&&(s3==1)&&(oPot1!=OBJECT_INVALID))
     {
      TakeSpeed(OBJECT_SELF);
      SetLocalInt(oPC, "speedtook", 1);
      DelayCommand(20.0, SetLocalInt(oPC, "speedtook", 0));
      return;
     }
     if ((i4!=1)&&(s4==1)&&(oPot4!=OBJECT_INVALID))
     {
      TakeClear(OBJECT_SELF);
      SetLocalInt(oPC, "cleartook", 1);
      DelayCommand(oDelay, SetLocalInt(oPC, "cleartook", 0));
      return;
     }
     if ((i5!=1)&&(s5==1)&&(oPot3!=OBJECT_INVALID))
      {
       TakeBark(OBJECT_SELF);
       SetLocalInt(oPC, "barktook", 1);
       DelayCommand(oDelay, SetLocalInt(oPC, "barktook", 0));
       return;
     }
     if ((i6!=1)&&(s6==1)&&(oPot5!=OBJECT_INVALID))
     {
      TakeEag(OBJECT_SELF);
      SetLocalInt(oPC, "eagletook", 1);
      DelayCommand(oDelay, SetLocalInt(oPC, "eagletook", 0));
      return;
     }
     if ((i7!=1)&&(s7==1)&&(oPot6!=OBJECT_INVALID))
     {
      TakeEnd(OBJECT_SELF);
      SetLocalInt(oPC, "endtook", 1);
      DelayCommand(oDelay, SetLocalInt(oPC, "endtook", 0));
      return;
     }
     if ((i8!=1)&&(s8==1)&&(oPot7!=OBJECT_INVALID))
     {
      TakeCat(OBJECT_SELF);
      SetLocalInt(oPC, "cattook", 1);
      DelayCommand(oDelay, SetLocalInt(oPC, "cattook", 0));
      return;
     }
     if ((i9!=1)&&(s9==1)&&(oPot8!=OBJECT_INVALID))
     {
      TakeFox(OBJECT_SELF);
      SetLocalInt(oPC, "foxtook", 1);
      DelayCommand(oDelay, SetLocalInt(oPC, "foxtook", 0));
      return;
     }
     if ((i10!=1)&&(s10==1)&&(oPot9!=OBJECT_INVALID))
     {
      TakeOwl(OBJECT_SELF);
      SetLocalInt(oPC, "owltook", 1);
      DelayCommand(oDelay, SetLocalInt(oPC, "owltook", 0));
      return;
     }
     if ((i11!=1)&&(s11==1)&&(oPot10!=OBJECT_INVALID))
     {
      TakeIron(OBJECT_SELF);
      SetLocalInt(oPC, "irontook", 1);
      DelayCommand(oDelay, SetLocalInt(oPC, "irontook", 0));
      return;
     }
     if ((i12!=1)&&(s12==1)&&(oPot11!=OBJECT_INVALID))
     {
      TakeDeath(OBJECT_SELF);
      SetLocalInt(oPC, "deathtook", 1);
      DelayCommand(oDelay, SetLocalInt(oPC, "deathtook", 0));
      return;
     }
     if ((i13!=1)&&(s13==1)&&(oPot12!=OBJECT_INVALID))
     {
      TakeBless(OBJECT_SELF);
      SetLocalInt(oPC, "blesstook", 1);
      DelayCommand(oDelay, SetLocalInt(oPC, "blesstook", 0));
      return;
     }
     if ((i3!=1)&&(s3==1)&&(oPot1==OBJECT_INVALID))
     {
      SendMessageToPC(oPC1, "Starbright is out of Speed potions.");
     }
     if ((i1!=1)&&(s1==1)&&(oPot2==OBJECT_INVALID))
     {
     SendMessageToPC(oPC1, "Starbright is out of Aid potions.");
     }
     if ((i2!=1)&&(s2==1)&&(oPot==OBJECT_INVALID))
     {
      SendMessageToPC(oPC1, "Starbright is out of Bull's Strength potions.");
     }
     if ((i4!=1)&&(s4==1)&&(oPot4==OBJECT_INVALID))
     {
      SendMessageToPC(oPC1, "Starbright is out of Clarity potions.");
     }
     if ((i5!=1)&&(s5==1)&&(oPot3==OBJECT_INVALID))
     {
     SendMessageToPC(oPC1, "Starbright is out of Barkskin potions.");
     }
     if ((i6!=1)&&(s6==1)&&(oPot5==OBJECT_INVALID))
     {
      SendMessageToPC(oPC1, "Starbright is out of Eagle's Splendour potions.");
     }
     if ((i7!=1)&&(s7==1)&&(oPot6==OBJECT_INVALID))
     {
     SendMessageToPC(oPC1, "Starbright is out of Endurance potions.");
     }
     if ((i8!=1)&&(s8==1)&&(oPot7==OBJECT_INVALID))
     {
      SendMessageToPC(oPC1, "Starbright is out of Cat's Grace potions.");
     }
     if ((i9!=1)&&(s9==1)&&(oPot8==OBJECT_INVALID))
     {
      SendMessageToPC(oPC1, "Starbright is out of Fox's Cunning potions.");
     }
      if ((i10!=1)&&(s10==1)&&(oPot9==OBJECT_INVALID))
     {
      SendMessageToPC(oPC1, "Starbright is out of Owl's Wisdom potions.");
     }
     if ((i11!=1)&&(s11==1)&&(oPot10==OBJECT_INVALID))
     {
      SendMessageToPC(oPC1, "Starbright is out of Ironguts potions.");
     }
     if ((i12!=1)&&(s12==1)&&(oPot11==OBJECT_INVALID))
     {
     SendMessageToPC(oPC1, "Starbright is out of Death Armor potions.");
     }
     if ((i13!=1)&&(s13==1)&&(oPot12==OBJECT_INVALID))
     {
      SendMessageToPC(oPC1, "Starbright is out of Bless potions.");
     }

     if ((s1!=1)&&(s2!=1)&&(s3!=1)&&(s3!=1)&&(s4!=1)&&(s5!=1)&&(s6!=1)
            &&(s7!=1)&&(s8!=1)&&(s9!=1)&&(s10!=1)&&(s11!=1)&&(s12!=1)&&(s13!=1))
     {

     ClearAllActions();
     ActionSpeakString("Please tell me which potions I should drink");
     ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
     return;
     }
     ClearAllActions();
     ActionSpeakString("I am ready for battle! Lets take em out!");
     ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2);
     }
     else if ((i1==1)&&(i2==1)&&(i3==1)&&(i3==1)&&(i4==1)&&(i5==1)&&(i6==1)
            &&(i7==1)&&(i8==1)&&(i9==1)&&(i10==1)&&(i11==1)&&(i12==1)&&(i13==1))

     {
     ClearAllActions();
     ActionSpeakString("I believe I'm fully buffed! Let's go!");
     ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1);
     }

}
