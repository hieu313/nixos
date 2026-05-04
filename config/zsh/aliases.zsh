# ============================================================================
# Custom Aliases
# ============================================================================

# Common
alias mkdir="mkdir -pv"
alias cp="cp -r"
has_command nmcli && alias wifi="nmcli device wifi"
has_command eza && alias ls="$EZA_DEFAULT_COMMAND"
has_command eza && alias tree="eza --icons=always --color=always -a --tree --git --level=2"

# Navigate by zoxide
has_command zoxide && alias cd="z"

# Default tools
has_command bat && alias bat="$BAT_DEFAULT_COMMAND"
has_command fd && alias find="$FDFIND_DEFAULT_COMMAND"
has_command rg && alias rg="$RG_DEFAULT_COMMAND"

# Trash-cli instead of rm
alias rmrm="command rm -rf"
if has_command trash; then
    alias rm="trash"
    alias rmlist="trash list"
    alias rmrestore="trash restore"
    alias rmempty="trash empty"
fi

# Wayland clipboard
has_command wl-copy && alias copy="wl-copy"
has_command wl-paste && alias paste="wl-paste"

# Disk/duf
has_command duf && alias df="duf"
alias du="du -ahx --max-depth=1 . | sort -hr"

# Fzf
has_command fzf && alias fzf="fzf --preview-window=right:50% --preview='[[ -d {} ]] && $FZF_PREVIEW_FOLDER {} | nl || $FZF_PREVIEW_FILE {}'"

# Docker
has_command docker && alias drmia!="docker rmi -f $(docker images -aq)"
has_command docker && alias drmca!="docker rm -f $(docker ps -aq)"
# Fun
has_command terminal-rain && alias rain="terminal-rain"
has_command cbonsai && alias cbonsai="cbonsai --screensaver --life 40 --multiplier 5 --time 20 --screensaver"

# Tmux
has_command tmux && alias tx="tmux"

# Lazygit
has_command lazygit && alias lzg="lazygit"
# Lazydocker
has_command lazydocker && alias lzd="lazydocker"

# Gemini CLI
# has_command gemini && alias how="gemini -p"
has_command serie && alias gitgraph="serie"

# Amazing
alias please='sudo $(fc -ln -1)'
alias lich="curl lich.day"
alias weather="curl wttr.in"

# Wine
# has_command wine && alias ws="wine start"
has_command claude && alias claude="claude --dangerously-skip-permissions"

function claudekit() {
  /home/hieunm/Workspace/claudekit/link-manager.sh "$@"
}

function ytm(){
  mpv --no-video "$@"
}

function clipimg() {
  cliphist list | head -n 1 | cliphist decode | kitten icat
}

function wine() {
  WINEPREFIX=/home/hieunm/WindowsApps flatpak run \
    --branch=stable-25.08 \
    --env=WINEPREFIX=/home/hieunm/WindowsApps \
    --filesystem=/home/hieunm/WindowsApps \
    --command=wine \
    org.winehq.Wine \
    "$@"
}