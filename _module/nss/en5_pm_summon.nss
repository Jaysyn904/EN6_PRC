void main()
{
talent tFeat;

if (GetHasFeat(FEAT_SUMMON_GREATER_UNDEAD))
//    tFeat = TalentFeat(FEAT_SUMMON_GREATER_UNDEAD);
{
ClearAllActions();
ActionUseFeat(FEAT_SUMMON_GREATER_UNDEAD,OBJECT_SELF);
}
else if (GetHasFeat(FEAT_SUMMON_UNDEAD))
    tFeat = TalentFeat(FEAT_SUMMON_UNDEAD);
else if (GetHasFeat(FEAT_ANIMATE_DEAD))
    tFeat = TalentFeat(FEAT_ANIMATE_DEAD);

SetLocalInt(OBJECT_SELF,"ANIMATE_DEAD",1);

ClearAllActions();
ActionUseTalentAtLocation(tFeat,GetLocation(OBJECT_SELF));

}
