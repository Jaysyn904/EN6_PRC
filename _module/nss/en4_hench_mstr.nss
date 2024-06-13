int StartingConditional()
{
int iResult;

iResult = FALSE;
if (GetMaster() == GetPCSpeaker())
    iResult = TRUE;

return iResult;
}
