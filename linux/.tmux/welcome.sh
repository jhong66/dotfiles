#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

C_LOGO_FRONT=$GREEN
C_LOGO_BACK=$GRAY

# ascii font: ogre
tmux_ascii='
                              /\                             
                           <_//\\_>                          
                      ______//  \\______                     
                       \\    <__>    //                      
================    _____ //  ||  \\__  __   ================
    =============  /__   \/\/\  /\ /\ \/ /  =============    
          =========  / /\/    \/ / \ \  / =========          
         =========  / / / /\/\ \ \_/ /  \  =========         
            =====   \/  \/    \/\___/_/\_\  =====            
                     //       ||        \\                   
                    /         ||          \                  
'

# TODO: automatically deal with color code offsets so positions don't change
# Can use ansi 255 colors after this

# -- highlight tmux in white (NC)
# declare -a color_changes=(
# "269 5"
# "296 6"
# "350 25"
# "425 22"
# "498 24"
# "570 24"
# )

# -- highlight tmux in color
declare -a color_changes=(
"269 5"
"299 6"
"356 25"
"434 22"
"509 24"
"586 24"
)

for conf in "${color_changes[@]}"; do
	p="${conf% *}"
	offset="${conf#* }"
	end=$((p+offset))
	tmux_ascii=$(printf "%s${C_LOGO_FRONT}%s${C_LOGO_BACK}%s" \
						 "${tmux_ascii:0:p}" "${tmux_ascii:p:offset}" "${tmux_ascii:end}")
done

width=$(tput cols)

center() {
	# Don't count color codes in length
	len=$(echo "$1" | sed "s/$(echo -e "\e")[^m]*m//g");
	printf "%$(((width-${#len})/2))s%s\n" "" "$1"
}

echo
center "WELCOME TO"

printf "${C_LOGO_BACK}"
echo "$tmux_ascii" | while IFS= read -r line; do
	center "$line"
done
printf "${NC}"
echo

max_line_len=60

# get quotes from square brackets
# randomly pick one
# format text
# wrap to max line length
quote=$( \
    grep -Po '(?<=\[).*(?=\])' ~/.tmux/quotes.sh \
	| shuf -n 1 \
	| xargs -d '\n' -I {} printf "{}\n" \
	| fold -s -w $max_line_len \
)

echo "$quote" | while IFS= read -r line; do
	center "$line"
done
echo

