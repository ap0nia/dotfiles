#------------------------------------------------------------------------------------
# Paths.
#------------------------------------------------------------------------------------

# bun completions
# [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="${HOME}/.bun"

CARGO_BIN=${HOME}/.cargo/bin
LOCAL_BIN=${HOME}/.local/bin
BUN_BIN=${BUN_INSTALL}/bin
EMSDK=${HOME}/.local/sources/emsdk:${HOME}/.local/sources/emsdk/upstream/emscripten

export PATH=${PATH}:${LOCAL_BIN}:${CARGO_BIN}:${BUN_BIN}:${EMSDK}


#------------------------------------------------------------------------------------
# WSL Pipe stuff. i.e. SSH, Discord.
#------------------------------------------------------------------------------------
# $HOME/.config/wsl/discord-relay

${HOME}/.config/wsl/ssh-agent-relay start

[[ -f ${HOME}/.ssh/wsl-ssh-agent.sock ]] || touch ${HOME}/.ssh/wsl-ssh-agent.sock
export SSH_AUTH_SOCK=${HOME}/.ssh/wsl-ssh-agent.sock


#------------------------------------------------------------------------------------
# Terminal/Shell.
#------------------------------------------------------------------------------------

# Use Vim keybindings.
bindkey -v

#------------------------------------------------------------------------------------
# Environment.
#------------------------------------------------------------------------------------

. "$HOME/.cargo/env"

# Source dircolors to set the colors used for `ls`.
eval "$(coreutils dircolors ~/.config/dircolors/nord.dircolors)"

# Start the node environment managed by fnm.
eval "$(fnm env --use-on-cd)"

# Load the shell plugin manager.
eval "$(sheldon source)"

# Initialize Starship prompt.
eval "$(starship init zsh)"


#------------------------------------------------------------------------------------
# Aliases.
#------------------------------------------------------------------------------------

# Always use LSDeluxe
alias ls=lsd

# `clip.exe` is from Windows's System32 folder.
alias clip=clip.exe

# `explorer.exe` is from Windows's System32 folder.
alias exp=explorer.exe
