#include "en5_misc"

void main()
{
SetLocalInt(OBJECT_SELF,"Random",4);
AssignCommand(OBJECT_SELF,SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS));
AssignCommand(OBJECT_SELF,SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS));

}
