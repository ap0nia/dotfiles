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

# Vim keybindings
bindkey -v


# Antidote ZSH plugin manager.

# Clone antidote if necessary.
[[ -d ${HOME}/.antidote ]] || git clone https://github.com/mattmc3/antidote ${HOME}/.antidote

# Set the name of the static .zsh plugins file antidote will generate.
zsh_plugins=${HOME}/.zsh_plugins.zsh

# Ensure you have a .zsh_plugins.txt file where you can add plugins.
[[ -f ${zsh_plugins:r}.txt ]] || touch ${zsh_plugins:r}.txt

# Create an amazing Zsh config using antidote plugins.
source ${HOME}/.antidote/antidote.zsh

antidote load


#------------------------------------------------------------------------------------
# Environment.
#------------------------------------------------------------------------------------

. "$HOME/.cargo/env"

# source the dircolors to set the colors for ls
eval "$(coreutils dircolors ~/.config/dircolors/nord.dircolors)"

# start the node environment managed by fnm
eval "$(fnm env --use-on-cd)"

# init starship prompt
eval "$(starship init zsh)"


#------------------------------------------------------------------------------------
# Aliases.
#------------------------------------------------------------------------------------
alias ls=lsd
alias clip=clip.exe
alias exp=explorer.exe
