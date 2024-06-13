#include "qdb_include"

void main()
{
int iDeleteItem;

iDeleteItem=GetResponseInt("DeleteItem");
if (iDeleteItem==0)
    iDeleteItem=1;
else
    iDeleteItem=0;

SetResponseInt("DeleteItem",iDeleteItem);


SetupResponse(GetResponseNumber());
}
