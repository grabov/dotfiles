export ZSH="$HOME/.oh-my-zsh"

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000
HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"
setopt inc_append_history

plugins=(git starship docker docker-compose fzf kitty poetry)

# Extra completions must be on fpath before oh-my-zsh runs compinit.
[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)

source $ZSH/oh-my-zsh.sh

# User configuration

# tmux already appends the folder to the window name, so an idle shell shows
# the git branch there instead of user@host:path.
if [[ -n "$TMUX" ]]; then
  function _idle_title_precmd {
    local branch="$(git_current_branch)"
    ZSH_THEME_TERM_TITLE_IDLE="${${branch:+ %30>…>${branch//\%/%%}%<<}:-zsh}"
  }
  precmd_functions=(_idle_title_precmd $precmd_functions)
fi

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# Aliases
# alias task='go-task'

export PATH="$PATH:$HOME/.local/bin"
if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi

# Java 17: Homebrew on macOS, archlinux-java layout on Arch.
for _jdk in /opt/homebrew/opt/openjdk@17 /usr/lib/jvm/java-17-openjdk; do
  if [[ -d "$_jdk" ]]; then
    export JAVA_HOME="$_jdk"
    export PATH="$JAVA_HOME/bin:$PATH"
    break
  fi
done
unset _jdk

# Android SDK: Android Studio default locations on macOS and Linux.
for _sdk in "$HOME/Library/Android/sdk" "$HOME/Android/Sdk"; do
  if [[ -d "$_sdk" ]]; then
    export ANDROID_HOME="$_sdk"
    export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH"
    break
  fi
done
unset _sdk

# libpq is keg-only in Homebrew; on Arch `postgresql-libs` puts psql on PATH already.
[[ -d /opt/homebrew/opt/libpq/bin ]] && export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# mise: ~/.local/bin on macOS (curl installer), /usr/bin on Arch (pacman).
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi
