#!/bin/bash

Help() 
{
	echo
	echo "Copy the configuration files in this repository into their functional locations"
	echo
	echo "Syntax: push [-s|h]"
	echo "options:"
	echo "s    Simple setup (push vanilla vim and tmux configurations only)"
	echo "h    Print this help page"
	echo
}

while getopts "hs" option; do
	case $option in
		h) # display Help
			Help
			exit;;
		s) # Simple setup
			run_simple=true;;
		\?) # Invalid option
			echo "Error: Invalid option"
			exit;;
	esac
done

cd linux

# Custom bash settings
while IFS= read -r line; do
	# Avoid extra newlines
	last_line=$(tail -n 1 ~/.bashrc)
	if [[ $line == "" ]] && [[ $last_line != "" ]] ; then
		echo $line >> ~/.bashrc

	elif ! grep -q "$line" ~/.bashrc ; then
		echo $line >> ~/.bashrc
	fi
done < ".bashrc"


# tmux and vim config
cp -ri -t ~/ .tmux.conf .vimrc

# neovim and tmux-powerline config
if [ ! $run_simple ]; then
	cd .config
	mkdir -p ~/.config
	cp -ri -t ~/.config/ tmux-powerline nvim
fi

