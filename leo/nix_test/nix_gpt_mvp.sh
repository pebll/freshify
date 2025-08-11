#!/bin/bash

# Fresh Linux Setup Script with Nix
# This script installs Nix package manager and essential development tools

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
  log_error "This script should not be run as root"
  exit 1
fi

# Update system packages first
log_info "Updating system packages..."
if command -v apt &>/dev/null; then
  sudo apt update && sudo apt upgrade -y
  sudo apt install -y curl wget git xz-utils
elif command -v dnf &>/dev/null; then
  sudo dnf update -y
  sudo dnf install -y curl wget git xz
elif command -v pacman &>/dev/null; then
  sudo pacman -Syu --noconfirm
  sudo pacman -S --noconfirm curl wget git xz
elif command -v zypper &>/dev/null; then
  sudo zypper refresh && sudo zypper update -y
  sudo zypper install -y curl wget git xz
else
  log_warn "Unknown package manager. Please ensure curl, wget, git, and xz-utils are installed."
fi

log_success "System packages updated"

# Install Nix
if ! command -v nix &>/dev/null; then
  log_info "Installing Nix package manager..."

  # Install Nix with the Determinate Nix installer (more reliable than the official installer)
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

  # Source nix in current shell
  if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  fi

  log_success "Nix installed successfully"
else
  log_info "Nix is already installed"
fi

# Enable flakes and nix-command (modern Nix features)
log_info "Configuring Nix with flakes support..."
mkdir -p ~/.config/nix
cat >~/.config/nix/nix.conf <<EOF
experimental-features = nix-command flakes
auto-optimise-store = true
max-jobs = auto
EOF

log_success "Nix configuration updated"

# Source Nix environment
if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Install packages with Nix
log_info "Installing essential packages with Nix..."

# Core packages to install
PACKAGES=(
  "neovim"
  "tmux"
  "kitty"
  "git"
  "curl"
  "wget"
  "ripgrep"     # Better grep, essential for LazyVim
  "fd"          # Better find, used by many nvim plugins
  "fzf"         # Fuzzy finder
  "bat"         # Better cat with syntax highlighting
  "eza"         # Better ls
  "zoxide"      # Better cd
  "starship"    # Shell prompt
  "lazygit"     # Git TUI
  "tree-sitter" # Syntax highlighting
  "nodejs_20"   # For nvim plugins
  "python3"     # For nvim plugins
  "gcc"         # For compiling nvim plugins
  "gnumake"     # Build tool
  "unzip"       # For extracting plugins
  "htop"        # System monitor
  "btop"        # Better system monitor
  "neofetch"    # System info
  "jq"          # JSON processor
  "yq"          # YAML processor
  "direnv"      # Environment management
)

# Install packages
nix-env -iA $(printf "nixpkgs.%s " "${PACKAGES[@]}")

log_success "Essential packages installed"

# Install LazyVim
log_info "Setting up LazyVim..."

# Backup existing nvim config if it exists
if [ -d ~/.config/nvim ]; then
  log_warn "Existing nvim config found. Backing up to ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
  mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
fi

if [ -d ~/.local/share/nvim ]; then
  log_warn "Existing nvim data found. Backing up to ~/.local/share/nvim.backup.$(date +%Y%m%d_%H%M%S)"
  mv ~/.local/share/nvim ~/.local/share/nvim.backup.$(date +%Y%m%d_%H%M%S)
fi

if [ -d ~/.local/state/nvim ]; then
  log_warn "Existing nvim state found. Backing up to ~/.local/state/nvim.backup.$(date +%Y%m%d_%H%M%S)"
  mv ~/.local/state/nvim ~/.local/state/nvim.backup.$(date +%Y%m%d_%H%M%S)
fi

if [ -d ~/.cache/nvim ]; then
  log_warn "Existing nvim cache found. Backing up to ~/.cache/nvim.backup.$(date +%Y%m%d_%H%M%S)"
  mv ~/.cache/nvim ~/.cache/nvim.backup.$(date +%Y%m%d_%H%M%S)
fi

# Clone LazyVim starter
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

log_success "LazyVim installed"

# Create basic tmux config
log_info "Setting up tmux configuration..."
cat >~/.tmux.conf <<'EOF'
# Set prefix to Ctrl-a
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Reload config file
bind r source-file ~/.tmux.conf

# Switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Enable mouse control
set -g mouse on

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Status bar
set -g status-bg black
set -g status-fg white
set -g status-left '#[fg=green]#H '
set -g status-right '#[fg=yellow]#(uptime | cut -d, -f1)'

# 256 colors
set -g default-terminal "screen-256color"
EOF

log_success "Tmux configuration created"

# Setup shell integrations
log_info "Setting up shell integrations..."

# Add to bashrc/zshrc
SHELL_RC=""
if [ -n "${BASH_VERSION:-}" ]; then
  SHELL_RC="$HOME/.bashrc"
elif [ -n "${ZSH_VERSION:-}" ]; then
  SHELL_RC="$HOME/.zshrc"
else
  # Default to bashrc
  SHELL_RC="$HOME/.bashrc"
fi

# Add Nix to PATH and other tools
cat >>"$SHELL_RC" <<'EOF'

# Nix
if [ -e /home/$USER/.nix-profile/etc/profile.d/nix.sh ]; then 
    . /home/$USER/.nix-profile/etc/profile.d/nix.sh; 
fi

# Starship prompt
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

# Direnv
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

# Aliases
alias ls='eza --color=always --group-directories-first'
alias ll='eza -alF --color=always --group-directories-first'
alias la='eza -a --color=always --group-directories-first'
alias l='eza -F --color=always --group-directories-first'
alias lt='eza -aT --color=always --group-directories-first'
alias cat='bat'
alias cd='z'

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
EOF

log_success "Shell configuration updated"

# Create a simple git configuration
log_info "Setting up basic git configuration..."
if ! git config --global user.name >/dev/null 2>&1; then
  log_warn "Git user.name not set. Please run: git config --global user.name 'Your Name'"
fi

if ! git config --global user.email >/dev/null 2>&1; then
  log_warn "Git user.email not set. Please run: git config --global user.email 'your.email@example.com'"
fi

# Set some sensible git defaults
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor nvim

log_success "Git configuration updated"

# Final instructions
echo ""
log_success "Setup completed successfully!"
echo ""
log_info "What was installed:"
echo "  ✓ Nix package manager with flakes support"
echo "  ✓ Neovim with LazyVim configuration"
echo "  ✓ Tmux with basic configuration"
echo "  ✓ Kitty terminal emulator"
echo "  ✓ Modern CLI tools (ripgrep, fd, fzf, bat, eza, zoxide, starship)"
echo "  ✓ Development tools (lazygit, tree-sitter, nodejs, python)"
echo ""
log_info "Next steps:"
echo "  1. Restart your terminal or run: source $SHELL_RC"
echo "  2. Open nvim to let LazyVim install plugins automatically"
echo "  3. Configure git if not already done:"
echo "     git config --global user.name 'Your Name'"
echo "     git config --global user.email 'your.email@example.com'"
echo "  4. Consider setting Kitty as your default terminal"
echo ""
log_info "Enjoy your new development environment!"
