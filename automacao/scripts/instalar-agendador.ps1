$ErrorActionPreference = "Stop"
$scriptsDir = Split-Path $PSCommandPath -Parent
$raiz = "$scriptsDir\.."

Write-Host "=== Instalando Automacao - Kit IA Empreendedor ===" -ForegroundColor Cyan

function New-Task($name, $hour, $script) {
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptsDir\$script`""
    $trigger = New-ScheduledTaskTrigger -Daily -At $hour
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
    $principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
    try {
        Register-ScheduledTask -TaskName $name -Action $action -Trigger $trigger -Settings $settings -Principal $principal -Force
        Write-Host "[OK] $name as $hour" -ForegroundColor Green
    } catch {
        Write-Host "[AVISO] $name: $_" -ForegroundColor Yellow
    }
}

New-Task "KitIA-PostarTelegraph1" "06:00" "postar-telegraph.ps1"
New-Task "KitIA-PostarTelegraph2" "18:00" "postar-telegraph.ps1"
New-Task "KitIA-VerificarVendas" "07:00" "verificar-vendas.ps1 --once"

Write-Host "`nTasks ativas:" -ForegroundColor Cyan
Get-ScheduledTask -TaskName "KitIA-*" 2>$null | Format-Table TaskName, State -AutoSize

Write-Host "`nLogs: $raiz\logs\" -ForegroundColor Cyan
