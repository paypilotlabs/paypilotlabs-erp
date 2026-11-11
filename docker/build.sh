#!/usr/bin/env bash
# Build the PayPilotLabs ERP image with frappe_docker's custom Containerfile (Frappe v16: Python 3.14, Node 24).
# Needs: docker and git. GITHUB_TOKEN is only needed while the paypilotlabs repos are private.
#   ./docker/build.sh                 (public repos)
#   GITHUB_TOKEN=ghp_xxx ./docker/build.sh
# Branches: FRAPPE_BRANCH for paypilotlabs-framework; app branches are in docker/apps.json.
set -euo pipefail
cd "$(dirname "$0")/.."
[ -d .frappe_docker ] || git clone --depth 1 https://github.com/frappe/frappe_docker .frappe_docker
AUTH=${GITHUB_TOKEN:+${GITHUB_TOKEN}@}
APPS_JSON=$(mktemp)
trap 'rm -f "$APPS_JSON"' EXIT
sed "s#https://github.com/#https://${AUTH}github.com/#" docker/apps.json > "$APPS_JSON"
# apps.json goes in as a build secret (what the Containerfile reads), so a token never lands in the image history.
# Secrets are not part of BuildKit's cache key: without CACHE_BUST, builds of two products share the bench layer.
docker build \
  --secret=id=apps_json,src="$APPS_JSON" \
  --build-arg=CACHE_BUST="$(git hash-object docker/apps.json)" \
  --build-arg=FRAPPE_PATH="https://${AUTH}github.com/paypilotlabs/paypilotlabs-framework.git" \
  --build-arg=FRAPPE_BRANCH="${FRAPPE_BRANCH:-develop}" \
  --build-arg=PYTHON_VERSION=3.14 \
  --build-arg=NODE_VERSION=24 \
  --tag="${IMAGE:-paypilotlabs/erp}:${TAG:-latest}" \
  --file=.frappe_docker/images/custom/Containerfile \
  .frappe_docker
