int StartingConditional()
{
int iResult;
object oPC;

oPC=GetPCSpeaker();
iResult = FALSE;

if (GetLocalInt(oPC,"FameLevel") > GetLocalInt(oPC,"FameUsed"))
    iResult=TRUE;

return iResult;
}
