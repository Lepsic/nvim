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
vim.api.nvim_set_keymap('t', 'jj', '<C-\\><C-n>', {noremap= true})
-- Ну тупа кейбинды --
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Следующий буфер" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Предыдущий буфер" })

-- Границы всех окон
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7c6f64", bold = true })
vim.opt.fillchars = { vert = "┃", horiz = "━" }

-- Для NvimTree (если используется)
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#7c6f64", bold = true })
-- require("nvim-tree").setup({
--   renderer = { indent_markers = { enable = true } },
-- })

-- Для toggleterm.nvim (терминал)
vim.api.nvim_set_hl(0, "TermWinSeparator", { fg = "#7c6f64", bold = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"javascript", "typescript", "javascriptreact", "typescriptreact", "css"},
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = false
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "make",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
    end
})
