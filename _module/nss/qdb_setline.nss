#include "qdb_include"

void main()
{

string sTalk = GetLocalString(OBJECT_SELF, "Stack");

if (GetLine()=="")
    SetLine(sTalk);
else
    SetLine(GetLine() + " \n\n" + sTalk);

SetCustomToken(100,GetLine());
}
