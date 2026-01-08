#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

C_LOGO_FRONT=$GREEN
C_LOGO_BACK=$GRAY

WIDTH=$(tput cols)

INTRO_TEXT="WELCOME TO"

# ascii font: ogre
tmux_logo='
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

logo_mini='
 _____           __  __
/__   \/\/\  /\ /\ \/ /
  / /\/    \/ / \ \  / 
 / / / /\/\ \ \_/ /  \ 
 \/  \/    \/\___/_/\_\
'

# TODO: Logo width is 61...make a more round number later
# (will have to change color offsets)
LOGO_WIDTH=$(printf "$tmux_logo" | head -2 | wc -m)
LOGO_WIDTH=$((LOGO_WIDTH - 2))

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
	tmux_logo=$(printf "%s${C_LOGO_FRONT}%s${C_LOGO_BACK}%s" \
						 "${tmux_logo:0:p}" "${tmux_logo:p:offset}" "${tmux_logo:end}")
done

center() {
	# Don't count color codes in length
	len=$(echo "$1" | sed "s/$(echo -e "\e")[^m]*m//g");
	printf "%$(((WIDTH-${#len})/2))s%s\n" "" "$1"
}

if [ "$WIDTH" -lt "$LOGO_WIDTH" ]; then
	mini_logo_width=$(printf "$logo_mini" | head -2 | wc -m)
	mini_logo_width=$(( mini_logo_width - 2 ))
	spacing=$(( mini_logo_width / 2 + 5 ))	

	printf "%${spacing}s%s" "${INTRO_TEXT}"
  printf "${C_LOGO_FRONT}"
	printf "$logo_mini"
	echo
	exit
fi

echo
center "${INTRO_TEXT}"

printf "${C_LOGO_BACK}"
echo "$tmux_logo" | while IFS= read -r line; do
	center "$line"
done
printf "${NC}"
echo

max_line_len=$(( LOGO_WIDTH - 2 ))

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

