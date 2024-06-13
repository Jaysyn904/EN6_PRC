void GetPotion(object oCreature);
void CreateRandomItem(object oCreature);
void CreateTrap(object oCreature);
void GetScrolls(object oCreature);
string GetRandomScroll();
void GetRareItem(object oCreature);

void CreateTrap(object oCreature)
{
int iRandom;
string sTag;

if (Random(100)>0)
    {
    iRandom = Random(44)+1;
    if (iRandom<10)
        sTag = "NW_IT_TRAP00" + IntToString(iRandom);
    else
        sTag = "NW_IT_TRAP0" + IntToString(iRandom);
    } else {
        iRandom = Random(4)+1;
        sTag = "X2_IT_TRAP00" + IntToString(iRandom);
    }

CreateItemOnObject(sTag,oCreature);
}

void GetPotion(object oCreature)
{
int iRandom;
string sTag;

iRandom = Random(10)+1;

switch (iRandom)
    {
    case 1 : sTag="NW_IT_MPOTION005"; break;
    case 2 : sTag="NW_IT_MPOTION009"; break;
    case 3 : sTag="NW_IT_MPOTION015"; break;
    case 4 : sTag="NW_IT_MPOTION003"; break;
    case 5 : sTag="NW_IT_MPOTION020"; break;
    case 6 : sTag="NW_IT_MPOTION002"; break;
    case 7 : sTag="X2_IT_MPOTION002"; break;
    case 8 : sTag="NW_IT_MPOTION012"; break;
    case 9 : sTag="NW_IT_MPOTION008"; break;
    case 10 : sTag="NW_IT_MPOTION004"; break;
    }

CreateItemOnObject(sTag,oCreature);
if (Random(3)==0)
    CreateItemOnObject(sTag,oCreature);
}

void CreateRandomItem(object oCreature)
{
int iRandom;
string sItem;

sItem = "en3_item";
iRandom = Random(98)+1;
switch (iRandom)
    {
     case 1: sItem = "nw_it_mglove004"; break;
     case 2: sItem = "nw_it_mglove004"; break;
     case 3: sItem = "nw_it_mglove005"; break;
     case 4: sItem = "nw_it_mglove006"; break;
     case 5: sItem = "nw_it_mglove007"; break;
     case 6: sItem = "nw_it_mglove008"; break;
     case 7: sItem = "nw_it_mglove009"; break;
     case 8: sItem = "nw_mcloth006"; break;
     case 9: sItem = "nw_it_mglove012"; break;
     case 10: sItem = "nw_mcloth006"; break;
     case 11: sItem = "nw_it_mring009"; break;
     case 12: sItem = "nw_it_mring009"; break;
     case 13: sItem = "nw_it_mring010"; break;
     case 14: sItem = "nw_it_mring011"; break;
     case 15: sItem = "nw_it_mboots010"; break;
     case 16: sItem = "nw_it_mneck024"; break;
     case 17: sItem = "nw_mcloth007"; break;
     case 18: sItem = "nw_it_mring024"; break;
     case 19: sItem = "nw_it_mring012"; break;
     case 20: sItem = "nw_mcloth008"; break;
     case 21: sItem = "nw_it_mglove010"; break;
     case 22: sItem = "nw_it_mglove011"; break;
     case 23: sItem = "nw_it_mglove013"; break;
     case 24: sItem = "nw_it_mglove014"; break;
     case 25: sItem = "nw_it_mglove015"; break;
     case 26: sItem = "nw_maarcl097"; break;
     case 27: sItem = "nw_maarcl097"; break;
     case 28: sItem = "nw_maarcl099"; break;
     case 29: sItem = "nw_it_mneck032"; break;
     case 30: sItem = "nw_mcloth010"; break;
     case 31: sItem = "nw_it_mbracer002"; break;
     case 32: sItem = "nw_it_mneck001"; break;
     case 33: sItem = "nw_maarcl055"; break;
     case 34: sItem = "nw_mcloth009"; break;
     case 35: sItem = "nw_it_mring009"; break;
     case 36: sItem = "nw_it_mring009"; break;
     case 37: sItem = "nw_it_mring010"; break;
     case 38: sItem = "nw_it_mring011"; break;
     case 39: sItem = "nw_it_mboots010"; break;
     case 40: sItem = "nw_it_mneck024"; break;
     case 41: sItem = "nw_mcloth007"; break;
     case 42: sItem = "nw_it_mring024"; break;
     case 43: sItem = "nw_it_mring012"; break;
     case 44: sItem = "nw_mcloth008"; break;
     case 45: sItem = "nw_it_mglove010"; break;
     case 46: sItem = "nw_it_mglove011"; break;
     case 47: sItem = "nw_it_mglove013"; break;
     case 48: sItem = "nw_it_mglove014"; break;
     case 49: sItem = "nw_it_mglove015"; break;
     case 50: sItem = "nw_it_contain003"; break;
     case 51: sItem = "nw_maarcl097"; break;
     case 52: sItem = "nw_maarcl099"; break;
     case 53: sItem = "nw_it_mneck032"; break;
     case 54: sItem = "nw_mcloth010"; break;
     case 55: sItem = "nw_it_mbracer002"; break;
     case 56: sItem = "nw_it_mneck001"; break;
     case 57: sItem = "nw_maarcl055"; break;
     case 58: sItem = "nw_mcloth009"; break;
     case 59: sItem = "nw_it_mring001"; break;
     case 60: sItem = "nw_it_mboots001"; break;
     case 61: sItem = "nw_it_mbracer001"; break;
     case 62: sItem = "nw_it_mneck007"; break;
     case 63: sItem = "nw_maarcl096"; break;
     case 64: sItem = "nw_it_mglove003"; break;
     case 65: sItem = "nw_it_contain004"; break;
     case 66: sItem = "nw_it_mneck031"; break;
     case 67: sItem = "nw_it_mring006"; break;
     case 68: sItem = "nw_it_mneck006"; break;
     case 69: sItem = "nw_it_mneck029"; break;
     case 70: sItem = "nw_it_mring013"; break;
     case 71: sItem = "nw_it_mboots011"; break;
     case 72: sItem = "nw_it_mneck025"; break;
     case 73: sItem = "nw_it_mbelt009"; break;
     case 74: sItem = "nw_it_mbelt010"; break;
     case 75: sItem = "nw_it_mbelt011"; break;
     case 76: sItem = "nw_it_mring025"; break;
     case 77: sItem = "nw_it_mring025"; break;
     case 78: sItem = "nw_maarcl031"; break;
     case 79: sItem = "nw_it_mring001"; break;
     case 80: sItem = "nw_it_mboots001"; break;
     case 81: sItem = "nw_it_mbracer001"; break;
     case 82: sItem = "nw_it_mneck007"; break;
     case 83: sItem = "nw_maarcl096"; break;
     case 84: sItem = "nw_it_mglove003"; break;
     case 85: sItem = "nw_it_mneck031"; break;
     case 86: sItem = "nw_it_mneck031"; break;
     case 87: sItem = "nw_it_mring006"; break;
     case 88: sItem = "nw_it_mneck006"; break;
     case 89: sItem = "nw_it_mneck029"; break;
     case 90: sItem = "nw_it_mring013"; break;
     case 91: sItem = "nw_it_mboots011"; break;
     case 92: sItem = "nw_it_mneck025"; break;
     case 93: sItem = "nw_it_mbelt009"; break;
     case 94: sItem = "nw_it_mbelt010"; break;
     case 95: sItem = "nw_it_mbelt011"; break;
     case 96: sItem = "nw_it_mring025"; break;
     case 97: sItem = "nw_it_mring025"; break;
     case 98: sItem = "nw_it_mbracer007"; break;
     case 99: sItem = "nw_it_mbracer007"; break;
     case 100: sItem = "nw_it_mneck012"; break;
     case 101: sItem = "nw_maarcl088"; break;
     case 102: sItem = "nw_it_mboots012"; break;
     case 103: sItem = "nw_it_mneck026"; break;
     case 104: sItem = "nw_it_mboots006"; break;
     case 105: sItem = "nw_it_mbracer003"; break;
     case 106: sItem = "nw_it_mneck008"; break;
     case 107: sItem = "nw_it_mring008"; break;
     case 108: sItem = "nw_maarcl056"; break;
     case 109: sItem = "nw_maarcl092"; break;
     case 110: sItem = "nw_it_mring014"; break;
     case 111: sItem = "nw_it_mneck016"; break;
     case 112: sItem = "nw_it_mboots013"; break;
     case 113: sItem = "nw_it_mneck027"; break;
     case 114: sItem = "nw_it_mbracer008"; break;
     case 115: sItem = "nw_it_mneck013"; break;
     case 116: sItem = "nw_maarcl089"; break;
     case 117: sItem = "nw_it_mbelt012"; break;
     case 118: sItem = "nw_it_mbelt013"; break;
     case 119: sItem = "nw_it_mbelt014"; break;
     case 120: sItem = "nw_it_mring027"; break;
     case 121: sItem = "nw_it_mboots007"; break;
     case 122: sItem = "nw_it_mbracer004"; break;
     case 123: sItem = "nw_it_mneck009"; break;
     case 124: sItem = "nw_it_mring018"; break;
     case 125: sItem = "nw_maarcl093"; break;
     case 126: sItem = "nw_it_mboots002"; break;
     case 127: sItem = "nw_it_mbracer007"; break;
     case 128: sItem = "nw_it_mbracer007"; break;
     case 129: sItem = "nw_it_mneck012"; break;
     case 130: sItem = "nw_maarcl088"; break;
     case 131: sItem = "nw_it_mboots012"; break;
     case 132: sItem = "nw_it_mneck026"; break;
     case 133: sItem = "nw_it_mboots006"; break;
     case 134: sItem = "nw_it_mbracer003"; break;
     case 135: sItem = "nw_it_mneck008"; break;
     case 136: sItem = "nw_it_mring008"; break;
     case 137: sItem = "nw_maarcl056"; break;
     case 138: sItem = "nw_maarcl092"; break;
     case 139: sItem = "nw_it_mring014"; break;
     case 140: sItem = "nw_it_mneck016"; break;
     case 141: sItem = "nw_it_mboots013"; break;
     case 142: sItem = "nw_it_mneck027"; break;
     case 143: sItem = "nw_it_mbracer008"; break;
     case 144: sItem = "nw_it_mneck013"; break;
     case 145: sItem = "nw_maarcl089"; break;
     case 146: sItem = "nw_it_mbelt012"; break;
     case 147: sItem = "nw_it_mbelt013"; break;
     case 148: sItem = "nw_it_mbelt014"; break;
     case 149: sItem = "nw_it_mring027"; break;
     case 150: sItem = "nw_it_mboots007"; break;
     case 151: sItem = "nw_it_mbracer004"; break;
     case 152: sItem = "nw_it_mneck009"; break;
     case 153: sItem = "nw_it_mring018"; break;
     case 154: sItem = "nw_maarcl093"; break;
     case 155: sItem = "nw_it_mboots002"; break;
     case 156: sItem = "nw_it_mboots014"; break;
     case 157: sItem = "nw_it_mneck028"; break;
     case 158: sItem = "nw_it_mring015"; break;
     case 159: sItem = "nw_it_mbracer009"; break;
     case 160: sItem = "nw_it_mneck014"; break;
     case 161: sItem = "nw_maarcl090"; break;
     case 162: sItem = "nw_it_mring028"; break;
     case 163: sItem = "nw_it_mneck017"; break;
     case 164: sItem = "nw_it_mboots008"; break;
     case 165: sItem = "nw_it_mbracer005"; break;
     case 166: sItem = "nw_it_mneck010"; break;
     case 167: sItem = "nw_it_mmidmisc02"; break;
     case 168: sItem = "nw_it_mring019"; break;
     case 169: sItem = "nw_it_mring027"; break;
     case 170: sItem = "nw_it_mboots007"; break;
     case 171: sItem = "nw_it_mbracer004"; break;
     case 172: sItem = "nw_it_mneck009"; break;
     case 173: sItem = "nw_it_mring018"; break;
     case 174: sItem = "nw_maarcl093"; break;
     case 175: sItem = "nw_it_mboots002"; break;
     case 176: sItem = "nw_it_mboots014"; break;
     case 177: sItem = "nw_it_mneck028"; break;
     case 178: sItem = "nw_it_mring015"; break;
     case 179: sItem = "nw_it_mbracer009"; break;
     case 180: sItem = "nw_it_mneck014"; break;
     case 181: sItem = "nw_maarcl090"; break;
     case 182: sItem = "nw_it_mring028"; break;
     case 183: sItem = "nw_it_mneck017"; break;
     case 184: sItem = "nw_it_mboots008"; break;
     case 185: sItem = "nw_it_mbracer005"; break;
     case 186: sItem = "nw_it_mneck010"; break;
     case 187: sItem = "nw_it_mmidmisc02"; break;
     case 188: sItem = "nw_maarcl094"; break;
     case 189: sItem = "nw_it_mring019"; break;
     case 190: sItem = "nw_it_mring016"; break;
     case 191: sItem = "nw_it_mbracer010"; break;
     case 192: sItem = "nw_it_mneck015"; break;
     case 193: sItem = "nw_maarcl091"; break;
     case 194: sItem = "nw_it_mboots009"; break;
     case 195: sItem = "nw_it_mbracer006"; break;
     case 196: sItem = "nw_it_mneck011"; break;
     case 197: sItem = "nw_maarcl095"; break;
     case 198: sItem = "nw_it_mneck018"; break;
    }
CreateItemOnObject(sItem,oCreature);
}

void GetScrolls(object oCreature)
{
int iCount;
int iIndex;
string sTag;

iCount = Random(4)+1;
if (iCount+1*7 > GetHitDice(oCreature) + 7)
    iCount = GetHitDice(oCreature)/7 + 1;

iIndex = 0;
while (iIndex < iCount)
    {
    sTag = GetRandomScroll();
    CreateItemOnObject(sTag,oCreature);
    iIndex++;
    }
}

void GetScrollsOnChest(object oChest)
{
int iCount;
int iIndex;
string sTag;

if (Random(2) == 0)
    iCount = Random(4)+1;
else
    iCount = Random(2)+1;

iIndex = 0;
while (iIndex < iCount)
    {
    sTag = GetRandomScroll();
    CreateItemOnObject(sTag,oChest);
    iIndex++;
    }
}

string GetRandomScroll()
{
int iRandom;
string sTag;

sTag = "x1_it_sparscr002";
iRandom = Random(287)+1;
switch(iRandom)
    {
    case 1:
        sTag ="x1_it_sparscr002"; break;
        break;
    case 2:
        sTag ="nw_it_sparscr003"; break;
        break;
    case 3:
        sTag ="x1_it_sparscr003"; break;
        break;
    case 4:
        sTag ="x1_it_sparscr001"; break;
        break;
    case 5:
        sTag ="x1_it_spdvscr001"; break;
        break;
    case 6:
        sTag ="nw_it_sparscr004"; break;
        break;
    case 7:
        sTag ="nw_it_sparscr002"; break;
        break;
    case 8:
        sTag ="nw_it_sparscr001"; break;
        break;
    case 9:
        sTag ="x2_it_spdvscr001"; break;
        break;
    case 10:
        sTag ="x2_it_spdvscr002"; break;
        break;
    case 11:
        sTag ="x1_it_sparscr102"; break;
        break;
    case 12:
        sTag ="x1_it_spdvscr101"; break;
        break;
    case 13:
        sTag ="nw_it_sparscr112"; break;
        break;
    case 14:
        sTag ="x1_it_spdvscr107"; break;
        break;
    case 15:
        sTag ="nw_it_sparscr107"; break;
        break;
    case 16:
        sTag ="nw_it_sparscr110"; break;
        break;
    case 17:
        sTag ="x1_it_spdvscr102"; break;
        break;
    case 18:
        sTag ="nw_it_sparscr101"; break;
        break;
    case 19:
        sTag ="x1_it_spdvscr103"; break;
        break;
    case 20:
        sTag ="x1_it_sparscr101"; break;
        break;
    case 21:
        sTag ="nw_it_sparscr103"; break;
        break;
    case 22:
        sTag ="nw_it_sparscr106"; break;
        break;
    case 23:
        sTag ="x1_it_spdvscr104"; break;
        break;
    case 24:
        sTag ="nw_it_sparscr104"; break;
        break;
    case 25:
        sTag ="x1_it_spdvscr106"; break;
        break;
    case 26:
        sTag ="nw_it_sparscr109"; break;
        break;
    case 27:
        sTag ="nw_it_sparscr113"; break;
        break;
    case 28:
        sTag ="nw_it_sparscr102"; break;
        break;
    case 29:
        sTag ="nw_it_sparscr111"; break;
        break;
    case 30:
        sTag ="nw_it_sparscr210"; break;
        break;
    case 31:
        sTag ="x1_it_sparscr103"; break;
        break;
    case 32:
        sTag ="x1_it_spdvscr105"; break;
        break;
    case 33:
        sTag ="nw_it_sparscr108"; break;
        break;
    case 34:
        sTag ="nw_it_sparscr105"; break;
        break;
    case 35:
        sTag ="x1_it_sparscr104"; break;
        break;
    case 36:
        sTag ="x2_it_spdvscr103"; break;
        break;
    case 37:
        sTag ="x2_it_spdvscr102"; break;
        break;
    case 38:
        sTag ="x2_it_spdvscr104"; break;
        break;
    case 39:
        sTag ="x2_it_spdvscr101"; break;
        break;
    case 40:
        sTag ="x2_it_spdvscr105"; break;
        break;
    case 41:
        sTag ="x2_it_spdvscr106"; break;
        break;
    case 42:
        sTag ="x2_it_spavscr101"; break;
        break;
    case 43:
        sTag ="x2_it_spavscr104"; break;
        break;
    case 44:
        sTag ="x2_it_spavscr102"; break;
        break;
    case 45:
        sTag ="x2_it_spavscr105"; break;
        break;
    case 46:
        sTag ="x2_it_sparscral"; break;
        break;
    case 47:
        sTag ="x2_it_spdvscr107"; break;
        break;
    case 48:
        sTag ="x2_it_spdvscr108"; break;
        break;
    case 49:
        sTag ="x2_it_spavscr103"; break;
        break;
    case 50:
        sTag ="x1_it_spdvscr204"; break;
        break;
    case 51:
        sTag ="x1_it_sparscr201"; break;
        break;
    case 52:
        sTag ="nw_it_sparscr211"; break;
        break;
    case 53:
        sTag ="x1_it_spdvscr202"; break;
        break;
    case 54:
        sTag ="nw_it_sparscr212"; break;
        break;
    case 55:
        sTag ="nw_it_sparscr213"; break;
        break;
    case 56:
        sTag ="nw_it_spdvscr202"; break;
        break;
    case 57:
        sTag ="x1_it_sparscr301"; break;
        break;
    case 58:
        sTag ="nw_it_sparscr206"; break;
        break;
    case 59:
        sTag ="nw_it_sparscr219"; break;
        break;
    case 60:
        sTag ="nw_it_sparscr215"; break;
        break;
    case 61:
        sTag ="x1_it_spdvscr205"; break;
        break;
    case 62:
        sTag ="nw_it_sparscr220"; break;
        break;
    case 63:
        sTag ="nw_it_sparscr208"; break;
        break;
    case 64:
        sTag ="nw_it_sparscr209"; break;
        break;
    case 65:
        sTag ="x1_it_spdvscr201"; break;
        break;
    case 66:
        sTag ="nw_it_sparscr207"; break;
        break;
    case 67:
        sTag ="nw_it_sparscr216"; break;
        break;
    case 68:
        sTag ="nw_it_sparscr218"; break;
        break;
    case 69:
        sTag ="nw_it_spdvscr201"; break;
        break;
    case 70:
        sTag ="nw_it_sparscr202"; break;
        break;
    case 71:
        sTag ="x1_it_spdvscr203"; break;
        break;
    case 72:
        sTag ="nw_it_sparscr221"; break;
        break;
    case 73:
        sTag ="nw_it_sparscr201"; break;
        break;
    case 74:
        sTag ="nw_it_sparscr205"; break;
        break;
    case 75:
        sTag ="nw_it_spdvscr203"; break;
        break;
    case 76:
        sTag ="nw_it_spdvscr204"; break;
        break;
    case 77:
        sTag ="nw_it_sparscr203"; break;
        break;
    case 78:
        sTag ="x1_it_sparscr202"; break;
        break;
    case 79:
        sTag ="nw_it_sparscr214"; break;
        break;
    case 80:
        sTag ="nw_it_sparscr204"; break;
        break;
    case 81:
        sTag ="x2_it_spdvscr201"; break;
        break;
    case 82:
        sTag ="x2_it_spdvscr202"; break;
        break;
    case 83:
        sTag ="x2_it_spavscr207"; break;
        break;
    case 84:
        sTag ="x2_it_spavscr206"; break;
        break;
    case 85:
        sTag ="x2_it_spavscr201"; break;
        break;
    case 86:
        sTag ="x2_it_spdvscr203"; break;
        break;
    case 87:
        sTag ="x2_it_spavscr201"; break;
        break;
    case 88:
        sTag ="x2_it_spavscr205"; break;
        break;
    case 89:
        sTag ="x2_it_spavscr203"; break;
        break;
    case 90:
        sTag ="x2_it_spdvscr204"; break;
        break;
    case 91:
        sTag ="x2_it_spdvscr205"; break;
        break;
    case 92:
        sTag ="x2_it_spavscr204"; break;
        break;
    case 93:
        sTag ="nw_it_sparscr307"; break;
        break;
    case 94:
        sTag ="nw_it_sparscr217"; break;
        break;
    case 95:
        sTag ="nw_it_sparscr301"; break;
        break;
    case 96:
        sTag ="x1_it_sparscr301"; break;
        break;
    case 97:
        sTag ="nw_it_sparscr309"; break;
        break;
    case 98:
        sTag ="nw_it_sparscr304"; break;
        break;
    case 99:
        sTag ="x1_it_spdvscr303"; break;
        break;
    case 100:
        sTag ="x1_it_sparscr303"; break;
        break;
    case 101:
        sTag ="nw_it_sparscr312"; break;
        break;
    case 102:
        sTag ="nw_it_sparscr308"; break;
        break;
    case 103:
        sTag ="x1_it_spdvscr302"; break;
        break;
    case 104:
        sTag ="nw_it_sparscr314"; break;
        break;
    case 105:
        sTag ="nw_it_sparscr310"; break;
        break;
    case 106:
        sTag ="nw_it_sparscr302"; break;
        break;
    case 107:
        sTag ="nw_it_sparscr315"; break;
        break;
    case 108:
        sTag ="nw_it_sparscr303"; break;
        break;
    case 109:
        sTag ="x1_it_spdvscr305"; break;
        break;
    case 110:
        sTag ="nw_it_spdvscr302"; break;
        break;
    case 111:
        sTag ="nw_it_sparscr313"; break;
        break;
    case 112:
        sTag ="x1_it_spdvscr304"; break;
        break;
    case 113:
        sTag ="nw_it_sparscr305"; break;
        break;
    case 114:
        sTag ="nw_it_sparscr306"; break;
        break;
    case 115:
        sTag ="nw_it_sparscr311"; break;
        break;
    case 116:
        sTag ="x1_it_sparscr302"; break;
        break;
    case 117:
        sTag ="x2_it_spdvscr303"; break;
        break;
    case 118:
        sTag ="x2_it_spdvscr307"; break;
        break;
    case 119:
        sTag ="x2_it_spdvscr308"; break;
        break;
    case 120:
        sTag ="x2_it_spdvscr305"; break;
        break;
    case 121:
        sTag ="x2_it_spdvscr309"; break;
        break;
    case 122:
        sTag ="x2_it_spavscr305"; break;
        break;
    case 123:
        sTag ="x2_it_spdvscr306"; break;
        break;
    case 124:
        sTag ="x2_it_spavscr304"; break;
        break;
    case 125:
        sTag ="x2_it_spdvscr302"; break;
        break;
    case 126:
        sTag ="x2_it_spdvscr301"; break;
        break;
    case 127:
        sTag ="x2_it_spdvscr310"; break;
        break;
    case 128:
        sTag ="x2_it_spavscr303"; break;
        break;
    case 129:
        sTag ="x2_it_sparscrmc"; break;
        break;
    case 130:
        sTag ="x2_it_spdvscr304"; break;
        break;
    case 131:
        sTag ="x2_it_spavscr301"; break;
        break;
    case 132:
        sTag ="x2_it_spdvscr311"; break;
        break;
    case 133:
        sTag ="x2_it_spdvscr312"; break;
        break;
    case 134:
        sTag ="x2_it_spavscr302"; break;
        break;
    case 135:
        sTag ="x2_it_spdvscr313"; break;
        break;
    case 136:
        sTag ="nw_it_sparscr414"; break;
        break;
    case 137:
        sTag ="nw_it_sparscr405"; break;
        break;
    case 138:
        sTag ="nw_it_sparscr406"; break;
        break;
    case 139:
        sTag ="nw_it_sparscr411"; break;
        break;
    case 140:
        sTag ="nw_it_sparscr416"; break;
        break;
    case 141:
        sTag ="nw_it_sparscr412"; break;
        break;
    case 142:
        sTag ="nw_it_sparscr418"; break;
        break;
    case 143:
        sTag ="nw_it_sparscr413"; break;
        break;
    case 144:
        sTag ="nw_it_sparscr408"; break;
        break;
    case 145:
        sTag ="x1_it_spdvscr401"; break;
        break;
    case 146:
        sTag ="x1_it_sparscr401"; break;
        break;
    case 147:
        sTag ="nw_it_sparscr417"; break;
        break;
    case 148:
        sTag ="x1_it_spdvscr402"; break;
        break;
    case 149:
        sTag ="nw_it_sparscr401"; break;
        break;
    case 150:
        sTag ="nw_it_spdvscr402"; break;
        break;
    case 151:
        sTag ="nw_it_sparscr409"; break;
        break;
    case 152:
        sTag ="nw_it_sparscr415"; break;
        break;
    case 153:
        sTag ="nw_it_sparscr402"; break;
        break;
    case 154:
        sTag ="nw_it_spdvscr401"; break;
        break;
    case 155:
        sTag ="nw_it_sparscr410"; break;
        break;
    case 156:
        sTag ="nw_it_sparscr403"; break;
        break;
    case 157:
        sTag ="nw_it_sparscr404"; break;
        break;
    case 158:
        sTag ="nw_it_sparscr407"; break;
        break;
    case 159:
        sTag ="x2_it_spdvscr402"; break;
        break;
    case 160:
        sTag ="x2_it_spdvscr403"; break;
        break;
    case 161:
        sTag ="x2_it_spdvscr404"; break;
        break;
    case 162:
        sTag ="x2_it_spdvscr405"; break;
        break;
    case 163:
        sTag ="x2_it_spdvscr406"; break;
        break;
    case 164:
        sTag ="x2_it_spdvscr401"; break;
        break;
    case 165:
        sTag ="x2_it_spavscr401"; break;
        break;
    case 166:
        sTag ="x2_it_spdvscr407"; break;
        break;
    case 167:
        sTag ="nw_it_sparscr509"; break;
        break;
    case 168:
        sTag ="x1_it_sparscr502"; break;
        break;
    case 169:
        sTag ="nw_it_sparscr502"; break;
        break;
    case 170:
        sTag ="nw_it_sparscr507"; break;
        break;
    case 171:
        sTag ="nw_it_sparscr501"; break;
        break;
    case 172:
        sTag ="nw_it_sparscr503"; break;
        break;
    case 173:
        sTag ="nw_it_sparscr504"; break;
        break;
    case 174:
        sTag ="x1_it_sparscr501"; break;
        break;
    case 175:
        sTag ="x1_it_spdvscr403"; break;
        break;
    case 176:
        sTag ="nw_it_sparscr508"; break;
        break;
    case 177:
        sTag ="nw_it_sparscr505"; break;
        break;
    case 178:
        sTag ="x1_it_spdvscr501"; break;
        break;
    case 179:
        sTag ="nw_it_sparscr511"; break;
        break;
    case 180:
        sTag ="nw_it_sparscr512"; break;
        break;
    case 181:
        sTag ="nw_it_sparscr513"; break;
        break;
    case 182:
        sTag ="nw_it_sparscr506"; break;
        break;
    case 183:
        sTag ="x1_it_spdvscr502"; break;
        break;
    case 184:
        sTag ="nw_it_spdvscr501"; break;//raisedead
        break;
    case 185:
        sTag ="nw_it_sparscr510"; break;
        break;
    case 186:
        sTag ="x2_it_spdvscr508"; break;
        break;
    case 187:
        sTag ="x2_it_spavscr501"; break;
        break;
    case 188:
        sTag ="x2_it_spdvscr501"; break;
        break;
    case 189:
        sTag ="x2_it_spdvscr504"; break;
        break;
    case 190:
        sTag ="x2_it_spavscr503"; break;
        break;
    case 191:
        sTag ="x2_it_spdvscr509"; break;
        break;
    case 192:
        sTag ="x2_it_spdvscr505"; break;
        break;
    case 193:
        sTag ="x2_it_spavscr502"; break;
        break;
    case 194:
        sTag ="x2_it_spdvscr502"; break;
        break;
    case 195:
        sTag ="x2_it_spdvscr506"; break;
        break;
    case 196:
        sTag ="x2_it_spdvscr507"; break;
        break;
    case 197:
        sTag ="x2_it_spdvscr503"; break;
        break;
    case 198:
        sTag ="nw_it_sparscr603"; break;
        break;
    case 199:
        sTag ="x1_it_sparscr602"; break;
        break;
    case 200:
        sTag ="nw_it_sparscr607"; break;
        break;
    case 201:
        sTag ="nw_it_sparscr610"; break;
        break;
    case 202:
        sTag ="x1_it_sparscr601"; break;
        break;
    case 203:
        sTag ="x1_it_spdvscr604"; break;
        break;
    case 204:
        sTag ="nw_it_sparscr608"; break;
        break;
    case 205:
        sTag ="x1_it_sparscr605"; break;
        break;
    case 206:
        sTag ="nw_it_sparscr601"; break;
        break;
    case 207:
        sTag ="nw_it_sparscr602"; break;
        break;
    case 208:
        sTag ="nw_it_sparscr612"; break;
        break;
    case 209:
        sTag ="nw_it_sparscr613"; break;
        break;
    case 210:
        sTag ="x1_it_sparscr603"; break;
        break;
    case 211:
        sTag ="nw_it_sparscr611"; break;
        break;
    case 212:
        sTag ="x1_it_spdvscr603"; break;
        break;
    case 213:
        sTag ="nw_it_sparscr604"; break;
        break;
    case 214:
        sTag ="nw_it_sparscr609"; break;
        break;
    case 215:
        sTag ="x1_it_sparscr604"; break;
        break;
    case 216:
        sTag ="nw_it_sparscr605"; break;
        break;
    case 217:
        sTag ="nw_it_sparscr614"; break;
        break;
    case 218:
        sTag ="nw_it_sparscr606"; break;
        break;
    case 219:
        sTag ="x2_it_spdvscr603"; break;
        break;
    case 220:
        sTag ="x2_it_spdvscr601"; break;
        break;
    case 221:
        sTag ="x2_it_spdvscr606"; break;
        break;
    case 222:
        sTag ="x2_it_spdvscr604"; break;
        break;
    case 223:
        sTag ="x2_it_spdvscr605"; break;
        break;
    case 224:
        sTag ="x2_it_spavscr602"; break;
        break;
    case 225:
        sTag ="x2_it_spdvscr602"; break;
        break;
    case 226:
        sTag ="x2_it_spavscr601"; break;
        break;
    case 227:
        sTag ="x1_it_spdvscr701"; break;
        break;
    case 228:
        sTag ="x1_it_sparscr701"; break;
        break;
    case 229:
        sTag ="nw_it_sparscr707"; break;
        break;
    case 230:
        sTag ="x1_it_spdvscr702"; break;
        break;
    case 231:
        sTag ="nw_it_sparscr704"; break;
        break;
    case 232:
        sTag ="x1_it_spdvscr703"; break;
        break;
    case 233:
        sTag ="nw_it_sparscr708"; break;
        break;
    case 234:
        sTag ="nw_it_spdvscr701"; break;
        break;
    case 235:
        sTag ="nw_it_sparscr705"; break;
        break;
    case 236:
        sTag ="nw_it_sparscr702"; break;
        break;
    case 237:
        sTag ="nw_it_sparscr706"; break;
        break;
    case 238:
        sTag ="nw_it_sparscr802"; break;
        break;
    case 239:
        sTag ="nw_it_spdvscr702"; break;//ressurection
        break;
    case 240:
        sTag ="nw_it_sparscr701"; break;
        break;
    case 241:
        sTag ="nw_it_sparscr703"; break;
        break;
    case 242:
        sTag ="x2_it_spavscr701"; break;
        break;
    case 243:
        sTag ="x2_it_spdvscr702"; break;
        break;
    case 244:
        sTag ="x2_it_spavscr703"; break;
        break;
    case 245:
        sTag ="x2_it_spdvscr701"; break;
        break;
    case 246:
        sTag ="x1_it_sparscr801"; break;
        break;
    case 247:
        sTag ="x1_it_spdvscr803"; break;
        break;
    case 248:
        sTag ="x1_it_spdvscr804"; break;
        break;
    case 249:
        sTag ="x1_it_spdvscr801"; break;
        break;
    case 250:
        sTag ="x1_it_spdvscr704"; break;
        break;
    case 251:
        sTag ="nw_it_sparscr803"; break;
        break;
    case 252:
        sTag ="x1_it_spdvscr602"; break;
        break;
    case 253:
        sTag ="nw_it_sparscr809"; break;
        break;
    case 254:
        sTag ="nw_it_sparscr804"; break;
        break;
    case 255:
        sTag ="nw_it_sparscr807"; break;
        break;
    case 256:
        sTag ="nw_it_sparscr806"; break;
        break;
    case 257:
        sTag ="nw_it_sparscr801"; break;
        break;
    case 258:
        sTag ="nw_it_sparscr808"; break;
        break;
    case 259:
        sTag ="nw_it_sparscr805"; break;
        break;
    case 260:
        sTag ="x2_it_spdvscr804"; break;
        break;
    case 261:
        sTag ="x2_it_spavscr801"; break;
        break;
    case 262:
        sTag ="x2_it_spdvscr801"; break;
        break;
    case 263:
        sTag ="x2_it_spdvscr802"; break;
        break;
    case 264:
        sTag ="x2_it_spdvscr803"; break;
        break;
    case 265:
        sTag ="x1_it_sparscr901"; break;
        break;
    case 266:
        sTag ="nw_it_sparscr905"; break;
        break;
    case 267:
        sTag ="nw_it_sparscr908"; break;
        break;
    case 268:
        sTag ="nw_it_sparscr902"; break;
        break;
    case 269:
        sTag ="nw_it_sparscr912"; break;
        break;
    case 270:
        sTag ="nw_it_sparscr906"; break;
        break;
    case 271:
        sTag ="nw_it_sparscr901"; break;
        break;
    case 272:
        sTag ="nw_it_sparscr903"; break;
        break;
    case 273:
        sTag ="nw_it_sparscr910"; break;
        break;
    case 274:
        sTag ="nw_it_sparscr904"; break;
        break;
    case 275:
        sTag ="nw_it_sparscr911"; break;
        break;
    case 276:
        sTag ="x1_it_spdvscr901"; break;
        break;
    case 277:
        sTag ="nw_it_sparscr909"; break;
        break;
    case 278:
        sTag ="nw_it_sparscr907"; break;
        break;
    case 279:
        sTag ="x2_it_spavscr901"; break;
        break;
    case 280:
        sTag ="x2_it_spdvscr901"; break;
        break;
    case 281:
        sTag ="x2_it_spdvscr902"; break;
        break;
    case 282:
        sTag ="x2_it_spdvscr903"; break;
        break;
    case 283:
        sTag ="x2_it_spavscr902"; break;
        break;
    case 284:
        sTag ="nw_it_spdvscr301"; break;
        break;
    case 285:
        sTag ="x1_it_spdvscr601"; break;
        break;
    case 286:
        sTag ="x1_it_spdvscr802"; break;
        break;
    case 287:
        sTag ="x1_it_spdvscr605"; break;
        break;
    }

return sTag;
}

void GetRareItem(object oCreature)
{
string sTag;
int iRandom;

sTag = "X0_IT_MSMLMISC01";

iRandom = Random(67)+1;
switch (iRandom)
    {
    case 1: sTag = "X0_IT_MSMLMISC01"; break;
    case 2: sTag = "X0_IT_MSMLMISC02"; break;
    case 3: sTag = "X0_IT_MTHNMISC21"; break;
    case 4: sTag = "NW_IT_CONTAIN006"; break;
    case 5: sTag = "X0_IT_MMEDMISC03"; break;
    case 6: sTag = "X0_IT_MMEDMISC01"; break;
    case 7: sTag = "X0_IT_MTHNMISC18"; break;
    case 8: sTag = "X0_IT_MTHNMISC05"; break;
    case 9: sTag = "X0_IT_MTHNMISC06"; break;
    case 10: sTag = "X0_IT_MTHNMISC13"; break;
    case 11: sTag = "X0_IT_MSMLMISC03"; break;
    case 12: sTag = "X0_IT_MTHNMISC14"; break;
    case 13: sTag = "NW_IT_CONTAIN005"; break;
    case 14: sTag = "NW_IT_MMIDMISC01"; break;
    case 15: sTag = "NW_IT_MMIDMISC02"; break;
    case 16: sTag = "NW_IT_MMIDMISC03"; break;
    case 17: sTag = "X0_IT_MSMLMISC06"; break;
    case 18: sTag = "X0_IT_MTHNMISC08"; break;
    case 19: sTag = "X0_IT_MTHNMISC09"; break;
    case 20: sTag = "NW_IT_NOVEL002"; break;
    case 21: sTag = "X0_IT_MMEDMISC05"; break;
    case 22: sTag = "X0_IT_MTHNMISC10"; break;
    case 23: sTag = "X0_IT_MTHNMISC11"; break;
    case 24: sTag = "X0_IT_MTHNMISC16"; break;
    case 25: sTag = "X0_IT_MMEDMISC04"; break;
    case 26: sTag = "NW_IT_MMIDMISC04"; break;
    case 27: sTag = "X0_IT_MSMLMISC05"; break;
    case 28: sTag = "X0_DECK_AVATAR"; break;
    case 29: sTag = "NW_HEN_DAE3RW"; break;
    case 30: sTag = "NW_HEN_GRI3RW"; break;
    case 31: sTag = "NW_HEN_SHA3RW"; break;
    case 32: sTag = "NW_HEN_DAE1RW"; break;
    case 33: sTag = "NW_HEN_GRI1RW"; break;
    case 34: sTag = "NW_HEN_LIN2RW"; break;
    case 35: sTag = "NW_HEN_BOD3RW"; break;
    case 36: sTag = "NW_HEN_GAL2RW"; break;
    case 37: sTag = "NW_WSWMLS013"; break;
    case 38: sTag = "NW_HEN_DAE3QT"; break;
    case 39: sTag = "en4_vecnahand"; break;
    case 40: sTag = "X0_IT_MRING012"; break;
    case 41: sTag = "en2_ring8"; break;
    case 42: sTag = "NW_IT_MRING020"; break;
    case 43: sTag = "ZEP_NECRO_RING"; break;
    case 44: sTag = "en2_ring10"; break;
    case 45: sTag = "en2_ring7"; break;
    case 46: sTag = "en2_ring6"; break;
    case 47: sTag = "en2_ring4"; break;
    case 48: sTag = "en2_amulet1"; break;
    case 49: sTag = "en2_misc3"; break;
    case 50: sTag = "en2_cloak4"; break;
    case 51: sTag = "en2_cloak1"; break;
    case 52: sTag = "en4_negcloak"; break;
    case 53: sTag = "en2_cloak2"; break;
    case 54: sTag = "en2_bracer3"; break;
    case 55: sTag = "en2_boots4"; break;
    case 56: sTag = "en2_boots2"; break;
    case 57: sTag = "en2_boots3"; break;
    case 58: sTag = "en2_belt2"; break;
    case 59: sTag = "en2_belt1"; break;
    case 60: sTag = "en2_belt4"; break;
    case 61: sTag = "en4_rarebelt2"; break;
    case 62: sTag = "en4_rarebelt1"; break;
    case 63: sTag = "en4_rareamulet1"; break;
    case 64: sTag = "en4_rareamulet2"; break;
    case 65: sTag = "en4_rareboots1"; break;
    case 66: sTag = "en4_rarehelm1"; break;
    case 67: sTag = "X0_IT_MMEDMISC06"; break;

    }

CreateItemOnObject(sTag,oCreature);
}
