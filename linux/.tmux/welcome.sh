#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

C_LOGO_FRONT=$GREEN
C_LOGO_BACK=$GRAY

TERM_WIDTH=$(tput cols)

INTRO_TEXT="WELCOME TO"

# ascii font: ogre
TMUX_LOGO='
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

# TODO: Logo width is 61...make a more round number later
# (will have to change color offsets)
LOGO_WIDTH=$(printf "$TMUX_LOGO" | head -2 | wc -m)
LOGO_WIDTH=$((LOGO_WIDTH - 2))

LOGO_MINI='
 _____           __  __
/__   \/\/\  /\ /\ \/ /
  / /\/    \/ / \ \  / 
 / / / /\/\ \ \_/ /  \ 
 \/  \/    \/\___/_/\_\
'

MINI_LOGO_WIDTH=$(printf "$LOGO_MINI" | head -2 | wc -m)
MINI_LOGO_WIDTH=$(( MINI_LOGO_WIDTH - 2 ))

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
	TMUX_LOGO=$(printf "%s${C_LOGO_FRONT}%s${C_LOGO_BACK}%s" \
						 "${TMUX_LOGO:0:p}" "${TMUX_LOGO:p:offset}" "${TMUX_LOGO:end}")
done

center() {
	# Don't count color codes in length
	len=$(echo "$1" | sed "s/$(echo -e "\e")[^m]*m//g");
	printf "%$(((TERM_WIDTH-${#len})/2))s%s\n" "" "$1"
}

# CONSTANTS
# =======================
# LOGIC

if [ "$TERM_WIDTH" -lt "$LOGO_WIDTH" ]; then
	spacing=$(( MINI_LOGO_WIDTH / 2 + 5 ))	

	printf "%${spacing}s%s" "$INTRO_TEXT"
  printf "$C_LOGO_FRONT"
	printf "$LOGO_MINI"
	echo
	exit
fi

echo
center "$INTRO_TEXT"

printf "$C_LOGO_BACK"
echo "$TMUX_LOGO" | while IFS= read -r line; do
	center "$line"
done
printf "$NC"
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

