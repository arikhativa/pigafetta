#!/bin/bash
set -e
LOG_FILE="/tmp/deploy.log"
source /home/yoav/pigafetta/.env
source "$(dirname "$0")/utils.sh"

PARENT_DIR="$(dirname "$(dirname "$0")")"
GITHUB_USERNAME="arikhativa"
REPO_NAME="pigafetta"
RELEASE_ID_FILE="/home/yoav/pigafetta/.last_release_id"

log "Starting deployment"

if [ -z "$GITHUB_TOKEN" ]; then
    log "GITHUB_TOKEN is missing"
    exit 1
fi

cd "$PARENT_DIR" || {
    log "Repository not found: $1"
    exit 1
}

log "Starting git fetch"
git fetch

log "Starting git reset"
git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)

log "Checking for new asset"
LATEST=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/$GITHUB_USERNAME/$REPO_NAME/releases/latest") 2>>$LOG_FILE

# Extract asset details
DOWNLOAD_URL=$(echo "$LATEST" | grep -Po '"browser_download_url": "\K[^"]*' | head -1)
RELEASE_ID=$(echo "$LATEST" | grep -Po '"id": \K\d+' | head -1)

if [ -z "$DOWNLOAD_URL" ]; then
    log "No assets found in the latest release"
    exit 1
fi

# Check if we've stored the last release ID
if [ -f "$RELEASE_ID_FILE" ]; then
    LAST_RELEASE_ID=$(cat "$RELEASE_ID_FILE")

    # If the release IDs match, it's not new
    if [ "$LAST_RELEASE_ID" = "$RELEASE_ID" ]; then
        log "Already have the latest release (ID: $RELEASE_ID)"
        exit 0
    fi
fi

log "New release detected! Downloading..."
FILENAME=$(basename "$DOWNLOAD_URL")

log "Downloading asset from github"
curl -L -o "$FILENAME" "$DOWNLOAD_URL" 2>>$LOG_FILE

log "Unzipping asset"
unzip -o $FILENAME 2>>$LOG_FILE

log "Restating the service"
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus
systemctl --user daemon-reload 2>>$LOG_FILE
systemctl --user restart deno-task.service 2>>$LOG_FILE

log "Deployed successfully :)"

echo "$RELEASE_ID" >"$RELEASE_ID_FILE"
