#!/bin/bash
# build-containers.sh

set -e

echo "Building Ubuntu development container..."
docker build -f Dockerfile.ubuntu -t freshify-ubuntu .

echo "Building Fedora development container..."
docker build -f Dockerfile.fedora -t freshify-fedora .

echo "✅ Both containers built successfully!"
echo ""
echo "Usage:"
echo "  ./run-ubuntu.sh   - Start Ubuntu container with freshify repo"
echo "  ./run-fedora.sh   - Start Fedora container with freshify repo"
