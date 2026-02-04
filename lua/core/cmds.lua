-- не коментиовать в новой строке (когда создаем новую строку)
vim.cmd([[autocmd BufEnter * set fo-=c fo-=r fo-=o]])

-- кратковременно подсвечивает скопированную строку или блок
-- local YankHighlightGrp = vim.api.nvim_create_augroup('YankHighlightGrp', {})

-- vim.api.nvim_create_autocmd('TextYankPost', {
-- 	group  = vim.api.nvim_create_augroup('YankHighlightGrp', {}),
--   pattern = '*',
--   callback = function()
--     vim.highlight.on_yank({
--       higroup = 'IncSearch',
--       timeout = 30,
--     })
--   end,
-- })


vim.api.nvim_create_autocmd('TextYankPost', {
	pattern = "*",
  desc = 'Highlight when yanking (copy) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      timeout = 50,
		})
  end,
})


-- форматирование файлов go css js на запись
vim.api.nvim_create_autocmd('BufWritePre', {
  -- pattern = {'*.go', '*.css', '*.js', '*.ts', '*.svelte'},
  pattern = {'*.go', '*.css', '*.js', '*.ts'},
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})


-- Создаём свою команду :Rg для Quickfix (:vimgrep / :grep)
-- :Rg go import :Rg js import
-- :Rg js -w app - поиск в файлах *.js целого слова "app"
-- :Rg import - поиск "import" во всех файлах которые разрешены в конфиге rj и .ignoge
-- ]q и [q - перемещение по результатам поиска
vim.api.nvim_create_user_command("Rg", function(opts)
  local args = opts.args
  local file_type = nil

  -- Парсим аргументы: если первый аргумент это известный тип
  local first_arg = vim.split(args, " ")[1]
  local file_types = {
    go = "go", css = "css", js = "js", ts = "ts",
    svelte = "svelte", html = "html", lua = "lua", rs = "rust"
  }

  if file_types[first_arg] then
    file_type = file_types[first_arg]
    -- Убираем тип из аргументов поиска
    args = args:gsub("^"..first_arg.."%s+", "")
  end

  -- local cmd = "rg --vimgrep --smart-case --hidden --glob '!testdata/**' --glob '!node_modules/**' --glob '!dist/**'"
  -- local cmd = "rg --vimgrep --smart-case --no-hidden --glob '!testdata/*' --glob '!node_modules/*' --glob '!dist/*'"
  local cmd = "rg --vimgrep"
  if file_type then
    cmd = cmd.." --type "..file_type
  end
  cmd = cmd.." "..args

  local result = vim.fn.systemlist(cmd)
  -- local title = file_type and ('Rg '..file_type..' '..args) or ('Rg '..args)
  local title = file_type and string.format('(%d) Rg %s %s', #result, file_type, args) or string.format('(%d) Rg %s', #result, args)

  vim.fn.setqflist({}, ' ', { title = title, lines = result })
  vim.cmd("copen")
end, { nargs = "+" })

-- Добавьте этот автокоманд
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "go",
--     callback = function()
--         vim.opt_local.syntax = "OFF"
--         vim.cmd("syntax off")
--         vim.cmd("setlocal syntax=OFF")
--     end
-- })

-- привязка keymap для окна quickfix
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    -- vim.keymap.set('n', '<C-q>', ':cclose<CR>', { buffer = true, nowait = true })
    -- Можно добавить и другие удобные маппинги для quickfix окна
    vim.keymap.set('n', '<Esc>', ':cclose<CR>', { buffer = true, nowait = true })
    vim.keymap.set('n', 'q', ':cclose<CR>', { buffer = true, nowait = true })
  end
})


-- keymap("n", "<Leader>ex", "<cmd>Ex %:p:h<CR>") -- Open Netrw in the current file's directory
-- улучшенное создание файла во встроенном fikes manager
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		-- local bs = { buffer = true, silent = true }
		-- local brs = { buffer = true, remap = true, silent = true }
		-- vim.keymap.set("n", "q", "<cmd>bd<CR>", bs) -- Close the current Netrw buffer
		-- vim.keymap.set("n", "<Tab>", "mf", brs)		-- Mark the file/directory to the mark lis
		-- vim.keymap.set("n", "<S-Tab>", "mF", brs) -- Unmark all the files/directories

		-- vim.keymap.set("n", "q", function()
		-- 	local bufnr = vim.api.nvim_get_current_buf()
		-- 	vim.api.nvim_win_close(0, false)
		-- 	vim.defer_fn(function()
		-- 		if vim.api.nvim_buf_is_valid(bufnr) then
		-- 			vim.api.nvim_buf_delete(bufnr, { force = true })
		-- 		end
		-- 	end, 50)
		-- end, bs)

		-- Improved file creation
		vim.keymap.set("n", "%", function()
			local dir = vim.b.netrw_curdir or vim.fn.expand("%:p:h")
			vim.ui.input({ prompt = "Enter filename: " }, function(input)
				if input and input ~= "" then
					local filepath = dir .. "/" .. input
					vim.cmd("!touch " .. vim.fn.shellescape(filepath))
					vim.api.nvim_feedkeys("<C-l>", "n", false) -- обновление списка файлов
				end
			end)
		end, { buffer = true, silent = true })
	end,
})

