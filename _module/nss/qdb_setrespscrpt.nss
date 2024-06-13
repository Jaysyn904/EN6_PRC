#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");

SetResponseString("Script",sTalk);

SetupResponse(GetResponseNumber());
}
