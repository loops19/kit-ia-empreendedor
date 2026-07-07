# Script para gerar todo o conteudo das 4 semanas automaticamente
# Eu (Claude) vou executar este script para criar todos os posts

$semanas = @{
    "semana1" = @{
        "segunda" = @(
            @{titulo="Criei 50 prompts de IA para empreendedores"; plataforma="reddit"; tema="lancamento"},
            @{titulo="IA para Empreendedores: Como Dobrar Sua Produtividade"; plataforma="medium"; tema="guia"},
            @{titulo="Prompt de IA que me salvou horas de trabalho"; plataforma="reddit"; tema="dica"},
            @{titulo="I Built a Digital Product with AI in 2 Hours"; plataforma="devto"; tema="caso"}
        )
        "terca" = @(
            @{titulo="Como voces usam IA no negocio?"; plataforma="reddit"; tema="discussao"},
            @{titulo="Guia Definitivo de Prompts de IA para Negocios"; plataforma="medium"; tema="guia"},
            @{titulo="Testei 5 ferramentas de IA gratis"; plataforma="reddit"; tema="review"},
            @{titulo="Automated Content Creation Pipeline"; plataforma="devto"; tema="tecnico"}
        )
        "quarta" = @(
            @{titulo="O prompt que uso todo dia"; plataforma="reddit"; tema="dica"},
            @{titulo="De Zero a Produto Digital em 2 Horas"; plataforma="medium"; tema="caso"},
            @{titulo="Copy de vendas com IA funciona?"; plataforma="reddit"; tema="review"},
            @{titulo="Building a Micro-SaaS with Free Tools"; plataforma="devto"; tema="tecnico"}
        )
        "quinta" = @(
            @{titulo="Melhor ferramenta IA gratuita 2026"; plataforma="reddit"; tema="review"},
            @{titulo="Negocio Digital Automatico sem Investimento"; plataforma="medium"; tema="guia"},
            @{titulo="Script que posta em 3 plataformas"; plataforma="reddit"; tema="tecnico"},
            @{titulo="Automating Social Media with PowerShell"; plataforma="devto"; tema="tecnico"}
        )
        "sexta" = @(
            @{titulo="Vendi meu primeiro produto digital"; plataforma="reddit"; tema="caso"},
            @{titulo="10 Prompts que Uso Todo Dia"; plataforma="medium"; tema="lista"},
            @{titulo="Estrategia de divulgacao gratuita"; plataforma="reddit"; tema="estrategia"},
            @{titulo="Digital Product Blueprint: Idea to Revenue"; plataforma="devto"; tema="guia"}
        )
        "sabado" = @(
            @{titulo="Melhores dicas de IA da semana"; plataforma="reddit"; tema="compilado"},
            @{titulo="IA Gratis vs Paga: Qual Escolher?"; plataforma="medium"; tema="comparativo"}
        )
        "domingo" = @(
            @{titulo="Planejamento Semanal com IA"; plataforma="medium"; tema="rotina"},
            @{titulo="O que funcionou essa semana"; plataforma="reddit"; tema="reflexao"}
        )
    )
}

Write-Host "Template de calendario criado."
Write-Host "Execute o gerador de conteudo para criar todos os posts:"
Write-Host "  ./gerar-posts-completos.ps1"
