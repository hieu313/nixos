# Zsh Configuration
# Main configuration file - consolidated from multiple files

# ============================================================================
# 1. XDG Base Directory
# ============================================================================
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# ============================================================================
# 2. Helpers
# ============================================================================
# log_info: log info
log_info() { echo "ℹ️ $1"; }

# log_error: log error
log_error() { echo "❌ $1"; }

# safe_source: only source when file readable
safe_source() { has_readable "$1" && source "$1" || log_error "Failed to source $1"; }

# has: check if command exists
has_command() { 
	if command -v "$1" >/dev/null 2>&1; then
		return 0;
	else
		log_error "Command $1 does not exist";
		return 1;
	fi
}

has_directory() { 
	if [[ -d "$1" ]]; then
		return 0;
	else
		log_error "Directory $1 does not exist";
		return 28;
	fi
}

has_file() { 
	if [[ -f "$1" ]]; then
		return 0;
	else
		log_error "File $1 does not exist";
		return 1;
	fi
}

has_readable() { 
	if [[ -r "$1" ]]; then
		return 0;
	else
		log_error "File $1 is not readable";
		return 1;
	fi
}

check_file_size() { 
	if [[ -s "$1" ]]; then
		return 0;
	else
		log_error "File $1 is not size";
		return 1;
	fi
}

# join: join string by delimiter
join() { local IFS="$1"; shift; echo "$*"; }

# is_linux: check if current OS is Linux
is_linux() { [[ "$OSTYPE" == linux* ]]; }

# is_macos: check if current OS is macOS
is_macos() { [[ "$OSTYPE" == darwin* ]]; }

# is_wsl: check if running under WSL
is_wsl() { [[ "$(uname -r)" == *microsoft* ]]; }

# is_running_in_warp_terminal
is_running_in_warp_terminal() { [[ "$TERM_PROGRAM" == "WarpTerminal" ]]; }

# reload: reload zsh configuration
reload() { exec "$SHELL" -l; }

# ============================================================================
# 3. Environment Variables
# ============================================================================
# Common
export DOTFILES="$HOME/dotfiles"
export ZSH="$XDG_CONFIG_HOME/zsh"
export PATH="$HOME/.local/bin:$PATH"

# Editor
local nvim_path="/home/hieunm/.nix-profile/bin/nvim"
export SUDO_EDITOR="$nvim_path"
export VISUAL="$nvim_path"
export EDITOR="$nvim_path"
export TERM=xterm-256color

# Rust
export RUST_BACKTRACE=1

# Docker
has_directory "$XDG_CONFIG_HOME/docker" && export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# Input methods (fcitx5)
if has_command fcitx5; then
    export XMODIFIERS="@im=fcitx"
    export INPUT_METHOD=fcitx
    export SDL_IM_MODULE=fcitx
    export GLFW_IM_MODULE=fcitx
    # Uncomment if needed:
    # export GTK_IM_MODULE=fcitx
    # export QT_IM_MODULE=fcitx
fi

# Wine configuration
has_directory "$HOME/WindowsApps" && export WINEPREFIX="$HOME/WindowsApps"

# ============================================================================
# 4. Zinit Plugin Manager Setup
# ============================================================================
# Zinit installation directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if not present
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$(dirname $ZINIT_HOME)"
    command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

# Load Zinit
source "$ZINIT_HOME/zinit.zsh"
setopt EXTENDED_GLOB
### 5.1. Core & Utilities (Load immediately or very fast)
# zsh-defer: Helper to defer heavy commands execution
zinit light romkatv/zsh-defer

# OMZ Libs: directories (cho alias ..), git lib (cần cho git plugin)
# Load mức độ ưu tiên cao (0a) để alias .. hoạt động ngay lập tức
zinit wait'0a' lucid for \
    OMZ::lib/directories.zsh \
    OMZ::lib/git.zsh \
    OMZ::lib/theme-and-appearance.zsh

### 5.2. UI & UX (Essential for interaction)
# Autosuggestions & Fast Syntax Highlighting
# Lưu ý: Đã xóa zsh-users/zsh-syntax-highlighting vì Fast-syntax tốt hơn
zinit wait'0a' lucid for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start; ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(print-alias-widget bracketed-paste-magic)" \
        zsh-users/zsh-autosuggestions \
    blockf \
        zsh-users/zsh-completions

# FZF-Tab: Biến Tab thành menu chọn (Cần cài fzf trước)
zinit wait'0a' lucid for Aloxaf/fzf-tab

### 5.3. OMZ Plugins & Tools (Defer loading)
# Load các plugin thông dụng của OMZ
zinit wait'0b' lucid for \
    OMZ::plugins/git/git.plugin.zsh \
    OMZ::plugins/sudo/sudo.plugin.zsh \
    OMZ::plugins/extract/extract.plugin.zsh \
    OMZ::plugins/archlinux/archlinux.plugin.zsh

# Các plugin nặng hơn hoặc ít dùng ngay khi khởi động thì delay lâu hơn chút (wait'1')
zinit wait'1' lucid for \
    OMZ::plugins/tmux/tmux.plugin.zsh \
    OMZ::plugins/docker/docker.plugin.zsh \
    MichaelAquilina/zsh-you-should-use

zinit wait'0b' lucid \
    atload'bindkey "^[[A" history-substring-search-up; bindkey "^[[B" history-substring-search-down' \
    for zsh-users/zsh-history-substring-search

### 5.4. Advanced Tools (Installed via Zinit)
# Forgit: Interactive Git (gõ 'glo' để xem log, 'ga' để add file có preview)
zinit ice wait'1' lucid
zinit light wfxr/forgit
zinit light brymck/print-alias
# ============================================================================
# 5. Zsh Options & Key Bindings
# ============================================================================

# Core key bindings
bindkey '^Z' undo

# ============================================================================
# 6. Theme (managed by NixOS Home Manager - programs.starship)
# ============================================================================

# ============================================================================
# 7. External Tool Integrations
# ============================================================================
# fzf - load immediately (needed for keybindings)
if has_command fzf; then
    source <(fzf --zsh)
fi

# atuin - deferred loading
if has_command atuin; then
    zsh-defer -c 'eval "$(atuin init zsh --disable-up-arrow)"'
fi

# fzf-git - deferred loading
if [[ -r "$HOME/.config/fzf/fzf-git.sh" ]]; then
    zsh-defer -t 0.5 -c 'source "$HOME/.config/fzf/fzf-git.sh"'
fi

# zoxide - deferred loading
if has_command zoxide; then
    zsh-defer -c 'eval "$(zoxide init zsh)"'
fi

# pay-respects - deferred loading
if has_command pay-respects; then
    zsh-defer -c 'eval "$(pay-respects zsh --alias)"'
fi

# fnm - deferred loading
if has_command fnm; then
    zsh-defer -c 'eval "$(fnm env --use-on-cd --shell zsh)"'
fi


# ============================================================================
# 8. CLI Tools Configuration
# ============================================================================
# Eza config dir (theme deployed by NixOS Home Manager)
export EZA_CONFIG_DIR="$HOME/.config/eza"
export EZA_ICONS_AUTO=1

# Modern command replacements
has_command fd && export FDFIND_DEFAULT_COMMAND="fd -H"
has_command eza && export EZA_DEFAULT_COMMAND="eza --icons=always --long --color=always -a"
has_command bat && export BAT_DEFAULT_COMMAND="bat"
has_command rg && export RG_DEFAULT_COMMAND="rg --color=always --smart-case --line-number --column"

# FZF environment variables
if has_command fzf; then
  ## FZF preview helpers
  export FZF_PREVIEW_FOLDER="$EZA_DEFAULT_COMMAND --tree --level=2"
  export FZF_PREVIEW_FILE="$BAT_DEFAULT_COMMAND --style=numbers"
  export FZF_DEFAULT_FIND="$FDFIND_DEFAULT_COMMAND"

  ## FZF default commands
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

  ## CTRL-T (files) default
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

  ## ALT-C (cd) default
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

  ## CTRL-R (history) default
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
fi

# Print aliases
export PRINT_ALIAS_PREFIX='  ╰─> '
export PRINT_ALIAS_FORMAT=$'\e[1m'
export PRINT_NON_ALIAS_FORMAT=$'\e[0m'

# ============================================================================
# 9. Custom Functions
# ============================================================================
# fzfrg: find content by ripgrep + open file at line by $EDITOR
function fzfrg {
  local selected=$(
    rg --color=always --line-number --no-heading --smart-case --colors 'match:fg:cyan' . |
    fzf --ansi \
        --border-label '🔎 Find with ripgrep' \
        --delimiter : \
        --preview "bat --style=numbers --color=always --highlight-line {2} --theme='Visual Studio Dark+' {1}" \
        --layout reverse --multi --min-height 20+ --border \
        --no-separator --header-border horizontal \
        --border-label-pos 5 \
        --preview-window=right:50% \
        --bind 'ctrl-/:change-preview-window(down,70%|hidden|)'
  )
  if [[ -n "$selected" ]]; then
    local file="${${selected%%:*}}"
    local line="${${selected#*:}%%:*}"
    if [[ -n "$EDITOR" ]]; then
      "$EDITOR" +$line "$file"
    else
      vi +$line "$file"
    fi
  fi
}

# fzf_kill_process: select process by %CPU then kill
function fzf_kill_process {
  local pid
  pid=$(ps -eo pid,comm,user,%cpu,%mem --sort=-%cpu | \
    sed 1d | \
    fzf --header="Select process to kill" --preview="ps -p {1} -o pid,ppid,cmd,%cpu,%mem" | \
    awk '{print $1}')
  if [[ -n "$pid" ]]; then
    kill -9 "$pid" && echo "Killed process $pid"
  fi
}

# ============================================================================
# 11. Custom Key Bindings
# ============================================================================
# FZF keybindings
if has_command fzf; then
  ## Ctrl+F: FZF + ripgrep integration
  zle -N fzfrg_widget fzfrg
  bindkey '^F' fzfrg_widget

  ## Ctrl+K: FZF process killer
  zle -N fzf_kill_process
  bindkey '^K' fzf_kill_process
fi

# ============================================================================
# 10. Custom Aliases: Move to last with zsh-defer because it must be loaded after all other plugins are loaded to avoid conflicts
# ============================================================================
zsh-defer -c 'source "$ZSH/aliases.zsh"'
# import api keys or something else do not want to be committed
if [ -f "$ZSH/keys.zsh" ]; then
  source "$ZSH/keys.zsh"
fi