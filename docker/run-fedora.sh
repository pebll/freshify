#!/bin/bash
# run-fedora.sh

echo "🚀 Starting fresh Fedora container with freshify repo..."
echo "📁 Your freshify repo will be available at: ~/freshify"
echo "💡 Type 'exit' to destroy the container and start fresh"
echo ""

# Run container with freshify repo cloned
docker run -it --rm \
  --name freshify-fedora-test \
  -w /home/developer \
  freshify-fedora \
  bash -c "
    git clone https://github.com/pebll/freshify.git
    cd ~/freshify
    exec bash
    "

echo "🧹 Container destroyed - ready for fresh start!"
