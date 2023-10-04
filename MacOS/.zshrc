#------------------------------------------------------------------------------------
# Paths.
#------------------------------------------------------------------------------------

# bun completions
# [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

CARGO_BIN=${HOME}/.cargo/bin
LOCAL_BIN=${HOME}/.local/bin
BUN_BIN=${BUN_INSTALL}/bin
JAVA_BIN=/opt/homebrew/opt/openjdk@11/bin
EMSDK=${HOME}/.local/sources/emsdk:${HOME}/.local/sources/emsdk/upstream/emscripten

export PATH=${PATH}:${LOCAL_BIN}:${CARGO_BIN}:${BUN_BIN}:${EMSDK}:${JAVA_BIN}

#------------------------------------------------------------------------------------
# Terminal/Shell.
#------------------------------------------------------------------------------------

# Use Vim keybindings.
bindkey -v

autoload -Uz compinit
compinit

#------------------------------------------------------------------------------------
# Environment.
#------------------------------------------------------------------------------------

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

. "$HOME/.cargo/env"

# Source dircolors to set the colors used for `ls`.
eval "$(coreutils dircolors ~/.config/dircolors/nord.dircolors)"

# Start the node environment managed by fnm.
eval "$(fnm env --use-on-cd)"

# Load the shell plugin manager.
eval "$(sheldon source)"

# Initialize Starship prompt.
eval "$(starship init zsh)"

export BUN_INSTALL="${HOME}/.bun"

export DBUS_SESSION_BUS_ADDRESS='unix:path='$DBUS_LAUNCHD_SESSION_BUS_SOCKET

#------------------------------------------------------------------------------------
# Aliases.
#------------------------------------------------------------------------------------
alias ls=lsd
