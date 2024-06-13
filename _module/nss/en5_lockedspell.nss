#include "en5_misc"

void main()
{
//GetError("SpellCaster = " + GetName(GetLastSpellCaster()) + " | Spell = " + IntToString(GetLastSpell()));

if (GetLastSpell() == SPELL_KNOCK)
    {
    SetLocalInt(OBJECT_SELF,"Unlocked",1);
    SetLocked(OBJECT_SELF,FALSE);
    }
}
