int StartingConditional()
{
int iResult;
object oPC;

oPC=GetPCSpeaker();
iResult = FALSE;

if (GetLocalInt(oPC,"FameLevel") > 0 && GetLocalInt(oPC,"FameUsed") == 0)
    iResult=TRUE;

return iResult;
}
