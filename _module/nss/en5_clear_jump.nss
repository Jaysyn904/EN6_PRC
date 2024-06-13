
void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  object oArea;
  object oNPC;

  SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);

  oArea = GetArea(oClicker);
  oNPC = GetFirstObjectInArea(oArea);
  while (GetIsObjectValid(oNPC))
    {
        if (GetObjectType(oNPC) == OBJECT_TYPE_CREATURE && !GetIsPC(oNPC))
            DelayCommand(0.1,AssignCommand(oNPC,ClearAllActions()));
        oNPC = GetNextObjectInArea(oArea);
    }

  AssignCommand(oClicker,JumpToObject(oTarget));
}
