# Como ativar a postagem automatica (Gratuito)

## 1. Fork este repositorio para sua conta GitHub

## 2. Crie contas gratuitas nas plataformas:
- Reddit (reddit.com)
- Medium (medium.com)
- Dev.to (dev.to)

## 3. Gere as chaves de API:

### Reddit:
1. Acesse https://www.reddit.com/prefs/apps
2. Clique "create app" → "script"
3. Copie client_id e client_secret

### Medium:
1. Acesse https://medium.com/me/settings/security
2. Gerar "Integration token"

### Dev.to:
1. Acesse https://dev.to/settings/extensions
2. Gerar "API Key"

## 4. Adicione os Secrets no GitHub:
Settings → Secrets and variables → Actions

| Secret | Valor |
|--------|-------|
| REDDIT_CLIENT_ID | Seu client_id |
| REDDIT_CLIENT_SECRET | Seu client_secret |
| REDDIT_USERNAME | Seu usuario Reddit |
| REDDIT_PASSWORD | Sua senha Reddit |
| MEDIUM_API_KEY | Seu token Medium |
| MEDIUM_AUTHOR_ID | Deixe vazio (detecta automatico) |
| DEVTO_API_KEY | Sua API Key Dev.to |

## 5. Pronto!

O GitHub Actions postara automaticamente:
- 6x por dia (06h, 09h, 12h, 15h, 18h, 21h BRT)
- Conteudo rotativo a cada 4 semanas
- Posts variados por plataforma

Nenhum custo. GitHub Actions free tier = 2000 min/mes.
