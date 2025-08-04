#!/bin/bash

# Imports
. ../lib/utils.sh
. ../lib/colors.sh

# Install Nushell if not installed
install_nushell() {
  if ! command -v nu &>/dev/null; then
    echo "${BLUE}📦 Installing Nushell with Homebrew...${NC}"
    brew install nushell
  else
    echo "${GREEN}✅ Nushell is already installed.${NC}"
  fi
}

# Add Nushell to /etc/shells if it's not there
add_nushell_to_shells() {
  local nu_path
  nu_path="$(command -v nu)"
  if ! grep -Fxq "$nu_path" /etc/shells; then
    echo "${YELLOW}🛠 Adding Nushell to /etc/shells (requires sudo)...${NC}"
    echo "$nu_path" | sudo tee -a /etc/shells
  else
    echo "${GREEN}✅ Nushell already listed in /etc/shells${NC}"
  fi
}

# Change the default shell to Nushell
set_default_shell_to_nushell() {
  local nu_path
  nu_path="$(command -v nu)"
  if [ "$SHELL" != "$nu_path" ]; then
    echo "${PURPLE}🔄 Changing default shell to Nushell...${NC}"
    chsh -s "$nu_path"
    echo "${GREEN}✅ Default shell changed. Restart your terminal.${NC}"
  else
    echo "${GREEN}✅ Nushell is already your default shell.${NC}"
  fi
}

main() {
  install_nushell
  add_nushell_to_shells
  set_default_shell_to_nushell
}

main
