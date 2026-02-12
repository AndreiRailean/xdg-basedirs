#!/usr/bin/env zsh

# Define XDG base directories only if they aren't already set
# Using the :+ syntax to check for non-empty values
: "${XDG_BIN_HOME:=$HOME/.local/bin}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"
: "${XDG_RUNTIME_DIR:=$HOME/.local/run}"
: "${XDG_STATE_HOME:=$HOME/.local/state}"

# Export them all at once
export XDG_BIN_HOME XDG_CACHE_HOME XDG_CONFIG_HOME XDG_DATA_HOME XDG_RUNTIME_DIR XDG_STATE_HOME

create_xdg_basedirs() {
  # Ensures options set here (like allexport) don't leak out of this function
  setopt localoptions

  local green=$'\e[0;32m'
  local cyan=$'\e[0;36m'
  local nc=$'\e[0m'

  local xdg_vars=(
    XDG_BIN_HOME
    XDG_CACHE_HOME
    XDG_CONFIG_HOME
    XDG_DATA_HOME
    XDG_RUNTIME_DIR
    XDG_STATE_HOME
  )

  local var dir
  for var in $xdg_vars; do
    dir="${(P)var}"

    # Only create if it's within $HOME and doesn't exist
    if [[ "$dir" == "$HOME"/* && ! -d "$dir" ]]; then
      mkdir -p "$dir" && \
      printf '[%s%s%s] Created directory: %s%s%s\n' \
        "$green" "$var" "$nc" \
        "$cyan" "$dir" "$nc"
    fi
  done
}
