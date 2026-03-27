#!/usr/bin/env bash
# Symlinks dotfiles from this repo to their expected locations.

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

link() {
    local src="$DOTFILES_DIR/$1"
    local dest="$2"

    if [ -L "$dest" ]; then
        echo "Already linked: $dest -> $(readlink "$dest")"
        return
    fi

    if [ -e "$dest" ]; then
        echo "Backing up existing $dest to ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    ln -s "$src" "$dest"
    echo "Linked: $dest -> $src"
}

link .tmux.conf "$HOME/.tmux.conf"
