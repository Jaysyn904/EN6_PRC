#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");

SetLocalString(OBJECT_SELF,"HenchName",sTalk);

SetCustomToken(100,sTalk);
}
