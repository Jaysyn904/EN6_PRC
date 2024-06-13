#include "prc_x2_itemprop"

void main()
{
object oItem=GetPCItemLastUnequippedBy();
object oPC=GetPCItemLastUnequipped();

ExecuteScript("x2_mod_def_unequ",OBJECT_SELF);


if (GetLocalString(oItem,"PCWielder") != "")
    {
    IPRemoveAllItemProperties(oItem,DURATION_TYPE_TEMPORARY);
    SetLocalString(oItem,"PCWielder","");
    }

}


