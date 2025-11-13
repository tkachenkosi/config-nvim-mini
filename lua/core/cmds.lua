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
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      timeout = 55,
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




