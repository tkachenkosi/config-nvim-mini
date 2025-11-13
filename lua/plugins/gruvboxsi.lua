return {
  "tkachenkosi/gruvboxsi.nvim",
  priority = 1000 ,
  config = function()
    require("gruvboxsi").setup({
      contrast = "hard",
			italic = { strings = false },
			palette_overrides = {
				-- faded_red = '#993300',
				-- neutral_red = '#993300',
				-- dark_red = '#993300',
				-- bright_red = '#ff5500',
				-- bright_red = '#0084ff',
				-- bright_red = '#fcae70',
				-- bright_red = '#fc936b',
				-- bright_red = '#eac0fe',
				-- bright_red = '#d378d1',
				bright_red = '#78a3d3',
				-- bright_yellow = '#e8a406',  -- hard
				bright_yellow = '#d89905',  -- soft
				-- dark3 = "#1d3c5a",
				-- dark3 = "#224466",
			},
			overrides = {
        -- ["@lsp.type.method"] = { bg = "#ff9900" },
        -- ["@comment.lua"] = { bg = "#000000" },
        -- ["@comment.go"] = { bg = "#000000" },
        -- ["@function"] = { fg = "#0084ff" },
        -- ["@keyword"] = { fg = "#0084ff" },
        -- ["@keyword.return"] = { fg = "#0084ff" },
        -- goDeclaration = { fg = "#0084ff" },
        -- goDeclType = { fg = "#0084ff" },
        -- goConstants = { fg = "#0084ff" },
        -- Function = { fg = "#0084ff", bold = true },
        -- ["@keyword.function"] = { fg = "#fb4934", bold = true },
        ["@keyword.function"] = { bold = true },
				-- ["@keyword.type"] = { fg = "#0084ff" },
				-- ["@type"] = { fg = "#0084ff" },
				-- ["@type.definition"] = { fg = "#0084ff" },
			},
    })
    require("gruvboxsi").load()
  end
}
