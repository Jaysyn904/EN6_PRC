#include "cm_treat_include"

void TakeSpeed(object oUser)
{
object oPC=GetModule();
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
   }
}

 void TakeBless(object oUser)
{
object oPC=GetModule();
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
   }
}

void TakeClear(object oUser)
{
object oPC=GetModule();
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
   }

}


void TakeAid(object oUser)
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
   }
}



void TakeBull(object oUser)
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
   }
}

 void TakeBark(object oUser)
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
   }
}
void TakeEag(object oUser)
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
   }
}

void TakeFox(object oUser)
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
   }
}

void TakeOwl(object oUser)
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
   }
}

void TakeCat(object oUser)
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
   }
}

void TakeEnd(object oUser)
{

object oPot = GetItemPossessedBy(oUser, "NW_IT_MPOTION013");
SetLocalInt(oUser, "buffing", 1);
DelayCommand(3.0, SetLocalInt(oUser, "buffing", 0));
if (oPot!= OBJECT_INVALID)
   {
   int iStack = GetNumStackedItems(oPot);
   iStack--;
   DestroyObject(oPot, 0.0);
   if (iStack>0){DelayCommand(0.3, CreatePotion("nw_it_mpotion013", oUser, iStack));}
   ClearAllActions();
   ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
   ActionCastSpellAtObject(SPELL_ENDURANCE, oUser, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
   }
}

void TakeIron(object oUser)
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
   }
}
void TakeDeath(object oUser)
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
   }
}





//void main () {}

