param(
    [string]$Subreddit = "empreendedorismo",
    [string]$PostFile = "",
    [string]$Action = "post"
)

# Requer: $env:REDDIT_CLIENT_ID, $env:REDDIT_CLIENT_SECRET, $env:REDDIT_USERNAME, $env:REDDIT_PASSWORD
# Ou configurar no arquivo config.json

$configPath = Join-Path $PSScriptRoot "..\config.json"
if (Test-Path $configPath) {
    $config = Get-Content $configPath | ConvertFrom-Json
    $clientId = $config.reddit.client_id
    $clientSecret = $config.reddit.client_secret
    $username = $config.reddit.username
    $password = $config.reddit.password
} else {
    $clientId = $env:REDDIT_CLIENT_ID
    $clientSecret = $env:REDDIT_CLIENT_SECRET
    $username = $env:REDDIT_USERNAME
    $password = $env:REDDIT_PASSWORD
}

if (-not $clientId) { Write-Error "REDDIT_CLIENT_ID nao configurado"; exit 1 }

function Get-RedditToken {
    $auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${clientId}:${clientSecret}"))
    $body = @{ grant_type = "password"; username = $username; password = $password }
    $headers = @{ Authorization = "Basic $auth"; "User-Agent" = "windows:kit-ia:v1.0 (by /u/$username)" }
    $resp = Invoke-RestMethod -Uri "https://www.reddit.com/api/v1/access_token" -Method POST -Body $body -Headers $headers
    return $resp.access_token
}

function Post-RedditLink {
    param($Token, $Sub, $Title, $Url)
    $headers = @{ Authorization = "Bearer $Token"; "User-Agent" = "windows:kit-ia:v1.0 (by /u/$username)" }
    $body = @{ kind = "link"; sr = $Sub; title = $Title; url = $Url; resubmit = $true }
    $resp = Invoke-RestMethod -Uri "https://oauth.reddit.com/api/submit" -Method POST -Body $body -Headers $headers
    return $resp
}

function Post-RedditSelf {
    param($Token, $Sub, $Title, $Text)
    $headers = @{ Authorization = "Bearer $Token"; "User-Agent" = "windows:kit-ia:v1.0 (by /u/$username)" }
    $body = @{ kind = "self"; sr = $Sub; title = $Title; text = $Text }
    $resp = Invoke-RestMethod -Uri "https://oauth.reddit.com/api/submit" -Method POST -Body $body -Headers $headers
    return $resp
}

$token = Get-RedditToken
Write-Host "Autenticado no Reddit. Token obtido."

if ($Action -eq "post" -and $PostFile) {
    $content = Get-Content $PostFile -Raw
    $lines = $content -split "`n"
    $title = ($lines | Where-Object { $_ -match "^## Título:" } | Select-Object -First 1) -replace "^## Título:\s*", ""
    $body = ($lines | Where-Object { $_ -notmatch "^#" } | Out-String).Trim()
    
    if ($title) {
        $result = Post-RedditSelf -Token $token -Sub $Subreddit -Title $title -Text $body
        if ($result.json.errors.length -eq 0 -or $result.json.errors -eq $null) {
            Write-Host "Post enviado para r/$Subreddit : $title"
            return $result
        } else {
            Write-Error "Erro: $($result.json.errors)"
        }
    }
}

if ($Action -eq "comment") {
    # Funcao para comentar em posts (engajamento)
    Write-Host "Modo comentario ativado"
}

Write-Host "Uso: postar-reddit.ps1 -PostFile ./post.md -Subreddit empreendedorismo"
