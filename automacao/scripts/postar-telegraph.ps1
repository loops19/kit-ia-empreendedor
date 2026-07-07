$scriptsDir = Split-Path $PSCommandPath -Parent
$logDir = "$scriptsDir\..\logs"
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir -Force | Out-Null }

$data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "[$data] Iniciando postagem Telegraph..."

$result = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$scriptsDir\gerar-artigos-telegraph.ps1" 2>&1
$total = if ($result -match 'Total unicos: (\d+)') { $matches[1] } else { '?' }

$dataFim = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$log = "[$dataFim] $($result -join ' | ')"
Add-Content -Path "$logDir\postagens.log" -Value $log -Encoding UTF8

Write-Host "[$dataFim] Concluido"
Write-Host "Log: $logDir\postagens.log"
