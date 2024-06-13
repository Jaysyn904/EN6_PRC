int StartingConditional()
{
int iResult;

iResult = TRUE;
if (GetLocalInt(GetPCSpeaker(),"Quest")>99)
    iResult=FALSE;
return iResult;
}
