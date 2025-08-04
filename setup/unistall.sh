#!/bin/bash
set -e

USER_HOME="$HOME"
BREW_PATH="/home/linuxbrew/.linuxbrew"

echo "Deteniendo y desinstalando Homebrew..."

# Ejecutar el script oficial de desinstalación
if [ -f "$USER_HOME/.linuxbrew/uninstall.sh" ]; then
  echo "Ejecutando script oficial de desinstalación..."
  bash "$USER_HOME/.linuxbrew/uninstall.sh"
else
  echo "Script oficial de desinstalación no encontrado, eliminando directorios manualmente..."
  rm -rf "$BREW_PATH"
fi

# Eliminar líneas de configuración de Homebrew en archivos de shell
remove_line_if_exists() {
  local line="$1"
  local file="$2"
  if [ -f "$file" ]; then
    # Usamos sed para eliminar líneas exactas
    sed -i "\|$line|d" "$file" && echo "Línea removida de $file"
  fi
}

BREW_CONFIG_LINE='eval "\$('"$BREW_PATH"'/bin/brew shellenv)"'

remove_line_if_exists "$BREW_CONFIG_LINE" "$USER_HOME/.bashrc"
remove_line_if_exists "$BREW_CONFIG_LINE" "$USER_HOME/.zshrc"
remove_line_if_exists "$BREW_CONFIG_LINE" "$USER_HOME/.config/fish/config.fish"

# Para nushell, la línea es un poco distinta
NUSHELL_LINE='eval (bash -c "'"$BREW_PATH"'/bin/brew shellenv")'
remove_line_if_exists "$NUSHELL_LINE" "$USER_HOME/.config/nushell/config.nu"

echo "Homebrew desinstalado y configuraciones limpiadas."
