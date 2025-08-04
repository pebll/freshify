#!/bin/bash

add_line_if_not_exists() {
  local line="$1"
  local file="$2"

  mkdir -p "$(dirname "$file")"
  if ! grep -Fxq "$line" "$file" 2>/dev/null; then
    echo "$line" >>"$file"
    echo "Added config to $file"
  else
    echo "Config already in $file"
  fi
}

run_command() {
  local command="$1"
  local verbose="$2"

  if [ "$verbose" = "Yes" ]; then
    eval "$command"
  else
    eval "$command" &>/dev/null
  fi
}

select_option() {
  local prompt_message="$1"
  shift
  local options=("$@")
  PS3="${ORANGE}$prompt_message${NC} "
  select opt in "${options[@]}"; do
    if [ -n "$opt" ]; then
      echo "$opt"
      break
    else
      echo -e "${RED}Invalid option. Please try again.${NC}"
    fi
  done
}
