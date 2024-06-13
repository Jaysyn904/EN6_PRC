#include "en5_misc"
#include "en6_mq6_include"

void main()
{
int iIndex;
object oHenchman;
object oPC;

oPC=GetPCLevellingUp();

iIndex=1;
while (iIndex<11)
    {
    oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,iIndex);
    if (GetIsObjectValid(oHenchman) && GetLocalInt(oHenchman,"Henchman") == 1)
        LevelHenchman(oHenchman,1);
    iIndex++;
    }
if (GetLocalInt(oPC,"MQ6_found")>0 && GetLocalInt(oPC,"MQ6ItemMade")>0)
    GetMQ6Powers(oPC);
}
