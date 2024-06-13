#include "qdb_include"

void main()
{
string sTalk = GetLocalString(OBJECT_SELF, "Stack");
string sDB;
string sVarName;

int iGoto;

sDB=GetDBName();
iGoto=StringToInt(sTalk);
SetResponseInt("Goto",iGoto);

SetupResponse(GetResponseNumber());
}
