#include "en5_treasure"

void main()
{
object oMob;
int iAreaMaxLevel;
int iItemLevel;

oMob=OBJECT_SELF;
iAreaMaxLevel=GetMaxLevel(GetLocalString(GetArea(OBJECT_SELF),"Zone"));
iItemLevel=GetItemLevel(iAreaMaxLevel);

GetMagicItem(oMob,iItemLevel);
if (Random(5)==0)
    GetMagicItem(oMob,iItemLevel,1);
if (Random(5)==0)
    GetMagicItem(oMob,iItemLevel,2);
if (Random(50)==0)
    GetArtifact(oMob);
}
