$ErrorActionPreference = "SilentlyContinue"
$baseUrl = "https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-50-prompts"
$proUrl = "https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-50-prompts-pro"
$bundleUrl = "https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-bundle"
$freeUrl = "https://loopsofficial.gumroad.com/l/5-prompts-ia-gratis"
$usedFile = "$PSScriptRoot\..\logs\titulos_usados.txt"
$urlLogFile = "$PSScriptRoot\..\logs\urls_publicadas.txt"
$logDir = "$PSScriptRoot\..\logs"
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir -Force | Out-Null }

$usados = @()
if (Test-Path $usedFile) { $usados = Get-Content $usedFile }

$prefixos = @(
    "Prompt de IA para","Como Usar IA para","Guia de IA para",
    "Aprenda a Usar IA para","O Melhor Prompt de IA para",
    "5 Prompts de IA para","10 Prompts de IA para",
    "3 Prompts de IA que","Prompt Infalivel de IA para",
    "Domine a IA para","Estrategia de IA para",
    "Automatize com IA:","IA para Empreendedores:",
    "O Segredo da IA para","Dicas de IA para",
    "Tutorial de IA:","Receita de IA para","Macete de IA para",
    "IA na Pratica:","Passo a Passo de IA para"
)

$verbos = @(
    "Criar","Automatizar","Organizar","Planejar","Analisar",
    "Escrever","Produzir","Gerenciar","Otimizar","Estruturar",
    "Desenvolver","Gerar","Calcular","Resolver","Transformar"
)

$objetos = @(
    "Posts para Instagram","Campanhas de Vendas","Atendimento ao Cliente",
    "Fluxo de Caixa","Conteudo para Redes Sociais","Emails de Marketing",
    "Propostas Comerciais","Pesquisas de Mercado","Relatorios Financeiros",
    "Roteiros de Video","Textos para Site","Briefings Criativos",
    "Calendarios Editoriais","Scripts de Vendas","Respostas para Clientes",
    "Analises de Concorrentes","Planejamentos Mensais","Contratos Simples",
    "Manuais de Processos","Pesquisas NPS","Descricoes de Produtos",
    "Sequencias de Emails","Landing Pages","Posts para LinkedIn",
    "Anuncios para Meta Ads","Copy para Vendas","Estrategias de Precos",
    "Controles de Estoque","Relatorios de Resultados","Apresentacoes de Vendas"
)

$beneficios = @(
    "em 1 minuto","em segundos","em 5 minutos","sem esforco",
    "sem contratar equipe","com resultados profissionais","do zero",
    "com inteligencia artificial","em poucos cliques","automaticamente",
    "rapidamente","com alta qualidade","sem complicacao","eficientemente",
    "sem gastar nada","com IA gratuita","de forma profissional",
    "em metade do tempo","com excelencia","sem estresse"
)

$ganchos = @(
    "e pare de perder horas com tarefas repetitivas",
    "e foque no que realmente importa",
    "e aumente sua produtividade","e reduza custos operacionais",
    "e dobre sua producao de conteudo","e conquiste mais clientes",
    "e automatize seu negocio","e trabalhe menos, ganhe mais"
)

$descriptions = @(
    "Descubra o prompt exato que empreendedores de alto desempenho usam para {verbo} {objeto}.",
    "Aprenda o passo a passo para usar IA e {verbo} {objeto} como um profissional.",
    "Este prompt transforma a forma como voce {verbo} {objeto}. Testado e aprovado.",
    "Cansado de perder tempo tentando {verbo} {objeto} sozinho? Use IA e resolva em segundos.",
    "O guia definitivo para {verbo} {objeto} com IA. Inclui prompts prontos e exemplos reais.",
    "Nunca foi tao facil {verbo} {objeto}. Com este prompt voce faz em 1 minuto.",
    "Domine a arte de {verbo} {objeto} usando IA. Resultados profissionais sem conhecimento tecnico.",
    "Quer {verbo} {objeto} como os experts? Este prompt e o atalho que voce precisa.",
    "Prompt testado e validado para {verbo} {objeto} em qualquer nicho. Funciona sempre.",
    "O segredo dos empreendedores que ja dominam IA para {verbo} {objeto}. Revelado."
)

$dicas = @(
    "Dica: use este prompt no ChatGPT ou Claude e substitua as informacoes entre [colchetes] pelos dados do seu negocio.",
    "Importante: quanto mais detalhes voce fornecer no prompt, melhor sera o resultado da IA.",
    "Lembre-se de revisar e adaptar o resultado gerado pela IA ao seu estilo pessoal.",
    "Teste variacoes do prompt para encontrar o resultado ideal para seu negocio.",
    "Salve os melhores resultados em um documento para reutilizar depois."
)

$ctas = @(
    "Quer todos os 50 prompts testados e prontos para usar?",
    "50 prompts exclusivos esperando por voce. Clique e descubra.",
    "Nao perca tempo criando prompts do zero. Tenha 50 prontos.",
    "Acelere seu negocio com 50 prompts de IA profissionais.",
    "O kit que empreendedores estao usando para crescer.",
    "Teste 5 prompts gratis antes de comprar o kit completo!"
)
$targets = @($baseUrl, $baseUrl, $baseUrl, $proUrl, $bundleUrl, $freeUrl)

function New-Title {
    $p = $prefixos | Get-Random
    $v = $verbos | Get-Random
    $o = $objetos | Get-Random
    $b = $beneficios | Get-Random
    $g = $ganchos | Get-Random
    $t = "$p $v $o $b $g"
    if ($t.Length -gt 120) { $t = "$p $v $o $b" }
    if ($t.Length -gt 120) { $t = "$p $v $o" }
    return $t
}

function New-Description {
    $d = $descriptions | Get-Random
    $v = $verbos | Get-Random
    $o = $objetos | Get-Random
    return $d -replace "{verbo}", $v -replace "{objeto}", $o
}

$tokensAtivos = @()
for ($i = 0; $i -lt 5; $i++) {
    $resp = Invoke-RestMethod -Uri "https://api.telegra.ph/createAccount" -Method POST -ContentType "application/json" -Body (@{ short_name = "Conta$([char](65+$i))"; author_name = "Kit IA"; author_url = $baseUrl } | ConvertTo-Json)
    if ($resp.ok) { $tokensAtivos += $resp.result.access_token }
    Start-Sleep -Milliseconds 200
}

$discountNote = " Clientes do Brasil: use o cupom BRASIL40 para 40% de desconto!"
$couponCodes = @("BRASIL40", "BRASIL40", "")
$couponMsgs = @(
    "Clientes do Brasil: use o cupom BRASIL40 e ganhe 40% de desconto!",
    "Precos em USD. Para clientes brasileiros, use BRASIL40 e pague em reais com desconto.",
    ""
)

$count = 0
while ($count -lt 12) {
    $title = New-Title
    if ($usados -contains $title) { continue }
    
    $desc = New-Description
    $dica = $dicas | Get-Random
    $cta = $ctas | Get-Random
    $url = $targets | Get-Random
    $cupomMsg = $couponMsgs | Get-Random
    
    $contentLines = @()
    $contentLines += @{ tag = "p"; children = @($desc) }
    $contentLines += @{ tag = "p"; children = @($dica) }
    
    if ($cupomMsg -ne "") {
        $contentLines += @{ tag = "p"; children = @($cupomMsg) }
    }
    
    $ctaChildren = @($cta)
    if ($cta -like "*gratis*") {
        $contentLines += @{ tag = "p"; children = @($cta) }
        $contentLines += @{ tag = "a"; attributes = @{ href = $url }; children = @("BAIXAR 5 PROMPTS GRATIS") }
    } else {
        $contentLines += @{ tag = "p"; children = @($cta) }
        $contentLines += @{ tag = "a"; attributes = @{ href = $url }; children = @("ACESSAR KIT COMPLETO") }
    }
    
    $token = $tokensAtivos[$count % $tokensAtivos.Count]
    $body = @{ access_token = $token; title = $title; author_name = "Kit IA Empreendedor"; author_url = $baseUrl; content = $contentLines } | ConvertTo-Json -Depth 10
    
    $resp = Invoke-RestMethod -Uri "https://api.telegra.ph/createPage" -Method POST -ContentType "application/json" -Body $body
    if ($resp.ok) {
        $usados += $title; $title >> $usedFile
        $articleUrl = $resp.result.url
        "$articleUrl | $title" >> $urlLogFile
        $count++
        Write-Host "OK: $title" -ForegroundColor Green
        Write-Host "   URL: $articleUrl" -ForegroundColor DarkGray
    } else {
        Write-Host "FALHOU: $($resp.error)" -ForegroundColor Red
    }
    Start-Sleep -Milliseconds 500
}

Write-Host "`n$count artigos publicados" -ForegroundColor Cyan
Write-Host "Total unicos: $(@(Get-Content $usedFile).Count)" -ForegroundColor Cyan
