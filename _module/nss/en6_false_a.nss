#include "en5_rankings"

int StartingConditional()
{
int iResult;
string sAccomplishment;

sAccomplishment=GetMajorAccomplishment(GetPCSpeaker());
if (sAccomplishment == "")
    sAccomplishment = "did nothing special";

SetCustomToken(401,sAccomplishment);

iResult = FALSE;
return iResult;
}
