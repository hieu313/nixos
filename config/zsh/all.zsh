# Zsh configuration entrypoint.
# Keep this file small: every environment (NixOS, Arch, WSL, etc.) should
# source only this file, and this file orchestrates the rest of the modules.

# Resolve the directory of this sourced file so the entrypoint works both from
# Home Manager's ~/.config/zsh link and direct repo checkouts. Use the entrypoint
# path, not a pre-existing $ZSH, so direct sourcing always loads adjacent modules.
export ZSH="${${(%):-%x}:a:h}"

source "$ZSH/env.zsh"
source "$ZSH/helpers.zsh"

setopt EXTENDED_GLOB

safe_source "$ZSH/plugins.zsh"
safe_source "$ZSH/aliases.zsh"
safe_source "$ZSH/keybindings.zsh"

# Backward compatibility for existing private key/env file.
[[ -r "$ZSH/local.zsh" ]] && safe_source "$ZSH/local.zsh"
