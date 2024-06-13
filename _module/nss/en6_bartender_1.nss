void main()
{
object oPC;
int iHench;
string sText;

oPC=GetPCSpeaker();
iHench=GetLocalInt(oPC,"HenchmenBought");

if (iHench==0)
    {
    sText="I know of someone who is looking for work as we speak, and they come cheap, it will just be 10 gold coins to hire them, and a cut of the loot of course.";
    SetLocalInt(OBJECT_SELF,"Cost",10);
    }
else if (iHench==1)
    {
    sText="I know of someone who is looking for work, and they aren't too expensive, it will just be 1,000 gold coins to hire them, and a cut of the loot of course.";
    SetLocalInt(OBJECT_SELF,"Cost",1000);
    }
else if (iHench==2)
    {
    sText="I know of someone, but they aren't cheap, it will be 2,500 gold coins to hire them, and a cut of the loot of course.";
    SetLocalInt(OBJECT_SELF,"Cost",2500);
    }

else if (iHench>2)
    {
    sText="I know of someone, but they aren't cheap, it will be " + IntToString(3000 + (iHench-2) * 1000) + " gold coins to hire them, and a cut of the loot of course.";
    SetLocalInt(OBJECT_SELF,"Cost",3000 + (iHench-2) * 1000);
    }

SetCustomToken(100,sText);
}
