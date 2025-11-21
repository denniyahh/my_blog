#!/usr/bin/env bash
# Run the mobile-first verification loop described in specs/001-mobile-first-redesign.
# Steps:
#   1. bundle exec jekyll build --config _config.yml,_config.ci.yml
#   2. bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https
#   3. npx markdownlint-cli2 "**/*.md"
#   4. Start a local Jekyll preview server, collect Lighthouse Mobile metrics via npx @lhci/cli, then shut the server down.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if git -C "$SCRIPT_DIR" rev-parse --show-toplevel >/dev/null 2>&1; then
    REPO_ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel)"
else
    # Script lives under docs/.specify/scripts/bash -> repo root is four levels up
    REPO_ROOT="$(cd "$SCRIPT_DIR/../../../../" && pwd)"
fi
LOG_ROOT="$REPO_ROOT/tmp/mobile-preview"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
RUN_DIR="$LOG_ROOT/$TIMESTAMP"
mkdir -p "$RUN_DIR"

PORT="${PREVIEW_PORT:-4001}"
LH_URL="http://127.0.0.1:${PORT}"
SERVER_LOG="$RUN_DIR/jekyll-serve.log"
JEKYLL_PID_FILE="$RUN_DIR/jekyll.pid"

shopt -s globstar nullglob

run_step() {
    local label="$1"
    shift
    local log_file="$RUN_DIR/${label// /-}.log"

    echo "[mobile-preview] -> $label"
    if "$@" &> "$log_file"; then
        echo "[mobile-preview] OK $label (log: $log_file)"
    else
        echo "[mobile-preview] FAIL $label failed (log: $log_file)" >&2
        exit 1
    fi
}

start_preview_server() {
    echo "[mobile-preview] -> Starting Jekyll preview server on $LH_URL"
    (cd "$REPO_ROOT" && \
        bundle exec jekyll serve \
            --host 127.0.0.1 \
            --port "$PORT" \
            --force_polling \
            --detach) &> "$SERVER_LOG"

    for attempt in {1..10}; do
        if [[ -f "$REPO_ROOT/jekyll.pid" ]]; then
            mv "$REPO_ROOT/jekyll.pid" "$JEKYLL_PID_FILE"
            break
        fi
        sleep 1
    done

    if [[ ! -f "$JEKYLL_PID_FILE" ]]; then
        echo "[mobile-preview] WARN jekyll.pid not found; falling back to parsing $SERVER_LOG"
        if grep -q "Server detached with pid" "$SERVER_LOG"; then
            sed -n "s/.*pid '\\([0-9]*\\)'.*/\\1/p" "$SERVER_LOG" > "$JEKYLL_PID_FILE"
        fi
    fi

    if [[ ! -s "$JEKYLL_PID_FILE" ]]; then
        echo "[mobile-preview] FAIL Failed to detect jekyll.pid; check $SERVER_LOG" >&2
        exit 1
    fi

    for attempt in {1..15}; do
        if curl -fsS "$LH_URL" >/dev/null 2>&1; then
            echo "[mobile-preview] OK Preview server ready"
            return
        fi
        sleep 1
    done

    echo "[mobile-preview] FAIL Preview server did not become ready; check $SERVER_LOG" >&2
    stop_preview_server
    exit 1
}

stop_preview_server() {
    if [[ -f "$JEKYLL_PID_FILE" ]]; then
        local pid
        pid="$(cat "$JEKYLL_PID_FILE")"
        if ps -p "$pid" >/dev/null 2>&1; then
            kill "$pid" >/dev/null 2>&1 || true
            wait "$pid" 2>/dev/null || true
        fi
        rm -f "$JEKYLL_PID_FILE"
    fi
}

trap stop_preview_server EXIT

cd "$REPO_ROOT"

run_step "jekyll-build" \
    bundle exec jekyll build --config _config.yml,_config.ci.yml

run_step "htmlproofer" \
    bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https

run_step "markdownlint" \
    npx markdownlint-cli2 "**/*.md"

start_preview_server

CHROME_BIN=${CHROME_PATH:-$(command -v chromium || command -v google-chrome-stable || command -v google-chrome || true)}
run_step "lighthouse-mobile" \
    env CHROME_PATH="$CHROME_BIN" npx @lhci/cli collect \
        --url "$LH_URL" \
        --collect.settings.preset=experimental \
        --collect.numberOfRuns=1 \
        --collect.settings.chromeFlags="--headless=new --no-sandbox --disable-dev-shm-usage" \
        --collect.settings.disableStorageReset \
        --outputDir "$RUN_DIR/lighthouse"

echo "[mobile-preview] Reports available in $RUN_DIR"
