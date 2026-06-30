vim.pack.add({
	{
		src = "https://github.com/tkachenkosi/mautopairs.nvim.git",
		name = "mautopairs.nvim",
		version = "master",
	},
})

require("mautopairs").setup()
