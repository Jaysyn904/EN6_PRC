#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");

SetLineString("Script",sTalk);

SetCustomToken(100,GetLineInfo());
}
