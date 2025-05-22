
require("lazy").setup({
  { "neovim/nvim-lspconfig" },
  { "SmiteshP/nvim-navic" },
})

local lspconfig = require("lspconfig")

require('nvim-navic').setup({
  icons = {
    File          = "File",
    Module        = " ",
    Namespace     = "Ns ",
    Package       = " ",
    Class         = "Cl ",
    Method        = "Met ",
    Property      = " ",
    Field         = " ",
    Constructor   = " ",
    Enum          = "練",
    Interface     = "練",
    Function      = "def",
    Variable      = " ",
    Constant      = " ",
    String        = " ",
    Number        = " ",
    Boolean       = "◩ ",
    Array         = " ",
    Object        = " ",
    Key           = " ",
    Null          = "ﳠ ",
    EnumMember    = " ",
    Struct        = " ",
    Event         = " ",
    Operator      = " ",
    TypeParameter = " ",
  },
  highlight = true,
  separator = " > ",
  depth_limit = 0,
  depth_limit_indicator = "..",
})
lspconfig.pyright.setup({
  on_attach = function(client, bufnr)
    -- Настройки для буфера
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Основные бинды
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)       -- Переход к определению
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)   -- Переход к реализации
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)       -- Поиск ссылок
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)             -- Просмотр документации
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)   -- Переименование
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Исправление ошибок
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts) -- Форматирование кода

    -- Диагностика
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)    -- Предыдущее сообщение об ошибке
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)    -- Следующее сообщение об ошибке
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- Показать диагностику
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts) -- Список диагностики

    -- Настройки для диагностики LSP
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",  -- Префикс для ошибок
      },
      update_in_insert = true,  -- Включаем обновление диагностики в Insert Mode
    })

    -- Настройка флагов и обработчиков
    client.server_capabilities.textDocument_publishDiagnostics = true
    client.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        update_in_insert = true,  -- Обновление диагностики в Insert Mode
      }
    )
  local navic = require("nvim-navic")
    navic.attach(client, bufnr)
  end,
})
