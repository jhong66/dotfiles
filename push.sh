#!/bin/bash

cd linux
cp -ri -t ~/ .tmux.conf .vimrc

cd .config
mkdir ~/.config
cp -ri -t ~/.config/ tmux-powerline nvim
