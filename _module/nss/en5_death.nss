void GetKiller();
void GetDeathMenu(object oPlayer);
void GetDeathMenu2(object oPC);

void main()
{
int iIndex;
int iFlag;
int iRaise;
object oHenchman;

object oPlayer = GetLastPlayerDied();

AssignCommand(oPlayer,GetKiller());
AssignCommand(oPlayer, ClearAllActions());

if (GetCampaignInt("Endless Nights VI","GameMode") == 1)
    {
    PopUpDeathGUIPanel(oPlayer,TRUE, TRUE,0,"Death has taken you.");
    return;
    }

iIndex=1;
iRaise=0;
iFlag=FALSE;

oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPlayer,iIndex);
while (GetIsObjectValid(oHenchman) && iFlag==FALSE)
    {
    if (GetLocalInt(oHenchman,"RESURRECTION") ==0 && GetLevelByClass(CLASS_TYPE_CLERIC,oHenchman)>12)
        {
        iFlag=TRUE;
        AssignCommand(oHenchman,ClearAllActions());
        AssignCommand(oHenchman,ActionCastSpellAtObject(SPELL_RESURRECTION,oPlayer,METAMAGIC_ANY,TRUE));
        SetLocalInt(oHenchman,"RESURRECTION",1);
        }
    iIndex++;
    oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPlayer,iIndex);
    }

iIndex=1;
oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPlayer,iIndex);
while (GetIsObjectValid(oHenchman) && iFlag==FALSE)
    {
    if (GetLocalInt(oHenchman,"RAISE_DEAD") ==0 && GetLevelByClass(CLASS_TYPE_CLERIC,oHenchman)>8)
        {
        iFlag=TRUE;
        iRaise=1;
        AssignCommand(oHenchman,ClearAllActions());
        AssignCommand(oHenchman,ActionCastSpellAtObject(SPELL_RAISE_DEAD,oPlayer,METAMAGIC_ANY,TRUE));
        SetLocalInt(oHenchman,"RAISE_DEAD",1);
        }
    iIndex++;
    oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPlayer,iIndex);
    }

if (iRaise==1)
    {
    if (GetHasSpell(SPELL_HEAL,oHenchman)>0)
        {
        AssignCommand(oHenchman,ActionCastSpellAtObject(SPELL_HEAL,oPlayer));
        } else {
        if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oHenchman)>0)
            AssignCommand(oHenchman,ActionCastSpellAtObject(SPELL_CURE_CRITICAL_WOUNDS,oPlayer));
        }
    }


if (iFlag==TRUE)
    DelayCommand(10.0,GetDeathMenu(oPlayer));
else
    PopUpDeathGUIPanel(oPlayer,TRUE, TRUE,0,"Death has taken you.");
}

void GetDeathMenu(object oPlayer)
{
int iIndex;
int iFlag;
int iRaise;
object oHenchman;

if (GetIsDead(oPlayer))
    {
    iRaise=0;
    iIndex=1;
    iFlag=FALSE;

    oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPlayer,iIndex);
    while (GetIsObjectValid(oHenchman) && iFlag==FALSE)
        {
        if (GetLocalInt(oHenchman,"RESURRECTION") ==0 && GetLevelByClass(CLASS_TYPE_CLERIC,oHenchman)>12)
            {
            iFlag=TRUE;
            AssignCommand(oHenchman,ClearAllActions());
            AssignCommand(oHenchman,ActionCastSpellAtObject(SPELL_RESURRECTION,oPlayer,METAMAGIC_ANY,TRUE));
            SetLocalInt(oHenchman,"RESURRECTION",1);
            }
        iIndex++;
        oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPlayer,iIndex);
        }

    iIndex=1;
    oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPlayer,iIndex);
    while (GetIsObjectValid(oHenchman) && iFlag==FALSE)
        {
        if (GetLocalInt(oHenchman,"RAISE_DEAD") ==0 && GetLevelByClass(CLASS_TYPE_CLERIC,oHenchman)>8)
            {
            iFlag=TRUE;
            iRaise=1;
            AssignCommand(oHenchman,ClearAllActions());
            AssignCommand(oHenchman,ActionCastSpellAtObject(SPELL_RAISE_DEAD,oPlayer,METAMAGIC_ANY,TRUE));
            SetLocalInt(oHenchman,"RAISE_DEAD",1);
            }
        iIndex++;
        oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPlayer,iIndex);
        }

    if (iRaise==1)
        {
        if (GetHasSpell(SPELL_HEAL,oHenchman)>0)
            {
            AssignCommand(oHenchman,ActionCastSpellAtObject(SPELL_HEAL,oPlayer));
            } else {
            if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS,oHenchman)>0)
                AssignCommand(oHenchman,ActionCastSpellAtObject(SPELL_CURE_CRITICAL_WOUNDS,oPlayer));
            }
        }

    if (iFlag==TRUE)
        DelayCommand(10.0,GetDeathMenu2(oPlayer));
    else
        PopUpDeathGUIPanel(oPlayer,TRUE, TRUE,0,"Death has taken you.");
    }
}

void GetDeathMenu2(object oPC)
{
if (GetIsDead(oPC))
    PopUpDeathGUIPanel(oPC,TRUE, TRUE,0,"Death has taken you.");
}

void GetKiller()
{
object oKiller = GetLastKiller();
if (oKiller == GetModule())
    oKiller = GetLastHostileActor();

SetLocalString(OBJECT_SELF,"Killer",GetName(oKiller));
}
