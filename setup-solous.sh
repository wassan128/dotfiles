#!/usr/bin/env bash

sudo eopkg update-repo -f
sudo eopkg up -d

sudo eopkg it -c system.devel
sudo eopkg install git
sudo eopkg install arc-gtk-theme
sudo eopkg install -y paper-gtk-theme paper-icon-theme
sudo eopkg install vim
