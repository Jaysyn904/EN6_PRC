#include "qdb_include"

void main()
{

string sTalk = GetLocalString(OBJECT_SELF, "Stack");

if (GetLine()=="")
    SetLine(sTalk);
else if (GetStringLeft(sTalk,1) == "," ||GetStringLeft(sTalk,1) == ".")
    SetLine(GetLine() + sTalk);
else
    SetLine(GetLine() + " " + sTalk);

SetCustomToken(100,GetLine());
}
