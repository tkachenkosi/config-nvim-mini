return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {"c", "cpp","lua","typescript","javascript",
				"query","rust","go","css","html","json","make","sql",
				"toml","bash","markdown","dockerfile","svelte"},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true, },
			indent = { enable = false,	},
			additional_vim_regex_highlighting = false, -- только подсветку только treesitter (vim.opt.syntax = "OFF")
		})
	end,
}
