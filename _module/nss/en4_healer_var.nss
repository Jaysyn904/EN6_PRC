int StartingConditional()
{
object oPC;
int iLevel;
int iGold;
int iPCGold;
int iResult;

oPC = GetPCSpeaker();
iLevel = GetLocalInt(GetArea(OBJECT_SELF),"MinimumLevel");
iGold = 250;

SetCustomToken(200,IntToString(iGold));

iResult = FALSE;
return iResult;
}
