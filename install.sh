#!/usr/bin/env bash

DOTPATH=~/ghq/github.com/wassan128/dotfiles

for f in .??*
do
    [ "$f" = ".git" ] && continue

    if [ "$f" = ".config" ]; then
        ln -snfv "$DOTPATH/$f/fish/config.fish" "$HOME/.config/fish/config.fish"
        continue
    fi

    ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done
