#include "qdb_include"

void main()
{
int iAccept;

iAccept=GetResponseInt("Accept");
if (iAccept==0)
    iAccept=1;
else
    iAccept=0;

SetResponseInt("Accept",iAccept);

if (iAccept==1)
    SetResponseInt("Stop",1);

SetupResponse(GetResponseNumber());
}
