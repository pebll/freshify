#!/bin/bash

# Global variables
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Imports
. "$PROJECT_ROOT/lib/colors.sh"
. "$PROJECT_ROOT/lib/utils.sh"
. "$PROJECT_ROOT/package_managers/homebrew.sh"
. "$PROJECT_ROOT/lib/detect_os.sh"

# Detect OS
OS=$(detect_os)

# Logo
logo="
⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣤⣄⣀⣀⡀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⠶
⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀
⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀
⢀⣠⠞⠋⠉⠛⠻⠿⣿⣿⣿⠿⠟⠋⠀⠀⠀⠀⠀
⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
"
echo "$GREEN $logo $NC"
echo "$GREEN Welcome to Freshify, your $PURPLE$OS$NC$GREEN will config automatically $NC"

show_details=$(select_option "Do you want to see the detailed output of the commands?" "Yes" "No")

# Install essentials
install_and_configure_homebrew $show_details
