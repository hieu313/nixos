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
if has_command trashy; then
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
has_command gemini && alias how="gemini -p"
has_command serie && alias gitgraph="serie"

# Amazing
alias please="sudo $(history -p !!)"
alias lich="curl lich.day"
alias weather="curl wttr.in"

# Wine
has_command wine && alias ws="wine start"
has_command claude && alias claude="claude --dangerously-skip-permissions"

# ccg: claude code gpt - run Claude Code CLI with GPT model via Proxypal
# Usage: ccg [xhigh|high|medium|low|none] [claude args...]
#        ccg [--thinking|-t <level>] [claude args...]
# Thinking levels: xhigh, high, medium, low, none/off (default: high)
# Default thinking: high (or set CCG_THINKING env var)
ccg() {
  local thinking="${CCG_THINKING:-xhigh}"
  local args=()

  # Check if first arg is a valid thinking level (shorthand)
  case "${1:-}" in
    xhigh|high|medium|low|none|off)
      thinking="$1"
      shift
      ;;
  esac

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --thinking|-t)
        thinking="$2"
        shift 2
        ;;
      *)
        args+=("$1")
        shift
        ;;
    esac
  done

  local model
  if [[ "$thinking" == "none" || "$thinking" == "off" ]]; then
    model="gpt-5.4"
  else
    model="gpt-5.4(${thinking})"
  fi

  (
    export ANTHROPIC_API_KEY="proxypal-local"
    export ANTHROPIC_BASE_URL="http://127.0.0.1:8317/v1"
    export ANTHROPIC_MODEL="$model"
    echo "🚀 Starting Claude with Proxypal [model: ${model}] ..."
    claude "${args[@]}"
  )
}

proxypal() {
  cd ~/Desktop/proxypal && pnpm tauri dev > /dev/null 2>&1 & disown
}
claudekit() {
  /home/hieunm/Workspace/claudekit/link-manager.sh "$@"
}

floorp(){
  /home/hieunm/Desktop/floorp/floorp > /dev/null 2>&1 & disown
}

ytm(){
  mpv --no-video "$@"
}

vbook() {
  java --module-path /home/hieunm/Desktop/Java/javafx-sdk-25.0.1/lib  --add-modules javafx.controls,javafx.fxml,javafx.web -jar ~/Workspace/Vbook/vbook-hieu/ExtensionMaker.jar > /dev/null 2>&1 & disown
}

clipimg() {
  cliphist list | head -n 1 | cliphist decode | kitten icat
}

telegram() {
  Telegram > /dev/null 2>&1 & disown
}

zen() {
  /home/hieunm/Desktop/zen/zen-bin > /dev/null 2>&1 & disown
}
