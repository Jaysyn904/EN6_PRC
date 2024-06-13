int StartingConditional()
{
int iResult;
int iRandom;

iResult = FALSE;

iRandom=GetLocalInt(OBJECT_SELF,"Random");
if (iRandom==0)
    {
    iRandom=Random(3)+1;
    SetLocalInt(OBJECT_SELF,"Random",iRandom);
    }

return iResult;
}
