#!/usr/bin/env bash

sudo eopkg update-repo -f
sudo eopkg up -d

# install fish shell
sudo eopkg install -y fish
fish

# its time to sleep, caps lock
setxkbmap -option caps:ctrl_modifier

# install foundamental utils and system theme
sudo eopkg it -c system.devel
sudo eopkg install -y git
sudo eopkg install -y arc-gtk-theme
sudo eopkg install -y paper-gtk-theme paper-icon-theme
sudo eopkg install -y vim
sudo eopkg install -y tmux
sudo eopkg install gnome-tweaks

# install chrome
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/network/web/browser/google-chrome-stable/pspec.xml
sudo eopkg it google-chrome-*.eopkg
sudo rm google-chrome-*.eopkg

# install golang
sudo mkdir -p /usr/local
export LOCAL_GOVERSION="1.14.6"
curl -sSfLO "https://golang.org/dl/go$LOCAL_GOVERSION.linux-amd64.tar.gz"
tar -C /usr/local -xzf "go$LOCAL_GOVERSION.linux-amd64.tar.gz"
export PATH="$PATH:/usr/local/go/bin:/home/$USER/go/bin"

# install ghq and peco
go get github.com/motemen/ghq
go get github.com/peco/peco/cmd/peco
alias g='cd (ghq root)/(ghq list | peco)'

# generate ssh key and register pubkey to github
ssh-keygen
cat ~/.ssh/id_rsa.pub

# clone this repository and exec install.sh
ghq get -p git@github.com:wassan128/dotfiles.git
g
./install.sh

# install vim plugins
vim

# build ycm
sudo eopkg install python3-devel
cd ~/.cache/dein/repos/github.com/Valloric/YouCompleteMe/
./install.py

# install starship
sudo mkdir -p /usr/local/bin
curl -fsSL https://starship.rs/install.sh | bash

# setup mozc
sudo eopkg install ibus-mozc
ibus-setup
sudo reboot  # to recognize mozc...

# install fonts
curl -sSfL -o yutapon_coding_sl_080.zip "http://net2.system.to/pc/cgi-bin/download.cgi?file=yutapon_coding_sl_080.zip"
