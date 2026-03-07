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
    Enum          = "練",
    Interface     = "練",
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

-- CSS/SCSS/LSS сервер
lspconfig.cssls.setup({
  on_attach = function(client, bufnr)
    -- Настройки для буфера
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Основные бинды для CSS
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)       -- Переход к определению переменных
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)       -- Поиск использований (для переменных/mixins)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)             -- Просмотр документации свойства
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)   -- Переименование переменных
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Исправления
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts) -- Форматирование CSS

    -- Диагностика (ошибки в CSS)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)    -- Предыдущая ошибка
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)    -- Следующая ошибка
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- Показать ошибку
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts) -- Список всех ошибок

    -- Настройки для диагностики
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",  -- Префикс для ошибок
      },
      update_in_insert = true,  -- Обновление диагностики при печати
      severity_sort = true,     -- Сортировка по серьезности
    })

    -- Подключаем навигацию (показывает структуру CSS)
    local navic = require("nvim-navic")
    navic.attach(client, bufnr)
  end,

  -- Настройки для CSS сервера (включают автокомплит и подсветку допустимых значений)
  settings = {
    css = {
      validate = true,  -- Включаем валидацию
      hover = {
        documentation = true,  -- Показывать документацию при наведении
      },
      completion = {
        completePropertyWithSemicolon = true,  -- Добавлять ; после свойства
        triggerPropertyValueCompletion = true, -- Автокомплит значений свойств
      },
      lint = {
        unknownAtRules = "warning",        -- Предупреждать о неизвестных @правилах
        unknownProperties = "warning",     -- Предупреждать о неизвестных свойствах
        ieHack = "warning",                -- Предупреждать о IE хаках
        unknownVendorSpecificProperties = "warning", -- Предупреждать о вендорных свойствах
        propertyIgnoredDueToDisplay = "warning", -- Свойство игнорируется из-за display
        important = "warning",              -- Предупреждать об important
        float = "warning",                  -- Проверка float
        idSelector = "ignore",              -- Игнорировать ID селекторы
      }
    },
    scss = {
      validate = true,
      hover = {
        documentation = true,
      },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
      lint = {
        unknownAtRules = "warning",
        unknownProperties = "warning",
        -- специфичные для SCSS настройки
      }
    },
    less = {
      validate = true,
      hover = {
        documentation = true,
      },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    }
  },

  -- На каких файлах запускать сервер
  filetypes = { "css", "scss", "less", "sass" },

  -- Автоматически запускать сервер при открытии файла
  autostart = true,

  -- Капабилити для автокомплита
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,  -- Поддержка сниппетов
          resolveSupport = {
            properties = {
              "documentation",
              "detail",
              "additionalTextEdits",
            }
          }
        },
        contextSupport = true,
      },
      hover = {
        contentFormat = { "markdown", "plaintext" }, -- Формат документации
      },
    },
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
})

-- Если используешь Tailwind CSS (опционально)
-- Сначала установи: npm install -g @tailwindcss/language-server
lspconfig.tailwindcss.setup({
  on_attach = function(client, bufnr)
    -- Используем те же бинды, что и для CSS
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)

    -- Подключаем навигацию
    local navic = require("nvim-navic")
    navic.attach(client, bufnr)
  end,
  filetypes = { 
    "css", "scss", "html", "javascript", "javascriptreact", 
    "typescript", "typescriptreact", "vue", "svelte" 
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        invalidConfig = "warning",
        invalidScreen = "warning",
        invalidVariant = "warning",
        invalidTailwindDirective = "warning",
        invalidApply = "warning",
        recommendedVariantOrder = "warning",
      }
    }
  }
})
