#!/bin/bash

# Global variables
USER_HOME="$HOME"
BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"

add_brew_to_nushell() {
  local file="$USER_HOME/.config/nushell/config.nu"
  mkdir -p "$(dirname "$file")"
  local line="eval (bash -c \"$BREW_PATH shellenv\")"

  if ! grep -Fxq "$line" "$file" 2>/dev/null; then
    echo "$line" >>"$file"
    echo "${GREEN}✅ Added brew config to $file${NC}"
  else
    echo "${YELLOW}ℹ️  Brew config already in $file${NC}"
  fi
}

install_and_configure_homebrew() {
  local show_details="$1"

  if ! command -v brew &>/dev/null; then
    echo "${BLUE}📦 Homebrew not found. Installing...${NC}"
    run_command 'yes "" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"' "$show_details"
  else
    echo "${GREEN}✅ Homebrew already installed.${NC}"
  fi

  local line="eval \"\$($BREW_PATH shellenv)\""

  add_line_if_not_exists "$line" "$USER_HOME/.bashrc"
  add_line_if_not_exists "$line" "$USER_HOME/.zshrc"
  add_line_if_not_exists "$line" "$USER_HOME/.config/fish/config.fish"
  add_brew_to_nushell

  eval "$($BREW_PATH shellenv)"
  echo "${GREEN}🚀 Homebrew configured for Bash, Zsh, Fish and Nushell.${NC}"
}
