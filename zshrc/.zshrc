

export ZSH="$HOME/.oh-my-zsh"

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000
HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"
setopt inc_append_history

plugins=(git starship asdf docker docker-compose fzf kitty)

source $ZSH/oh-my-zsh.sh

# User configuration
. "$HOME/.asdf/asdf.sh"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# Created by `pipx` on 2025-01-07 08:09:57
export PATH="$PATH:/Users/viktor/.local/bin"
