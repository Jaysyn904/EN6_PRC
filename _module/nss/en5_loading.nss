#include "en5_treasure"

void main()
{
object oPC;
object oSpawnPoint;
string sDestTag;

oPC = GetEnteringObject();

if (GetIsPC(oPC))
    {
    sDestTag = GetLocalString(oPC,"Respawn");
    oSpawnPoint = GetObjectByTag(sDestTag);
    AssignCommand(oPC,JumpToLocation(GetLocation(oSpawnPoint)));
    }
}


