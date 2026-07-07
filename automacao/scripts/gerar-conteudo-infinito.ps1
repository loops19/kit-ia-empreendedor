$ErrorActionPreference = "SilentlyContinue"
$baseUrl = "https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-50-prompts"
$proUrl = "https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-50-prompts-pro"
$bundleUrl = "https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-bundle"
$logDir = "$PSScriptRoot\..\logs"
$usedFile = "$logDir\titulos_usados.txt"
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir -Force | Out-Null }

$usados = @()
if (Test-Path $usedFile) { $usados = Get-Content $usedFile }

# === TEMPLATES DE TITULOS (60 combinacoes) ===
$prefixos = @(
    "Prompt de IA para", "Como Usar IA para", "Guia de IA para",
    "Aprenda a Usar IA para", "O Melhor Prompt de IA para",
    "5 Prompts de IA para", "10 Prompts de IA para",
    "3 Prompts de IA que", "Prompt Infalivel de IA para",
    "Domine a IA para", "Estrategia de IA para",
    "Automatize com IA:", "IA para Empreendedores:",
    "O Segredo da IA para", "Dicas de IA para"
)

$verbos = @(
    "Criar", "Automatizar", "Organizar", "Planejar", "Analisar",
    "Escrever", "Produzir", "Gerenciar", "Otimizar", "Estruturar",
    "Desenvolver", "Gerar", "Calcular", "Resolver", "Transformar"
)

$objetos = @(
    "Posts para Instagram", "Campanhas de Vendas", "Atendimento ao Cliente",
    "Fluxo de Caixa", "Conteudo para Redes Sociais", "Emails de Marketing",
    "Propostas Comerciais", "Pesquisas de Mercado", "Relatorios Financeiros",
    "Roteiros de Video", "Textos para Site", "Briefings Criativos",
    "Calendarios Editoriais", "Scripts de Vendas", "Respostas para Clientes",
    "Analises de Concorrentes", "Planejamentos Mensais", "Contratos Simples",
    "Manuais de Processos", "Pesquisas NPS", "Descricoes de Produtos",
    "Sequencias de Emails", "Landing Pages", "Posts para LinkedIn",
    "Anuncios para Meta Ads", "Copy para Vendas", "Estrategias de Precos",
    "Controles de Estoque", "Relatorios de Resultados", "Apresentacoes de Vendas"
)

$beneficios = @(
    "em 1 minuto", "em segundos", "em 5 minutos", "sem esforco",
    "sem contratar equipe", "com resultados profissionais", "do zero",
    "com inteligencia artificial", "em poucos cliques", "automaticamente",
    "rapidamente", "com alta qualidade", "sem complicacao", "eficientemente",
    "sem gastar nada", "com IA gratuita", "de forma profissional",
    "em metade do tempo", "com excelencia", "sem estresse"
)

$ganchos = @(
    "e pare de perder horas com tarefas repetitivas",
    "e foque no que realmente importa",
    "e aumente sua produtividade",
    "e reduza custos operacionais",
    "e dobre sua producao de conteudo",
    "e conquiste mais clientes",
    "e automatize seu negocio",
    "e trabalhe menos, ganhe mais"
)

# === DESCRICOES (20 variacoes) ===
$descriptions = @(
    "Descubra o prompt exato que empreendedores de alto desempenho usam para {verbo} {objeto}. Resultado em minutos.",
    "Aprenda o passo a passo para usar IA e {verbo} {objeto} como um profissional. Sem complicacao.",
    "Este prompt transforma a forma como voce {verbo} {objeto}. Testado e aprovado por centenas de empreendedores.",
    "Cansado de perder tempo tentando {verbo} {objeto} sozinho? Use IA e resolva em segundos.",
    "O guia definitivo para {verbo} {objeto} com IA. Inclui prompts prontos e exemplos reais.",
    "Nunca foi tao facil {verbo} {objeto}. Com este prompt voce faz em 1 minuto o que levava horas.",
    "Domine a arte de {verbo} {objeto} usando IA. Resultados profissionais sem conhecimento tecnico.",
    "Quer {verbo} {objeto} como os experts? Este prompt e o atalho que voce precisa.",
    "A forma mais inteligente de {verbo} {objeto}: use IA e economize tempo, dinheiro e energia.",
    "Prompt testado e validado para {verbo} {objeto} em qualquer nicho. Funciona sempre.",
    "Chega de tentativas e erros. Aprenda o metodo certo de {verbo} {objeto} com IA.",
    "Transforme seu jeito de {verbo} {objeto} com este prompt revolucionario.",
    "O segredo dos empreendedores que ja dominam IA para {verbo} {objeto}. Revelado.",
    "Nao perca mais tempo. Com IA voce {verbo} {objeto} em minutos e com qualidade superior.",
    "Tudo que voce precisa saber sobre {verbo} {objeto} com IA em um guia pratico e direto."
)

$ctas = @(
    "Quer todos os 50 prompts testados e prontos para usar?",
    "50 prompts exclusivos esperando por voce. Clique e descubra.",
    "Nao perca tempo criando prompts do zero. Tenha 50 prontos.",
    "Resultado garantido com nossos 50 prompts testados.",
    "Acelere seu negocio com 50 prompts de IA profissionais.",
    "O kit que empreendedores estao usando para crescer."
)

$targets = @($baseUrl, $baseUrl, $baseUrl, $proUrl, $bundleUrl)

function New-Title {
    $p = $prefixos | Get-Random
    $v = $verbos | Get-Random
    $o = $objetos | Get-Random
    $b = $beneficios | Get-Random
    $g = $ganchos | Get-Random
    $title = "$p $v $o $b $g"
    if ($title.Length -gt 120) { $title = "$p $v $o $b" }
    if ($title.Length -gt 120) { $title = "$p $v $o" }
    return $title
}

function New-Description {
    $d = $descriptions | Get-Random
    $v = $verbos | Get-Random
    $o = $objetos | Get-Random
    return $d -replace "{verbo}", $v -replace "{objeto}", $o
}

function New-Token {
    $resp = Invoke-RestMethod -Uri "https://api.telegra.ph/createAccount" -Method POST -ContentType "application/json" -Body (@{ short_name = "Conta$([char](65+(Get-Random -Max 26)))"; author_name = "Kit IA"; author_url = $baseUrl } | ConvertTo-Json)
    if ($resp.ok) { return $resp.result.access_token }
    return $null
}

$totalNeeded = 3650
$count = 0
$tokensAtivos = @()
$batch = 0

while ($count -lt $totalNeeded) {
    # Refresh tokens every 100 articles
    if ($tokensAtivos.Count -eq 0 -or ($count % 100 -eq 0 -and $count -gt 0)) {
        $tokensAtivos = @()
        for ($i = 0; $i -lt 10; $i++) {
            $t = New-Token
            if ($t) { $tokensAtivos += $t }
        }
        Write-Host "[Batch $batch] $($tokensAtivos.Count) tokens renovados" -ForegroundColor Cyan
        $batch++
    }
    
    $title = New-Title
    if ($usados -contains $title) { continue }
    
    $desc = New-Description
    $cta = $ctas | Get-Random
    $url = $targets | Get-Random
    
    $content = @(
        @{ tag = "p"; children = @($desc) }
        @{ tag = "p"; children = @("") }
        @{ tag = "p"; children = @($cta) }
        @{ tag = "a"; attributes = @{ href = $url }; children = @("ACESSAR KIT COMPLETO") }
    )
    
    $token = $tokensAtivos[$count % $tokensAtivos.Count]
    $body = @{
        access_token = $token
        title = $title
        author_name = "Kit IA Empreendedor"
        author_url = $baseUrl
        content = $content
    } | ConvertTo-Json -Depth 10
    
    $resp = Invoke-RestMethod -Uri "https://api.telegra.ph/createPage" -Method POST -ContentType "application/json" -Body $body
    if ($resp.ok) {
        $usados += $title
        $title >> $usedFile
        $count++
        Write-Host "OK ($count/$totalNeeded): $title" -ForegroundColor Green
    } else {
        Write-Host "FALHOU: $title - $($resp.error)" -ForegroundColor Red
    }
    
    if ($count % 10 -eq 0) { Write-Host " [$count/$totalNeeded - $([math]::Round($count/$totalNeeded*100,1))%]" -ForegroundColor Cyan }
    if ($count % 100 -eq 0) { Start-Sleep -Seconds 5 }
    Start-Sleep -Milliseconds 300
}

Write-Host "`n=== CONCLUIDO: $count artigos gerados ===" -ForegroundColor Green
Write-Host "Cobertura: $([math]::Round($count/3650*100,1))% de 5 anos" -ForegroundColor Cyan
