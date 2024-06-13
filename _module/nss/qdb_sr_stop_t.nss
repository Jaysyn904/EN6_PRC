#include "qdb_include"

void main()
{
int iStop;

iStop=GetResponseInt("Stop");
if (iStop==0)
    iStop=1;
else
    iStop=0;

SetResponseInt("Stop",iStop);


SetupResponse(GetResponseNumber());
}
