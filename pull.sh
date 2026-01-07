#!/bin/bash

rm -rf ./linux

mkdir -p ./linux
cp -rf -t ./linux ~/.tmux.conf  ~/.vimrc 

mkdir -p ./linux/.config
cp -rf -t ./linux/.config ~/.config/tmux-powerline ~/.config/nvim

mkdir -p ./linux/.tmux
cp -rf -t ./linux/.tmux ~/.tmux/welcome.sh
