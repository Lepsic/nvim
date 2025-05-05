-- вообще полезно юзаю каждый день ультра 360 ноу скоп а так в целом все что визульное то сюда --
vim.opt.number = true        -- Абсолютная нумерация
vim.opt.relativenumber = true -- Относительная нумерация

-- Другие полезные настройки
vim.opt.laststatus = 2       -- Всегда показывать строку статуса
vim.opt.clipboard = "unnamedplus" -- Общий буфер обмена с системой
vim.opt.cursorline = true    -- Подсветка текущей строки

-- Сеты для лидера - это некая кнопка которая нужна для не конфликтования с vim биндами --
-- Установить пробел в качестве leader
vim.g.mapleader = " " -- Пробел
vim.g.maplocalleader = " " -- Локальный leader (для конкретных буферов)
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true})

-- Ну тупа кейбинды --
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Следующий буфер" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Предыдущий буфер" })
