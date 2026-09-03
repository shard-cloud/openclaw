## Pré-requisitos

- Uma **conta na ShardCloud**
- Uma **chave de API de um provedor de modelo** (por padrão este template
  usa a OpenAI — veja abaixo como trocar)

## 1. Deploy do template

Nenhum banco de dados é anexado — o OpenClaw guarda seu próprio estado
localmente. Antes de iniciar o app pela primeira vez, preencha:

| Variável                 | Descrição                                                                 |
| ------------------------ | -------------------------------------------------------------------------- |
| `OPENAI_API_KEY`         | Chave de API da OpenAI, usada no onboarding automático                    |
| `OPENCLAW_GATEWAY_TOKEN` | Token exigido para se conectar ao Gateway — **troque o valor padrão, trate como senha de root** |

Se preferir outro provedor de modelo (Anthropic, Google, etc.), edite o
`CUSTOM_COMMAND` do app para trocar `--auth-choice openai-api-key` pela opção
correspondente e ajuste a variável de ambiente da chave.

## 2. Primeira inicialização

No primeiro start, o app instala o plugin de runtime necessário e roda o
onboarding automático (não-interativo) antes de subir o Gateway — isso só
acontece uma vez; reinicializações seguintes vão direto para o Gateway.
Acompanhe os logs até aparecer `ready`.

## 3. Conectar seus canais

Canais de mensagem (WhatsApp, Telegram, Discord, etc.) não são configurados
automaticamente — exigem um passo interativo (QR Code, OAuth). Depois do
primeiro deploy, use o app companheiro do OpenClaw ou a CLI para conectar
cada canal ao Gateway hospedado.

## Referências

- [Documentação oficial do OpenClaw](https://docs.openclaw.ai)
- [Repositório original](https://github.com/openclaw/openclaw)
