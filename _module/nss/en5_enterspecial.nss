void MovePC(object oPC,string sArea);
void SpawnOver(object oPC,object oWP);

void main()
{
object oPC;
object oWP;
string sArea;

oPC = GetEnteringObject();
if (GetIsPC(oPC))
    {
    sArea = GetLocalString(OBJECT_SELF,"Area");
    //SendMessageToPC(oPC,"Area=" + sArea);
    if (sArea == "")
        {
        oWP=GetObjectByTag(GetLocalString(GetArea(OBJECT_SELF),"Zone") + "_Default");
        if (GetIsObjectValid(oWP))
            {
            if (GetIsInCombat(oPC))
                SpawnOver(oPC,oWP);
            AssignCommand(oPC,JumpToLocation(GetLocation(oWP)));
            } else
            SendMessageToPC(oPC,"The area beyond is wild and upassable.");
        }
    else
        MovePC(oPC,sArea);
    }
}

void MovePC(object oPC,string sArea)
{
object oWP;

oWP = GetObjectByTag(sArea);
if (GetIsObjectValid(oWP))
    {
    if (GetIsInCombat(oPC))
        SpawnOver(oPC,oWP);
    AssignCommand(oPC,JumpToLocation(GetLocation(oWP)));
    } else {
    SendMessageToPC(oPC,"ERROR: Could Not Find " + sArea);
    }
}

void SpawnOver(object oPC,object oWP)
{
object oMob;

oMob = GetFirstObjectInArea(GetArea(OBJECT_SELF));
while (GetIsObjectValid(oMob))
    {
    if (GetObjectType(oMob) == OBJECT_TYPE_CREATURE && !GetIsPC(oMob))
        if (GetIsInCombat(oMob) && GetDistanceBetween(oPC,oMob) < 50.0f && (GetAttackTarget(oMob)==oPC || !GetIsObjectValid(GetAttackTarget(oMob))))
            if (GetDistanceBetween(oPC,oMob) < 10.0f)
                {
                DelayCommand(GetDistanceBetween(oPC,oMob)/9+1,AssignCommand(oMob,JumpToLocation(GetLocation(oWP))));
                DelayCommand(GetDistanceBetween(oPC,oMob)/9+1.5,AssignCommand(oMob,ActionAttack(oPC)));
                }
            else if (GetDistanceBetween(oPC,oMob) < 20.0f && Random(10)>0)
                {
                DelayCommand(GetDistanceBetween(oPC,oMob)/9+1,AssignCommand(oMob,JumpToLocation(GetLocation(oWP))));
                DelayCommand(GetDistanceBetween(oPC,oMob)/9+1.5,AssignCommand(oMob,ActionAttack(oPC)));
                }
            else if (GetDistanceBetween(oPC,oMob) < 30.0f && Random(10)>1)
                {
                DelayCommand(GetDistanceBetween(oPC,oMob)/9+1,AssignCommand(oMob,JumpToLocation(GetLocation(oWP))));
                DelayCommand(GetDistanceBetween(oPC,oMob)/9+1.5,AssignCommand(oMob,ActionAttack(oPC)));
                }
            else if (GetDistanceBetween(oPC,oMob) < 50.0f && Random(10)>2)
                {
                DelayCommand(GetDistanceBetween(oPC,oMob)/9+1,AssignCommand(oMob,JumpToLocation(GetLocation(oWP))));
                DelayCommand(GetDistanceBetween(oPC,oMob)/9+1.5,AssignCommand(oMob,ActionAttack(oPC)));
                }

    oMob = GetNextObjectInArea(GetArea(OBJECT_SELF));
    }
}
