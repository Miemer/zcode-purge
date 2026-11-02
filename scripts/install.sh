#!/usr/bin/env bash
# dsh-purge -> ZCode install script (Git Bash)
# usage: bash scripts/install.sh   (override app path via ZCODE_EXE)
set -euo pipefail
export ELECTRON_RUN_AS_NODE=1
ZCODE_EXE="${ZCODE_EXE:-/f/ZCode/ZCode.exe}"
CLI="$(dirname "$ZCODE_EXE")/resources/glm/zcode.cjs"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ ! -f "$CLI" ]; then echo "ZCode CLI not found: $CLI (set ZCODE_EXE)" >&2; exit 1; fi
"$ZCODE_EXE" "$CLI" plugins validate "$HERE/plugins/dsh-purge"
"$ZCODE_EXE" "$CLI" plugins marketplace add "$HERE"
"$ZCODE_EXE" "$CLI" plugins install dsh-purge@zcode-purge
"$ZCODE_EXE" "$CLI" plugins enable dsh-purge@zcode-purge
"$ZCODE_EXE" "$CLI" plugins list | grep -A2 "dsh-purge@" || true
echo "Done. Restart ZCode: /redteam, /purge-status, redteam-lead, unrestricted-mode, 23 redteam skills."

