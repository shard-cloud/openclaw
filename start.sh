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

# --bind lan puts the gateway behind whatever reverse proxy fronts port 80,
# so it refuses to attribute client IPs (proxy_attribution_required) until
# it's told which immediate peer to trust. Private/CGNAT ranges cover common
# proxy placements without needing the exact proxy IP. Idempotent — safe to
# run every start, not just the first one.
npx openclaw@2026.8.2 config set gateway.trustedProxies \
  '["10.0.0.0/8","172.16.0.0/12","192.168.0.0/16","100.64.0.0/10","127.0.0.1","::1"]' \
  --strict-json

# The Gateway only auto-allows localhost/127.0.0.1 origins matching its own
# bound port — a browser opening the Control UI at the app's real public
# origin gets rejected ("Browser origin not allowed") until that origin is
# explicitly trusted. PUBLIC_ORIGIN is resolved from the {DOMAIN} placeholder
# at deploy time (see the app's env vars) to this app's actual URL.
if [ -n "$PUBLIC_ORIGIN" ]; then
  npx openclaw@2026.8.2 config set gateway.controlUi.allowedOrigins \
    "[\"$PUBLIC_ORIGIN\"]" --strict-json
fi

exec npx openclaw@2026.8.2 gateway --bind lan --port 80 --auth token
