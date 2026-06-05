# Environment variables loaded before all other Zsh modules.
# Do not depend on helper functions here; helpers load after this file.

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export DOTFILES="${DOTFILES:-$HOME/dotfiles}"
export ZSH="${ZSH:-$XDG_CONFIG_HOME/zsh}"
export PATH="$HOME/.local/bin:$PATH"
    
# Editor
nvim_path="$HOME/.nix-profile/bin/nvim"
export SUDO_EDITOR="$nvim_path"
export VISUAL="$nvim_path"
export EDITOR="$nvim_path"
export TERM="${TERM:-xterm-256color}"
unset nvim_path

# Rust
export RUST_BACKTRACE="${RUST_BACKTRACE:-1}"

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# Input methods (fcitx5)
if command -v fcitx5 >/dev/null 2>&1; then
  export XMODIFIERS="@im=fcitx"
  export INPUT_METHOD=fcitx
  export SDL_IM_MODULE=fcitx
  export GLFW_IM_MODULE=fcitx
  # Uncomment if needed:
  # export GTK_IM_MODULE=fcitx
  # export QT_IM_MODULE=fcitx
fi

# Wine configuration
export WINEPREFIX="$HOME/WindowsApps"

# Eza configuration
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"
export EZA_ICONS_AUTO=1

# Modern command replacements.
export FDFIND_DEFAULT_COMMAND="fd -H"
export EZA_DEFAULT_COMMAND="eza --icons=always --long --color=always -a"
export BAT_DEFAULT_COMMAND="bat"
export RG_DEFAULT_COMMAND="rg --color=always --smart-case --line-number --column"

# FZF environment variables.
export FZF_PREVIEW_FOLDER="$EZA_DEFAULT_COMMAND --tree --level=2"
export FZF_PREVIEW_FILE="$BAT_DEFAULT_COMMAND --style=numbers"
export FZF_DEFAULT_FIND="$FDFIND_DEFAULT_COMMAND"

# FZF default commands.
export FZF_DEFAULT_COMMAND="$FZF_DEFAULT_FIND"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_FIND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_FIND"

export FZF_DEFAULT_OPTS="
  --style full
  --ansi
  --layout=reverse
  --border=none
  --marker=✔
  --pointer=➤
  --color=label:#aeaeae
  --info=right
"

# CTRL-T (files) default.
export FZF_CTRL_T_OPTS="
  --preview='[[ -d {} ]] && $FZF_PREVIEW_FOLDER {} | nl || $FZF_PREVIEW_FILE {}'
  --header='Press CTRL-A to select all | Press ALT-E to edit the selected'
  --bind='ctrl-a:select-all'
  --bind='alt-e:execute:\$EDITOR {} > /dev/tty'
  --multi
  --border-label='🔎 Find files, folders'
  --border
  --border-label-pos 5
  --no-separator
  --header-border horizontal
  --min-height 20+
  --preview-window=right:50%
  --bind='ctrl-/:change-preview-window(down,70%|hidden|)'
"

# ALT-C (cd) default.
export FZF_ALT_C_OPTS="
  --preview='$FZF_PREVIEW_FOLDER {} | nl'
  --walker-skip .git,node_modules
  --border-label='CD into the selected directory'
  --border
  --border-label-pos 5
  --no-separator
  --header-border horizontal
  --min-height 20+
  --preview-window=right:50%
  --bind='ctrl-/:change-preview-window(down,70%|hidden|)'
"

# CTRL-R (history) default.
export FZF_CTRL_R_OPTS="
  --preview='echo {2..} | bat --color=always -pl sh'
  --preview-window=up:hidden:wrap
  --bind='ctrl-/:change-preview-window(right:50%|down:30%|)'
  --bind='ctrl-y:execute-silent(echo -n {2..} | wl-copy)'
  --color=header:italic
  --header='CTRL-Y: copy | CTRL-/: change preview'
  --color=border:#c8b3b3
  --border-label='🔎 Find command'
  --border
  --border-label-pos 5
  --no-separator
  --header-border horizontal
"

# Print aliases.
export PRINT_ALIAS_PREFIX='  ╰─> '
export PRINT_ALIAS_FORMAT=$'\e[1m'
export PRINT_NON_ALIAS_FORMAT=$'\e[0m'
