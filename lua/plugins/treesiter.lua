
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- Автоматическое обновление парсеров
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "python", "lua" }, -- Добавляем языки
      highlight = {
        enable = true, -- Включить подсветку
        additional_vim_regex_highlighting = false, -- Отключить устаревшую подсветку
        custom_captures = {
          ["keyword.python"] = "Keyword",  -- Настройка подсветки для ключевых слов в Python
          ["class.python"] = "Type",      -- Настройка подсветки для классов в Python
          ["function.python"] = "Function", -- Настройка подсветки для функций в Python
        },
      },
      indent = {
        enable = true, -- Умное выравнивание
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    })

    -- Настройка цветов вручную через `vim.api.nvim_set_hl
    vim.api.nvim_set_hl(0, "TSKeyword", { ctermfg = 202 }) -- Цвет для ключевых слов (202 - красный)
    vim.api.nvim_set_hl(0, "TSFunction", { ctermfg = 82 }) -- Цвет для функций (82 - зеленый)
    vim.api.nvim_set_hl(0, "TSClass", { ctermfg = 220 }) -- Цвет для классов (220 - желтый)
    vim.api.nvim_set_hl(0, "TSVariable", { ctermfg = 51 }) -- Цвет для переменных (51 - голубой)

  end,
}
