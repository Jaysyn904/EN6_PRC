void main()
{
SetFogColor(FOG_TYPE_ALL,FOG_COLOR_GREEN,GetArea(OBJECT_SELF));
SetFogAmount(FOG_TYPE_ALL,1,GetArea(OBJECT_SELF));

DelayCommand(2.5,ExecuteScript("en6_wind",GetFirstPC()));

int i;
i=2;
while (i<31)
    {
    DelayCommand(3.0 + IntToFloat(i)/20.0,SetFogAmount(FOG_TYPE_ALL,i,GetArea(OBJECT_SELF)));
    i=i+2;
    }
DelayCommand(6.0,SetFogAmount(FOG_TYPE_ALL,20,GetArea(OBJECT_SELF)));
DelayCommand(6.2,SetFogAmount(FOG_TYPE_ALL,10,GetArea(OBJECT_SELF)));
DelayCommand(6.3,SetFogAmount(FOG_TYPE_ALL,1,GetArea(OBJECT_SELF)));



}
