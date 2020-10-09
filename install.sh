#!/usr/bin/env bash

exe_path="${0}"
if [[ "$exe_path" != './install.sh' ]]; then
    echo '[ERROR] install.shはdotfile直下で実行してください。'
    exit 1
fi

mkdirIfNotExist() {
    local dir="$1"
    [ ! -d "$HOME/$1" ] && mkdir -p "$HOME/$1"
}

mkdirIfNotExist '.config'
mkdirIfNotExist '.config/fish'
mkdirIfNotExist '.config/nvim'

# init
current_path="$(pwd)"
for f in .??*
do
    # skip list
    [ "$f" = ".git" ] && continue
    [ "$f" = "vim" ] && continue

    if [ "$f" = ".config" ]; then
        ln -snfv "$current_path/$f/fish/config.fish" "$HOME/.config/fish/config.fish"
        ln -snfv "$current_path/$f/starship.toml" "$HOME/.config/starship.toml"
        continue
    fi

    ln -snfv "$current_path/$f" "$HOME"/"$f"
done

# setup vim/neovim rc
## vim
ln -snfv "$current_path/.vimrc" "$HOME/.vimrc"
ln -snfv "$current_path/vim" "$HOME/.vim"
## neovim
ln -snfv "$current_path/.vimrc" "$HOME/.config/nvim/init.vim"
ln -snfv "$current_path/neovim" "$HOME/.nvim"
