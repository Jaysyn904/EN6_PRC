#include "en5_encounters"

void main()
{
int iIndex;
int iMaxCamp;

iIndex=0;
iMaxCamp=GetTotalCamps();

while (iIndex<=iMaxCamp)
    {
    GetQuestCamp(iIndex,1,1);
    iIndex++;
    }
}
