#include "x0_i0_deckmany"

void main()
{
if (Random(3)==1)
    DoDeckDrawNegative(OBJECT_SELF, 0);
else
    DoDeckDrawPositive(OBJECT_SELF, 0);
}
