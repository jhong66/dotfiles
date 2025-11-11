require("config.lazy")

vim.cmd("colorscheme nightfox")

vim.cmd([[
	set runtimepath^=~/.vim runtimepath+=~/.vim/after
	let &packpath = &runtimepath
	source ~/.vimrc
]])

vim.api.nvim_create_user_command(
	"Dash",
	function()
		vim.cmd("lua Snacks.dashboard()")
	end,
	{
		desc = "Display neovim dashboard",
		nargs = 0,
	}
)

