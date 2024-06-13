int StartingConditional()
{
int iResult;

iResult = FALSE;

if (GetLocalInt(GetPCSpeaker(),"MQ6_found")>0 && GetLocalInt(GetPCSpeaker(),"MQ6ItemMade")==0)
    iResult=TRUE;

return iResult;
}
