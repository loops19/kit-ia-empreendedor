param(
    [int]$IntervaloMinutos = 60,
    [string]$LogDir = "$PSScriptRoot\..\logs"
)

$ErrorActionPreference = "Stop"
$token = "sR4TkYgshB7ThQpyOtUJnVGcnsNtT7MlTZAw6jSO5rw"
$headers = @{ Authorization = "Bearer $token" }
$entryUrl = "https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-50-prompts"
$proUrl = "https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-50-prompts-pro"

if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }

function VerificarVendas {
    try {
        $resp = Invoke-RestMethod -Uri "https://api.gumroad.com/v2/products" -Method GET -Headers $headers -ErrorAction Stop
        $entry = $resp.products | Where-Object { $_.name -like "*Produtividade*" }
        $pro = $resp.products | Where-Object { $_.name -like "*Kit PRO*" }

        $entrySales = if ($entry) { $entry.sales_count } else { 0 }
        $proSales = if ($pro) { $pro.sales_count } else { 0 }
        $entryRevenue = if ($entry) { $entry.sales_count * $entry.price / 100 } else { 0 }
        $proRevenue = if ($pro) { $pro.sales_count * $pro.price / 100 } else { 0 }
        $totalRevenue = $entryRevenue + $proRevenue

        $data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $log = @{ data = $data; entry_sales = $entrySales; pro_sales = $proSales; entry_revenue = $entryRevenue; pro_revenue = $proRevenue; total_revenue = $totalRevenue }

        $logFile = "$LogDir\vendas_$(Get-Date -Format 'yyyy-MM').jsonl"
        Add-Content -Path $logFile -Value "$($log | ConvertTo-Json -Compress)" -Encoding UTF8

        Write-Host "[$data] Entry: $entrySales vendas (R`$$entryRevenue) | PRO: $proSales vendas (R`$$proRevenue) | Total: R`$$totalRevenue" -ForegroundColor Green

        if ($totalRevenue -gt 0) {
            Write-Host "*** VENDA DETECTADA! ***" -ForegroundColor Yellow
            Write-Host "Entry: $entryUrl" -ForegroundColor Yellow
            Write-Host "PRO: $proUrl" -ForegroundColor Yellow
        }

        return $log
    } catch {
        Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] ERRO: $_" -ForegroundColor Red
        return $null
    }
}

if ($args[0] -eq "--once") {
    VerificarVendas
} else {
    Write-Host "Monitorando vendas a cada $IntervaloMinutos minutos... Ctrl+C para parar" -ForegroundColor Cyan
    while ($true) {
        VerificarVendas
        Start-Sleep -Seconds ($IntervaloMinutos * 60)
    }
}
