#include "en6_mq6_include"

void main()
{
string sTag;
int iType;
object oItem;
string sName;
object oPC;
int iValue;

oPC=GetPCSpeaker();
sTag=GetLocalString(oPC,"QPTag");
iType=GetLocalInt(oPC,"MQ6ItemType");
oItem=GetItemPossessedBy(oPC,sTag);

sName=GetName(oItem);
if (iType<2)
    {
    if (GetStringLeft(sName,7) == "Special")
        sName=GetStringRight(sName,GetStringLength(sName)-8);
    }
sName = sName + " of Narsis";
SetName(oItem,sName);
SetLocalInt(oPC,"MQ6ItemMade",1);

if (GetGoodEvilValue(oPC) <35)
    iValue=1;
else if (GetGoodEvilValue(oPC) >65)
    iValue=2;
else
    iValue=3;

SetLocalInt(oPC,"MQ6Alignment",iValue);
SetLocalInt(oPC,"MQ6Alignment2",Random(2));

GetMQ6Powers(oPC);
}
