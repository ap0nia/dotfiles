#------------------------------------------------------------------------------------
# Shell.
#------------------------------------------------------------------------------------

# Use Vim keybindings.
bindkey -v

# Load zsh autocompletion system.
autoload -Uz compinit
compinit


#------------------------------------------------------------------------------------
# Static.
#------------------------------------------------------------------------------------

CARGO_BIN=${HOME}/.cargo/bin

export PATH=${PATH}:${CARGO_BIN}

export DBUS_SESSION_BUS_ADDRESS='unix:path='$DBUS_LAUNCHD_SESSION_BUS_SOCKET


#------------------------------------------------------------------------------------
# Dynamic.
#------------------------------------------------------------------------------------

. "$HOME/.cargo/env"

# Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Source dircolors to set the colors used for `ls`.
eval "$(dircolors ~/.config/dircolors/nord.dircolors)"

# Start the node environment managed by fnm.
eval "$(fnm env --use-on-cd)"

# Load the shell plugin manager.
eval "$(sheldon source)"

# Initialize Starship prompt.
eval "$(starship init zsh)"


#------------------------------------------------------------------------------------
# Aliases.
#------------------------------------------------------------------------------------
alias ls=lsd
