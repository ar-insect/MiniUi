#!/usr/bin/env zsh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="${SCRIPT_DIR%/tools}"

cd "$PROJECT_ROOT"

flutter run -t example/lib/main.dart -d ios

