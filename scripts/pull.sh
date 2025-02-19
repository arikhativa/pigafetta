#!/bin/bash

# Check if the repository path is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <repository-path>"
  exit 1
fi

# Navigate to the repository
cd "$1" || { echo "Repository not found: $1"; exit 1; }

# Run git pull
git pull