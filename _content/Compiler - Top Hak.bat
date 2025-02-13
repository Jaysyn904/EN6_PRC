:loop
"C:\NWN Work\nwnsc.exe" -o -w -n "C:\Games\Steam\steamapps\common\Neverwinter Nights" -i "D:\NWN Repos\EN6_PRC\_content\_hak\prc8_en6_top";"D:\NWN Repos\PRC8\nwn\nwnprc\trunk\include"  "D:\NWN Repos\EN6_PRC\_content\_hak\prc8_en6_top\*.nss"
if %errorLevel% == -1 goto :loop
pause