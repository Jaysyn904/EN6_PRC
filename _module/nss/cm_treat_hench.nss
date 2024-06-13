#include "cm_treat_include"

void main()
{
SetLocalInt(OBJECT_SELF, "buffing", 1);
DelayCommand(3.5, SetLocalInt(OBJECT_SELF, "buffing", 0));
CalcNegEff(OBJECT_SELF);
int nInt = GetLocalInt(OBJECT_SELF, "badeffects");

if  (nInt==0)
    {
     ClearAllActions();
     ActionSpeakString("There's nothing wrong with me right now...");
     ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0f, 2.0f);
    }
    else
    {
     if (GetItemPossessedBy(OBJECT_SELF,"NW_IT_MPOTION001") != OBJECT_INVALID
     || GetItemPossessedBy(OBJECT_SELF,"NW_IT_MPOTION006") != OBJECT_INVALID
     || GetItemPossessedBy(OBJECT_SELF,"NW_IT_MPOTION011") != OBJECT_INVALID
     || GetItemPossessedBy(OBJECT_SELF,"NW_IT_MPOTION004") != OBJECT_INVALID
     || GetItemPossessedBy(OBJECT_SELF,"greaterrest") != OBJECT_INVALID)
        {
         TreatSelf(OBJECT_SELF);
        }
        else
        {
         ClearAllActions();
         ActionSpeakString("I don't have any cleansing potions...");
         ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
         }
     }

}


