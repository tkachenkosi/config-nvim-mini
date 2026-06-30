vim.pack.add({
	{
		src = "https://github.com/tkachenkosi/malpha.nvim.git",
		name = "malpha.nvim",
		version = "master",
	},
})

require("malpha").setup({
	count_recent = 25,
	add_filter = true,
})


require("malpha").enable_autostart()
