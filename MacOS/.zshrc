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

# bun completions
[ -s "/Users/aponia/.bun/_bun" ] && source "/Users/aponia/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
