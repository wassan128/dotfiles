#!/usr/bin/env bash

sudo eopkg install -y fish

sudo eopkg update-repo -f
sudo eopkg up -d

sudo eopkg it -c system.devel
sudo eopkg install -y git
sudo eopkg install -y arc-gtk-theme
sudo eopkg install -y paper-gtk-theme paper-icon-theme
sudo eopkg install -y vim

sudo mkdir -p /usr/local

# install chrome
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/network/web/browser/google-chrome-stable/pspec.xml
sudo eopkg it google-chrome-*.eopkg
sudo rm google-chrome-*.eopkg

# install golang
export LOCAL_GOVERSION="1.14.6"
curl -sSfLO https://golang.org/dl/go$LOCAL_GOVERSION.linux-amd64.tar.gz
tar -C /usr/local -xzf go$LOCAL_GOVERSION.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
