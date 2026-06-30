vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2b2b2b" })

-- добовляет тэги к полям структуры на golang
local function gen_json_current_line()
	if vim.bo.filetype ~= "go" then
		return
	end

	local line = vim.api.nvim_get_current_line()

	-- проверяем что в строке нет json
	if string.find(line, 'json', 2) == nil then
		-- поиск пробела с конца строки
		local x,_ = string.find(line, ' ', 2)
		if x ~= nil and x > 2 then
			-- выдиляем имя поля структуры, также удаляем все пробелы и символы перевода
			local field = string.lower(string.gsub(string.sub(line, 1, x), "%s+", ""))
			vim.api.nvim_set_current_line(line .. ' `json:"' .. field .. '"`')
			-- перемещаем курсор вниз
			vim.cmd('norm! j')
		end
	end
end

-- Создаём команду для вызова функции
-- Использование: вводим только тег dev, a, strong, ... нажимаем a-` получаем законченный тег
-- vim.api.nvim_create_user_command("JsonLine", gen_json_current_line, {})
-- vim.api.nvim_set_keymap('n', '<a-2>', "<CMD>JsonLine<CR>")
vim.keymap.set({'n','i'}, '<a-1>', gen_json_current_line)


-- автодополнение HTML тэгов
local function gen_snip_current_line()
	local ext = vim.bo.filetype
	if ext ~= "html" and ext ~= "svelte" then
		return
	end

	local line = vim.api.nvim_get_current_line()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)  -- Позиция курсора (строка, колонка)
	local row, col = cursor_pos[1], cursor_pos[2]

  -- Ищем позицию начала подстроки (до первого символа " ", ">", "," или начала строки)
  local start_pos = col
  while start_pos > 0 do
    local char = line:sub(start_pos, start_pos)
    if char == " " or char == "\t" or char == ">" or char == "," or char == "}" then
      break
    end
    start_pos = start_pos - 1
  end

	local teg = ">"
	local col_new = col
	local col_cur = col + 2									-- новое положение курсора
	local ch2 = line:sub(col, col)					-- последний символ
	local ch1 = " "

	if ch2 == "." then
		ch1 = line:sub(col - 1, col - 1)
	end

	if ch1 == "#" and ch2 == "." then
		col_new = col - 2
		teg = [[ id="" class="">]]
		col_cur = col + 15
	elseif ch1 == "a" and ch2 == "." then
		col_new = col - 1
		teg = [[ class="" href="">]]
		col_cur = col + 17
	elseif ch2 == "." then
		col_new = col - 1
		teg = [[ class="">]]
		col_cur = col + 9
	elseif ch2 == "a" then
		teg = [[ href="">]]
		col_cur = col + 8
	end

  local substring = teg .. "</" .. line:sub(start_pos + 1, col_new) .. ">"

	-- Модифицируем строку: добавляем выделенный фрагмент дважды
  -- local new_line = line:sub(1, col) .. substring .. line:sub(col + 1)
  -- local new_line = line:sub(1, start_pos) .. "<" .. line:sub(start_pos + 1, col_new) .. substring .. line:sub(col + 1)
	vim.api.nvim_set_current_line(line:sub(1, start_pos) .. "<" .. line:sub(start_pos + 1, col_new) .. substring .. line:sub(col + 1))
	vim.api.nvim_win_set_cursor(0, { row, col_cur })
end

vim.keymap.set({'n','i'}, "<a-`>", gen_snip_current_line)

-- получение цвета фона текущец строки
local function put_color()
	local hl = vim.api.nvim_get_hl(0, { name = 'CursorLine' })
	if hl.bg then
		local bg_color = string.format('#%06x', hl.bg)
		print("CursorLine bg color:", bg_color)
	end
end

vim.keymap.set({'n','i'}, '<a-5>', put_color)

-- читает слово под курсором, определяет расширение файла 
-- поиск основан на запуске пользовательской команды (in cmd.lua) Rg <ext_file> <current_word>
local function QuickfixCurrWord()
    local current_mode = vim.api.nvim_get_mode().mode
    local current_word

    if current_mode == 'n' then
        current_word = vim.fn.expand('<cword>')
    elseif current_mode == 'v' or current_mode == 'V' or current_mode == '\22' then -- \22 = Ctrl-V
			-- это для поиска выделенного фрагмента, а не одного слова
			-- Сохраняем выделение в регистр "
			vim.cmd('noautocmd normal! "xy')
			-- Получаем выделенный текст из регистра x
			-- Убираем последний символ если это перевод строки (в визуальном режиме часто добавляется)
			current_word = vim.fn.getreg('x'):gsub('\n$', '')
    else
        vim.notify("Не поддерживаемый режим", vim.log.levels.WARN)
        return
    end

    if current_word == '' then
        vim.notify("Ничего не выделено", vim.log.levels.WARN)
        return
    end

    local ext_file = vim.fn.expand('%:e')
    if ext_file == '' then
        vim.notify("Файл без расширения", vim.log.levels.WARN)
        return
    end

    -- Используем vim.system (асинхронно)
    local args = { "rg", "--vimgrep", "--type", ext_file, current_word }

		vim.system(args, { text = true }, function(out)
			vim.schedule(function()
				if out.code ~= 0 or out.stdout == "" then
					vim.notify("Ничего не найдено или ошибка", vim.log.levels.INFO)
					return
				end
				local lines = vim.split(out.stdout, "\n")
				vim.fn.setqflist({}, ' ', {
					title = string.format('Rg %s %s (%d)', ext_file, current_word, #lines),
					lines = lines
				})
				vim.cmd("copen")
			end)
		end)

end

vim.keymap.set({'n','v'}, '<leader><F7>', QuickfixCurrWord, {desc = 'Quickfix current word'})


-- SmartNetrw открытие и закрытие files explorer
local function SmartNetrw()
  local netrw_bufs = {}

	-- Собираем все активные буферы netrw
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
			if ft == 'netrw' then
				table.insert(netrw_bufs, bufnr)
			end
		end
	end

	if #netrw_bufs > 0 then
		-- Если буферы netrw есть — закрываем их все
		for _, bufnr in ipairs(netrw_bufs) do
				vim.api.nvim_buf_delete(bufnr, { force = true })
		end
		if vim.api.nvim_get_current_buf() == netrw_bufs[1] then
				vim.cmd("close")   -- если текущее окно было netrw
		end
	else
		-- Если буферов netrw нет — открываем новый
		vim.cmd("25vs +Explore")
	end
end

vim.keymap.set('n', '<leader>e', SmartNetrw, { desc = 'Toggle netrw file explorer' })
