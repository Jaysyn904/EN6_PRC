#include "qdb_include"

void main()
{
int iDone;

iDone=GetLineInt("Done");
if (iDone == 0)
    SetLineInt("Done",GetLineNumber()+1);

}
