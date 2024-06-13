//:://////////////////////////////////////////////////
//:: X0_O2_SEC_DOOR2
//::    This is an OnEntered script for a generic trigger.
#include "x0_i0_secret"


void main()
{
object oEntered = GetEnteringObject();

if (GetIsSecretItemRevealed()) {return;}

RevealSecretItem("x0_sec_door2");

if (GetLocalInt(OBJECT_SELF,"DoOnce") > 0)
    return;

SendMessageToPC(oEntered,"You have discovered a secret treasure room");


SetLocalInt(OBJECT_SELF,"DoOnce",1);

}
