#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");

SetResponse(sTalk);

SetupResponse(GetResponseNumber());
}
