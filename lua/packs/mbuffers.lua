vim.pack.add({
	{
		src = "https://github.com/tkachenkosi/mbuffers.nvim.git",
		name = "mbuffers.nvim",
		version = "master",
	},
})

require("mbuffers").setup({
	width_win = 0,
})

