#include "en5_rankings"

void main()
{
string sText;

sText = GetAllAccomplishments(GetPCSpeaker(),0);
SendMessageToPC(GetPCSpeaker(),sText);
}
