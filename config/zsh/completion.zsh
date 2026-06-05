# Completion initialization.
# Use zinit's zicompinit/zicdreplay integration with a stable XDG cache dump.

ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump-${HOST:-${HOSTNAME:-unknown}}-${ZSH_VERSION}"
mkdir -p "${ZSH_COMPDUMP:h}"

# Rebuild completion dump at most once per day; otherwise trust the cache.
if [[ ! -f "$ZSH_COMPDUMP" ]] || (( $(date +%s) - $(stat -c %Y "$ZSH_COMPDUMP" 2>/dev/null || echo 0) > 86400 )); then
  zicompinit -d "$ZSH_COMPDUMP"
else
  zicompinit -C -d "$ZSH_COMPDUMP"
fi

zicdreplay
