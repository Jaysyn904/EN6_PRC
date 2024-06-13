void main()
{
string sCampaign = "Endless Nights VI";
SetCampaignInt(sCampaign,"GameMode",1);
SetLocalInt(GetModule(),"GameMode",1);
SetLocalInt(GetModule(),"MagicLevel",0);
}
