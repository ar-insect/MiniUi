#!/usr/bin/env zsh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="${SCRIPT_DIR%/tool}"

cd "$PROJECT_ROOT"

flutter run -t example/lib/main.dart -d android
