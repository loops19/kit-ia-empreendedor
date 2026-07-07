#!/bin/bash
# Script de publicação automática via Gumroad CLI
# Uso: ./publish.sh [--pro]
#
# Requer: gumroad-cli instalado e GUMROAD_ACCESS_TOKEN configurado

set -e

PRODUCT_NAME="50 Prompts de IA para Empreendedor - Kit de Produtividade"
PRODUCT_PRICE="3700"  # R$37,00 em centavos
PRODUCT_DESC_FILE="../landing-page/index.html"

# ---- Criar produto como rascunho ----
echo ">>> Criando produto no Gumroad..."
PRODUCT_JSON=$(gumroad products create \
  --name "$PRODUCT_NAME" \
  --type digital \
  --price "$PRODUCT_PRICE" \
  --tag "ia" \
  --tag "prompts" \
  --tag "empreendedor" \
  --tag "produtividade" \
  --tag "marketing-digital" \
  --description "$(cat $PRODUCT_DESC_FILE)" \
  --custom-permalink "kit-ia-empreendedor-50-prompts" \
  --json --no-input)

PRODUCT_ID=$(echo "$PRODUCT_JSON" | jq -r '.product.id')
echo ">>> Produto criado: $PRODUCT_ID"

# ---- Upload dos arquivos ----
echo ">>> Fazendo upload dos arquivos..."
gumroad files upload "$PRODUCT_ID" \
  --file "../produto/50-prompts-ia-empreendedor.md" \
  --name "Ebook - 50 Prompts de IA" \
  --json --no-input

gumroad files upload "$PRODUCT_ID" \
  --file "../produto/prompts/01-vendas.txt" \
  --name "Prompts de Vendas" \
  --json --no-input

gumroad files upload "$PRODUCT_ID" \
  --file "../produto/prompts/02-instagram.txt" \
  --name "Prompts de Instagram" \
  --json --no-input

gumroad files upload "$PRODUCT_ID" \
  --file "../produto/prompts/03-atendimento.txt" \
  --name "Prompts de Atendimento" \
  --json --no-input

gumroad files upload "$PRODUCT_ID" \
  --file "../produto/prompts/04-financas.txt" \
  --name "Prompts de Financas" \
  --json --no-input

gumroad files upload "$PRODUCT_ID" \
  --file "../produto/prompts/05-produtividade.txt" \
  --name "Prompts de Produtividade" \
  --json --no-input

gumroad files upload "$PRODUCT_ID" \
  --file "../produto/prompts/06-bonus-secretos.txt" \
  --name "Bonus - 5 Prompts Secretos" \
  --json --no-input

gumroad files upload "$PRODUCT_ID" \
  --file "../produto/guia/guia-rapido-ia.md" \
  --name "Guia Rapido - IA do Zero" \
  --json --no-input

gumroad files upload "$PRODUCT_ID" \
  --file "../produto/planilha/controle-financeiro.csv" \
  --name "Planilha Financeira" \
  --json --no-input

echo ">>> Todos os arquivos enviados."

# ---- Criar código de oferta (desconto de lançamento) ----
gumroad offer-codes create "$PRODUCT_ID" \
  --name "LANCAMENTO10" \
  --offer-type percent \
  --offer-amount 10 \
  --max-purchase-count 50 \
  --json --no-input

echo ">>> Código LANCAMENTO10 criado (10% off para 50 primeiros)."

# ---- Habilitar programa de afiliados ----
gumroad products update "$PRODUCT_ID" \
  --affiliate-basis-points 3000 \
  --shown-on-profile true \
  --json --no-input

echo ">>> Afiliados habilitados (30% de comissão)."

# ---- Preview e confirmação ----
echo ""
echo "=========================================="
echo " PRODUTO PRONTO PARA PUBLICAÇÃO"
echo "=========================================="
echo "ID: $PRODUCT_ID"
echo "Nome: $PRODUCT_NAME"
echo "Preço: R$37,00"
echo "Arquivos: 9 enviados"
echo "Afiliados: 30%"
echo ""
echo "Para publicar, execute:"
echo "  gumroad products publish $PRODUCT_ID --json --no-input"
echo ""
echo "Para previsualizar:"
echo "  gumroad products view $PRODUCT_ID"
echo "=========================================="

# ---- (Opcional) Publicar ----
# Descomente a linha abaixo para publicar automaticamente:
# gumroad products publish "$PRODUCT_ID" --json --no-input
# echo ">>> Produto publicado com sucesso!"
