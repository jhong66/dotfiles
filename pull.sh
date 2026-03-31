#!/bin/bash

DIR=${1:-"./linux"}
echo "Copying into: ${DIR}"

rm -rf ${DIR}

mkdir -p ${DIR}
cp -rf ~/.tmux.conf ~/.vimrc ${DIR}

mkdir -p ${DIR}/.config
cp -rf ~/.config/tmux-powerline ~/.config/nvim ${DIR}/.config

mkdir -p ${DIR}/.tmux
cp -rf ~/.tmux/welcome.sh ~/.tmux/quotes.sh ~/.tmux/logos.sh ${DIR}/.tmux
