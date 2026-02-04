local opts = { noremap = true, silent = true }

-- Buffers
vim.keymap.set("n", "<leader>q", "<cmd>qa<CR>", opts)
vim.keymap.set("n", "<leader>s", function() vim.cmd("mks! .session"); print("Save Ok. "..vim.fn.getcwd()); end)		-- сохранить сессию
vim.keymap.set('n', '<F2>', '<cmd>w<CR>', opts)
vim.keymap.set('i', '<F2>', '<Esc><cmd>w<CR>', opts)
-- vim.keymap.set("i", "jj", "<Esc>")

-- закоментировать строку/ Коментарий блока - <leader>gc
vim.api.nvim_set_keymap('n', '<F3>', "gccj", {})
vim.api.nvim_set_keymap('i', '<F3>', "<Esc>gcca", {})

-- выделяем и копируем слово (F4 может не нужно это только выделение)
vim.api.nvim_set_keymap('n', '<F5>', 'viwy', {})
-- vim.keymap.set('i', '<F5>', '<Esc>viwy', {})

-- копирует и всавляем из системного буфера (пока только вставляет, эта поперация нужна чаще)
vim.api.nvim_set_keymap('n', '<F6>', '"+p', opts)
vim.api.nvim_set_keymap('i', '<F6>', '<Esc>"+pa', opts)
vim.api.nvim_set_keymap('v', '<F6>', '"+y', opts)     -- копирует выделенный фрагмент в системный буфер в режиме выделения

-- выделяет и тутже заменяет слово
vim.api.nvim_set_keymap('n', '<F8>', 'viw"0p', {})
vim.api.nvim_set_keymap('i', '<F8>', '<Esc>viwp', {})

-- быстрый поиск (выделение) текста. Так же есть команада * - движение по n вперед, # - назад
vim.keymap.set('n', '<F7>', '*', opts)
vim.keymap.set('i', '<F7>', '<Esc>*', opts)

-- сдублировать строку
vim.keymap.set('n', '<C-l>', 'yyp', opts)
vim.keymap.set('i', '<C-l>', '<Esc>yypa', opts)

-- сдублировать и закоментировать первую строку
vim.api.nvim_set_keymap('n', '<A-l>', 'yypkgccj', {})
vim.api.nvim_set_keymap('i', '<A-l>', '<Esc>yypkgccja', {})

-- Yank в регистр t
vim.keymap.set('n', '<A-y>', [["tyy]], opts)
vim.keymap.set('v', '<A-y>', [["ty]], opts)
vim.keymap.set('i', '<A-y>', [[<Esc>"tyya]], opts)

-- Paste из регистра t
vim.keymap.set('n', '<A-p>', [["tpa]], opts)
vim.keymap.set('v', '<A-p>', [["tp]], opts)
vim.keymap.set('i', '<A-p>', [[<Esc>"tpa]], opts)

-- Windows
-- vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
-- vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
-- vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
-- vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- vim.api.nvim_set_keymap('n', '<c-s>', '<cmd>set relativenumber!<CR>', {})
vim.keymap.set('n', '<leader>/', '<cmd>noh<CR>', opts)

-- открыть окно со списоком буферов
vim.keymap.set({'n', 'i'}, '<F12>', function() require('mbuffers').start(); end, opts)

-- переключиться на предыдущий буфер
vim.keymap.set('n', '<F10>', '<c-6>', opts)
vim.keymap.set('i', '<F10>', '<Esc><c-6>', opts)
-- выдиляет весь текст
vim.keymap.set('n', '<Leader>sa', 'ggVG<c-$>', opts)
-- дополнительная команда входа в командный режим
vim.keymap.set("n", ";", ":", {noremap = true, silent = false})

-- встроенный Exploer (открываем слева окно в 30 колонок)
-- уже не нужно так как есть <leader>e
-- keymap('n', '<leader><F3>', '<Esc>:Explore<CR>', {})

-- Tab
vim.keymap.set("n", "<Tab>", "<c-6>", opts)
vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<CR>', opts)

-- цветовые темы оформления
vim.keymap.set('n', '<leader>2', function() vim.cmd.colorscheme('onedark'); end, opts)
vim.keymap.set('n', '<leader>3', function() vim.cmd.colorscheme('gruvboxsi'); end, opts)

-- отмена в привычном сочетании
vim.keymap.set('n', '<C-z>', "<cmd>undo<CR>", opts)
vim.keymap.set('i', '<C-z>', "<Esc><cmd>undo<CR>", opts)
-- заблокируем стандартную отмену, что бы не путаться
-- keymap('n', 'u', "<Nop>", {})
-- навесим на u снятие выделения
vim.keymap.set('n', 'u', '<cmd>noh<CR>', opts)

vim.keymap.set('n', '<leader>й', "<cmd>qa<CR>", opts)
vim.keymap.set('n', 'щ', 'o', opts)
vim.keymap.set('n', 'ш', 'i', opts)
vim.keymap.set('n', 'ф', 'a', opts)
vim.keymap.set('n', 'Ж', ':', opts)
vim.keymap.set('n', 'М', 'V', opts)
vim.keymap.set('n', 'м', 'v', opts)
vim.keymap.set('n', 'г', 'u', opts)
vim.keymap.set('n', 'н', 'y', opts)
vim.keymap.set('v', 'н', 'y', opts)
vim.keymap.set('o', 'н', 'y', opts)
vim.keymap.set('n', 'з', 'p', opts)
vim.keymap.set('v', 'з', 'p', opts)
vim.keymap.set('n', 'в', 'd', opts)
vim.keymap.set('v', 'в', 'd', opts)
vim.keymap.set('o', 'в', 'd', opts)

-- отключить запись макросов
vim.keymap.set('n', 'q', '<Nop>', opts)

