## O que é este template?

**OpenClaw** é um gateway pessoal de agente de IA: conecta um ou mais
provedores de modelo (OpenAI, Anthropic, Google, etc.) aos canais de
mensagem que você já usa — WhatsApp, Telegram, Discord, Slack e outros —
através de um único painel de controle (o "Gateway"). Este template implanta
o Gateway do OpenClaw na ShardCloud como um app **Node.js**, sem banco de
dados anexado.

## O que o OpenClaw faz?

- Roda um agente de IA que responde por múltiplos canais de mensagem
- Conecta a diversos provedores de modelo através de uma única configuração
- Expõe um Gateway (WebSocket) que apps companheiros (mobile, desktop, CLI)
  usam para conversar com o agente remotamente

### Fluxo básico de uso

```
Deploy do template → Onboarding automático na primeira inicialização
                                                        ↓
                              Gateway no ar, protegido por token
                                                        ↓
              Conecta canais (WhatsApp/Telegram/Discord/...) manualmente
```

## Importante: exposição pública

Este template expõe o Gateway publicamente, protegido apenas por um token
(`OPENCLAW_GATEWAY_TOKEN`). O Gateway é um painel de controle com acesso a
ferramentas e, dependendo da configuração, ao sistema onde roda — trate o
token como uma credencial de root, não como uma senha qualquer.

## Estrutura do projeto

```
openclaw/
├── package.json          ← Declara a dependência do pacote "openclaw"
├── start.sh              ← Onboarding (primeira vez) + inicia o Gateway
├── .shardcloud           ← Config de deploy da ShardCloud
└── docs/
    ├── _manifest.json
    ├── 01-intro.md       ← Esta página
    └── 02-config.md      ← Configuração
```

## Próximos passos

1. **[Configurar o app](02-config.md)** — variáveis de ambiente obrigatórias
   e como conectar seus canais de mensagem
