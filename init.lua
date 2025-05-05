--:Lazy sync- Автоматическая установка lazy.nvim, если его нет
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
--vim.cmd("syntax on")
-- vim.api.nvim_set_hl(0, "keyword", {fg = "#f707ef" })

--vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#ffbc03" })
--vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#ff5733" })

-- Подключаем LSP настройки
require("settings.options") -- Дефолт настройки для вима(кейбинды, всякая минорная хуйня)


--require("settings.create_file") -- Создание файла в текущей диреткории
-- Загружаем плагины
require("plugins")
require("lsp.pyright")
-- Настройка подсветки Treesitter
vim.cmd("syntax on") -- Включить подсветку синтаксиса
-- Настройка подсветки Treesitter
-- vim.cmd("colorscheme koehler ")

