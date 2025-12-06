#!/bin/bash

declare -a palettes=(
	"221 143 065: << Current tmux bottom left status"
	"065 108 151"
	"066 109 152"
	"066 073 080: << Current tmux bottom right status"
	"031 074 117"
)

for p in "${palettes[@]}"; do
	colors="${p%:*}"
	for c in $colors; do
		printf "\e[30;48;5;%sm   %s   \e[m" "$c" "$c"
	done
	
	if [[ $p == *":"* ]]; then
		note="${p#*:}"
		printf "\e[33m%s\e[m" "$note"
	fi
	printf "\n\n"
done
