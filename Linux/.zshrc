#------------------------------------------------------------------------------------
# Initialize custom relays for piping WSL information to Windows.
#------------------------------------------------------------------------------------
# ${HOME}/.config/wsl/discord-relay

# Location of nipiperelay.exe (UNIX path), can be on a Windows volume.
# If you don't have it, see: https://github.com/jstarks/npiperelay#building-npiperelayexe
export NPIPERELAY=/mnt/c/WSL/npiperelay.exe

${HOME}/.config/wsl/ssh-agent-relay start
export SSH_AUTH_SOCK=${HOME}/.ssh/wsl-ssh-agent.sock


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

# Windows clipboard (found in the System32 folder).
alias clip=clip.exe

# Windows file explorer (found in System32 folder).
alias exp=explorer.exe

#------------------------------------------------------------------------------------
# Run on initialization.
#------------------------------------------------------------------------------------

bindkey -v
autoload -Uz compinit
compinit
fastfetch
