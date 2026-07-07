param(
    [string]$ArticleFile = "",
    [string]$Action = "post"
)

$configPath = Join-Path $PSScriptRoot "..\config.json"
if (Test-Path $configPath) {
    $config = Get-Content $configPath | ConvertFrom-Json
    $apiKey = $config.medium.api_key
    $authorId = $config.medium.author_id
} else {
    $apiKey = $env:MEDIUM_API_KEY
    $authorId = $env:MEDIUM_AUTHOR_ID
}

if (-not $apiKey) { Write-Error "MEDIUM_API_KEY nao configurado"; exit 1 }

$headers = @{ Authorization = "Bearer $apiKey"; "Content-Type" = "application/json"; "Accept" = "application/json" }

# Obter info do usuario se nao tiver author_id
if (-not $authorId) {
    $me = Invoke-RestMethod -Uri "https://api.medium.com/v1/me" -Method GET -Headers $headers
    $authorId = $me.data.id
    Write-Host "Author ID: $authorId"
}

if ($Action -eq "post" -and $ArticleFile) {
    $content = Get-Content $ArticleFile -Raw
    
    # Extrair frontmatter (title, tags, description)
    $title = ""
    $tags = @("IA", "empreendedorismo", "produtividade")
    $description = ""
    
    if ($content -match "title: `"(.*?)`"") { $title = $matches[1] }
    elseif ($content -match "^# (.+)$") { $title = $matches[1] }
    
    if ($content -match "tags: \[(.*?)\]") { $tags = $matches[1] -split ", " }
    
    # Remover frontmatter
    $body = $content -replace "^---[\s\S]*?---`n", ""
    
    # Se title veio do frontmatter
    if (-not $title) { $title = "IA para Empreendedores: Como Dobrar Sua Produtividade" }
    
    $postBody = @{
        title = $title
        contentFormat = "markdown"
        content = $body
        tags = $tags
        publishStatus = "public"
    } | ConvertTo-Json
    
    $resp = Invoke-RestMethod -Uri "https://api.medium.com/v1/users/$authorId/posts" -Method POST -Body $postBody -Headers $headers
    if ($resp.data) {
        Write-Host "Artigo publicado no Medium: $($resp.data.title)"
        Write-Host "URL: $($resp.data.url)"
    } else {
        Write-Error "Falha: $resp"
    }
}

Write-Host "Uso: postar-medium.ps1 -ArticleFile ./artigo.md"
