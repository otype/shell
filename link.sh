#!/usr/bin/env bash
# Symlinks this repo's ZSH configs into $HOME (for an existing clone).
# Unlike bin/install.sh it does not clone anything and works on a present checkout.
# Existing non-symlink targets are moved to <target>.bak-<timestamp>.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"

# "<link path relative to $HOME>:<source path relative to repo>"
LINKS=(
  ".zshenv:zshenv"
  ".zshrc:zshrc"
  ".zsh:zsh"
  ".zprofile:zprofile"
)

# Install Oh My Zsh if missing (zshrc expects it at ~/.oh-my-zsh). A plain clone
# is used instead of the official installer, so it never touches ~/.zshrc or
# the login shell, and doesn't start zsh.
OMZ_DIR="$HOME/.oh-my-zsh"
if [[ ! -d "$OMZ_DIR" ]]; then
  command -v git >/dev/null 2>&1 || { echo "git is required to install Oh My Zsh" >&2; exit 1; }
  echo "INSTALL Oh My Zsh -> $OMZ_DIR"
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$OMZ_DIR"
else
  echo "OK    Oh My Zsh already installed ($OMZ_DIR)"
fi

LINKS+=(".oh-my-zsh/themes/otype.zsh-theme:themes/otype.zsh-theme")

for entry in "${LINKS[@]}"; do
  link="$HOME/${entry%%:*}"
  src="$REPO/${entry#*:}"

  if [[ ! -e "$src" ]]; then
    echo "SKIP  $src does not exist" >&2
    continue
  fi

  mkdir -p "$(dirname "$link")"

  if [[ -L "$link" ]]; then
    if [[ "$(readlink -f "$link")" == "$(readlink -f "$src")" ]]; then
      echo "OK    $link (already linked)"
      continue
    fi
    rm "$link"
  elif [[ -e "$link" ]]; then
    mv "$link" "$link.bak-$TS"
    echo "BACKUP $link -> $link.bak-$TS"
  fi

  ln -s "$src" "$link"
  echo "LINK  $link -> $src"
done
