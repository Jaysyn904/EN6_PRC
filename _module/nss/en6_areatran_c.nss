
void main()
{
object oClicker = GetClickingObject();
object oTarget = GetTransitionTarget(OBJECT_SELF);
object oArea;
object oNPC;

if (GetIsPC(oClicker))
{
oArea = GetArea(oClicker);
oNPC = GetFirstObjectInArea(oArea);
while (GetIsObjectValid(oNPC))
    {
    if (GetObjectType(oNPC) == OBJECT_TYPE_CREATURE)
        {
        if (GetIsInCombat(oNPC))
            DelayCommand(0.1f, AssignCommand(oNPC,ClearAllActions()));
        }
    oNPC = GetNextObjectInArea(oArea);
    }
}

SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
AssignCommand(oClicker,JumpToObject(oTarget));
}

