#include "prc_class_const"

void main()
{
	object oPC = GetFirstPC();
	
	int iRogue	= GetLevelByClass(CLASS_TYPE_ROGUE, oPC)
				+ GetLevelByClass(CLASS_TYPE_SCOUT, oPC)
				+ GetLevelByClass(CLASS_TYPE_BEGUILER, oPC)
				+ GetLevelByClass(CLASS_TYPE_NINJA, oPC)
				+ GetLevelByClass(CLASS_TYPE_FACTOTUM, oPC)
				+ GetLevelByClass(CLASS_TYPE_PSYCHIC_ROGUE, oPC);
			
if (GetLocalInt(OBJECT_SELF,"LockCheck")==0)
    {
    SetLocalInt(OBJECT_SELF,"LockCheck",1);
    object oDoor = GetFirstObjectInArea();
    while (GetIsObjectValid(oDoor))
        {
        if (GetTag(oDoor) == "LockedDoor")
            {
            //DelayCommand(0.1,SendMessageToPC(GetFirstPC(),"Found Locked Door!"));
            if (Random(12)>0 && iRogue == 0)
                {
                SetLocalInt(oDoor,"Unlocked",1);
                SetLocked(oDoor,FALSE);
                }

            if (Random(8)>0 && iRogue > 0)
                {
                SetLocalInt(oDoor,"Unlocked",1);
                SetLocked(oDoor,FALSE);
                }
            SetLocalInt(oDoor,"LockCheck",1);
            }
        oDoor = GetNextObjectInArea();
        }
    }

ExecuteScript("en5_ae",OBJECT_SELF);
}
