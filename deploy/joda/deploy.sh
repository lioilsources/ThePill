#!/usr/bin/env bash
# Deploy pill-core to JODA behind its own Cloudflare tunnel (pattern:
# AlienMatch/deploy/joda/deploy.sh). Idempotent: .env secrets, the tunnel and
# its DNS record are created on the first run, on JODA, and never leave it.
# Public step: run only on Olin's explicit "nasaď".
#   deploy/joda/deploy.sh [ssh-host]      (default: joda; PILL_HOST overrides the hostname)
set -euo pipefail
host=${1:-joda}
here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
repo=$(cd "$here/../.." && pwd)
dest=deploy/ThePill/deploy/joda
public=${PILL_HOST:-pill.ol1n.com}
version=$(git -C "$repo" describe --tags --always --dirty 2>/dev/null || echo dev)

echo "==> build pill-core $version (linux/amd64)"
make -C "$repo/core" joda-bin >/dev/null

echo "==> sync to $host:$dest"
ssh "$host" "mkdir -p $dest"
rsync -a --delete --exclude .env --exclude data --exclude 'cloudflared/*.json' --exclude cloudflared/config.yml "$here/" "$host:$dest/"

ssh "$host" PUBLIC="$public" VERSION="$version" bash -s -- "$dest" <<'REMOTE'
set -euo pipefail
cd "$1"
if [ ! -f .env ]; then
  # First run: random token, generated here and never printed.
  sed -e "s/^PILL_HOST=.*/PILL_HOST=$PUBLIC/" \
      -e "s/^PILL_TOKEN=.*/PILL_TOKEN=$(openssl rand -hex 24)/" .env.example > .env
  echo "created .env (token stays on this host; add the LiteLLM key from Olin)"
fi
chmod 600 .env

if [ ! -f cloudflared/config.yml ]; then
  # --config /dev/null: never fall back to ~/.cloudflared/config.yml (another tunnel).
  cf() { cloudflared tunnel --config /dev/null --origincert ~/.cloudflared/cert.pem "$@"; }
  tunnel_id() { cf list -o json 2>/dev/null | python3 -c 'import sys,json;print(next((t["id"] for t in json.load(sys.stdin) if t["name"]=="thepill"),""))'; }
  ID=$(tunnel_id)
  [ -n "$ID" ] || { cf create thepill >/dev/null 2>&1; ID=$(tunnel_id); }
  [ -n "$ID" ] || { echo "tunnel thepill not created" >&2; exit 1; }
  install -m 644 ~/.cloudflared/"$ID".json cloudflared/"$ID".json
  sed -e "s/<TUNNEL-ID>/$ID/g" -e "s/<PUBLIC>/$PUBLIC/g" cloudflared/config.yml.example > cloudflared/config.yml
  cf route dns "$ID" "$PUBLIC" 2>&1 | tail -1 || true
  echo "tunnel thepill = $ID"
fi

docker compose up -d --build
ok=
for _ in $(seq 1 30); do
  if docker compose exec -T api pill-core healthcheck 2>/dev/null; then ok=1; break; fi
  sleep 2
done
[ -n "$ok" ] || { docker compose logs --tail 50 api >&2; exit 1; }
mkdir -p ~/deploy
printf '{"at":"%s","project":"ThePill","service":"thepill","version":"%s","host":"%s"}\n' "$(date -u +%FT%TZ)" "$VERSION" "$PUBLIC" >> ~/deploy/events.jsonl
docker compose ps --format '{{.Name}} {{.Status}}'
REMOTE
echo "==> https://$public/healthz"
