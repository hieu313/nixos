# Zinit plugin manager setup.

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$(dirname $ZINIT_HOME)"
  command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

source "$ZINIT_HOME/zinit.zsh"

# Zinit plugin declarations.

# zsh-defer: helper to defer heavy command execution.
zinit light romkatv/zsh-defer

# OMZ libs: directories (aliases like ..), git lib, theme helpers.
zinit wait'0a' lucid for \
  OMZ::lib/directories.zsh \
  OMZ::lib/git.zsh

# Autosuggestions, syntax highlighting, and completions.
zinit wait'0a' lucid for \
  zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start; ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(print-alias-widget bracketed-paste-magic)" \
    zsh-users/zsh-autosuggestions \
  blockf \
    zsh-users/zsh-completions

# FZF-Tab: turn Tab completion into a selection menu.
zinit wait'0a' lucid for Aloxaf/fzf-tab

# Common OMZ plugins.
zinit wait'0b' lucid for \
  OMZ::plugins/git/git.plugin.zsh \
  OMZ::plugins/sudo/sudo.plugin.zsh \
  OMZ::plugins/extract/extract.plugin.zsh

# Heavier or less frequently needed plugins.
zinit wait'1' lucid for \
  OMZ::plugins/tmux/tmux.plugin.zsh \
  OMZ::plugins/docker/docker.plugin.zsh \
  MichaelAquilina/zsh-you-should-use

zinit wait'0b' lucid \
  atload'bindkey "^[[A" history-substring-search-up; bindkey "^[[B" history-substring-search-down' \
  for zsh-users/zsh-history-substring-search

# Interactive Git and alias helper.
zinit ice wait'1' lucid
zinit light wfxr/forgit
zinit light brymck/print-alias

# External tool integrations.

# fzf - load immediately because keybindings rely on it.
if command_exists fzf; then
  source <(fzf --zsh)
fi

# atuin - deferred loading.
if command_exists atuin; then
  zsh-defer -c 'eval "$(atuin init zsh --disable-up-arrow)"'
fi

# fzf-git - deferred loading.
if [[ -r "$HOME/.config/fzf/fzf-git.sh" ]]; then
  zsh-defer -t 0.5 -c 'source "$HOME/.config/fzf/fzf-git.sh"'
fi

# zoxide - load before aliases so cd=z is available immediately.
if command_exists zoxide; then
  eval "$(zoxide init zsh)"
fi

# pay-respects - deferred loading.
if command_exists pay-respects; then
  zsh-defer -c 'eval "$(pay-respects zsh --alias)"'
fi

# fnm - deferred loading.
if command_exists fnm; then
  zsh-defer -c 'eval "$(fnm env --use-on-cd --shell zsh)"'
fi
