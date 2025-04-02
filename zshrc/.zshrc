

export ZSH="$HOME/.oh-my-zsh"

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000
HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"
setopt inc_append_history

plugins=(git starship asdf docker docker-compose fzf kitty poetry)

source $ZSH/oh-my-zsh.sh

# User configuration
. "$HOME/.asdf/asdf.sh"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Created by `pipx` on 2025-01-07 08:09:57
export PATH="$PATH:/Users/viktor/.local/bin"


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# The next line updates PATH for CLI.
if [ -f '/home/viktor/yandex-cloud/path.bash.inc' ]; then source '/home/viktor/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/viktor/yandex-cloud/completion.zsh.inc' ]; then source '/home/viktor/yandex-cloud/completion.zsh.inc'; fi

