return {
	"tkachenkosi/malpha.nvim",
	config = function()
			require("malpha").setup({
				count_recent = 25,
				add_filter = true,
			})
			require("malpha").enable_autostart()
	end,
	event = "VimEnter",
}

