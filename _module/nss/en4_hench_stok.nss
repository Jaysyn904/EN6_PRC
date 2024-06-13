void main()
{
int iLevel;
string sToken;

iLevel = GetHitDice(GetPCSpeaker());
sToken = IntToString(iLevel * 250) + " gold";
SetCustomToken(999,sToken);
}
