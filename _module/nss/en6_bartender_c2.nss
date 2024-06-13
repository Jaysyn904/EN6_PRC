int GetNumberOfHenchman(object oPC);

int StartingConditional()
{
int iResult;
int iIndex;

iResult = FALSE;
if (GetNumberOfHenchman(GetPCSpeaker()) >= 3)
    iResult=TRUE;

return iResult;
}

int GetNumberOfHenchman(object oPC)
{
int iIndex;
int iCount;
object oHenchman;

iIndex=1;
iCount=0;
while (iIndex<11)
    {
    oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,iIndex);
    if (GetIsObjectValid(oHenchman))
        iCount++;
    iIndex++;
    }

return iCount;
}
