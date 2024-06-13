void main()
{
object oPC;

oPC=GetPCSpeaker();

CreateItemOnObject("en6_mq6robes",oPC);
SetLocalString(oPC,"QPTag","en6_mq6robes");
SetLocalInt(oPC,"MQ6ItemType",2);

}
