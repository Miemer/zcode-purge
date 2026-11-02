#!/usr/bin/env bash
set -euo pipefail
export ELECTRON_RUN_AS_NODE=1
ZCODE_EXE="${ZCODE_EXE:-/f/ZCode/ZCode.exe}"
CLI="$(dirname "$ZCODE_EXE")/resources/glm/zcode.cjs"
"$ZCODE_EXE" "$CLI" plugins uninstall dsh-purge@zcode-purge --force || true
"$ZCODE_EXE" "$CLI" plugins marketplace remove zcode-purge || true
echo "Uninstalled."

