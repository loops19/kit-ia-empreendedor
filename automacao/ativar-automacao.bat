@echo off
schtasks /CREATE /SC DAILY /TN "KitIA-PostarTelegraph1" /TR "powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Users\DELL\projetos\kit-ia-empreendedor\automacao\scripts\postar-telegraph.ps1"" /ST 06:00 /F
schtasks /CREATE /SC DAILY /TN "KitIA-PostarTelegraph2" /TR "powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Users\DELL\projetos\kit-ia-empreendedor\automacao\scripts\postar-telegraph.ps1"" /ST 18:00 /F
echo Tasks criadas!
pause
