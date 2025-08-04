#!/bin/bash

# Global variables
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Imports
. "$PROJECT_ROOT/lib/colors.sh"
. "$PROJECT_ROOT/lib/utils.sh"
. "$PROJECT_ROOT/package_managers/homebrew.sh"
. "$PROJECT_ROOT/lib/detect_os.sh"
show_details=$(select_option "¿Quieres ver la salida detallada de los comandos?" "Yes" "No")

# Detect OS
OS=$(detect_os)

echo "Detected OS: $OS"
# Install essentials
install_and_configure_homebrew $show_details
