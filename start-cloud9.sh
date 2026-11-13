#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if [[ ! -f .local-admin.env ]]; then
  echo 'Run bash setup-cloud9.sh first.' >&2
  exit 1
fi
set -a
source .local-admin.env
set +a
cd blog
exec bin/rails server -b 0.0.0.0 -p 8080
