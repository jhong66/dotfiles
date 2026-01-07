
# Custom ls output colors
export LS_COLORS=$LS_COLORS'ow=1;30;42'

# Tmux welcome message
if { [ -n "$TMUX" ]; } then
	./.tmux/welcome.sh
fi

