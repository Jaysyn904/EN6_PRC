#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");

SetLineInt("Done",StringToInt(sTalk));

}
