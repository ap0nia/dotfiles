#------------------------------------------------------------------------------------
# Homebrew.
#------------------------------------------------------------------------------------
eval "$(/opt/homebrew/bin/brew shellenv)"

#------------------------------------------------------------------------------------
# Rust programs and environment initialization.
#------------------------------------------------------------------------------------

. "$HOME/.cargo/env"

# Set the colors used by `ls` (and `lsd`).
eval "$(coreutils dircolors ~/.config/dircolors/catppuccin-macchiato.dircolors)"

# Initialize fnm (fast-node-manager, a Node.js version manager.
eval "$(fnm env --use-on-cd)"

# Initialize all plugins managed by the shell plugin manager.
eval "$(sheldon source)"

# Initialize Starship prompt.
eval "$(starship init zsh)"


#------------------------------------------------------------------------------------
# Aliases.
#------------------------------------------------------------------------------------

# Always use LSDeluxe.
alias ls=lsd

#------------------------------------------------------------------------------------
# Run on initialization.
#------------------------------------------------------------------------------------

bindkey -v
autoload -Uz compinit
compinit
fastfetch
