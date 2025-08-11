#!/bin/bash
# run-ubuntu.sh

# NOTE: if freshify is not in your HOME folder, please set
# your custom freshify path in your env variables:
# [@.zshrc] export FRESHIFY_DIR=~/path/to/freshify

# Set freshify directory (default to ~/freshify if FRESHIFY_DIR not set)
FRESHIFY_PATH="${FRESHIFY_DIR:-$HOME/freshify}"

# Check if freshify directory exists
if [ ! -d "$FRESHIFY_PATH" ]; then
  echo "❌ Error: Freshify directory not found at: $FRESHIFY_PATH"
  echo "Either:"
  echo "  1. Make sure your freshify repo is at $HOME/freshify, or"
  echo "  2. Set FRESHIFY_DIR environment variable: export FRESHIFY_DIR=~/path/to/freshify"
  exit 1
fi

echo "🚀 Starting fresh Ubuntu container with freshify repo..."
echo "📁 Your freshify repo will be available at: ~/freshify"
echo "💡 Type 'exit' to destroy the container and start fresh"
echo ""

# Run container with freshify repo mounted
docker run -it --rm \
  --name freshify-ubuntu-test \
  -v "$HOME/freshify:/home/developer/freshify:ro" \
  -w /home/developer \
  freshify-ubuntu

echo "🧹 Container destroyed - ready for fresh start!"
