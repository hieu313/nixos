# Custom key bindings and ZLE widgets.

# Core key bindings.
bindkey '^Z' undo

# FZF keybindings.
if command_exists fzf; then
  # Ctrl+K: FZF process killer.
  zle -N fzf_kill_process
  bindkey '^K' fzf_kill_process
fi
