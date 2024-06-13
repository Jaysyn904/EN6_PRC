#include "en5_misc"
#include "en5_treasure"

void SetupDynamicMerchant();

void main()
{

if (GetIsPC(GetEnteringObject()) && GetLocalInt(GetModule(),"DynamicMerchant") == 0)
    {
    SetupDynamicMerchant();
    SetLocalInt(GetModule(),"DynamicMerchant",1);
    }

}

void SetupDynamicMerchant()
{
object oMer;
//object oPC;
int iIndex;
int iRandom;

oMer = GetObjectByTag("en5_dmer1");
//oPC = GetFirstPC();

iIndex = 1;
iRandom=Random(7)+4;
while (iIndex <= iRandom)
    {
    GetMagicItem(oMer,Random(3)+1,0,GetRandomPC());
    iIndex++;
    }

iIndex = 1;
iRandom=Random(2)+2;
while (iIndex <= iRandom)
    {
    GetMagicItem(oMer,Random(3)+1,1,GetRandomPC());
    iIndex++;
    }

iIndex = 1;
iRandom=Random(2)+1;
while (iIndex <= iRandom)
    {
    GetMagicItem(oMer,Random(3)+1,2,GetRandomPC());
    iIndex++;
    }

iIndex = 1;
iRandom=Random(3);
while (iIndex <= iRandom)
    {
    GetMagicItem(oMer,Random(6)+1,0,GetRandomPC());
    iIndex++;
    }

iIndex=5;
while (iIndex <= 11)
    {
    if (Random(3)>0)
        GetRandomMagic(oMer,Random(3)+1,iIndex,GetRandomPC());
    else
        GetRandomMagic(oMer,Random(6)+1,iIndex,GetRandomPC());
    iIndex++;
    }
}

