param(
    [string]$ArticleFile = "",
    [string]$Action = "post"
)

$configPath = Join-Path $PSScriptRoot "..\config.json"
if (Test-Path $configPath) {
    $config = Get-Content $configPath | ConvertFrom-Json
    $apiKey = $config.devto.api_key
} else {
    $apiKey = $env:DEVTO_API_KEY
}

if (-not $apiKey) { Write-Error "DEVTO_API_KEY nao configurado"; exit 1 }

$headers = @{ "api-key" = $apiKey; "Content-Type" = "application/json" }

if ($Action -eq "post" -and $ArticleFile) {
    $content = Get-Content $ArticleFile -Raw
    
    # Extrair frontmatter
    $title = ""
    $tags = @("ai", "productivity", "entrepreneurship")
    $description = ""
    $published = $false
    
    if ($content -match "^---\s*`n(.*?)---" ) {
        $front = $matches[1]
        if ($front -match "title: `"(.*?)`"") { $title = $matches[1] }
        if ($front -match "description: `"(.*?)`"") { $description = $matches[1] }
        if ($front -match "tags: \[(.*?)\]") { $tags = $matches[1] -split ", " }
        if ($front -match "published: (true|false)") { $published = $matches[1] -eq "true" }
    }
    
    if (-not $title) {
        if ($content -match "^# (.+)$") { $title = $matches[1] }
        else { $title = "I Built a Digital Product with AI in 2 Hours" }
    }
    
    $body = @{
        article = @{
            title = $title
            published = $true
            body_markdown = $content
            tags = $tags
            description = $description
        }
    } | ConvertTo-Json -Depth 10
    
    $resp = Invoke-RestMethod -Uri "https://dev.to/api/articles" -Method POST -Body $body -Headers $headers
    if ($resp.id) {
        Write-Host "Artigo publicado no Dev.to: $($resp.title)"
        Write-Host "URL: $($resp.url)"
    } else {
        Write-Error "Falha: $resp"
    }
}

Write-Host "Uso: postar-devto.ps1 -ArticleFile ./artigo.md"
