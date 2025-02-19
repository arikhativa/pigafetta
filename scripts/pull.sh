#!/bin/bash

LOG_FILE="/tmp/pull.log"

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

if [ -z "$1" ]; then
  log "Usage: $0 <repository-path>"
  exit 1
fi

cd "$1" || { log "Repository not found: $1"; exit 1; }

log "Starting git fetch"
git fetch >> "$LOG_FILE" 2>&1

log "Starting git reset"
git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)

log "Pull completed successfully"