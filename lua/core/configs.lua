vim.wo.number = true
-- vim.wo.relativenumber = true
vim.opt.mouse = "a"
vim.opt.mousefocus = true
vim.opt.clipboard = "unnamedplus"

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true  -- что то для отступов в новой строке
vim.opt.autoindent = true		-- копирует отступы с текущей строки при добавлении новой
vim.opt.breakindent = true	-- позволяет сохранять отступы виртуальных строк

vim.opt.encoding="utf-8"
vim.opt.fileformat="unix"

vim.opt.scrolloff = 3
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.background = "dark" -- or "light" for light mode

vim.opt.updatetime = 25000
vim.opt.timeoutlen = 1600
vim.opt.undolevels = 200
vim.opt.history = 300

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.wo.foldmethod = 'marker'

-- настройки для встоенного Exploer
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4

-- Не понятные настройки
-- opt.cursorline = true
vim.wo.signcolumn = 'yes'
-- vim.opt.hlsearch = true
-- vim.opt.hidden = true

-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#112233" })
-- vim.api.nvim_win_set_option(0, "cursorline", true) -- Включаем подсветку текущей строки (команда устарела)
vim.opt.cursorline = true -- Включаем подсветку текущей строки

-- vim.api.statusline = %r%t%{(&mod?'*':'')}
-- set statusline=%r%t%{(&mod?'*':'')}

vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.shortmess:append("sIc")

-- настройки для treesister
vim.opt.syntax = "OFF"  -- ВСЕ ЗАГЛАВНЫЕ (иногда важно)
vim.opt_global.syntax = "OFF"
vim.cmd("syntax off")   -- Дублируем командой на всякий случай


-- тестирование функции alpha
-- vim.keymap.set('n', '<F9>', function() require('malpha').open(); end, {})
-- vim.keymap.set('n', '<leader>2', function() vim.cmd.colorscheme('onedark'); end)


-- цвет фона строки статуса #7c6f64
-- варианты оформление номеров строки и колонки
-- " %l/%L : %v",
-- "%5.5l/%L : %v",
-- mode = {bg = '#80a0ff', bold = true},
-- mode = {fg = '#0033cc', bold = true},
-- modi = {bg = '#e9c76b', fg = '#872d33', bold = true},


-- "%#Stlline# %l:%v %L%*",

-- оттенки красного: #73262b  #662227

-- local colors = {
-- 	mode = {bg = '#ada299', fg = '#0033cc', bold = true},
-- 	file = {bold = true},
-- 	modi = {bg = '#e9c76b', fg = '#662227', bold = true},
-- 	buff = {bg = '#96887d'},
-- 	line = {bg = '#ada299'},
-- 	lines = {bg = '#c4bcb5'},
-- }

-- for group, color in pairs(colors) do

-- local stl = {
--   "%#HL_mode#%-2{%v:lua.vim.fn.mode()%}%*",
--   "%#HL_file# %-.50f%* ",
--   "%#HL_modi#%-M%*",
--   "%=",
--   "%#HL_buff#%n%*",
--   "%#HL_line# %l:%v %*",
--   "%#HL_lines#%L%*",
-- }

-- vim.opt.statusline = table.concat(stl, "")

for group, color in pairs({
	mode = {bg = '#ada299', fg = '#0033cc', bold = true},
	file = {bold = true},
	modi = {bg = '#e9c76b', fg = '#662227', bold = true},
	buff = {bg = '#96887d'},
	line = {bg = '#ada299'},
	lines = {bg = '#c4bcb5'}}) do
	vim.api.nvim_set_hl(0, "HL_"..group, color)
end

vim.opt.statusline = table.concat({
  "%#HL_mode# %-3{%v:lua.vim.fn.mode()%}%*",
  "%#HL_file# %-.50f%* ",
  "%#HL_modi#%-M%*",
  "%=",
  "%#HL_buff#%n%*",
  "%#HL_line# %l:%v %*",
  "%#HL_lines#%L%*"}, "")
