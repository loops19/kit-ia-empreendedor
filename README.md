# Kit IA para Empreendedor - 50 Prompts de Produtividade

## Estrutura do Projeto

```
kit-ia-empreendedor/
├── produto/                          # Conteúdo do produto
│   ├── 50-prompts-ia-empreendedor.md # Ebook completo (50 prompts)
│   ├── prompts/                      # Arquivos individuais por categoria
│   │   ├── 01-vendas.txt
│   │   ├── 02-instagram.txt
│   │   ├── 03-atendimento.txt
│   │   ├── 04-financas.txt
│   │   ├── 05-produtividade.txt
│   │   └── 06-bonus-secretos.txt
│   ├── planilha/
│   │   └── controle-financeiro.csv
│   └── guia/
│       └── guia-rapido-ia.md
├── landing-page/
│   └── index.html                    # Página de vendas
├── scripts/
│   └── publish.sh                    # Script de publicação Gumroad CLI
└── README.md
```

## Preços

| Versão | Preço | Conteúdo |
|--------|-------|----------|
| Entry | R$37 | 50 prompts + planilha + guia + 5 bônus |
| PRO | R$67 | Tudo do Entry + 50 prompts extras + templates de e-mail |

## Plataforma de venda: Gumroad

- CLI oficial para agentes AI: `gumroad-cli`
- Token de acesso: `GUMROAD_ACCESS_TOKEN`
- Custo: 10% por venda (plano gratuito)
- Entrega automática após pagamento

## Pipeline de distribuição orgânica

1. Reddit (r/empreendedorismo, r/MarketingDigitalBR)
2. Medium (artigos sobre IA para negócios)
3. Dev.to (conteúdo técnico para devs empreendedores)
4. Pinterest (pins perenes com link para landing page)

## Comandos Gumroad CLI

```bash
# Autenticação
export GUMROAD_ACCESS_TOKEN="seu_token_aqui"

# Criar produto
gumroad products create --name "50 Prompts..." --price 3700 ...

# Publicar
gumroad products publish <product_id>

# Ver vendas
gumroad sales list --json
```

## Status Atual (Jul/2026)

- **3 produtos no ar**: Entry (R$37), PRO (R$67), Bundle (R$89)
- **29 artigos Telegraph** indexados pelo Google com links para os produtos
- **Automação Telegraph**: postagem 2x/dia (06:00 e 18:00)
- **Scripts prontos** para Reddit/Medium/Dev.to (precisa criar contas)

## Links

| Produto | Preço | Link |
|---------|-------|------|
| Entry (50 prompts) | R$37 | https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-50-prompts |
| PRO (100 prompts) | R$67 | https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-50-prompts-pro |
| Bundle Entry+PRO | R$89 | https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-bundle |
