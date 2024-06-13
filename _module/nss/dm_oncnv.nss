void main()
{
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    object oIntruder;

    if (nMatch == -1 && GetCommandable(OBJECT_SELF))
    {
        ClearAllActions();
        BeginConversation();
    }
    else
    if(nMatch == 777 && GetIsObjectValid(oShouter) && GetIsPC(oShouter))
  //     && GetIsFriend(oShouter)
    {
      if (oShouter == GetLocalObject(OBJECT_SELF, "Customer")) {
        string sSaid = GetMatchedSubstring(0);
        SetLocalString(OBJECT_SELF, "Stack", sSaid);
      }
    }
    if (GetIsPC(GetLastSpeaker()))
        SetLocalString(OBJECT_SELF, "Stack", GetMatchedSubstring(0));
//  SendMessageToPC(GetFirstPC(),"Test = " + GetMatchedSubstring(0));
}
