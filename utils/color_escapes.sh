#!/bin/bash

# Demo color formatting in current terminal
# Referenced from: https://misc.flogisoft.com/bash/tip_colors_and_formatting

declare -a codes=(
  "31: Red"
  "32: Green"
  "33: Yellow"
  "34: Blue"
  "35: Magenta"
  "36: Cyan"
  "37: Light Gray"
)

echo 'Standard color codes, format \e[<CODE>'
for c in "${codes[@]}"; do
  code="${c%%:*}"
  name="${c#*:}"
  
  printf "\e[%sm%s\e[m\n" "$code" "$c"
done 
  
