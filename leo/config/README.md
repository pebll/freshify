# Thoughts:

Probably would make sense to have one main config file (like this one) that sets all the high level stuff, and then to have specific config files for specific configs for example keybindings, shortcuts, shell_config, nvim_config, tmux_config,...

# Needed Configuration elements

## System
- os: (Linux/Windows)
- version: (Ubuntu 22/WSL2/...)

## Shell
- default_shell: (bash/zsh/fish/nush/...)

## Keybinds
- caps_is_esc: (yes/no)
- caps_is_ctrl: (yes/no)
- compose_key: (None/left_ctrl/alt/...)
- keybinds:
  - compose + j = (
  - compose + z = ß
  - ...

## Shortcuts
- preferred_shortcuts: (alias/abbreviation) [depending on what is available]
- shortcuts:
  - git: 
    - gd: git diff
    - gco: git checkout
    - ...
  - python:
    - pr: python -m 
    - cvenv: python -m venv .venv
    - svenv: source ./.venv/bin/activate
    - ...
  - ...

## Editor
- preferred_keybinds: (default/vim/emacs) [for different software if possibility to set keybinds use this parameter]
- editor: (vim/nvim/vscode/...)
- config: (config file path idk?)

## Terminal
- terminal: (default/kitty/wezterm/...)

## Terminal Multiplexer
- use_tmux: (yes/no)


