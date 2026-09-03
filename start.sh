#!/bin/sh
set -e

# Pin OpenClaw's home to the app's own working directory rather than the
# OS user home (default would be e.g. /root, which isn't necessarily what
# gets persisted across restarts). State ends up at $OPENCLAW_HOME/.openclaw.
export OPENCLAW_HOME=/app

if [ ! -f "$OPENCLAW_HOME/.openclaw/openclaw.json" ]; then
  npx openclaw@2026.8.2 plugins install codex --accept-capabilities
  npx openclaw@2026.8.2 onboard --non-interactive --accept-risk --skip-health \
    --mode local --auth-choice openai-api-key --secret-input-mode ref \
    --gateway-auth token --gateway-token-ref-env OPENCLAW_GATEWAY_TOKEN \
    --skip-channels --no-install-daemon
fi

exec npx openclaw@2026.8.2 gateway --bind lan --port 80 --auth token
