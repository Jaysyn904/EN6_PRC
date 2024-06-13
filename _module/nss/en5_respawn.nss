#include "nw_i0_plot"


void main()
{
int iDeaths;
int iLives;

object oRespawner = GetLastRespawnButtonPresser();
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
RemoveEffects(oRespawner);

if (GetCampaignInt("Endless Nights VI","GameMode") == 1)
    {
    iLives=2 + GetHitDice(oRespawner)/10;
    iDeaths=GetLocalInt(oRespawner,"Deaths");
    if (iDeaths<iLives)
        {
        iDeaths++;
        SetLocalInt(oRespawner,"Deaths",iDeaths);
        SendMessageToPC(oRespawner,"You have " + IntToString(iLives-iDeaths) + " lives left.");
        string sDestTag =  "NH1_Town";
        object oSpawnPoint = GetObjectByTag(sDestTag);
        AssignCommand(oRespawner,JumpToLocation(GetLocation(oSpawnPoint)));
        SendMessageToPC(oRespawner,"You regain unconciousness and find yourself in Nirra Hamlett.");
        } else {
        string sDestTag =  "spawn_purgatory";
        object oSpawnPoint = GetObjectByTag(sDestTag);
        AssignCommand(oRespawner,JumpToLocation(GetLocation(oSpawnPoint)));
        }
    } else {

    if (GetLocalInt(oRespawner,"Debug")==0)
        {
        string sDestTag =  "spawn_purgatory";
        object oSpawnPoint = GetObjectByTag(sDestTag);
        AssignCommand(oRespawner,JumpToLocation(GetLocation(oSpawnPoint)));
        }

    }
}
