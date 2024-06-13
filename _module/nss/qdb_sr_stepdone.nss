#include "qdb_include"

void main()
{
int iStepDone;

iStepDone=GetResponseInt("StepDone");
if (iStepDone==0)
    iStepDone=1;
else
    iStepDone=0;

SetResponseInt("StepDone",iStepDone);


SetupResponse(GetResponseNumber());
}
