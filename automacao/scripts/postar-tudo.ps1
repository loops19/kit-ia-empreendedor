param(
    [string]$Semana = "1",
    [string]$Modo = "automático"
)

Write-Host "=== SISTEMA DE POSTAGEM AUTOMATICA ==="
Write-Host "Semana: $Semana | Modo: $Modo"
Write-Host ""

$baseConteudo = Join-Path $PSScriptRoot "..\conteudo"
$scripts = Join-Path $PSScriptRoot "."

# Verificar se esta configurado
$configPath = Join-Path $PSScriptRoot "..\config.json"
if (-not (Test-Path $configPath)) {
    Write-Host "Arquivo de configuracao nao encontrado."
    Write-Host "Criando template..."
    
    $template = @"
{
    "reddit": {
        "client_id": "",
        "client_secret": "",
        "username": "",
        "password": ""
    },
    "medium": {
        "api_key": ""
    },
    "devto": {
        "api_key": ""
    },
    "pinterest": {
        "access_token": ""
    },
    "gumroad": {
        "access_token": "sR4TkYgshB7ThQpyOtUJnVGcnsNtT7MlTZAw6jSO5rw"
    }
}
"@
    Set-Content -Path $configPath -Value $template
    Write-Host "Template criado em: $configPath"
    Write-Host "Preencha com suas chaves de API e execute novamente."
    exit 0
}

$config = Get-Content $configPath | ConvertFrom-Json

$diasSemana = @("domingo", "segunda", "terca", "quarta", "quinta", "sexta", "sabado")
$diaSemana = (Get-Date).DayOfWeek.value__

# Encontrar posts para hoje
$hoje = $diasSemana[$diaSemana]
$pastaSemana = Join-Path $baseConteudo "semana$Semana"
$arquivoHoje = Join-Path $pastaSemana "$hoje.json"

if (Test-Path $arquivoHoje) {
    $posts = Get-Content $arquivoHoje | ConvertFrom-Json
    
    foreach ($post in $posts) {
        $horario = $post.horario
        $agora = Get-Date -Format "HH:mm"
        
        Write-Host "Post agendado para $horario : $($post.titulo) [$($post.plataforma)]"
        
        switch ($post.plataforma) {
            "reddit" {
                if ($config.reddit.client_id) {
                    $arquivo = Join-Path $pastaSemana "$($post.arquivo)"
                    if (Test-Path $arquivo) {
                        & "$scripts\postar-reddit.ps1" -PostFile $arquivo -Subreddit $post.subreddit
                    }
                } else { Write-Host "  [SKIP] Reddit nao configurado" }
            }
            "medium" {
                if ($config.medium.api_key) {
                    $arquivo = Join-Path $pastaSemana "$($post.arquivo)"
                    if (Test-Path $arquivo) {
                        & "$scripts\postar-medium.ps1" -ArticleFile $arquivo
                    }
                } else { Write-Host "  [SKIP] Medium nao configurado" }
            }
            "devto" {
                if ($config.devto.api_key) {
                    $arquivo = Join-Path $pastaSemana "$($post.arquivo)"
                    if (Test-Path $arquivo) {
                        & "$scripts\postar-devto.ps1" -ArticleFile $arquivo
                    }
                } else { Write-Host "  [SKIP] Dev.to nao configurado" }
            }
            default { Write-Host "  [SKIP] Plataforma desconhecida: $($post.plataforma)" }
        }
    }
} else {
    Write-Host "Nenhum post agendado para hoje (semana $Semana, $hoje)"
    Write-Host "Arquivo esperado: $arquivoHoje"
}

Write-Host ""
Write-Host "=== POSTAGEM CONCLUIDA ==="
