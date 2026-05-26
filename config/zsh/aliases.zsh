# ============================================================================
# Custom Aliases
# ============================================================================

# Common
alias mkdir="mkdir -pv"
alias cp="cp -r"
command_exists nmcli && alias wifi="nmcli device wifi"
command_exists eza && alias ls="$EZA_DEFAULT_COMMAND"
command_exists eza && alias tree="eza --icons=always --color=always -a --tree --git --level=2"

# Navigate by zoxide
command_exists zoxide && alias cd="z"

# Default tools
command_exists bat && alias bat="$BAT_DEFAULT_COMMAND"
command_exists fd && alias find="$FDFIND_DEFAULT_COMMAND"
command_exists rg && alias rg="$RG_DEFAULT_COMMAND"

# Trash-cli instead of rm
alias rmrm="command rm -rf"
if command_exists trash; then
    alias rm="trash"
    alias rmlist="trash list"
    alias rmrestore="trash restore"
    alias rmempty="trash empty"
fi

# Wayland clipboard
if ! is_wsl; then
    command_exists wl-copy && alias copy="wl-copy"
    command_exists wl-paste && alias paste="wl-paste"
fi

# Disk/duf
command_exists duf && alias df="duf"
alias du="du -ahx --max-depth=1 . | sort -hr"

# Fzf
command_exists fzf && alias fzf="fzf --preview-window=right:50% --preview='[[ -d {} ]] && $FZF_PREVIEW_FOLDER {} | nl || $FZF_PREVIEW_FILE {}'"

# Docker
command_exists docker && alias drmia!="docker rmi -f $(docker images -aq)"
command_exists docker && alias drmca!="docker rm -f $(docker ps -aq)"
# Fun
command_exists terminal-rain && alias rain="terminal-rain"
command_exists cbonsai && alias cbonsai="cbonsai --screensaver --life 40 --multiplier 5 --time 20 --screensaver"

# Tmux
command_exists tmux && alias tx="tmux"

# Lazygit
command_exists lazygit && alias lzg="lazygit"
# Lazydocker
command_exists lazydocker && alias lzd="lazydocker"

# Gemini CLI
# command_exists gemini && alias how="gemini -p"
command_exists serie && alias gitgraph="serie"

# Amazing
alias please='sudo $(fc -ln -1)'
alias lich="curl lich.day"
alias weather="curl wttr.in"

# Wine
# command_exists wine && alias ws="wine start"
command_exists claude && alias claude="claude --dangerously-skip-permissions"

function claudekit() {
  $HOME/Workspace/claudekit/link-manager.sh "$@"
}

function ytm(){
  mpv --no-video "$@"
}

if ! is_wsl; then
  function clipimg() {
    cliphist list | head -n 1 | cliphist decode | kitten icat
  }

  function wine() {
    WINEPREFIX=$HOME/WindowsApps flatpak run \
      --branch=stable-25.08 \
      --env=WINEPREFIX=$HOME/WindowsApps \
      --filesystem=$HOME/WindowsApps \
      --command=wine \
      org.winehq.Wine \
      "$@"
  }
fi

function nixupdate() {
  $HOME/nixos/update.sh
}
