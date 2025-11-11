#!/bin/bash

cd linux
cp -ri -t ~/ .tmux.conf .vimrc

cd .config
cp -ri -t ~/.config/ tmux-powerline nvim
