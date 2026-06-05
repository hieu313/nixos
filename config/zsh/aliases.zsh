# Custom aliases.

# Common.
alias mkdir="mkdir -pv"
alias cp="cp -r"
alias wifi="nmcli device wifi"
command_exists eza && alias ls="$EZA_DEFAULT_COMMAND"
command_exists eza && alias tree="eza --icons=always --color=always -a --tree --git --level=2"

# Navigate by zoxide.
command_exists zoxide && alias cd="z"

# Default tools.
alias bat="$BAT_DEFAULT_COMMAND"
alias fd="$FDFIND_DEFAULT_COMMAND"
alias rg="$RG_DEFAULT_COMMAND"

# Trash-cli instead of rm.
alias rmrm="command rm -rf"
if command_exists trash; then
  alias rm="trash"
  alias rmlist="trash list"
  alias rmrestore="trash restore"
  alias rmempty="trash empty"
fi

# Wayland clipboard.
if ! is_wsl; then
  command_exists wl-copy && alias copy="wl-copy"
  command_exists wl-paste && alias paste="wl-paste"
fi

# Disk/duf.
command_exists duf && alias df="duf"
alias du="du -ahx --max-depth=1 . | sort -hr"

# Fzf.
alias fzf="fzf --preview-window=right:50% --preview='[[ -d {} ]] && $FZF_PREVIEW_FOLDER {} | nl || $FZF_PREVIEW_FILE {}'"

# Fun.
alias rain="terminal-rain"
alias cbonsai="cbonsai --screensaver --life 40 --multiplier 5 --time 20 --screensaver"

# Tmux.
alias tx="tmux"

# Lazygit/Lazydocker.
alias lzg="lazygit"
alias lzd="lazydocker"

# Gemini CLI.
# command_exists gemini && alias how="gemini -p"
alias gitgraph="serie"

# Amazing.
alias please='sudo $(fc -ln -1)'
alias lich="curl lich.day"
alias weather="curl wttr.in"

# Wine.
# command_exists wine && alias ws="wine start"
alias claude="claude --dangerously-skip-permissions"

# Custom interactive functions.
# fzfrg: find content by ripgrep + open file at line by $EDITOR.
fzfrg() {
  local selected
  selected=$(rg --color=always --line-number --no-heading --smart-case --colors 'match:fg:cyan' . |
    fzf --ansi \
      --border-label '🔎 Find with ripgrep' \
      --delimiter : \
      --preview "bat --style=numbers --color=always --highlight-line {2} --theme='Visual Studio Dark+' {1}" \
      --layout reverse --multi --min-height 20+ --border \
      --no-separator --header-border horizontal \
      --border-label-pos 5 \
      --preview-window=right:50% \
      --bind 'ctrl-/:change-preview-window(down,70%|hidden|)')

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

# fzf_kill_process: select process by %CPU then kill.
fzf_kill_process() {
  local pid
  pid=$(ps -eo pid,comm,user,%cpu,%mem --sort=-%cpu |
    sed 1d |
    fzf --header="Select process to kill" --preview="ps -p {1} -o pid,ppid,cmd,%cpu,%mem" |
    awk '{print $1}')

  if [[ -n "$pid" ]]; then
    kill -9 "$pid" && echo "Killed process $pid"
  fi
}

ytm() {
  mpv --no-video "$@"
}

clipimg() {
  cliphist list | head -n 1 | cliphist decode | kitten icat
}

wine() {
  WINEPREFIX=$HOME/WindowsApps flatpak run \
    --branch=stable-25.08 \
    --env=WINEPREFIX=$HOME/WindowsApps \
    --filesystem=$HOME/WindowsApps \
    --command=wine \
    org.winehq.Wine \
    "$@"
}

nixupdate() {
  "$HOME/nixos/update.sh"
}
