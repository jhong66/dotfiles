#!/bin/bash

RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
GRAY='\e[0;90m'
NC='\e[0m' # No Color

C_LOGO_FRONT=$GREEN
C_LOGO_BACK=$GRAY
# Note: for ansi256 use '\e[38;5;[NUMBER]m'

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

# TODO: Logo width is 61...make a more round number later?
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

# -- highlight tmux in color
declare -a color_changes=(
"269 ${C_LOGO_FRONT}"
"275 ${C_LOGO_BACK}"
"285 ${C_LOGO_FRONT}"
"292 ${C_LOGO_BACK}"
"330 ${C_LOGO_FRONT}"
"354 ${C_LOGO_BACK}"
"394 ${C_LOGO_FRONT}"
"414 ${C_LOGO_BACK}"
"454 ${C_LOGO_FRONT}"
"476 ${C_LOGO_BACK}"
"515 ${C_LOGO_FRONT}"
"540 ${C_LOGO_BACK}"
)

esc_offset=0

# for conf in "${color_changes[@]}"; do
# 	p="${conf% *}"
# 	p=$(( p + esc_offset ))
# 	color="${conf#* }"
#
# 	TMUX_LOGO=$(printf "%s${color}%s" "${TMUX_LOGO:0:p}" "${TMUX_LOGO:p}")
# 	esc_offset=$(( esc_offset + ${#color} - 1 ))
# done

center() {
	# Don't count color codes in length
	# len=$(echo "$1" | sed "s/$(echo -e "\e")[^m]*m//g");
	len=$(echo "$1");
	printf "%$(((TERM_WIDTH-${#len})/2))s%s\n" "" "$1"
}

# CONSTANTS
# =======================
# LOGIC

if [ "$TERM_WIDTH" -lt "$LOGO_WIDTH" ]; then
	spacing=$(( MINI_LOGO_WIDTH / 2 + 5 ))	

	printf "%${spacing}s%s" "$INTRO_TEXT"
	printf "${C_LOGO_FRONT}${LOGO_MINI}${NC}"
	echo
	exit
fi

echo
center "$INTRO_TEXT"

# printf "$C_LOGO_BACK"
printf ${GREEN}
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
    ggrep -Po '(?<=\[).*(?=\])' ~/.tmux/quotes.sh \
	| gshuf -n 1 \
	| xargs -0 -I {} printf "{}\n" \
	| fold -s -w $max_line_len \
)

echo "$quote" | while IFS= read -r line; do
	center "$line"
done
echo

