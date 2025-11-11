#!/bin/bash

mkdir -p ./linux
cp -rf -t ./linux ~/.tmux.conf  ~/.vimrc 

mkdir -p ./linux/.config
cp -rf -t ./linux/.config ~/.config/tmux-powerline ~/.config/nvim
