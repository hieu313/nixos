# Shared helper functions for Zsh modules.

# log_info: log info
log_info() { echo "ℹ️ $1"; }

# log_error: log error
log_error() { echo "❌ $1"; }

# command_exists: silently check if command exists, only use when replace default tools (e.g. ls, rm) check before aliasing.
command_exists() { command -v "$1" >/dev/null 2>&1; }

has_directory() {
  if [[ -d "$1" ]]; then
    return 0
  else
    log_error "Directory $1 does not exist"
    return 1
  fi
}

has_file() {
  if [[ -f "$1" ]]; then
    return 0
  else
    log_error "File $1 does not exist"
    return 1
  fi
}

has_readable() {
  if [[ -r "$1" ]]; then
    return 0
  else
    log_error "File $1 is not readable"
    return 1
  fi
}

check_file_size() {
  if [[ -s "$1" ]]; then
    return 0
  else
    log_error "File $1 is not size"
    return 1
  fi
}

# safe_source: only source when file readable.
safe_source() {
  if [[ -r "$1" ]]; then
    source "$1"
  else
    log_error "Failed to source $1"
    return 1
  fi
}

# join: join string by delimiter.
join() { local IFS="$1"; shift; echo "$*"; }

# OS helpers.
is_linux() { [[ "$OSTYPE" == linux* ]]; }
is_macos() { [[ "$OSTYPE" == darwin* ]]; }
is_wsl() { [[ -n "$WSL_DISTRO_NAME" || "$(uname -r)" == *microsoft* || "$(uname -r)" == *Microsoft* ]]; }
is_running_in_warp_terminal() { [[ "$TERM_PROGRAM" == "WarpTerminal" ]]; }

# reload: reload zsh configuration.
reload() { exec "$SHELL" -l; }
