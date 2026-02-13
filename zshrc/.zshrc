export ZSH="$HOME/.oh-my-zsh"

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000
HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"
setopt inc_append_history

plugins=(git starship asdf docker docker-compose fzf kitty poetry)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# Aliases
alias task='go-task'

export PATH="$PATH:$HOME/.local/bin"
if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi

autoload -Uz compinit && compinit
