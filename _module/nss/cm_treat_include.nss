// Check to see if afflicted

void CreatePotion(string ResRef, object oUser, int iStack)
{
 CreateItemOnObject(ResRef, oUser, iStack);
}

void CalcNegEff(object oUser)
{
      int eCount=0;
      effect eBad = GetFirstEffect(oUser);//Search for negative effects
      SetLocalInt(oUser, "badeffects", 0);
      while(GetIsEffectValid(eBad))
              {
               if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
                GetEffectType(eBad) == EFFECT_TYPE_POISON ||
                GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
                GetEffectType(eBad) == EFFECT_TYPE_SLOW )
                {
                  eCount=(eCount+1);
                }
             eBad = GetNextEffect(oUser);
           }
           SetLocalInt(oUser, "badeffects", eCount);
           return;
}

// if need restoration

void Restoration(object oUser)
{
int iStack;
object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION011");
object oScroll = GetItemPossessedBy(oUser, "NW_IT_SPDVSCR201");
object oScroll1 = GetItemPossessedBy(oUser, "NW_IT_SPDVSCR401");
object oScroll2 = GetItemPossessedBy(oUser, "NW_IT_SPDVSCR701");
if (oPot!= OBJECT_INVALID)
   {
   iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion0011", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_LESSER_RESTORATION,
   oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   if (oScroll!= OBJECT_INVALID)
   {
   iStack = GetNumStackedItems(oScroll);
   iStack--;
   DestroyObject(oScroll, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_spdvscr201", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
   AssignCommand(oUser, ActionCastSpellAtObject(SPELL_LESSER_RESTORATION, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
   return;
   }
else
   if (oScroll1!= OBJECT_INVALID)
   {
   iStack = GetNumStackedItems(oScroll1);
   iStack--;
   DestroyObject(oScroll, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_spdvscr401", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
   AssignCommand(oUser, ActionCastSpellAtObject(SPELL_RESTORATION, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
   return;
   }
else
    if (oScroll2!= OBJECT_INVALID)
   {
   iStack = GetNumStackedItems(oScroll2);
   iStack--;
   DestroyObject(oScroll, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_spdvscr701", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
   AssignCommand(oUser, ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I need any Restoration potion or scroll.");
   }
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
}




void Speedup(object oUser)
{
object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION004");
object oScroll = GetItemPossessedBy(oUser, "NW_IT_SPDVSCR701");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
      int iStack = GetNumStackedItems(oPot);
      iStack--;
      DestroyObject(oPot, 0.0);
      if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion004", oUser, iStack));}
      ClearAllActions();
      ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
      ActionCastSpellAtObject(SPELL_HASTE, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
      return;
    }
    else
if (oScroll!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oScroll);
   iStack--;
   DestroyObject(oScroll, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_spdvscr701", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
   AssignCommand(oUser, ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I need a Speed potion or a Greater Restoration scroll.");
   }
}



void Antidote(object oUser)
{
object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION006");
object oScroll = GetItemPossessedBy(oUser, "NW_IT_SPDVSCR701");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion006", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_NEUTRALIZE_POISON, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
 if (oScroll!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oScroll);
   iStack--;
   DestroyObject(oScroll, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_spdvscr701", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
   AssignCommand(oUser, ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I need an Antedote potion.");
   }
}



void GreaterRestoration(object oUser)
{

object oScroll = GetItemPossessedBy(oUser, "NW_IT_SPDVSCR701");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oScroll!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oScroll);
   iStack--;
   DestroyObject(oScroll, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_spdvscr701", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
   AssignCommand(oUser, ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I need a Greater Restoration Scroll .");
   }
}

void Invisibility(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION008");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));

if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion008", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_INVISIBILITY, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Invisibility potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

 void Clarity(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION007");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion007", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_CLARITY, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Clarity potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void LesserRest(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION011");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion011", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_LESSER_RESTORATION, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Lesser Restoration potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void Anti(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION006");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion006", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_NEUTRALIZE_POISON, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Antidote potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}



void Haste(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION004");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion004", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_HASTE, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Speed potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void Bullstrength(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION015");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion015", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_BULLS_STRENGTH, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Bull's Strength potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void Aid(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION016");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion016", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_AID, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Aid potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void Barkskin(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION005");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion005", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_BARKSKIN, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Barkskin potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void Bless (object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION009");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion009", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_BLESS, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Bless potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void Heal(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION012");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion012", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_HEAL, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Full Heal potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void DeathArmour (object oUser)
{

object oPot = GetItemPossessedBy(oUser, "X2_IT_MPOTION002");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("x2_it_mpotion002", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_DEATH_ARMOR, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Death Armour potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void IronGuts(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "X2_IT_MPOTION001");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("x2_it_mpotion001", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_IRONGUTS, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Ironguts potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void Dex(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION014");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion014", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_CATS_GRACE, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Cat's Grace potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void Char(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION010");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion010", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_EAGLE_SPLEDOR, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Eagle's Splendour potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void Int(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION017");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion017", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_FOXS_CUNNING, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Fox's Cunning potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void Wis(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION018");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion018", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_OWLS_WISDOM, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Owl's Wisdom potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void Con(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION018");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion018", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_ENDURANCE, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Endurance potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}


void CureLig(object oUser)
{
object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION001");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion001", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_CURE_LIGHT_WOUNDS, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Cure Light Wounds potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void CureMod(object oUser)
{
object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION020");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion020", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_CURE_MODERATE_WOUNDS, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Cure Moderate Wounds potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

 void CureSer(object oUser)
{
object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION002");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion002", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_CURE_SERIOUS_WOUNDS, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Cure Serious Wounds potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}

void CureCrit(object oUser)
{
object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION003");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion003", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_CURE_CRITICAL_WOUNDS, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   return;
   }
else
   {
    ClearAllActions();
    ActionSpeakString("I don't have any Cure Critical Wounds potions.");
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0f, 2.0f);
   }
}


void TreatSelf(object oStar)
{
 effect eBad=GetFirstEffect(oStar);
                 while(GetIsEffectValid(eBad))
                 {
                 if (GetEffectType(eBad) == EFFECT_TYPE_POISON ||
                     GetEffectType(eBad) == EFFECT_TYPE_DISEASE)
                    {
                    Antidote(oStar);
                    return;
                    }
                   eBad = GetNextEffect(oStar);
                 }
                 eBad=GetFirstEffect(oStar);
                 while(GetIsEffectValid(eBad))
                 {
                  if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                   GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                   GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                   GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                   GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                   GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                   GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                   GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE)
                   {
                   Restoration(oStar);
                   return;
                   }
                eBad = GetNextEffect(oStar);
               }
               eBad=GetFirstEffect(oStar);
                 while(GetIsEffectValid(eBad))
                 {
                  if (GetEffectType(eBad) == EFFECT_TYPE_SLOW &&
                      GetEffectType(eBad) != EFFECT_TYPE_HASTE)
                   {
                   Speedup(oStar);
                   return;
                   }
                   else
                   {
                    ClearAllActions();
                    ActionSpeakString("There's nothing wrong with me right now...");
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0f, 2.0f);
                    return;
                   }
                eBad = GetNextEffect(oStar);
               }
               eBad=GetFirstEffect(oStar);
                 while(GetIsEffectValid(eBad))
                 {
                  if (GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                  GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                  GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                  GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
                   {
                   GreaterRestoration(oStar);
                   return;
                   }
                eBad = GetNextEffect(oStar);
               }
         }
//void main() {}



