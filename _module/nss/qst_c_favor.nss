int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(GetPCSpeaker(),"MagicalFavor")>0)
    iResult=TRUE;
return iResult;
}
