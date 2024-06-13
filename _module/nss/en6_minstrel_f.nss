int StartingConditional()
{
int iResult;
string sMob;

sMob=GetLocalString(OBJECT_SELF,"Mob");
if (sMob == "")
    sMob = "strange creature";
SetCustomToken(100,sMob);

iResult = FALSE;
return iResult;
}
