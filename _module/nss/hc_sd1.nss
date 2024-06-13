//:://////////////////////////////////////////////////
//:: X0_O2_SEC_DOOR2
//::    This is an OnEntered script for a generic trigger.
//::    When a PC enters the trigger area, it will perform
//::    a check to determine if the secret item is revealed,
//::    then make it appear if so.
//::
//::    Secret item to be revealed: Secret Stone Door
//::    Checking for: SKILL_SEARCH
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/08/2002
//:://////////////////////////////////////////////////

#include "x0_i0_secret"


void main()
{
int iRandom;
object oEntered = GetEnteringObject();

if (!GetIsPC(oEntered))
    return;

if (GetLocalInt(OBJECT_SELF,"DoOnce") > 0)
    return;

if (GetIsSecretItemRevealed()) {return;}

iRandom=GetLocalInt(oEntered,"HC1_SDOOR");
if (iRandom==0)
    iRandom=Random(10);

if (iRandom==1)
    RevealSecretItem("x0_sec_door2");

SetLocalInt(OBJECT_SELF,"DoOnce",1);

}
