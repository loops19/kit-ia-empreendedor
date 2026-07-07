---
layout: default
title: Blog
---
<div class="promo">
  <h3>🎯 50 Prompts de IA para Empreendedores</h3>
  <p>Pronto para usar. Testado e aprovado. <a href="https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-50-prompts">Comprar por </a></p>
  <p style="margin-top:8px;">🔥 Kit PRO () com 100 prompts • <a href="https://loopsofficial.gumroad.com/l/kit-ia-empreendedor-bundle">Bundle  (economize )</a></p>
</div>
<div class="cupom">🇧🇷 Clientes do Brasil: use cupom <strong>BRASIL40</strong> no checkout para 40% OFF!</div>
<p style="margin-bottom:20px;"><a href="https://loopsofficial.gumroad.com/l/5-prompts-ia-gratis" style="color:#166534;font-weight:bold;">🎁 Quer testar gratis? Baixe 5 prompts gratuitos</a></p>

{% for post in site.posts %}
<article class="post">
  <h2><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
  <div class="meta">{{ post.date | date: "%d/%m/%Y" }}</div>
  <p>{{ post.excerpt | strip_html | truncatewords: 40 }}</p>
  <p><a href="{{ post.url | relative_url }}" style="color:#e94560;">Continue lendo →</a></p>
</article>
{% endfor %}

<p style="text-align:center;margin:40px 0;color:#888;">Total de {{ site.posts | size }} artigos sobre IA para empreendedores</p>
