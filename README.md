# dotfiles

Configs are laid out for [GNU Stow](https://www.gnu.org/software/stow/): each top-level
directory mirrors `$HOME`, so `stow <dir>` symlinks it into place.

```sh
git clone <repo> ~/dotfiles
cd ~/dotfiles
stow zshrc tmux kitty nvim starship k9s          # macOS and Arch
stow hypr waybar wofi swappy                     # Arch / Hyprland only
```

`.zshrc` and `.tmux.conf` detect the OS at runtime (Homebrew vs pacman paths,
`pbcopy` vs `wl-copy`), so the same files work on both machines.

## Arch packages

```sh
sudo pacman -S --needed stow zsh tmux kitty neovim starship fzf git \
  ttf-jetbrainsmono-nerd wl-clipboard mise docker docker-compose k9s \
  ripgrep fd lazygit
# optional, only if you use them there:
sudo pacman -S --needed jdk17-openjdk postgresql-libs
```

- oh-my-zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
  (then remove the `.zshrc` it generates and run `stow zshrc`).
- tmux plugins (TPM + catppuccin) are cloned automatically on first tmux start.
- Neovim plugins install themselves on first launch (LazyVim).
- Default shell: `chsh -s /usr/bin/zsh`.

## macOS

```sh
brew install stow tmux kitty neovim starship fzf mise k9s ripgrep fd lazygit
brew install --cask font-jetbrains-mono-nerd-font
```
