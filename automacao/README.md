# Sistema de Postagem Automática 24/7

## O que já está funcionando:

### Telegraph.ph (conteúdo indexado pelo Google)
- 3 contas criadas, 7+ artigos publicados
- Cada artigo tem link direto para os produtos no Gumroad
- Google indexa automaticamente (tráfego orgânico gratuito)
- Script: `.\automacao\scripts\postar-telegraph.ps1` (gera novos artigos diariamente)

### Gumroad (produtos no ar)
- https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-50-prompts (R$37)
- https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-50-prompts-pro (R$67)
- Afiliados 30% ativo | Cupom LANCAMENTO10 ativo

## Como ativar postagem completa:

### Opção A: GitHub Actions (recomendado, 100% gratuito)
1. Crie contas gratuitas: Reddit, Medium, Dev.to (~5 min cada)
2. Gere API keys em cada plataforma
3. Fork o repositório e adicione como Secrets no GitHub
4. Pronto — posta 6x/dia automaticamente

### Opção B: Local (Windows Task Scheduler)
Execute como administrador:
```
.\automacao\scripts\instalar-agendador.ps1
```
Isso agenda: postagem Telegraph 06:00 + verificação de vendas a cada hora.

## Plataformas suportadas
| Plataforma | Tipo | Status |
|------------|------|--------|
| Telegraph.ph | Artigos indexáveis (Google) | ✅ Automático |
| Reddit | Posts e discussões | ⏳ Precisa de conta |
| Medium | Artigos completos | ⏳ Precisa de conta |
| Dev.to | Artigos técnicos | ⏳ Precisa de conta |

## Monitoramento
```powershell
.\automacao\scripts\verificar-vendas.ps1 --once
```
Logs salvos em `automacao/logs/`
